local device = {}


device.make_parser = function(regexes,re) 
  local parsers ={} 
  for i,obj in ipairs(regexes) do
    local regexp = obj.regex
    local device_rep = obj.device_replacement
    local parser = function (val)
      local m = re.match(val,regexp)
      if m==nil then
        return nil
      end
      local family  = device_rep and device_rep:gsub("$1",m[1]) or m[1]
      return { family=family}
    end
    table.insert(parsers,parser)    
  end
  
  local function parser(str, ua_family, os_family) 
    local obj
    for i,v in ipairs(parsers) do
      obj = v(str,ua_family,os_family)
      if obj then
        return obj
      end
    end
    return obj or {family="Other"};
  end

  return parser
end
local tablex = require 'pl.tablex'
local pretty  = require 'pl.pretty'
local MOBILE_DEVICE_LIST = {
  "Playstation Portable",
  "Playstation Vita",
  "Nintendo 3DS",
  "Nintendo DSi",
  "Nintendo DS",
  "Alcatel OT510A",
  "Alcatel OH5",
  "HTC Hero",
  "Huawei G2800",
  "Huawei M750",
  "Samsung GT-S5253",
  "PlayStation Portable",
  "PlayStation Vita",
  "Nokia 5130c-2",
  "Nokia 5320di",
  "Nokia 6120c",
  "Nokia C2-00"
}
local TELEVISION_DEVICE_LIST = {
  "HbbTV",
  "Sega Dreamcast",
  "Playstation 3",
  "PlayStation 3",
  "WebTV",
  "Nintendo Wii",
  "Nintendo Wii U"
}
local TABLET_LIST = {
  "Kindle",
  "Kindle Fire",
  "Kindle Fire HD",
  "iPad",
  "BlackBerry Playbook",
  "HP TouchPad",

}

-- local function is_psp(family)
--   if family == "Playstation Portable" or
--     family == "Playstation Vita" then
--     return true
--   else
--     return false
--   end
-- end
local function is_surface(ua,re)
  return ua.os.family == "Windows RT" and re.match(ua.ua_string,"Touch")
end
local function detect_mobile(ua,re)
  return re.match(ua.ua_string,"(Mobi(le)?|Symbian|MIDP|Windows CE|BREW|brew|J2ME|Brew MP)") or 
    ua.ua.family=="Opera Mini" or
    tablex.find(MOBILE_DEVICE_LIST,ua.device.family)
end
local function is_tablet(ua,re)
    return (tablex.find(TABLET_LIST,ua.device.family) or 
      (ua.os.family=="Android" and not detect_mobile(ua,re)) or is_surface(ua,re))
end
local function is_mobile(ua,re)
  return detect_mobile(ua,re) and not is_tablet(ua,re)
end
local function is_television( ua,re )
  return tablex.find(TELEVISION_DEVICE_LIST,ua.device.family)
end
function device.discover_device_type(ua,re)

  if is_television(ua,re) then
    return "television"
  elseif ua.device.family=="Spider" then
    return "spider"
  elseif ua.device.family=="Tesla Model S" then
    return "car"
  elseif is_tablet(ua,re) then
    return "tablet"
  elseif is_mobile(ua,re) then
    return "mobile"
  else
    return "other"
  end
end

return device 


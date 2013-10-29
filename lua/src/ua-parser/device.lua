local device = {}

device.make_parser = function(regexes,re) 
  local parsers ={} 
  for i,obj in ipairs(regexes) do
    local regexp = obj.regex
    local device_rep = obj.device_replacement
    local parser = function (val)
      local m = re.match(val,regexp)
      if #m==0 then
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

return device 


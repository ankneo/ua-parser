local ua_parser = {}
local yaml = require 'yaml'
local file = io.open("../regexes.yaml","r")
if not file then
  if ngx then
    file = io.open(ngx.var.regexes)
  end
end
local regexes = yaml.load(file:read("*all"))
-- local pretty = require 'pl.tablex'
file:close()
local re
if ngx then
  re = ngx.re
else
  re = require("rex_pcre")
  local old_match = re.match
  re.match = function ( ... )
    local results={old_match(...)}
    for i,v in ipairs(results) do
      if v==false then
        results[i]=nil
      end
    end
    if #results==0 then return nil end
    return results
  end
end
local device=  require(".ua-parser.device")

local parse_ua = require(".ua-parser.ua").make_parser(regexes.user_agent_parsers,re)
local parse_os = require(".ua-parser.operating_system").make_parser(regexes.os_parsers,re)
local parse_device = device.make_parser(regexes.device_parsers,re)

ua_parser.parse = function (str)

  result = {
      ua = parse_ua(str),
      os = parse_os(str),
      device= parse_device(str),
      ua_string = str
    }
  result.device.type = device.discover_device_type(result,re)

  return result
end
return ua_parser
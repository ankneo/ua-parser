local ua_parser = {}
local yaml = require 'yaml'
local file = io.open("../regexes.yaml","r")
local regexes = yaml.load(file:read("*all"))
local pretty = require 'pl.pretty'
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
    return results
  end
end


local parse_ua = require("src.ua-parser.ua").make_parser(regexes.user_agent_parsers,re)
local parse_os = require("src.ua-parser.operating_system").make_parser(regexes.os_parsers,re)
local parse_device = require("src.ua-parser.device").make_parser(regexes.device_parsers,re)

ua_parser.parse = function (str)
  return {
      ua = parse_ua(str),
      os = parse_os(str),
      device= parse_device(str)
    }
end
return ua_parser
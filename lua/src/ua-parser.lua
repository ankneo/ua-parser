local ua_parser = {}

local cjson = require 'cjson'

local REGEXESDICT = ngx.shared.REGEXES

local regexes, flags = REGEXESDICT:get("regexes")

if not regexes then
        ngx.log(ngx.WARN, "Failed to retrieve data from REGEXES DICT")
    else
        regexes = cjson.decode(regexes)
end

if not regexes then
    local yaml = require 'yaml'
    local file = io.open("./regexes.yaml","r")
    regexes = yaml.load(file:read("*all"))
    file:close()

    local ok, err, forcible = REGEXESDICT:set("regexes", cjson.encode(regexes))
    if not ok then
        ngx.log(ngx.WARN, "Unable to store data in REGEXES DICT : ",err)
    end
end

local re = ngx.re
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

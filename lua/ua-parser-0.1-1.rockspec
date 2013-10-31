package = "ua-parser"
version = "0.1-1"
source = {
  url = "https://github.com/fertel/ua-parser"
}
description = {
  summary = "ua parser for lua",
  detailed = [[
    A port of ua parser for lua. Works with both nginx and rex_PCRE parsers
  ]],
  homepage = "https://github.com/fertel/ua-parser",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["ua-parser"] = "src/ua-parser.lua",
    ["ua-parser.operating_system"]  = "src/ua-parser/operating_system.lua",
    ["ua-parser.ua"]  = "src/ua-parser/ua.lua",
    ["ua-parser.device"]  = "src/ua-parser/device.lua"

  },
  install = {
    conf = {
      ["regexes.yaml"] = "../regexes.yaml"
    }
  }
}
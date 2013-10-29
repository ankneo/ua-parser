local yaml = require 'yaml'

function read_yaml( file_name)
  local full_path = "../test_resources/"..file_name
  local file  = io.open(full_path,"r")
  local fixtures_yaml = file:read("*all")
  file:close()
  local fixtures = yaml.load(fixtures_yaml)
  return fixtures
end
function clean_yaml_value(value)
  for k,v in pairs(value) do
    if v=="" then
      value[k]=nil
    end
  end
  return value
end
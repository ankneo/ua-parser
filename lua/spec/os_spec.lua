require 'spec.spec_helper'
local ua_parser = require 'src.ua-parser'



local function check_os_equals(value)
  local os = ua_parser.parse(value.user_agent_string).os
  value = clean_yaml_value(value)
  assert.is.equals(os.family, value.family)
  assert.is.equals(os.major, value.major)
  assert.is.equals(os.minor, value.minor)
  assert.is.equals(os.patch, value.patch)
  assert.is.equals(os.patch_minor, value.patch_minor)
end

describe("Os",function ( ... )
  describe("os tests",function ( ... )
    local fixtures = read_yaml("test_user_agent_parser_os.yaml")
    for i,v in ipairs(fixtures.test_cases) do
      it("should equal match for :"..v.user_agent_string,function ( ... )
        check_os_equals(v)
      end)
    end
  end)
  describe("additional os tests",function ( ... )
    local fixtures = read_yaml("additional_os_tests.yaml")
    for i,v in ipairs(fixtures.test_cases) do
      it("should equal match for :"..v.user_agent_string,function ( ... )
        check_os_equals(v)
      end)
    end
  end)

end)
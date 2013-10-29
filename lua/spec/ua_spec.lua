require 'spec.spec_helper'
local ua_parser = require 'src.ua-parser'



local function check_ua_equals(value)
  local ua = ua_parser.parse(value.user_agent_string).ua
  value = clean_yaml_value(value)
  assert.is.equals(ua.family, value.family)
  assert.is.equals(ua.major, value.major)
  assert.is.equals(ua.minor, value.minor)
  assert.is.equals(ua.patch, value.patch)
end

-- describe("UserAgent",function ( ... )
  -- describe("Firefox User Agent",function ( ... )
    describe("this should work...",function ( ... )
      -- body
    it("should od this...",function ( ... )
      -- body
    
    local fixtures = read_yaml("firefox_user_agent_strings.yaml")
    for i,v in ipairs(fixtures.test_cases) do
      -- it("should equal match for: "..v.user_agent_string,function ( ... )
        check_ua_equals(v)
      -- end)
    end
  -- end)
    it("should do this",function ( ... )
      -- body
    
    local fixtures = read_yaml("test_user_agent_parser.yaml")
    for i,v in ipairs(fixtures.test_cases) do
      -- it("should equal match for: "..v.user_agent_string,function ( ... )
        check_ua_equals(v)
      -- end)
    end
  end)
  -- describe("pgts",function ( ... )
    it("should do this ",function ( ... )
      -- body
    
  local fixtures = read_yaml("pgts_browser_list.yaml")
    for i,v in ipairs(fixtures.test_cases) do
  --     it("should equal match for: "..v.user_agent_string,function ( ... )
      check_ua_equals(v)
      -- end)
    end
  end)
    end)
 end)
-- end)


require 'spec.spec_helper'
local ua_parser = require 'src.ua-parser'
local fixtures = read_yaml("test_device.yaml")

describe("Device",function ( ... )
  for i,v in ipairs(fixtures.test_cases) do
    it("should have family ".. v.family,function ( ... )
      local device = ua_parser.parse(v.user_agent_string).device
      assert.is.equals(device.family,v.family)
    end)
  end
end)

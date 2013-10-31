local operating_system ={}

operating_system.make_parser = function(regexes,re) 
  local parsers ={} 
  for i,obj in ipairs(regexes) do
    local regexp = obj.regex
    local fam_rep = obj.os_replacement
    local major_rep = obj.os_v1_replacement
    local minor_rep = obj.os_v2_replacement
    local patch_rep = obj.os_v3_replacement
    local patch_minor_rep = obj.os_v4_replacement

    local function parser(str) 
      local m = re.match(str,regexp)
      if m==nil then return nil end
      local family = (fam_rep and fam_rep:gsub('$1', m[1]) or m[1]) or "Other"
      local major = major_rep or m[2]
      local minor = minor_rep or m[3]
      local patch = patch_rep or m[4]
      local patch_minor = patch_minor_rep or m[5]
      return {family=family, major=major, minor=minor, patch=patch, patch_minor=patch_minor}
    end
    table.insert(parsers,parser)    
  end
  local function parser(str) 
    local obj
    for i,v in ipairs(parsers) do
      obj = v(str)
      if obj then
        return obj
      end
    end
    return obj or {family="Other"};
  end
  return parser
end
return operating_system
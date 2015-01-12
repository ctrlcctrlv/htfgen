kpse.set_program_name("luatex")
local loadenc = {}

loadenc.load = function(enc)
  local filename = kpse.find_file(enc,"enc files") or enc
  print(enc,filename)
	if not filename then return nil, "cannot load end ".. enc end
  local f = io.open(filename,"r")
  local contents = f:read("*all")
  f:close()
  local encoding = contents:match("/[^%s]+%s*%[(.-)%]%s*def")
  encoding = encoding:gsub("%%[^\n]*","")
  return encoding
end

loadenc.parse = function(s)
	local s = s or ""
  local t = {}
  local i = 0
  s:gsub("/([%a%.]+)", function(a)
    t[i] = a
    i = i + 1
  end)
  return t
end


-- k = loadenc.load("ntxmiaalt")
-- loadenc.parse(k)

return loadenc

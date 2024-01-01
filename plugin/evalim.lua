local vim = vim
local vnamespace = vim.api.nvim_create_namespace("evalim")

local function lshift(x, by)
  return x * 2 ^ by
end

local function rshift(x, by)
  return math.floor(x / 2 ^ by)
end

local _env = {
  ipairs = ipairs,
  next = next,
  pairs = pairs,
  pcall = pcall,
  tonumber = tonumber,
  tostring = tostring,
  type = type,
  unpack = unpack,
  coroutine = {
    create = coroutine.create,
    resume = coroutine.resume,
    running = coroutine.running,
    status = coroutine.status,
    wrap = coroutine.wrap
  },
  string = {
    byte = string.byte,
    char = string.char,
    find = string.find,
    format = string.format,
    gmatch = string.gmatch,
    gsub = string.gsub,
    len = string.len,
    lower = string.lower,
    match = string.match,
    rep = string.rep,
    reverse = string.reverse,
    sub = string.sub,
    upper = string.upper
  },
  table = {
    insert = table.insert,
    maxn = table.maxn,
    remove = table.remove,
    sort = table.sort
  },
  math = {
    abs = math.abs,
    acos = math.acos,
    asin = math.asin,
    atan = math.atan,
    atan2 = math.atan2,
    ceil = math.ceil,
    cos = math.cos,
    cosh = math.cosh,
    deg = math.deg,
    exp = math.exp,
    floor = math.floor,
    fmod = math.fmod,
    frexp = math.frexp,
    huge = math.huge,
    ldexp = math.ldexp,
    log = math.log,
    log10 = math.log10,
    max = math.max,
    min = math.min,
    modf = math.modf,
    pi = math.pi,
    pow = math.pow,
    rad = math.rad,
    random = math.random,
    sin = math.sin,
    sinh = math.sinh,
    sqrt = math.sqrt,
    tan = math.tan,
    tanh = math.tanh
  },
  os = { clock = os.clock, difftime = os.difftime, time = os.time, },
  evalim = { lshift = lshift, rshift = rshift }
}

local function _evalim()
  vim.api.nvim_buf_clear_namespace(0, vnamespace, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for idx, line in ipairs(lines) do
    if line then
      local _, y = string.find(line, "evalim: ")
      if y then
        local ret, err = pcall(load("return" .. " " .. string.sub(line, y + 1, -1), nil, "t", _env))
        vim.api.nvim_buf_set_extmark(0, vnamespace, idx - 1, 0, {
          virt_text = {
            { "[" .. tostring(err or ret) .. "]", "Special" }
          }
        })
      end
    end
  end
end

evalim = {
  evalim = _evalim,
  env = _env,
}

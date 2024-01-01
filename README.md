# evalim

evalim is a neovim plugin which allows inline evaluation of lua code.

# Example Usage

```lua
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TextChangedI", "TextChangedI" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    evalim.evalim()
  end
})
```

# Demo

https://github.com/Kraust/evalim/assets/6548135/fd7ccce5-3bce-4bdb-bd34-c3a792470a80

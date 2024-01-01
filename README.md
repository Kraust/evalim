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

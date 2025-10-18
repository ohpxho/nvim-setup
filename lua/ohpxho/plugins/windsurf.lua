local setup, codeium = pcall(require, "codeium")
if not setup then
  return
end

codeium.setup({})

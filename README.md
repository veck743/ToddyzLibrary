# ToddyzLibrary

Lib de UI leve e direta. O foco aqui é ter algo funcional, com animações suaves e sem pesar no script.

## Como usar

```lua
local ToddyzLibrary = loadstring(game:HttpGet("[https://raw.githubusercontent.com/veck743/ToddyzLibrary/main/Library.lua](https://raw.githubusercontent.com/veck743/ToddyzLibrary/main/Library.lua)"))()

local Menu = ToddyzLibrary:CreateWindow("Seu Título")
local Tab = Menu:CreateTab("Início")

-- Botão padrão
Tab:CreateButton("Executar", function()
    print("Botão clicado!")
end)

-- Toggle (ON/OFF)
Tab:CreateToggle("Modo Ativo", function(estado)
    print("Estado atual: " .. tostring(estado))
end)

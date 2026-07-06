# ToddyzLibrary 🇧🇷

Library feita pra você usar pro seu jogo, usável para comandos e outras coisas. feito por um Brasileiro

## Como usar ❓

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

# ToddyzLibrary 🇧🇷

Salve! Criei essa Library pra quem quer fazer uma UI rápida e sem dor de cabeça no Roblox. Ela é bem leve, simples e serve pra qualquer script que você precisar.

## Como usa ❓

Pra usar não tem segredo, é só copiar esse `loadstring` e jogar no topo do seu script:

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

-- Input de texto
Tab:CreateInput("Digite algo...", function(texto)
    print("Você digitou: " .. texto)
end)

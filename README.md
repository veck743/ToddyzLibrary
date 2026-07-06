# ToddyzLibrary 🇧🇷

**Toddyz Library Roblox** é uma biblioteca Lua leve para criação de interfaces (UI) em scripts Roblox.

Criada para desenvolvedores Roblox que querem criar menus, botões, toggles e inputs de forma rápida e simples, sem precisar montar toda a interface do zero.

## 📚 Documentação Oficial

Acesse a documentação:
https://veck743.github.io/ToddyzLibrary/

## 🔧 Como usar

Para usar a ToddyzLibrary, basta adicionar o `loadstring` no início do seu script:

```lua
local ToddyzLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/veck743/ToddyzLibrary/main/Library.lua"))()

local Menu = ToddyzLibrary:CreateWindow("Seu Título")
local Tab = Menu:CreateTab("Início")

Tab:CreateButton("Executar", function()
    print("Botão clicado!")
end)

Tab:CreateToggle("Modo Ativo", function(estado)
    print("Estado atual: " .. tostring(estado))
end)

Tab:CreateInput("Digite algo...", function(texto)
    print("Você digitou: " .. texto)
end)
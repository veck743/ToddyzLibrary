# ToddyzLibrary 🇧🇷

Uma lib de UI simples que fiz pra agilizar a criação de menus no Roblox. O foco aqui é ter algo funcional e sem enrolação.

## Como usar

Só jogar esse `loadstring` no topo do seu script:

```lua
local ToddyzLibrary = loadstring(game:HttpGet("[https://raw.githubusercontent.com/veck743/ToddyzLibrary/main/Library.lua](https://raw.githubusercontent.com/veck743/ToddyzLibrary/main/Library.lua)"))()

local Menu = ToddyzLibrary:CreateWindow("Seu Título")
local Tab = Menu:CreateTab("Início")

Tab:CreateButton("Botão", function()
    print("Funcionou!")
end)

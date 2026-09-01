-- ====================================================================================================
-- ECLIPSE HUB: MASTER LOADER (UN SOLO EJECUTABLE PARA TU EXPLOIT)
-- ====================================================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 1. Limpieza de instancias anteriores para evitar duplicados en pantalla
pcall(function()
    if CoreGui:FindFirstChild("EclipseHubMainGUI") then
        CoreGui.EclipseHubMainGUI:Destroy()
    end
end)

-- 2. Contenedor Principal de la Interfaz
local MainScreenGui = Instance.new("ScreenGui")
MainScreenGui.Name = "EclipseHubMainGUI"
MainScreenGui.Parent = CoreGui
MainScreenGui.ResetOnSpawn = false
MainScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local HubWindowFrame = Instance.new("Frame")
HubWindowFrame.Name = "HubWindowFrame"
HubWindowFrame.Size = UDim2.new(0, 750, 0, 480)
HubWindowFrame.Position = UDim2.new(0.5, -375, 0.5, -240)
HubWindowFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
HubWindowFrame.BorderSizePixel = 0
HubWindowFrame.Active = true
HubWindowFrame.Draggable = true
HubWindowFrame.Parent = MainScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 10)
WindowCorner.Parent = HubWindowFrame

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = Color3.fromRGB(120, 50, 200)
WindowStroke.Thickness = 2
WindowStroke.Parent = HubWindowFrame

-- 3. Barra Superior (Header)
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Parent = HubWindowFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = HeaderFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = 'ECLIPSE HUB <font color="#a250ff">[PRO]</font>'
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.RichText = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = HeaderFrame

-- 4. Contenedor de Contenido / Pestañas (Tabs)
local TabsContainer = Instance.new("ScrollingFrame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Size = UDim2.new(1, -220, 1, -65)
TabsContainer.Position = UDim2.new(0, 210, 0, 55)
TabsContainer.BackgroundTransparency = 1
TabsContainer.BorderSizePixel = 0
TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabsContainer.ScrollBarThickness = 4
TabsContainer.Parent = HubWindowFrame

-- 5. Menú Lateral (Sidebar) y Visor 3D
local SidebarFrame = Instance.new("Frame")
SidebarFrame.Size = UDim2.new(0, 195, 1, -60)
SidebarFrame.Position = UDim2.new(0, 10, 0, 55)
SidebarFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
SidebarFrame.BorderSizePixel = 0
SidebarFrame.Parent = HubWindowFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = SidebarFrame

local ViewportContainer = Instance.new("ViewportFrame")
ViewportContainer.Size = UDim2.new(1, -10, 0, 130)
ViewportContainer.Position = UDim2.new(0, 5, 0, 5)
ViewportContainer.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
ViewportContainer.BorderSizePixel = 0
ViewportContainer.Parent = SidebarFrame

local ViewportCorner = Instance.new("UICorner")
ViewportCorner.CornerRadius = UDim.new(0, 6)
ViewportCorner.Parent = ViewportContainer

pcall(function()
    local charClone = LocalPlayer.Character and LocalPlayer.Character:Clone()
    if charClone then
        charClone.Parent = ViewportContainer
        local camera = Instance.new("Camera")
        ViewportContainer.CurrentCamera = camera
        camera.Parent = charClone
        
        local rootPart = charClone:FindFirstChild("HumanoidRootPart")
        if rootPart then
            camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 1, -3.5), rootPart.Position)
        end
    end
end)

-- Función auxiliar para cargar los módulos externos desde GitHub en segundo plano
local function loadModule(rawUrl)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(rawUrl))()
    end)
    if success then
        return result
    else
        warn("[Eclipse Hub Error]: No se pudo cargar el módulo: " .. tostring(result))
        return nil
    end
end

-- 6. Función auxiliar para botones del menú lateral
local function CreateSidebarButton(name, posY, onClickCallback)
    local sBtn = Instance.new("TextButton")
    sBtn.Size = UDim2.new(1, -10, 0, 38)
    sBtn.Position = UDim2.new(0, 5, 0, posY)
    sBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    sBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
    sBtn.TextSize = 12
    sBtn.Font = Enum.Font.GothamBold
    sBtn.Text = name
    sBtn.Parent = SidebarFrame

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = sBtn

    sBtn.MouseButton1Click:Connect(onClickCallback)
    return sBtn
end

-- Botones del Menú (Conectados a la carga de GitHub)
CreateSidebarButton("⚡ Auto Steal", 145, function()
    -- Reemplaza con tu enlace Raw real de autosteal.lua cuando lo subas
    -- local module = loadModule("https://raw.githubusercontent.com/abrzlxope-tech/eclipse-hub/main/autosteal.lua")
    print("[Eclipse Hub]: Pestaña Auto Steal seleccionada.")
end)

CreateSidebarButton("🌍 Server Hop", 188, function()
    -- local module = loadModule("https://raw.githubusercontent.com/abrzlxope-tech/eclipse-hub/main/serverhop.lua")
    print("[Eclipse Hub]: Pestaña Server Hop seleccionada.")
end)

CreateSidebarButton("📦 Configs & Loads", 231, function()
    -- local module = loadModule("https://raw.githubusercontent.com/abrzlxope-tech/eclipse-hub/main/loads.lua")
    print("[Eclipse Hub]: Pestaña Loads seleccionada.")
end)

CreateSidebarButton("⚙️ Misc & Anti-Lag", 274, function()
    -- local module = loadModule("https://raw.githubusercontent.com/abrzlxope-tech/eclipse-hub/main/misc.lua")
    print("[Eclipse Hub]: Pestaña Misc seleccionada.")
end)

print("[Eclipse Hub]: Sistema maestro inicializado con éxito.")

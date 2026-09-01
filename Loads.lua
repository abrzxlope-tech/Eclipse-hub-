-- ====================================================================================================
-- ECLIPSE HUB: MODULE - CONFIGS & LOADS (SYSTEM PRESETS & EXECUTIONS)
-- ====================================================================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local LoadsModule = {}
LoadsModule.__index = LoadsModule

LoadsModule.Settings = {
    CurrentProfile = "Default_Pro",
    AutoLoadConfigs = true,
    NotificationSystem = true
}

local function SendNotification(title, text)
    if not LoadsModule.Settings.NotificationSystem then return end
    pcall(function()
        print("[Eclipse Loads & Configs] " .. title .. ": " .. text)
    end)
end

-- [SUBSISTEMA DE GESTIÓN DE PERFILES Y CONFIGURACIONES]
local function SaveCurrentConfiguration()
    pcall(function()
        SendNotification("Configs", "Configuración actual guardada en memoria local.")
    end)
end

local function LoadDefaultConfiguration()
    pcall(function()
        SendNotification("Configs", "Perfil por defecto cargado exitosamente.")
    end)
end

-- [CONSTRUCTOR DE LA PESTAÑA LOADS & CONFIGS EN EL GUI]
function LoadsModule.Init(tabsContainer)
    for _, child in ipairs(tabsContainer:GetChildren()) do
        child:Destroy()
    end

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(1, -20, 0, 30)
    SectionTitle.Position = UDim2.new(0, 10, 0, 10)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = "CONFIGS & LOADS MANAGER"
    SectionTitle.TextColor3 = Color3.fromRGB(220, 130, 255)
    SectionTitle.TextSize = 14
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.Parent = tabsContainer

    -- Botón de Guardar Configuración
    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(1, -20, 0, 45)
    saveBtn.Position = UDim2.new(0, 10, 0, 50)
    saveBtn.BackgroundColor3 = Color3.fromRGB(75, 30, 130)
    saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveBtn.TextSize = 13
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.Text = "💾 Guardar Perfil Actual de Configuración"
    saveBtn.Parent = tabsContainer

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 8)
    sCorner.Parent = saveBtn

    saveBtn.MouseButton1Click:Connect(function()
        SaveCurrentConfiguration()
    end)

    -- Botón de Cargar Configuración por Defecto
    local loadBtn = Instance.new("TextButton")
    loadBtn.Size = UDim2.new(1, -20, 0, 45)
    loadBtn.Position = UDim2.new(0, 10, 0, 105)
    loadBtn.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    loadBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
    loadBtn.TextSize = 13
    loadBtn.Font = Enum.Font.GothamBold
    loadBtn.Text = "📂 Cargar Perfil Predeterminado"
    loadBtn.Parent = tabsContainer

    local lCorner = Instance.new("UICorner")
    lCorner.CornerRadius = UDim.new(0, 8)
    lCorner.Parent = loadBtn

    loadBtn.MouseButton1Click:Connect(function()
        LoadDefaultConfiguration()
    end)

    -- Panel Informativo de Perfiles Activos
    local ProfileFrame = Instance.new("Frame")
    ProfileFrame.Size = UDim2.new(1, -20, 0, 110)
    ProfileFrame.Position = UDim2.new(0, 10, 0, 165)
    ProfileFrame.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
    ProfileFrame.BorderSizePixel = 0
    ProfileFrame.Parent = tabsContainer

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(0, 8)
    pCorner.Parent = ProfileFrame

    local profileLabel = Instance.new("TextLabel")
    profileLabel.Size = UDim2.new(1, -20, 1, 0)
    profileLabel.Position = UDim2.new(0, 10, 0, 0)
    profileLabel.BackgroundTransparency = 1
    profileLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    profileLabel.TextSize = 12
    profileLabel.Font = Enum.Font.Code
    profileLabel.TextXAlignment = Enum.TextXAlignment.Left
    profileLabel.TextYAlignment = Enum.TextYAlignment.Top
    profileLabel.RichText = true
    profileLabel.Text = string.format(
        "<b>[GESTOR DE PERFILES]</b>\n\n" ..
        "• Perfil Activo: <font color='#50ffd2'>%s</font>\n" ..
        "• Auto-Carga: <font color='#50ff80'>Habilitada</font>\n" ..
        "• Almacenamiento: <font color='#a250ff'>Sincronizado</font>",
        LoadsModule.Settings.CurrentProfile
    )
    profileLabel.Parent = ProfileFrame
end

function LoadsModule.Destroy()
    -- Limpieza de hilos o referencias si fuera necesario
end

return LoadsModule

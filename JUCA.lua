local imgui = require 'mimgui'
local memory = require 'memory'
local MDS = MONET_DPI_SCALE
local ffi = require 'ffi'
local new = imgui.new
local ev = require('lib.samp.events')
local sampEvents = require("lib.samp.events")
local events = require 'lib.samp.events'
local faicons = require('fAwesome6')
local gta = ffi.load('GTASA')
local se = require("samp.events")
local v = imgui.new.bool(false)
local espectando = new.bool(false)
local mostrar_controles = new.bool(false)
local id_jogador = new.int(0)
local act = imgui.new.bool(false)
local playerIdBuffer = imgui.new.char(10)  
local trollCheckbox = imgui.new.bool(false)
local bypass = false
local playerID = ffi.new("char[128]")
local vehicleID = ffi.new("char[128]")
local active = false
local windowAdmins = imgui.new.bool(false)
local admins = {}
local checkboxActive = imgui.new.bool(false)
local playerIdInput = imgui.new.int(0)
local lastTeleportTime = 0
local messageDelay = 1000
local carshot_active = imgui.new.bool(false)
local carshot_speed = imgui.new.float(50.0)
local esp_2d = imgui.new.bool(false)
local esp_3d = imgui.new.bool(false)

local new = imgui.new
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local widgets = require('widgets')
local ammo = new.int(500)
local noFallAnimation = imgui.new.bool(false)
local fastreload = imgui.new.bool(false)
local weapon_id = new.int(31)
local reparar = imgui.new.bool(false)
local rainbow = imgui.new.bool(false)
local ffi = require 'ffi'
local grudarAtivado = imgui.new.bool(false)
local targetID = imgui.new.int(0)
local gta = ffi.load('GTASA')
local SAMemory = require 'SAMemory'
local encoding = require 'encoding'
local vector3d = require("vector3d")
SAMemory.require("CCamera")
local json = require 'json'
local inicfg = require 'inicfg'
local ltn12 = require("ltn12")
local playerIdToAdd = ffi.new("int[1]", 0)
local kk = imgui.new.bool(false)
local tpres = true
local kk1 = imgui.new.bool(false)
local animCheckbox = imgui.new.bool(false)
local fireCheckbox = imgui.new.bool(false)
local MDS = MONET_DPI_SCALE
local DPI = MONET_DPI_SCALE
local window = imgui.new.bool(false)
local camera = SAMemory.camera
local screenWidth, screenHeight = getScreenResolution()
local configFilePath = getWorkingDirectory() .. "/config/config.json"
local circuloFOVAIM = false
local se = require("samp.events")

local weapons = {
    {id = 22, delay = 160, dmg = 8.25, distance = 35, camMode = 53, weaponState = 2},
    {id = 23, delay = 120, dmg = 13.2, distance = 35, camMode = 53, weaponState = 2},
    {id = 24, delay = 800, dmg = 46.2, distance = 35, camMode = 53, weaponState = 2},
    {id = 25, delay = 800, dmg = 3.3, distance = 40, camMode = 53, weaponState = 1},
    {id = 26, delay = 120, dmg = 3.3, distance = 35, camMode = 53, weaponState = 2},
    {id = 27, delay = 120, dmg = 4.95, distance = 40, camMode = 53, weaponState = 2},
    {id = 28, delay = 50, dmg = 6.6, distance = 35, camMode = 53, weaponState = 2},
    {id = 29, delay = 90, dmg = 8.25, distance = 45, camMode = 53, weaponState = 2},
    {id = 30, delay = 90, dmg = 9.9, distance = 70, camMode = 53, weaponState = 2},
    {id = 31, delay = 90, dmg = 9.9, distance = 90, camMode = 53, weaponState = 2},
    {id = 32, delay = 70, dmg = 6.6, distance = 35, camMode = 53, weaponState = 2},
    {id = 33, delay = 800, dmg = 24.75, distance = 100, camMode = 53, weaponState = 1},
    {id = 34, delay = 900, dmg = 41.25, distance = 320, camMode = 7, weaponState = 1},
    {id = 38, delay = 20, dmg = 46.2, distance = 75, camMode = 53, weaponState = 2},
}

local config = {
    ignorePlayerId = ffi.new("int[1]", 0),
    ignoredPlayers = {}
}

local MULTIPLAYER = {
    MOBILES = new.bool(false),
    RESPAWNAR = new.bool(false),
}

local FlyCar = {
    enabled = imgui.new.bool(false),
    bypass = imgui.new.bool(false),
    speed = imgui.new.float(10.0),
    cars = 0
}

local sulista = {
	teste64 = new.bool(false),
	RVANKA = imgui.new.bool(),
	ativado = imgui.new.bool(false),
    rvanka = false,
    DELAYRVK = imgui.new.int(10),
    RVK_DISTANCIA = imgui.new.int(100),
    ONLINE = imgui.new.bool(),
    RANGE = imgui.new.float(10.0),
    DDELAY = imgui.new.int(17),
    teste32 = new.bool(false),
    exibirAdminsProximos = imgui.new.bool(false),
}

local tp = {
	teleportlegit = imgui.new.bool(false),
	setarint_ativo = imgui.new.bool(false),
	byspawn_ativo = imgui.new.bool(false),
}

local script = { bypass = false }
local checkpointX, checkpointY, checkpointZ

local autoKill = imgui.new.bool(false)
local killedPlayers = {}
local targetPlayer = nil

local buttonPressedTime = 0
local buttonRepeatInterval = 0.0
local renderWindow = imgui.new.bool(false)
local buttonSize = imgui.ImVec2(120 * DPI, 60 * DPI)
local WinState = imgui.new.bool()
local renderWindow = imgui.new.bool()
local sizeX, sizeY = getScreenResolution()
local BOTAO = 2
local activeTab = 2
local SCREEN_W, SCREEN_H = getScreenResolution()

local bones = { 3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2 }
local font = renderCreateFont("Arial", 12, 1 + 4)
ffi.cdef("typedef struct RwV3d { float x; float y; float z; } RwV3d; void _ZN4CPed15GetBonePositionER5RwV3djb(void* thiz, RwV3d* posn, uint32_t bone, bool calledFromCam);")
ffi.cdef([[ void _Z12AND_OpenLinkPKc(const char* link); ]])
ignoredPlayers = {}


local function shouldIgnorePlayer(playerId)
    for _, id in ipairs(ignoredPlayers) do
        if id == playerId then
            return true
        end
    end
    return false
end

local function addIgnoredPlayer(playerId)
    if not table.contains(ignoredPlayers, playerId) then
        table.insert(ignoredPlayers, playerId)
    end
end

local function removeIgnoredPlayer(playerId)
    for i, id in ipairs(ignoredPlayers) do
        if id == playerId then
            table.remove(ignoredPlayers, i)
            break
        end
    end
end

local function shouldIgnorePlayer(playerId)
    for _, id in ipairs(ignoredPlayers) do
        if id == playerId then
            return true
        end
    end
    return false
end

local function loadConfig()
    local file = io.open(configFilePath, "r")
    if file then
        local content = file:read("*a")
        file:close()
        local config = json.decode(content)
        if config and config.slide then
            slide.FoVVHG[0] = tonumber(config.slide.FoVVHG) or slide.FoVVHG[0]
            slide.fovX[0] = tonumber(config.slide.fovX) or slide.fovX[0]
            slide.fovY[0] = tonumber(config.slide.fovY) or slide.fovY[0]          
            slide.fovvaimbotcirculo[0] = tonumber(config.slide.fovvaimbotcirculo) or slide.fovvaimbotcirculo[0]
            slide.DistanciaAIM[0] = tonumber(config.slide.DistanciaAIM) or slide.DistanciaAIM[0]
            slide.aimSmoothhhh[0] = tonumber(config.slide.aimSmoothhhh) or slide.aimSmoothhhh[0]
            slide.fovCorAimmm[0] = tonumber(config.slide.fovCorAimmm) or slide.fovCorAimmm[0]
            slide.posiX[0] = tonumber(config.slide.posiX) or slide.posiX[0]
            slide.posiY[0] = tonumber(config.slide.posiY) or slide.posiY[0]
            slide.circulooPosX[0] = tonumber(config.slide.circulooPosX) or slide.circulooPosX[0]
            slide.circuloooPosY[0] = tonumber(config.slide.circuloooPosY) or slide.circuloooPosY[0]
            slide.distancia[0] = tonumber(config.slide.distancia) or slide.distancia[0]
            slide.fovColor[0] = tonumber(config.slide.fovColorR) or slide.fovColor[0]
            slide.fovColor[1] = tonumber(config.slide.fovColorG) or slide.fovColor[1]
            slide.fovColor[2] = tonumber(config.slide.fovColorB) or slide.fovColor[2]
            slide.fovColor[3] = tonumber(config.slide.fovColorA) or slide.fovColor[3]
        end
    end
end

local function saveConfig()
    local config = {
        slide = {
            FoVVHG = slide.FoVVHG[0],
            fovX = slide.fovX[0],
            fovY = slide.fovY[0],
            fovvaimbotcirculo = slide.fovvaimbotcirculo[0],
            DistanciaAIM = slide.DistanciaAIM[0],
            aimSmoothhhh = slide.aimSmoothhhh[0],
            fovCorAimmm = slide.fovCorAimmm[0],
            posiX = slide.posiX[0],
            posiY = slide.posiY[0],
            circulooPosX = slide.circulooPosX[0],
            circuloooPosY = slide.circuloooPosY[0],
            distancia = slide.distancia[0],
            fovColorR = slide.fovColor[0],
            fovColorG = slide.fovColor[1],
            fovColorB = slide.fovColor[2],
            fovColorA = slide.fovColor[3],
        }
    }
    local file = io.open(configFilePath, "w")
    if file then
        file:write(json.encode(config))
        file:close()
    end
end

local function randomizeToggleButtons()
    while sulist.ativarRandomizacao[0] do
        sulist.peito[0].Checked = math.random(0, 1) == 1
        sulist.braco[0].Checked = math.random(0, 1) == 1
        sulist.braco2[0].Checked = math.random(0, 1) == 1
        sulist.cabeca[0].Checked = math.random(0, 4) == 1
        
        wait(40)
    end
end

local function isAnyToggleButtonActive()
    return sulist.cabeca[0].Checked or sulist.perna[0].Checked or sulist.virilha[0].Checked or sulist.pernas2[0].Checked or sulist.peito[0].Checked or sulist.braco[0].Checked or sulist.braco2[0].Checked or ativarMatarAtravesDeParedes[0].Checked
end

local ui_meta = {
    __index = function(self, v)
        if v == "switch" then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false
                end
                self.timer = os.clock()
                self.state = not self.state

                self.process = lua_thread.create(function()
                    local bringFloatTo = function(from, to, start_time, duration)
                        local timer = os.clock() - start_time
                        if timer >= 0.00 and timer <= duration then
                            local count = timer / (duration / 100)
                            return count * ((to - from) / 100)
                        end
                        return (timer > duration) and to or from
                    end

                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                    end
                end)
                return true
            end
            return switch
        end
 
        if v == "alpha" then
            return self.state and 1.00 or 0.00
        end
    end
}

local menu = { state = false, duration = 1.15 }
setmetatable(menu, ui_meta)



--fim local aimbot

--silent

local online = false
local var_0_10 = renderCreateFont("Verdana", 12, 4, FCR_BOLD + FCR_BORDER)
local var_0_0 = require("samp.events")
local carInput = imgui.new.char[256]()  

local enabled = false
local was_in_car = false
local last_car

local silentcabeca = imgui.new.bool(false)
local silentpeito = imgui.new.bool(false)
local silentvirilha = imgui.new.bool(false)
local silentbraco = imgui.new.bool(false)
local silentbraco2 = imgui.new.bool(false)
local silentperna = imgui.new.bool(false)
local silentperna2 = imgui.new.bool(false)

local bypass2 = false

local renderWindow = imgui.new.bool(false)
local selectedTab = 1
local state = false
local targetId = -1
local miss = false
local ped = nil
local fakemode = imgui.new.bool(false)

local directIni = 'JUCA MENU'
local ini = inicfg.load({
    search = {
        canSee = true,
        radius = 100,
        ignoreCars = true,
        distance = 500,
        useWeaponRadius = true,
        useWeaponDistance = true,
        ignoreObj = true
    },
    render = {
        line = true,
        circle = true,
        fpscircle = true,
        printString = true
    },
    shoot = {
        misses = false,
        miss_ratio = 3,
        removeAmmo = false,
        doubledamage = false,
        tripledamage = false
    }
}, directIni)

inicfg.save(ini, directIni)

local settings = {
    search = {
        canSee = imgui.new.bool(ini.search.canSee),
        radius = imgui.new.int(ini.search.radius),
        ignoreCars = imgui.new.bool(ini.search.ignoreCars),
        distance = imgui.new.int(ini.search.distance),
        useWeaponRadius = imgui.new.bool(ini.search.useWeaponRadius),
        useWeaponDistance = imgui.new.bool(ini.search.useWeaponDistance),
        ignoreObj = imgui.new.bool(ini.search.ignoreObj)
    },
    render = {
        line = imgui.new.bool(ini.render.line),
        circle = imgui.new.bool(ini.render.circle),
        fpscircle = imgui.new.bool(ini.render.fpscircle),
        printString = imgui.new.bool(ini.render.printString)
    },
    shoot = {
        misses = imgui.new.bool(ini.shoot.misses),
        miss_ratio = imgui.new.int(ini.shoot.miss_ratio),
        removeAmmo = imgui.new.bool(ini.shoot.removeAmmo),
        doubledamage = imgui.new.bool(ini.shoot.doubledamage),
        tripledamage = imgui.new.bool(ini.shoot.tripledamage)
    }
}

math.randomseed(os.time())

local w, h = getScreenResolution()

function getpx()
    local fov = getCameraFov() or 1  
    return ((w / 2) / fov) * settings.search.radius[0]
end

local function updateTargetId()
    if ped then
        local _, id = sampGetPlayerIdByCharHandle(ped)
        if _ then
            targetId = id
        end
    else
        targetId = -1
    end
end


--fim local silent

local ignoredPlayers = {}

local function addIgnoredPlayer(playerId)
    if not table.contains(ignoredPlayers, playerId) then
        table.insert(ignoredPlayers, playerId)
    end
end

local function removeIgnoredPlayer(playerId)
    for i, id in ipairs(ignoredPlayers) do
        if id == playerId then
            table.remove(ignoredPlayers, i)
            break
        end
    end
end

local slide = {
    fovColor = imgui.new.float[4](1.0, 1.0, 1.0, 1.0),
    fovX = imgui.new.float(832.0),
    fovY = imgui.new.float(313.0),
    FoVVHG = imgui.new.float(150.0),
    distancia = imgui.new.int(1000),
    fovvaimbotcirculo = imgui.new.float(200),
    DistanciaAIM = imgui.new.float(1000.0),
    aimSmoothhhh = imgui.new.float(1.000),
    fovCorAimmm = imgui.new.float[4](1.0, 1.0, 1.0, 1.0),
    fovCorsilent = imgui.new.float[4](1.0, 1.0, 1.0, 1.0),
    espcores = imgui.new.float[4](1.0, 1.0, 1.0, 1.0),
    posiX = imgui.new.float(0.520),
    posiY = imgui.new.float(0.439),
    circulooPosX = imgui.new.float(832.0),
    circuloooPosY = imgui.new.float(313.0),
    circuloFOV = false,
    qtdraios = imgui.new.int(5),
    raiosseguidos = imgui.new.int(10),
    larguraraios = imgui.new.int(40),
    HGPROAIM = imgui.new.int(1),
    minFov = 1,
    aimCtdr = imgui.new.int(1),
}

local sulist = {
    cabecaAIM = imgui.new.bool(),
    peitoAIM = imgui.new.bool(),
    bracoAIM = imgui.new.bool(),
    virilhaAIM = imgui.new.bool(),
    braco2AIM = imgui.new.bool(),
    pernaAIM = imgui.new.bool(),
    perna2AIM = imgui.new.bool(),
    PROAIM2 = imgui.new.bool(),
    aimbotparede = imgui.new.bool(false),
    lockAIM = imgui.new.bool()
}


local sampev = require "samp.events"

local ped_airbrake_enabled = false
local speed = 0.3
local was_in_car = false
local last_car
local isPedAirBrakeCheckboxActive = ffi.new("bool[1]", false) 
local autoRegenerarVida = imgui.new.bool(false)
local minusX, minusY = 231, 350
local font2 = renderCreateFont('Arial', 8, 5)

local var_0_10  

local FCR_BOLD = 1
local FCR_BORDER = 4
fontwarp = renderCreateFont("Arial", 9, 4, FCR_BOLD + FCR_BORDER)
 
local function createFont()
    local var_0_10 = renderCreateFont("Arial", 12, 4, FCR_BOLD + FCR_BORDER)
    return var_0_10
end

local players = {}

local aim = {
    renderWindow = {
        renderWindow = imgui.new.bool()
    },
    CheckBox = {
        enableLagger = imgui.new.bool(),
        teste73 = imgui.new.bool(),
        teste56 = imgui.new.bool(),
        teste95 = imgui.new.bool(),
        teste72 = imgui.new.bool(),
        teste11 = imgui.new.bool(),        
        teste53 = new.bool(),
    }
}

local cbugs = {
	lifefoot = imgui.new.bool(false),
	lifefoot1 = imgui.new.bool(false),
	shootingEnabled = imgui.new.bool(false),
	shootingEnabled1 = imgui.new.bool(false),
	clearAnimTime = imgui.new.float(200)
}

local tiroContador = 0
local miraAtual = 3
local currentWeaponID = 0
local shotCount = 0
local isActive = imgui.new.bool(false)
local weaponList = {}
local window = imgui.new.bool(false)
local config = {
    active_tab = imgui.new.int(1),
    godmod = imgui.new.bool(false),
    teste72 = new.bool(false),
    ANTICONGELAR = imgui.new.bool(),
    teste111 = imgui.new.bool(false),
    exibirAdminsProximos = imgui.new.bool(false),
    noreload = imgui.new.bool(false),    
    naotelaradm = new.bool(false),
    atrplay_enabled = new.bool(false),
    ativarfov = new.bool(false),
    alterarfov = new.float(60.0),
    noreload = imgui.new.bool(false),    
    nostun = imgui.new.bool(false),
    noreset = imgui.new.bool(false),
    espcar_enabled = new.bool(false),
    espcarlinha_enablade = new.bool(false),
    espinfo_enabled = new.bool(false),
    espplataforma = new.bool(false),
    ESP_ESQUELETO = imgui.new.bool(false),
    esp_enabled = new.bool(false),
    wallhack_enabled = new.bool(false),
    espcores = imgui.new.float[4](1.0, 1.0, 1.0, 1.0),
    dirsemcombus = imgui.new.bool(false),
    godcar = imgui.new.bool(false),
    motorcar = imgui.new.bool(false),
    pesadocar = imgui.new.bool(false),
    matararea_enabled = imgui.new.bool(false),
}

--[LOCAIS LOGICAS]

local function regenerarVida()
    lua_thread.create(function()
        while autoRegenerarVida[0] do
            wait(100)
            local vidaAtual = getCharHealth(PLAYER_PED)
            if vidaAtual < 100 then
                setCharHealth(PLAYER_PED, vidaAtual + 10)
            end
        end
    end)
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    imgui.GetStyle():ScaleAllSizes(MDS)
    
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    local iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('Regular'), 18, config, iconRanges)

    local style = imgui.GetStyle()
    style.WindowRounding = 13 * MDS
    style.FramePadding = imgui.ImVec2(8 * MDS, 8 * MDS)
    style.ItemSpacing = imgui.ImVec2(12.0 * MDS, 6.0 * MDS)
    style.FrameRounding = 10 * MDS
    style.WindowBorderSize = 2.0 * MDS
    
    -- Fundo com leve degradê
    style.Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.05, 0.05, 0.05, 1.0)
    style.Colors[imgui.Col.Border] = imgui.ImVec4(1.0, 1.0, 1.0, 1.0)

    -- Botões com efeito moderno
    style.Colors[imgui.Col.Button] = imgui.ImVec4(0.9, 0.2, 0.2, 1.0)
    style.Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(1.0, 0.3, 0.3, 1.0)
    style.Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.8, 0.1, 0.1, 1.0)

    style.Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.1, 0.1, 0.1, 1.0)
    style.Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.2, 0.2, 0.2, 1.0)
    style.Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.3, 0.3, 0.3, 1.0)

    style.Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.9, 0.2, 0.2, 1.0)
    style.Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(1.0, 0.3, 0.3, 1.0)
end)

imgui.OnFrame(function()
    return window[0]
end, function()
    local resX, resY = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(850 * MDS, 520 * MDS), imgui.Cond.Always) -- Aumentei um pouco mais

    imgui.Begin("NESCAU COMMUNITY", window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)

    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("JUCA MENU 1.0").x) / 2)
    imgui.TextColored(imgui.ImVec4(1.0, 1.0, 1.0, 1.0), "JUCA MENU")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(1.0, 0.2, 0.2, 1.0), " 3.0")

    local drawList = imgui.GetWindowDrawList()
    local borderColor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(math.sin(os.clock()), math.cos(os.clock()), 1.0, 1.0))
drawList:AddRect(imgui.GetWindowPos(), imgui.ImVec2(imgui.GetWindowPos().x + imgui.GetWindowWidth(), imgui.GetWindowPos().y + imgui.GetWindowHeight()), borderColor, 13 * MDS, nil, 2.5 * MDS)

    imgui.BeginChild("Aba", imgui.ImVec2(180 * MDS, imgui.GetWindowHeight() - 50 * MDS), true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)

    local buttonSize = imgui.ImVec2(160 * MDS, 45 * MDS) -- Ajuste para um melhor alinhamento

    local tabs = {
        {faicons("USER") .. " PLAYER", 1},
        {faicons("raygun") .. " WEAPONS", 2},
        {faicons("CAR") .. " VEHICLES", 3},
        {faicons("EYE") .. " ESP", 4},
        {faicons("CROSSHAIRS") .. " AIMBOT", 5},
        {faicons("SKULL") .. " TROLL", 6},
        {faicons("LOCATION_ARROW") .. " TELEPORTS", 7},
        {faicons("gun") .. "  SILENT AIM", 8},
        {faicons("GEAR") .. "  MISC", 9},
    }

    for _, tab in ipairs(tabs) do
        if imgui.Button(tab[1], buttonSize) then
            config.active_tab[0] = tab[2]
            addOneOffSound(0, 0, 0, 1002)
        end
    end

    imgui.EndChild()
    imgui.SameLine()

    -- Painel de conteúdo das abas
    imgui.BeginChild("Painel", imgui.ImVec2(imgui.GetWindowWidth() - 190 * MDS, imgui.GetWindowHeight() - 50 * MDS), true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)

    if config.active_tab[0] == 1 then
        player_tabs()
    elseif config.active_tab[0] == 2 then
        armas_tabs()
    elseif config.active_tab[0] == 3 then
        veiculos_tabs()
    elseif config.active_tab[0] == 4 then
        esp_tabs()
    elseif config.active_tab[0] == 5 then
        aimbot_tabs()
    elseif config.active_tab[0] == 6 then
        troll_tabs()
        elseif config.active_tab[0] == 7 then
        tele_tabs()
        elseif config.active_tab[0] == 8 then
        sile_tabs()
        elseif config.active_tab[0] == 9 then
        misc_tabs()
    end

    imgui.EndChild()
    imgui.End()
end)

function sendMessagebypass(message)
    sampAddChatMessage("[{00e1ff}JUCA{ffffff}] : " .. message, -1)
end

function misc_tabs()
    imgui.CustomCheckbox(u8"TWIST PLAYER", aim.CheckBox.teste56)
    imgui.CustomCheckbox(u8"TELEPORTE VEICULO PROXIMO", config.teste111) 
    imgui.CustomCheckbox(u8"USAR TAG DO MOD MENU", aim.CheckBox.teste95)   
    imgui.CustomCheckbox("ADMINISTRADORES PRÓXIMOS", windowAdmins)

    imgui.Separator()

    

    imgui.CustomCheckbox("TELEPORTE POR ID", checkboxActive)

    if checkboxActive[0] then
        imgui.Text("Digite o ID do jogador:")
        imgui.InputInt("##playerId", playerIdInput)
        if imgui.Button("Teleportar") then
            warp_to_player(playerIdInput[0])
        end
    end
    
    if imgui.CustomCheckbox("ANIM FUCK", animCheckbox) then
        if animCheckbox[0] then
            taskPlayAnimNonInterruptable(PLAYER_PED, "BIKEd_Back", "BIKED", 100, true, true, true, true, 900)
            
            local message = "ESTA DANÇANDO ~b~O CREU ~g~"
            printString(message, 15000) 
        end
    end
    
    if imgui.CustomCheckbox("TELAR PLAYERS", mostrar_controles) then
        if not mostrar_controles[0] then
            pararSpectar()
        end
    end

    if mostrar_controles[0] then
        imgui.Spacing()
        imgui.Text("ID do Jogador:")
        if imgui.InputInt("##id_input", id_jogador) then
            mostrar_controles[0] = true
        end
        
        if espectando[0] then
            if imgui.Button("Parar Spectar") then
                pararSpectar()
            end
        else
            if imgui.Button("Iniciar Spectar") then
                iniciarSpectar(id_jogador[0])
            end
        end
    end
    
    if imgui.CustomCheckbox("TOCHA HUMANA", fireCheckbox) then
        if fireCheckbox[0] then
            lua_thread.create(function()
                while fireCheckbox[0] do
                    startCharFire(PLAYER_PED)
                    setCharProofs(PLAYER_PED, true, true, true, true, true)
                    wait(500)
                end
            end)
        else
            removeCharFire(PLAYER_PED)
            setCharProofs(PLAYER_PED, false, false, false, false, false)
        end
    end
    
    imgui.Separator()
    
    imgui.CustomCheckbox('ANT RPG', aim.CheckBox.teste72)
          if imgui.CustomCheckbox("CAR SHOT", carshot_active) then
        end
        if carshot_active[0] then
            imgui.SliderFloat("Velocidade", carshot_speed, 10.0, 150.0)
        end
    
end

function sile_tabs()
    imgui.PushFont(font1)
    imgui.Text("SILENT AIM")
    imgui.Separator()
    imgui.PopFont()
    
    imgui.BeginChild("silent_aim_scroll", imgui.GetContentRegionAvail(), true)

    if imgui.Button(state and "DESLIGAR AIM" or "LIGAR AIM") then
        state = not state
        if state then
            lua_thread.create(function() 
                while state do
                    wait(0)
                    updateTargetId()
                end
            end)
        end
    end

    imgui.PushFont(font1)
    imgui.Text("ÁREAS ALVO")
    imgui.Separator()
    imgui.PopFont()

    imgui.CustomCheckbox("CABEÇA", silentcabeca)
    imgui.CustomCheckbox("PEITO", silentpeito)
    imgui.CustomCheckbox("VIRILHA", silentvirilha)
    imgui.CustomCheckbox("BRAÇO DIREITO", silentbraco)
    imgui.CustomCheckbox("BRAÇO ESQUERDO", silentbraco2)
    imgui.CustomCheckbox("PERNA DIREITA", silentperna)
    imgui.CustomCheckbox("PERNA ESQUERDA", silentperna2)

    imgui.PushFont(font1)
    imgui.Text("CONFIGURAÇÕES")
    imgui.Separator()
    imgui.PopFont()

    if imgui.CustomCheckbox("IGNORAR PAREDE", settings.search.ignoreObj) then
        ini.search.ignoreObj = settings.search.ignoreObj[0]
        save()
    end

    imgui.PushFont(font1)
    imgui.Text("LINHA NO ALVO")
    imgui.Separator()
    imgui.PopFont()

    if imgui.CustomCheckbox("ATIVAR LINHA", settings.render.line) then
        ini.render.line = settings.render.line[0]
        save()
    end

    imgui.PushFont(font1)
    imgui.Text("CONFIGURAÇÃO DO FOV")
    imgui.Separator()
    imgui.PopFont()

    if imgui.CustomCheckbox("ATIVAR FOV", settings.render.circle) then
        ini.render.circle = settings.render.circle[0]
        save()
    end

    imgui.Text("TAMANHO DO FOV")
    if imgui.SliderInt("FOV", settings.search.radius, 1, 60) then
        ini.search.radius = settings.search.radius[0]
        save()
    end

    imgui.Text("COR DO FOV")
    imgui.ColorEdit4("FOV COR", slide.fovCorsilent)

    if not settings.search.useWeaponDistance[0] then
        imgui.PushFont(font1)
        imgui.Text("DISTÂNCIA MÁXIMA")
        imgui.Separator()
        imgui.PopFont()

        if imgui.SliderInt("DISTÂNCIA", settings.search.distance, 1, 1000) then
            ini.search.distance = settings.search.distance[0]
            save()
        end
    end

    imgui.EndChild()
end

function tele_tabs()
    imgui.Separator()
    imgui.Text("Opções Teleporte:")
    
    if imgui.Button("TELEPORTAR PELO MAPA") then
        coords, posX, posY, posZ = getTargetBlipCoordinates()
        
        if posX and posY and posZ then
            if tp.teleportlegit[0] then
                teleportlegitFunc(posX, posY, posZ)
            else
                teleportNormal(posX, posY, posZ)
            end
        else
            printStringNow("MARQUE NO MAPA !!!, TELEPORTE CANCELADO.", 1000)
        end
    end

    if imgui.Button("TELEPORTAR CHECKPOINT") then
        if tp.teleportlegit[0] then
            teleportlegitFunc(checkpointX, checkpointY, checkpointZ)
        else
            teleportNormal(checkpointX, checkpointY, checkpointZ)
        end
    end

    imgui.Separator()
    imgui.Text("Configurações de Teleporte:")
    imgui.CustomCheckbox("BY PASS LEGIT", tp.teleportlegit)
    imgui.CustomCheckbox("BY PASS INTERIOR", tp.setarint_ativo)
    imgui.CustomCheckbox("BY PASS SPAWN", tp.byspawn_ativo)
    imgui.CustomCheckbox("BY PASS DESATIVAR POS", config.naotelaradm)
end

function troll_tabs()
imgui.Separator()
imgui.CustomCheckbox('FAKE KILL', sulista.teste64)
imgui.CustomCheckbox("HELICOPTERO KILL", sulista.RVANKA)
if sulista.RVANKA[0] then
imgui.SliderInt("DISTANCIA", sulista.RVK_DISTANCIA, 10, 500)
 imgui.SliderInt("DELAY", sulista.DELAYRVK, 0, 5000)
end

imgui.CustomCheckbox("RVANKA POR ID", sulista.ativado)
    if sulista.ativado[0] then
        imgui.Text("ID do Jogador:")
        imgui.InputText("##playerID", playerID, ffi.sizeof(playerID))
        if imgui.Button(sulista.rvanka and "DESATIVAR" or "ATIVAR", imgui.ImVec2(120 * DPI, 30 * DPI)) then
            local id = tonumber(ffi.string(playerID))
            if id and id >= 0 then
                ativarSlapp(id)
            else
                sampAddChatMessage("ID invalido", -1)
            end
        end
    end    
    
    if imgui.CustomCheckbox("GRUDAR VEÍCULO ATÉ EXPLODIR", trollCheckbox) then
		if not trollCheckbox[0] then
			active = false
		end
	end

	if trollCheckbox[0] then
		imgui.InputText("ID DO PLAYER", playerID, 128)
		imgui.InputText("ID DO VEÍCULO", vehicleID, 128)

		if imgui.Button("INICAR/PARAR", imgui.ImVec2(200 * DPI, 30 * DPI)) then
			active = true
			sampAddChatMessage("INICIADA", -1)
		end
	end

imgui.CustomCheckbox('CRASHAR MOBILES', MULTIPLAYER.MOBILES)
imgui.CustomCheckbox("TROLAR VISÃO DOS 'PCS'", act)
imgui.CustomCheckbox(u8'SKIN INVERTIDA', sulista.teste32)
imgui.CustomCheckbox("RVANK CARRO", sulista.ONLINE)
if sulista.ONLINE[0] then
imgui.SliderFloat("DISTANCIA", sulista.RANGE, 10, 500)
imgui.SliderInt("DELAY", sulista.DDELAY, 1, 5000)
    end
imgui.CustomCheckbox("MATAR PLAYERS PERTOS", autoKill) 
if imgui.CustomCheckbox("GRUDAR & BEIJAR", grudarAtivado) then
    end

    if grudarAtivado[0] then
        imgui.Text("ID do Jogador:")
        imgui.InputInt("##targetID", targetID)

        if imgui.Button("GRUDAR & BEIJAR", imgui.ImVec2(150 * MDS, 30 * MDS)) then
            local playerID = targetID[0]
            if sampIsPlayerConnected(playerID) then
                local result, ped = sampGetCharHandleBySampPlayerId(playerID)
                if result then
                    local x, y, z = getCharCoordinates(ped)
                    local px, py, pz = getCharCoordinates(PLAYER_PED)
                    
                    local distancia = getDistanceBetweenCoords3d(x, y, z, px, py, pz)
                    
                    if distancia < 3.0 then
                        setCharCoordinates(PLAYER_PED, x, y, z + 1.0)
                        sampSendChat("/beijar " .. playerID)
                    end
                end
            end
        end
    end
    
end

function sampev.onSendPlayerSync(arg_232_0)
	if sulista.teste32[0] then
		arg_232_0.quaternion[0] = 0
		arg_232_0.quaternion[1] = 1
		arg_232_0.quaternion[2] = 0
		arg_232_0.quaternion[3] = 0
		arg_232_0.position.y = arg_232_0.position.y + 0.2
	end
end

MULTIPLAYER.funcao3 = function()
    while not isSampAvailable() do wait(0) end

    while true do
        wait(0)
        if MULTIPLAYER.MOBILES[0] then
            test = not test
            if state1 then
                state1 = false
                state1 = true
            end
        end
    end
end

FlyCar.processFlyCar = function()
    local car = storeCarCharIsInNoSave(PLAYER_PED)
    local speed = getCarSpeed(car)

    if FlyCar.bypass[0] then
        -- Implementação do bypass para evitar kick/ban
        if speed > FlyCar.speed[0] then
            setCarForwardSpeed(car, FlyCar.speed[0])
        end
    end

    local result, var_1, var_2 = isWidgetPressedEx(WIDGET_VEHICLE_STEER_ANALOG, 0)
    if result then
        local var_1 = var_1 / -64.0
        local var_2 = var_2 / 64.0
        setCarRotationVelocity(car, var_2, 0.0, var_1)
    end

    if isWidgetPressed(WIDGET_ACCELERATE) and speed <= FlyCar.speed[0] then
        FlyCar.cars = FlyCar.cars + 0.4
    end
    if isWidgetPressed(WIDGET_BRAKE) then
        FlyCar.cars = FlyCar.cars - 0.3
        if FlyCar.cars < 0 then FlyCar.cars = 0 end
    end
    if isWidgetPressed(WIDGET_HANDBRAKE) then
        FlyCar.cars = 0
        setCarRotationVelocity(car, 0.0, 0.0, 0.0)
        setCarRoll(car, 0.0)
    end

    setCarForwardSpeed(car, FlyCar.cars)
end

FlyCar.activate = function()
    lua_thread.create(function()
        while FlyCar.enabled[0] do
            if isCharInAnyCar(PLAYER_PED) then
                FlyCar.processFlyCar()
            else
                FlyCar.cars = 0
            end
            wait(0)
        end
    end)
end

lua_thread.create(MULTIPLAYER.funcao3)

if state1 and ID == 13 then return false end

    if state1 and ID == 87 then return false end

if test then
        msync = not msync
        local sync = samp_create_sync_data('aim')
        sync.camMode = 0
    end

    if test then
        fsync = not fsync
        if fsync then
            local sync = samp_create_sync_data('player')
            sync.weapon = 40
            sync.weapon = 0
            sync.weapon = 40
            sync.weapon = 0
            sync.weapon = 40
            sync.weapon = 0
            sync.weapon = 40
            sync.keysData = 256
            sync.send()
            printStringNow("CRASHANDO...", 500)
            return false
        end
    end

function warp_to_player(playerId)
    local result, charHandle = sampGetCharHandleBySampPlayerId(playerId)
    if result then
        local x, y, z = getCharCoordinates(charHandle)
        if os.clock() - lastTeleportTime > messageDelay / 1000 then
            setCharCoordinates(PLAYER_PED, x, y, z)
            lastTeleportTime = os.clock()
            sampAddChatMessage("Teletransportado para o jogador " .. tostring(playerId), 0x00FF00)
        end
    end
end

function sampev.onSendAimSync(data)
    if state then
        data.camMode = 38
    end
end

--silent 

function save()
    inicfg.save(ini, directIni)
end

local function isAnyCheckboxActive()
    return silentcabeca[0] or silentpeito[0] or silentvirilha[0] or silentbraco[0] or silentbraco2[0] or silentperna[0] or silentperna2[0] 
end          


imgui.OnFrame(
    function()
        return state and not isGamePaused()
    end,
    function(circle)
        circle.HideCursor = true
        local xw, yw = getScreenResolution()
        if isCharOnFoot(PLAYER_PED) then
            local greenColor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(slide.fovCorsilent[0], slide.fovCorsilent[1], slide.fovCorsilent[2], slide.fovCorsilent[3]))

       
            if settings.render.circle[0] then
                imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xw / 2, yw / 2.5), getpx(), greenColor, 128, 3)
            end

            local chars = getAllChars()
            local clear = true
            if #chars > 0 then
                for i, v in pairs(chars) do
                    if isCharOnFoot(PLAYER_PED) and chars[i] ~= PLAYER_PED then
                        local _, id = sampGetPlayerIdByCharHandle(chars[i])
                        if _ then
                            local xx, yy, zz = getCharCoordinates(chars[i])
                            local xxx, yyy = convert3DCoordsToScreen(xx, yy, zz)
                            local px, py, pz = getCharCoordinates(PLAYER_PED)
                            local oX, oY = xw / 2, yw / 2.5
                            local x, y = math.abs(xxx - oX), math.abs(yyy - oY)
                            local distFromCenter = math.sqrt(x^2 + y^2)
                            local weapone = getWeaponInfoById(getCurrentCharWeapon(PLAYER_PED))
                            if weapone ~= nil and distFromCenter <= getpx() and isCharOnScreen(chars[i]) and targetId ~= nil then
                                if settings.search.useWeaponDistance[0] and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= weapone.distance then
                                    if settings.render.line[0] then
                                        imgui.GetBackgroundDrawList():AddLine(imgui.ImVec2(oX, oY), imgui.ImVec2(xxx, yyy), greenColor, 2)
                                        imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xxx, yyy), 3, greenColor, 128, 3)
                                    end
                                    if targetId ~= nil then
                                        clear = false
                                        ped = chars[i]
                                    end
                                    break
                                elseif not settings.search.useWeaponDistance[0] and getDistanceBetweenCoords3d(px, py, pz, xx, yy, zz) <= settings.search.distance[0] then
                         if settings.render.line[0] then
    imgui.GetBackgroundDrawList():AddLine(imgui.ImVec2(oX, oY), imgui.ImVec2(xxx, yyy), redColor, 2)
    imgui.GetBackgroundDrawList():AddCircle(imgui.ImVec2(xxx, yyy), 3, redColor, 128, 3)
end
                                    if targetId ~= nil then
                                        clear = false 
                                        ped = chars[i]
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if clear then
                ped = nil
            end
        end
    end
)


function getWeaponInfoById(id)
    for k, weapon in pairs(weapons) do
        if weapon.id == id then
            return weapon
        end
    end
    return nil
end

function rand()
    return math.random(-50, 50) / 100
end

function getMyId()
    return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
end

imgui.OnFrame(function()
    return windowAdmins[0]  -- Retorna corretamente o estado do checkbox
end, function()
    local resX, resY = getScreenResolution()

    imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(300 * MDS, 200 * MDS), imgui.Cond.FirstUseEver)

    imgui.Begin("", windowAdmins, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)

    -- Centralizar o título
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("ADMINS PRÓXIMOS").x) / 2)
    imgui.TextColored(imgui.ImVec4(1.0, 1.0, 1.0, 1.0), "ADMINS ")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(1.0, 0.2, 0.2, 1.0), "PRÓXIMOS")

    imgui.BeginChild("ListaAdmins", imgui.ImVec2(0, 0), true)
    imgui.PushTextWrapPos(0.0)

    if #admins == 0 then
        imgui.Text("Nenhum administrador próximo.")
    else
        for _, admin in ipairs(admins) do
            local r, g, b = math.random(), math.random(), math.random()
            imgui.TextColored(imgui.ImVec4(r, g, b, 1.0), string.format("Nick: %s - ID: %d - Distância: %.2f", admin.name, admin.id, admin.distance))
        end
    end

    imgui.PopTextWrapPos()
    imgui.EndChild()
    imgui.End()
end)

function getDistanceBetweenCoords(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
end

function atualizarAdminsProximos()
    while true do
        wait(1000)
        admins = {}

        for _, handle in ipairs(getAllChars()) do
            local x, y, z = getCharCoordinates(handle)
            local x2, y2, z3 = getCharCoordinates(PLAYER_PED)
            local res, id = sampGetPlayerIdByCharHandle(handle)

            if res then
                local model = getCharModel(handle)
                local playerName = sampGetPlayerNickname(id)
                local distance = getDistanceBetweenCoords(x, y, z, x2, y2, z3)

                if model == 217 or model == 211 or model == -56577 or model == -52327 or
                   string.find(playerName:lower(), "helper") or string.find(playerName:lower(), "staff") then
                    table.insert(admins, {id = id, name = playerName, distance = distance, handle = handle})
                end
            end
        end
    end
end

lua_thread.create(atualizarAdminsProximos)

lua_thread.create(function()
    while true do
        wait(0)
        if #admins > 0 then
            for _, admin in ipairs(admins) do
                local x, y, z = getCharCoordinates(admin.handle)
                local x2, y2, z2 = getCharCoordinates(PLAYER_PED)
                local wX, wY = convert3DCoordsToScreen(x2, y2, z2)
                local wX2, wY2 = convert3DCoordsToScreen(x, y, z)

                if wX and wY and wX2 and wY2 then
                    local cor = math.random(-1, -300000)
                    renderDrawLine(wX, wY, wX2, wY2, 3, cor)
                end
            end
        end
    end
end)

function ev.onSendBulletSync(sync)
    if state then
        local res, _, ped = pcall(sampGetCharHandleBySampPlayerId, targetId)
        if _ and res then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local x, y, z = getCharCoordinates(ped)
            if isLineOfSightClear(x, y, z, mx, my, mz, not settings.search.ignoreObj[0], not settings.search.ignoreCars[0], false, not settings.search.ignoreObj[0], false) then
                local weapon = getWeaponInfoById(getCurrentCharWeapon(PLAYER_PED))
                if weapon ~= nil then
                    lua_thread.create(function() 
                        if sync.targetType == 1 then
                            return
                        end
                        sync.targetType = 1
                        sync.targetId = targetId
                        sync.center = {x = rand(), y = rand(), z = rand()}
                        sync.target = {x = x + rand(), y = y + rand(), z = z + rand()}
                        if settings.shoot.removeAmmo[0] then
                            addAmmoToChar(PLAYER_PED, getCurrentCharWeapon(PLAYER_PED), -1)
                        end
                        if silentcabeca[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 9)
                        end
                        
                        if silentpeito[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 3)
                        end
                        
                        if silentvirilha[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 4)
                        end
                        
                        if silentbraco[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 6)
                        end
                        
                        if silentbraco2[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 5)
                        end
                        
                        if silentperna[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 8)
                        end
                        
                        if silentperna2[0] then
                            sampSendGiveDamage(targetId, weapon.dmg, getCurrentCharWeapon(PLAYER_PED), 7)
                        end
                        
                        if settings.render.printString[0] then
                        end
                    end)
                end
            end
        end
    end
end
 
 function sampev.onSendGiveDamage(targetId, weaponId, damage, pedPiece)
    if bypass then
        return false
    end
end

function sampev.onResetPlayerWeapons()
	if bypass then
		return false
	end
end

function sampev.onRemoveWeapon(weaponId)
    if bypass then
        return false
    end
end

function sampev.onSendBulletSync(data)
    if bypass then
        return false
    end
end

function sampev.onSetCurrentWeapon(weaponId)
    if bypass then
        return false
    end
end

function sampev.onSendTakeDamage(issuerId, weaponId, damage, pedPiece)
    if bypass then
        return false
    end
end

local lastShot = 0

function sampev.onSendBulletSync(data)
    local currentTime = os.clock()
    if bypass and (currentTime - lastShot) < 0.3 then -- Evita tiros muito rápidos
        return false
    end
    lastShot = currentTime
end

function ev.onSendAimSync(data)
    if state and fakemode[0] then
        camX = data.camPos.x
        camY = data.camPos.y
        camZ = data.camPos.z
        
        frontX = data.camFront.x
        frontY = data.camFront.y
        frontZ = data.camFront.z

        local res, _, ped = pcall(sampGetCharHandleBySampPlayerId, targetId)
        if _ and res then
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local x, y, z = getCharCoordinates(ped)
            if isLineOfSightClear(x, y, z, mx, my, mz, not settings.search.ignoreObj[0], not settings.search.ignoreCars[0], false, not settings.search.ignoreObj[0], false) then
                local x = x - mx
                local y = y - my
                local z = z - mz
                local dist = math.sqrt(x * x + y * y + z * z)
                if dist <= settings.search.radius[0] then
                    if settings.shoot.removeAmmo[0] then
                        setCharWeaponAmmo(PLAYER_PED, 0, 0)
                    end
                end
            end
        end
    end
end

function vect3_length(x, y, z)
    return math.sqrt(x * x + y * y + z * z)
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
  
    local raknet = require 'samp.raknet'
    

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
   
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
   
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
   
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
end)

lua_thread.create(function()
	while true do
		wait(0)
		if testewarp then
			local var_4_41, var_4_42, var_4_43 = getCharCoordinates(PLAYER_PED)
            local result, playerId = sampGetPlayerIdByCharHandle(PLAYER_PED)
                
            if result then
                warp_to_player(playerIdInput[0])
            end
        end
    end
end)

function teleportNormal(px, py, pz)
    if px and py and pz then    
        lua_thread.create(function()
            if tp.setarint_ativo[0] then
                setCharInterior(PLAYER_PED, 1)
            end
            
            if tp.byspawn_ativo[0] then
                sampSendSpawn()
            end
                        
            wait(1000)
            freezeCharPosition(PLAYER_PED, true)
            setCharCoordinates(PLAYER_PED, px, py, pz)
            freezeCharPosition(PLAYER_PED, false)

            setCharInterior(PLAYER_PED, 0)
        end)
    else
        printStringNow("NENHUM CHECKPOINT MARCADO !!!, TELEPORTE CANCELADO.", 1000)
    end
end

function teleportlegitFunc(px, py, pz)
    if px and py and pz then
        lua_thread.create(function()
            script.bypass = true
            wait(500)

            local function CoordMaster(targetX, targetY, targetZ)
                local charX, charY, charZ = getCharCoordinates(PLAYER_PED)
                local distance = getDistanceBetweenCoords3d(targetX, targetY, targetZ, charX, charY, charZ)

                if distance <= 1 then
                    setCharCoordinates(PLAYER_PED, targetX, targetY, targetZ)
                else
                    local dx, dy, dz = targetX - charX, targetY - charY, targetZ - charZ
                    charX = charX + 1 / distance * dx
                    charY = charY + 1 / distance * dy
                    charZ = charZ / distance * dz
                    setCharCoordinates(PLAYER_PED, charX, charY, charZ)
                    wait(50)
                    CoordMaster(targetX, targetY, targetZ)
                end
            end

            if tp.setarint_ativo[0] then
                setCharInterior(PLAYER_PED, 1)
            end
            
            if tp.byspawn_ativo[0] then
                sampSendSpawn()
            end

            clearExtraColours(true)
            requestCollision(px, py)
            activateInteriorPeds(true)

            CoordMaster(px, py, pz + 3)
            loadScene(px, py, pz)

            script.bypass = false
            setCharInterior(PLAYER_PED, 0)
        end)
    else
        printStringNow("NENHUM CHECKPOINT MARCADO !!!, TELEPORTE CANCELADO.", 1000)
    end
end

function sampev.onSetCheckpoint(position, radius)
    checkpointX = position.x
    checkpointY = position.y
    checkpointZ = position.z
end

function ativarSlapp(id)
    if not isCharInAnyCar(PLAYER_PED) then
        sampAddChatMessage("Voce nao esta em um veiculo.", -1)
        return
    end

    local result, ped = sampGetCharHandleBySampPlayerId(id)
    if result and doesCharExist(ped) then
        local px, py, pz = getCharCoordinates(ped)
        local ax, ay, az = getCharCoordinates(PLAYER_PED)
        local dist = getDistanceBetweenCoords3d(px, py, pz, ax, ay, az)

        if dist <= 29 then
            pid = id
            victimPed = ped
            sulista.rvanka = not sulista.rvanka
            sampAddChatMessage(sulista.rvanka and "SLAPP ATIVADO" or "SLAPP DESATIVADO", -1)
        else
            sampAddChatMessage("O jogador esta muito longe.", -1)
        end
    else
        sampAddChatMessage("ID invalido ou jogador nao encontrado.", -1)
    end
end

function ev.onSendVehicleSync(data)
    if sulista.rvanka then
        local px, py, pz = getCharCoordinates(victimPed)
        local ax, ay, az = getCharCoordinates(PLAYER_PED)
        local dist = getDistanceBetweenCoords3d(px, py, pz, ax, ay, az)

        if dist <= 29 and sampIsPlayerConnected(pid) then
            data.position = {px, py, pz - 0.7}
            data.moveSpeed = {0, 0, 1}
        else
            sulista.rvanka = false
            sampAddChatMessage("O jogador se afastou.", -1)
        end
    end
end

function sampev.onSendPlayerSync(arg_232_0)
	if sulista.teste32[0] then
		arg_232_0.quaternion[0] = 0
		arg_232_0.quaternion[1] = 1
		arg_232_0.quaternion[2] = 0
		arg_232_0.quaternion[3] = 0
		arg_232_0.position.y = arg_232_0.position.y + 0.2
	end
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    local raknet = require 'samp.raknet'
    require 'samp.synchronization'
    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = { 'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData },
        vehicle = { 'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData },
        passenger = { 'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData },
        aim = { 'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData },
        trailer = { 'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData },
        unoccupied = { 'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil },
        bullet = { 'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil },
        spectator = { 'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil }
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({ send = func_send }, mt)
end

function se.onSendPlayerSync(data)
    if act[0] then
        if math.random(0, 1) == 0 then
            data.weapon = math.random(44, 45)
        end

        if math.random(0, 1) == 1 then
            data.keysData = 132
        end
    end
end

lua_thread.create(function()
    while true do
        wait(0)
        if sulista.ONLINE[0] then
            for _, handle in ipairs(getAllChars()) do
                if handle ~= PLAYER_PED then
                    local res, id = sampGetPlayerIdByCharHandle(handle)
                    local x, y, z = getCharCoordinates(handle)
                    if res and isCharInAnyCar(PLAYER_PED) then
                        local sync = samp_create_sync_data("vehicle")
                        sync.position = {x, y, z - 1.30}
                        sync.moveSpeed = {sulista.RANGE[0], sulista.RANGE[0], sulista.RANGE[0]}
                        sync.send()
                        wait(sulista.DDELAY[0])
                        printStringNow("RVANKANDO "..sampGetPlayerNickname(id).."("..id..")", 1000)
                    end
                end
            end
        end
    end
end)

lua_thread.create(function()
    while true do
        wait(0)
        if sulista.RVANKA[0] then
            for _, handle in ipairs(getAllChars()) do
                if handle ~= PLAYER_PED then
                    local res, id = sampGetPlayerIdByCharHandle(handle)
                    if res then
                        local result, handlee = sampGetCharHandleBySampPlayerId(id)
                        local tX, tY, tZ = getCharCoordinates(handlee)
                        local pX, pY, pZ = getCharCoordinates(PLAYER_PED)
                        if getDistanceBetweenCoords3d(pX, pY, pZ, tX, tY, tZ) < sulista.RVK_DISTANCIA[0] then
                            if isCharInAnyHeli(PLAYER_PED) and not sampIsPlayerNpc(id) and not sampIsPlayerPaused(id) then
                                local sync = samp_create_sync_data('vehicle')
                                sync.position = {tX - 0.8, tY, tZ - 2.7}
                                sync.send()
                                wait(sulista.DELAYRVK[0])
                                printStringNow("MATANDO " .. sampGetPlayerNickname(id) .. "(" .. id .. ")", 1000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function aimbot_tabs()
    imgui.Separator()
    imgui.Text("Selecione onde o aimbot deve acertar:")
    imgui.CustomCheckbox("CABEÇA", sulist.cabecaAIM)
    imgui.CustomCheckbox("PEITO", sulist.peitoAIM)
    imgui.CustomCheckbox("BRAÇO ESQUERDO", sulist.bracoAIM)
    imgui.CustomCheckbox("BRAÇO DIREITO", sulist.braco2AIM)
    imgui.CustomCheckbox("VIRILHA", sulist.virilhaAIM)
    imgui.CustomCheckbox("PERNA ESQUERDA", sulist.pernaAIM)
    imgui.CustomCheckbox("PERNA DIREITA", sulist.perna2AIM)

    imgui.Separator()
    imgui.Text("CONFIGURAÇÕES DO AIMBOT:")
    imgui.SliderFloat("FOV", slide.fovvaimbotcirculo, 0, 500)
    imgui.SliderFloat("SUAVIZAÇÃO", slide.aimSmoothhhh, 0.1, 10.0)
end

function player_tabs()
    imgui.CustomCheckbox("GOD MOD", config.godmod)
    imgui.CustomCheckbox(u8'ANTI CAM SNIPER', config.teste72)
    if imgui.CustomCheckbox("UNFREEZER", config.ANTICONGELAR) then
    end
    imgui.CustomCheckbox('NÃO RECARREGAR', config.noreload)
    if imgui.CustomCheckbox("AIR BREAK", isPedAirBrakeCheckboxActive) then
        ped_airbrake_enabled = isPedAirBrakeCheckboxActive[0]
        if not ped_airbrake_enabled and not isCharInAnyCar(PLAYER_PED) then
            freezeCharPosition(PLAYER_PED, false)
            setCharCollision(PLAYER_PED, true)
        end

        if ped_airbrake_enabled then
            printStringNow("~g~Pedestrian AirBrake: on", 1000)
        else
            printStringNow("~r~Pedestrian AirBrake: off", 1000)
        end
    end
    imgui.CustomCheckbox("ADM NAO PUXAR", config.naotelaradm)
    imgui.CustomCheckbox("ATRAVESSAR PLAYER", config.atrplay_enabled)
    if imgui.CustomCheckbox("FOV", config.ativarfov) then
    end
    if imgui.CustomCheckbox("FAKE AFK", kk) then
    end
    if imgui.CustomCheckbox("SPEED SOCO", kk1) then
    end

    if config.ativarfov[0] then     
        imgui.SliderFloat("", config.alterarfov, 0.0, 150, "%.1f")
    end
    if imgui.CustomCheckbox("REMOVER ANIMAÇÃO DE QUEDA", noFallAnimation) then
        if noFallAnimation[0] then
            sampAddChatMessage("{00FF00} ANIMACAO DE QUEDA ATIVADA", -1)
        else
            sampAddChatMessage("{FF0000} ANIMACAO DE QUEDA DESATIVADA", -1)
        end
    end
    if imgui.CustomCheckbox("AUTO REGENERAÇÃO", autoRegenerarVida) then
        if autoRegenerarVida[0] then
            regenerarVida()
        end
    end
    imgui.CustomCheckbox('CHECAR JOGADORES PERTO', aim.CheckBox.teste73)    
end

function armas_tabs()
    if imgui.CustomCheckbox('BYPASS ARMAS', aim.CheckBox.teste11) then
                bypass = not bypass
                if bypass then
                    sampAddChatMessage("[{00e1ff}JUCA{ffffff}] ATIVADO", -1)
                else
                    sampAddChatMessage("[{00e1ff}JUCA{ffffff}] DESATIVADO", -1)
                end
            end
            
            if imgui.CustomCheckbox('NAO RESETAR ARMA', config.noreset) then            
            end                        
            imgui.CustomCheckbox(' FAST RELOAD', fastreload)
            imgui.CustomCheckbox(' ANT STUN', config.nostun)
            imgui.CustomCheckbox("CBUG", cbugs.shootingEnabled1) 
            if cbugs.shootingEnabled1[0] then
            imgui.SliderFloat("DEMORA DO CBUG", cbugs.clearAnimTime, 100, 1000)
            end    
            imgui.CustomCheckbox("CBUG/LIFE FOOT 2 TIROS", cbugs.shootingEnabled)
            imgui.CustomCheckbox("LIFE FOOT 1 TIRO", cbugs.lifefoot1)
            imgui.CustomCheckbox('LIFE FOOT 2 TIRO', cbugs.lifefoot)
                            
            imgui.InputInt('ID DA ARMA', weapon_id)
            imgui.InputInt('MUNIÇÃO', ammo)
            if imgui.Button('PUXAR ARMA') then
                giveGun(weapon_id[0], ammo[0])
            end            
            imgui.SameLine()
            if imgui.Button("REMOVER ARMAS") then
                removeAllCharWeapons(PLAYER_PED)
            end                  
end

function veiculos_tabs()           
    imgui.CustomCheckbox('GOD MOD CARRO', config.godcar)
    imgui.CustomCheckbox('MOTOR CARROS ON', config.motorcar)

    if imgui.CustomCheckbox("FLYCAR", FlyCar.enabled) then
        if FlyCar.enabled[0] then
            FlyCar.activate()
        end
    end

    if FlyCar.enabled[0] then
        imgui.SliderFloat("VELOCIDADE", FlyCar.speed, 1.0, 200.0, "%.1f")
    end

    if imgui.CustomCheckbox("BYPASS FLYCAR", FlyCar.bypass) then
        -- Aqui você pode adicionar funcionalidades para o bypass se necessário
    end

    imgui.CustomCheckbox('ATRAVESSAR CARROS', config.pesadocar)
    imgui.CustomCheckbox('DIRIGIR SEM GASOLINA', config.dirsemcombus)            

    if imgui.CustomCheckbox("REPARAR VEÍCULO AUTOMATICAMENTE", reparar) then
        if not reparar[0] then
            reparar[0] = false
        end
    end

    if imgui.CustomCheckbox("CARRO ARCO-ÍRIS", rainbow) then
        if not rainbow[0] then
            rainbowSpeed = 500 
        end
    end
end

function esp_tabs()
    imgui.CustomCheckbox('ESP LINHA PLAYER', config.esp_enabled)
    imgui.CustomCheckbox('ESP ESQUELETO', config.ESP_ESQUELETO)
    imgui.CustomCheckbox('ESP NOME/VIDA/COLETE', config.wallhack_enabled)         
    imgui.CustomCheckbox('ESP LINHA CARRO', config.espcar_enabled)
    imgui.CustomCheckbox('ESP BOX CARRO', config.espcarlinha_enablade)
    imgui.CustomCheckbox('ESP INFO CARRO', config.espinfo_enabled)
    imgui.CustomCheckbox("ESP CAIXA 2D", esp_2d)
    imgui.CustomCheckbox("ESP CAIXA 3D", esp_3d)
    imgui.CustomCheckbox(u8"ESP ID DA SKIN", aim.CheckBox.teste53)       
    imgui.CustomCheckbox('ESP PLATAFORMA', config.espplataforma)
    imgui.ColorEdit4("ESP COR", config.espcores)
end

--[LOGICAS]

function onSendPacket(id)
    if id == PACKET_VEHICLE_SYNC and tpres then
        if kk[0] then
            return false
        end
    end
end

function imgui.CustomCheckbox(str_id, bool, a_speed)
    local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
    local label = str_id:gsub("##.+", "") or ""
    local h = imgui.GetTextLineHeightWithSpacing() + 2
    local speed = a_speed or 0.2
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec2(from.x + (count * (to.x - from.x) / 100), from.y + (count * (to.y - from.y) / 100)), true
        end
        return (timer > duration) and to or from, false
    end
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
    local c = {
        {0.18536826495, 0.42833250947},
        {0.44109925858, 0.70010380622},
        {0.38825341901, 0.70010380622},
        {0.81248970176, 0.28238693976}
    }
    if UI_CUSTOM_CHECKBOX == nil then
        UI_CUSTOM_CHECKBOX = {}
    end
    if UI_CUSTOM_CHECKBOX[str_id] == nil then
        UI_CUSTOM_CHECKBOX[str_id] = {
            lines = {
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h * c[1][1], h * c[1][2]),
                    start = 0,
                    anim = false
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = bool[0] and imgui.ImVec2(h * c[2][1], h * c[2][2]) or imgui.ImVec2(h * c[1][1], h * c[1][2]),
                    start = 0,
                    anim = false
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h * c[3][1], h * c[3][2]),
                    start = 0,
                    anim = false
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = bool[0] and imgui.ImVec2(h * c[4][1], h * c[4][2]) or imgui.ImVec2(h * c[3][1], h * c[3][2]),
                    start = 0,
                    anim = false
                }
            },
            hovered = false,
            h_start = 0
        }
    end
    local pool = UI_CUSTOM_CHECKBOX[str_id]
    imgui.BeginGroup()
    imgui.InvisibleButton(str_id, imgui.ImVec2(h, h))
    imgui.SameLine()
    local pp = imgui.GetCursorPos()
    imgui.SetCursorPos(imgui.ImVec2(pp.x, pp.y + h / 2 - imgui.CalcTextSize(label).y / 2))
    imgui.Text(label)
    imgui.EndGroup()
    local clicked = imgui.IsItemClicked()
    if pool.hovered ~= imgui.IsItemHovered() then
        pool.hovered = imgui.IsItemHovered()
        local timer = os.clock() - pool.h_start
        if timer <= speed and timer >= 0 then
            pool.h_start = os.clock() - (speed - timer)
        else
            pool.h_start = os.clock()
        end
    end
    if clicked then
        local isAnim = false
        for i = 1, 4 do
            if pool.lines[i].anim then
                isAnim = true
            end
        end
        if not isAnim then
            bool[0] = not bool[0]
            pool.lines[1].from = imgui.ImVec2(h * c[1][1], h * c[1][2])
            pool.lines[1].to =
                bool[0] and imgui.ImVec2(h * c[1][1], h * c[1][2]) or imgui.ImVec2(h * c[2][1], h * c[2][2])
            pool.lines[1].start = bool[0] and 0 or os.clock()
            pool.lines[2].from =
                bool[0] and imgui.ImVec2(h * c[1][1], h * c[1][2]) or imgui.ImVec2(h * c[2][1], h * c[2][2])
            pool.lines[2].to =
                bool[0] and imgui.ImVec2(h * c[2][1], h * c[2][2]) or imgui.ImVec2(h * c[2][1], h * c[2][2])
            pool.lines[2].start = bool[0] and os.clock() or 0
            pool.lines[3].from = imgui.ImVec2(h * c[3][1], h * c[3][2])
            pool.lines[3].to =
                bool[0] and imgui.ImVec2(h * c[3][1], h * c[3][2]) or imgui.ImVec2(h * c[4][1], h * c[4][2])
            pool.lines[3].start = bool[0] and 0 or os.clock() + speed
            pool.lines[4].from =
                bool[0] and imgui.ImVec2(h * c[3][1], h * c[3][2]) or imgui.ImVec2(h * c[4][1], h * c[4][2])
            pool.lines[4].to = imgui.ImVec2(h * c[4][1], h * c[4][2]) or imgui.ImVec2(h * c[4][1], h * c[4][2])
            pool.lines[4].start = bool[0] and os.clock() + speed or 0
        end
    end
    local pos = {}
    for i = 1, 4 do
        pos[i], pool.lines[i].anim =
            bringVec2To(p + pool.lines[i].from, p + pool.lines[i].to, pool.lines[i].start, speed)
    end
    local color = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
    local c = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
    local colorHovered =
        bringVec4To(
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0) or imgui.ImVec4(c.x, c.y, c.z, 0.2),
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0.2) or imgui.ImVec4(c.x, c.y, c.z, 0),
        pool.h_start,
        speed
    )
    DL:AddRectFilled(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(colorHovered), h / 15, 15)
    DL:AddRect(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(color), h / 15, 15, 1.5)
    DL:AddLine(pos[1], pos[2], imgui.GetColorU32Vec4(color), h / 10)
    DL:AddLine(pos[3], pos[4], imgui.GetColorU32Vec4(color), h / 10)
    return clicked
end

function sampev.onResetPlayerWeapons()
    if config.godmod[0] then
        return false
    end
end
function sampev.onBulletSync()
    if config.godmod[0] then
        return false
    end
end
function autoKillPlayers()
    local playerId = findClosestPlayer(500)
    if playerId then
        kill(playerId, 24)
    end
end

function findClosestPlayer(radius)
    local closestPlayer = nil
    local closestDist = radius

    local myX, myY, myZ = getCharCoordinates(PLAYER_PED)

    for i = 0, sampGetMaxPlayerId(false) do
        if sampIsPlayerConnected(i) and not sampIsPlayerPaused(i) then
            local playerExists, playerHandle = sampGetCharHandleBySampPlayerId(i)
            if playerExists then
                local x, y, z = getCharCoordinates(playerHandle)
                local dist = getDistanceBetweenCoords3d(myX, myY, myZ, x, y, z)
                if dist < closestDist then
                    closestDist = dist
                    closestPlayer = i
                end
            end
        end
    end
    return closestPlayer
end

function kill(playerId, weaponId)
    if not playerId or not weaponId then
        sampAddChatMessage("ID DA ARMA ERRADO", -1)
        return
    end

    local playerExists, playerHandle = sampGetCharHandleBySampPlayerId(playerId)
    if playerExists and not sampIsPlayerPaused(playerId) then
        local x, y, z = getCharCoordinates(playerHandle)
        for i = 0, 3 do
            giveWeaponToChar(PLAYER_PED, weaponId, -1)
            local pt = getAmmoInCharWeapon(PLAYER_PED, weaponId)

            local data = samp_create_sync_data('player')
            data.weapon = weaponId
            data.animationId = 1167
            data.animationFlags = 32776
            data.send()

            local bulletData = samp_create_sync_data('bullet', false)
            bulletData.targetType = 1
            bulletData.targetId = playerId
            bulletData.origin.x, bulletData.origin.y, bulletData.origin.z = getActiveCameraCoordinates()
            bulletData.target.x, bulletData.target.y, bulletData.target.z = x, y, z
            bulletData.weaponId = weaponId
            bulletData.send()

            pt = pt - 1
            setCharAmmo(PLAYER_PED, weaponId, pt)
        end
        sampAddChatMessage("MATANDO: " .. sampGetPlayerNickname(playerId), -1)
        removeAllWeapons()
    else
        sampAddChatMessage("PLAYER AFK", -1)
    end
end

function removeAllWeapons()
    for i = 0, 46 do
        removeWeaponFromChar(PLAYER_PED, i)
    end
end
function repararVeiculo()
    local vehicle = getCarCharIsUsing(PLAYER_PED)
    if vehicle ~= 0 then
        fixCar(vehicle)
        setCarHealth(vehicle, 1000.0)
    end
end
function sampev.onSetCameraBehind()
    if config.godmod[0] then
        return false
    end
end
function sampev.onTogglePlayerControllable()
    if config.godmod[0] then
        return false
    end
end
function sampev.onSetPlayerHealth(health)
    if config.godmod[0] then
        return false
    end
end
function sampev.onSendPlayerSync(data)
    if config.godmod[0] then
        data.health = 100
    end
end
function sampev.onSendVehicleSync(data)
    if config.godmod[0] then
        data.playerHealth = 100
    end
  end
function sampev.onSendRequestClass(classId)
    if config.godmod[0] then
        return false
    end
end
function sampev.onSendPlayerSync(arg_234_0)
	if config.teste72[0] then
		arg_234_0.specialAction = 3
	end
end
function getMoveSpeed(heading, speed)
    return math.sin(-math.rad(heading)) * speed, math.cos(-math.rad(heading)) * speed
  end
  
  function setPlayerCarCoordinatesFixed(x, y, z)
    local ox, oy, oz = getCharCoordinates(PLAYER_PED)
    setCharCoordinates(PLAYER_PED, ox, oy, oz)
    local nx, ny, nz = getCharCoordinates(PLAYER_PED)
    local xoff = nx - ox
    local yoff = ny - oy
    local zoff = nz - oz
  
    setCharCoordinates(PLAYER_PED, x - xoff, y - yoff, z - zoff)
  end
  function sampev.onSendVehicleSync(data)
    if car_airbrake_enabled then
      local mx, my = getMoveSpeed(getCharHeading(PLAYER_PED), speed > 2 and 2 or speed)
      data.moveSpeed.x = mx
      data.moveSpeed.y = my
    end
  end
  
  function processSpecialWidgets()
    local delta = 0
    if isWidgetPressed(WIDGET_ZOOM_IN) then
      delta = delta + speed / 2
    end
    if isWidgetPressed(WIDGET_ZOOM_OUT) then
      delta = delta - speed / 2
    end
    if isWidgetPressed(WIDGET_VIDEO_POKER_ADD_COIN) then
      speed = speed + 0.01
      if speed > 3.5 then speed = 3.5 end
      printStringNow('Speed: ' .. string.format("%.2f", speed), 500)
    end
    if isWidgetPressed(WIDGET_VIDEO_POKER_REMOVE_COIN) then
      speed = speed - 0.01
      if speed < 0.1 then speed = 0.1 end
      printStringNow('Speed: ' .. string.format("%.2f", speed), 500)
    end
  
    return delta
  end
  
  function processCarAirBrake()
    local x1, y1, z1 = getActiveCameraCoordinates()
    local x, y, z = getActiveCameraPointAt()
    local angle = -math.rad(getHeadingFromVector2d(x - x1, y - y1))
  
    if isCharInAnyCar(PLAYER_PED) then
      local car = storeCarCharIsInNoSave(PLAYER_PED)
      if car ~= last_car and last_car ~= nil and doesVehicleExist(last_car) and was_in_car then
        freezeCarPosition(last_car, false)
        setCarCollision(last_car, true)
      end
      was_in_car = true
      last_car = car
      freezeCarPosition(car, true)
      setCarCollision(car, false)
  
      local result, var_1, var_2 = isWidgetPressedEx(WIDGET_VEHICLE_STEER_ANALOG, 0)
      if not result then
        var_1 = 0
        var_2 = 0
      end
      local intensity_x = var_1 / 127
      local intensity_y = var_2 / 127
  
      local cx, cy, cz = getCharCoordinates(PLAYER_PED)
      cx = cx - (math.sin(angle) * speed * intensity_y)
      cy = cy - (math.cos(angle) * speed * intensity_y)
      cx = cx + (math.cos(angle) * speed * intensity_x)
      cy = cy - (math.sin(angle) * speed * intensity_x)
      cz = cz + processSpecialWidgets()
  
      setPlayerCarCoordinatesFixed(cx, cy, cz)
      setCarHeading(car, math.deg(-angle))
  
      if intensity_x ~= 0 then
        restoreCameraJumpcut()
      end
    else
      if was_in_car and last_car ~= nil and doesVehicleExist(last_car) then
        freezeCarPosition(last_car, false)
        setCarCollision(last_car, true)
      end
      was_in_car = false
      freezeCharPosition(PLAYER_PED, true)
      setCharCollision(PLAYER_PED, false)
    end
  end
  
  function processPedAirBrake()
    local x1, y1, z1 = getActiveCameraCoordinates()
    local x, y, z = getActiveCameraPointAt()
    local angle = -math.rad(getHeadingFromVector2d(x - x1, y - y1))
  
    if not isCharInAnyCar(PLAYER_PED) then
      local result, var_1, var_2 = isWidgetPressedEx(WIDGET_PED_MOVE, 0)
      if not result then
        var_1 = 0
        var_2 = 0
      end
      local intensity_x = var_1 / 127
      local intensity_y = var_2 / 127
  
      local cx, cy, cz = getCharCoordinates(PLAYER_PED)
      cx = cx - (math.sin(angle) * speed * intensity_y)
      cy = cy - (math.cos(angle) * speed * intensity_y)
      cx = cx + (math.cos(angle) * speed * intensity_x)
      cy = cy - (math.sin(angle) * speed * intensity_x)
      cz = cz + processSpecialWidgets()
  
      setCharCoordinatesNoOffset(PLAYER_PED, cx, cy, cz)
      setCharHeading(PLAYER_PED, math.deg(-angle))
  
      if intensity_x ~= 0 then
        restoreCameraJumpcut()
      end
    end
  end
  function atrplay()
    for playerId = 0, sampGetMaxPlayerId(true) do
        if sampIsPlayerConnected(playerId) then
            local result, playerPed = sampGetCharHandleBySampPlayerId(playerId)
            
            if result and isCharOnScreen(playerPed) and not isCharInAnyCar(playerPed) then
                local playerCoords = { getCharCoordinates(PLAYER_PED) }
                local targetCoords = { getCharCoordinates(playerPed) }
                
                local distance = math.sqrt(math.pow(targetCoords[1] - playerCoords[1], 2) +
                                           math.pow(targetCoords[2] - playerCoords[2], 2) +
                                           math.pow(targetCoords[3] - playerCoords[3], 2))
                
                if distance < 1 then
                    setCharCollision(playerPed, false)
                else
                    setCharCollision(playerPed, true)
                end
            end
        end
    end
end
function sampEvents.onSendPlayerSync(syncData)
    if isActive[0] then
        syncData.weapon = 0
    end
end
function ev.onResetPlayerWeapons()
    if config.noreset[0] then    
    return false
    end
end
function drawSkeletonESP()
    local playerPed = PLAYER_PED
    local px, py, pz = getCharCoordinates(playerPed)

    local function convertColorToHex(color)
        local r = math.floor(color[0] * 255)
        local g = math.floor(color[1] * 255)
        local b = math.floor(color[2] * 255)
        local a = math.floor(color[3] * 255)
        return (a * 16777216) + (r * 65536) + (g * 256) + b
    end

    local espcor = convertColorToHex(config.espcores)

    for _, char in ipairs(getAllChars()) do
        if char ~= playerPed then
            local result, id = sampGetPlayerIdByCharHandle(char)
            if result and isCharOnScreen(char) then
                for _, bone in ipairs(bones) do
                    local x1, y1, z1 = getBonePosition(char, bone)
                    local x2, y2, z2 = getBonePosition(char, bone + 1)
                    local r1, sx1, sy1 = convert3DCoordsToScreenEx(x1, y1, z1)
                    local r2, sx2, sy2 = convert3DCoordsToScreenEx(x2, y2, z2)
                    if r1 and r2 then
                        renderDrawLine(sx1, sy1, sx2, sy2, 3, espcor)
                    end
                end
            end
        end
    end
end

function renderWallhack()
    if not var_0_10 then
        var_0_10 = createFont() 
        if not var_0_10 then
            return
        end
    end

    local var_0_21 = config.wallhack_enabled
    if var_0_21[0] then
        local var_6_0 = getAllChars()

        for iter_6_0, iter_6_1 in ipairs(var_6_0) do
            if iter_6_1 ~= PLAYER_PED then
                local var_6_1, var_6_2 = sampGetPlayerIdByCharHandle(iter_6_1)

                if var_6_1 and isCharOnScreen(iter_6_1) then
                    local var_6_3, var_6_4, var_6_5 = getOffsetFromCharInWorldCoords(iter_6_1, 0, 0, 0)
                    local var_6_6, var_6_7 = convert3DCoordsToScreen(var_6_3, var_6_4, var_6_5 + 1)
                    local var_6_8, var_6_9 = convert3DCoordsToScreen(var_6_3, var_6_4, var_6_5 - 1)
                    local var_6_10 = math.abs((var_6_7 - var_6_9) * 0.25)
                    local var_6_11 = sampGetPlayerNickname(var_6_2) .. " (" .. tostring(var_6_2) .. ")"

                    if sampIsPlayerPaused(var_6_2) then
                        var_6_11 = "[AFK] " .. var_6_11
                    end

                    local var_6_12 = sampGetPlayerHealth(var_6_2)
                    local var_6_13 = sampGetPlayerArmor(var_6_2)
                    local var_6_14 = "{FF0000}" .. string.format("%.0f", var_6_12) .. "hp "
                    local var_6_15 = "{BBBBBB}" .. string.format("%.0f", var_6_13) .. "ap"
                    local var_6_16 = bit.bor(bit.band(sampGetPlayerColor(var_6_2), 16777215), 4278190080)

                    renderFontDrawText(var_0_10, var_6_11, var_6_6 - renderGetFontDrawTextLength(var_0_10, var_6_11) / 2, var_6_7 - renderGetFontDrawHeight(var_0_10) * 3.8, var_6_16)
                    renderDrawBoxWithBorder(var_6_6 - 24, var_6_7 - 45, 50, 6, 4278190080, 1, 4278190080)
                    renderDrawBoxWithBorder(var_6_6 - 24, var_6_7 - 45, var_6_12 / 2, 6, 4294901760, 1, 0)

                    if var_6_13 > 0 then
                        renderDrawBoxWithBorder(var_6_6 - 24, var_6_7 + renderGetFontDrawHeight(var_0_10) - 50, 50, 6, 4278190080, 1, 4278190080)
                        renderDrawBoxWithBorder(var_6_6 - 24, var_6_7 + renderGetFontDrawHeight(var_0_10) - 50, var_6_13 / 2, 6, 4294967295, 1, 0)
                    end
                end
            end
        end
    end
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    local raknet = require 'samp.raknet'
    require 'samp.synchronization'
    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = { 'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData },
        vehicle = { 'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData },
        passenger = { 'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData },
        aim = { 'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData },
        trailer = { 'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData },
        unoccupied = { 'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil },
        bullet = { 'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil },
        spectator = { 'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil }
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({ send = func_send }, mt)
end

function esplinhacarro()
    local function convertColorToHex(color)
        local r = math.floor(color[0] * 255)
        local g = math.floor(color[1] * 255)
        local b = math.floor(color[2] * 255)
        local a = math.floor(color[3] * 255)
        return (a * 16777216) + (r * 65536) + (g * 256) + b
    end

    local espcor = convertColorToHex(config.espcores)
    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
    local x, y = convert3DCoordsToScreen(playerX, playerY, playerZ)
        for k, i in ipairs(getAllVehicles()) do
        if isCarOnScreen(i) then
            local carX, carY, carZ = getCarCoordinates(i)
            local px, py = convert3DCoordsToScreen(carX, carY, carZ)                        
            local thickness = 2 
            renderDrawLine(x, y, px, py, thickness, espcor)
        end
    end
end

function renderESP()
    if not var_0_10 then
        var_0_10 = createFont() 
        if not var_0_10 then
            return 
        end
    end
    
    local function convertColorToHex(color)
        local r = math.floor(color[0] * 255)
        local g = math.floor(color[1] * 255)
        local b = math.floor(color[2] * 255)
        local a = math.floor(color[3] * 255)
        return (a * 16777216) + (r * 65536) + (g * 256) + b
    end

    local espcor = convertColorToHex(config.espcores)

    local var_0_25 = config.esp_enabled
    if var_0_25[0] then
        local var_6_41, var_6_42, var_6_43 = getCharCoordinates(PLAYER_PED)

        for iter_6_4 = 0, 999 do
            local var_6_44, var_6_45 = sampGetCharHandleBySampPlayerId(iter_6_4)

            if var_6_44 and doesCharExist(var_6_45) and isCharOnScreen(var_6_45) then
                local var_6_46, var_6_47, var_6_48 = getCharCoordinates(PLAYER_PED)
                local var_6_49, var_6_50, var_6_51 = getCharCoordinates(var_6_45)
                local var_6_52 = math.floor(getDistanceBetweenCoords3d(var_6_41, var_6_42, var_6_43, var_6_49, var_6_50, var_6_51))

                local colory
                if isLineOfSightClear(var_6_46, var_6_47, var_6_48, var_6_49, var_6_50, var_6_51, true, true, false, true, true) then
                    colory = espcor
                else
                    colory = 4294901760
                end

                if var_6_52 <= 1000 then
                    local var_6_53, var_6_54 = convert3DCoordsToScreen(var_6_41, var_6_42, var_6_43)
                    local var_6_55, var_6_56 = convert3DCoordsToScreen(var_6_49, var_6_50, var_6_51)

                    renderDrawLine(var_6_53, var_6_54, var_6_55, var_6_56, 2, colory)

                    local var_6_57 = string.format("%.1f", var_6_52)
                    renderFontDrawText(var_0_10, var_6_57 .. "m", var_6_55, var_6_56, espcor, false)
                end
            end
        end
    end
end

function jogadorMuitoLonge(id)
    local _, handle = sampGetCharHandleBySampPlayerId(id)
    if not handle then return true end
    
    local x, y, z = getCharCoordinates(PLAYER_PED)
    local x2, y2, z2 = getCharCoordinates(handle)
    local distancia = math.sqrt((x2-x)^2 + (y2-y)^2 + (z2-z)^2)
    
    return distancia > 150.0 -- Distância máxima de 150 unidades
end

-- Função para iniciar o spect
function iniciarSpectar(id)
    if not isSampAvailable() then return end
    
    if not sampIsPlayerConnected(id) then
        sampAddChatMessage("Jogador não está conectado (ID: "..id..")", 0xFF0000FF)
        return
    end

    -- Verifica se o jogador está muito longe
    if jogadorMuitoLonge(id) then
        sampAddChatMessage("Jogador muito distante para spectar (ID: "..id..")", 0xFF9900FF)
        return
    end

    local resultado, handle = sampGetCharHandleBySampPlayerId(id)
    if resultado then
        setCameraInFrontOfChar(handle)
        freezeCharPosition(PLAYER_PED, true)
        setCharVisible(PLAYER_PED, false)
        espectando[0] = true
        sampAddChatMessage("Spectando: "..sampGetPlayerNickname(id), 0x00FF00FF)
    else
        sampAddChatMessage("Falha ao spectar jogador (ID: "..id..")", 0xFF0000FF)
    end
end

function pararSpectar()
    restoreCamera()
    freezeCharPosition(PLAYER_PED, false)
    setCharVisible(PLAYER_PED, true)
    espectando[0] = false
end

-- Sistema de sincronização simplificado
function sampev.onSendPlayerSync(data)
    if espectando[0] then
        return false -- Bloqueia completamente o sync do jogador
    end
end

function sampev.onSendVehicleSync(data)
    if espectando[0] then
        return false
    end
end

function sampev.onSendPassengerSync(data)
    if espectando[0] then
        return false
    end
end
function espcarlinha()
    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
    local x, y = convert3DCoordsToScreen(playerX, playerY, playerZ)
    
    local function convertColorToHex(color)
        local r = math.floor(color[0] * 255)
        local g = math.floor(color[1] * 255)
        local b = math.floor(color[2] * 255)
        local a = math.floor(color[3] * 255)
        return (a * 16777216) + (r * 65536) + (g * 256) + b
    end

    local espcor = convertColorToHex(config.espcores)

    for _, vehicle in ipairs(getAllVehicles()) do
        if isCarOnScreen(vehicle) then
            local carX, carY, carZ = getCarCoordinates(vehicle)
            local px, py = convert3DCoordsToScreen(carX, carY, carZ)
            local thickness = 2

            local corners = {
                { x = 1.5, y = 3, z = 1 }, 
                { x = 1.5, y = -3, z = 1 }, 
                { x = -1.5, y = -3, z = 1 },
                { x = -1.5, y = 3, z = 1 },
                { x = 1.5, y = 3, z = -1 },
                { x = 1.5, y = -3, z = -1 },
                { x = -1.5, y = -3, z = -1 },
                { x = -1.5, y = 3, z = -1 }
            }

            local boxCorners = {}
            for _, offset in ipairs(corners) do
                local worldX, worldY, worldZ = getOffsetFromCarInWorldCoords(vehicle, offset.x, offset.y, offset.z)
                local screenX, screenY = convert3DCoordsToScreen(worldX, worldY, worldZ)
                table.insert(boxCorners, { x = screenX, y = screenY })
            end

            for i = 1, 4 do
                local nextIndex = (i % 4 == 0 and i - 3) or (i + 1)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[nextIndex].x, boxCorners[nextIndex].y, thickness, espcor)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[i + 4].x, boxCorners[i + 4].y, thickness, espcor)
            end

            for i = 5, 8 do
                local nextIndex = (i % 4 == 0 and i - 3) or (i + 1)
                renderDrawLine(boxCorners[i].x, boxCorners[i].y, boxCorners[nextIndex].x, boxCorners[nextIndex].y, thickness, espcor)
            end
        end
    end
end

rainbowSpeed = 100

function getRainbowColor(timeOffset)
    local t = (os.clock() + timeOffset) * 0.5
    local r = math.sin(t * 2 * math.pi) * 0.5 + 0.5
    local g = math.sin((t + 0.33) * 2 * math.pi) * 0.5 + 0.5
    local b = math.sin((t + 0.66) * 2 * math.pi) * 0.5 + 0.5
    return math.floor(r * 126), math.floor(g * 126)
end

function carroArcoIris()
    if isCharInAnyCar(PLAYER_PED) then
        local vehicle = storeCarCharIsInNoSave(PLAYER_PED)
        if vehicle ~= 0 then
            rainbowSpeed = 100
            for t = 0, 1, 0.1 do
                local cor1, cor2 = getRainbowColor(t)
                changeCarColour(vehicle, cor1, cor2)
                wait(rainbowSpeed)
                rainbowSpeed = math.max(50, rainbowSpeed - 5)
            end
        end
    end
end

function espplataforma()
    local peds = getAllChars()

    local function convertColorToHex(color)
        local r = math.floor(color[0] * 255)
        local g = math.floor(color[1] * 255)
        local b = math.floor(color[2] * 255)
        local a = math.floor(color[3] * 255)
        return (a * 16777216) + (r * 65536) + (g * 256) + b
    end

    local espcor = convertColorToHex(config.espcores)

    for i = 2, #peds do
        local _, id = sampGetPlayerIdByCharHandle(peds[i])
        
        -- Verifique se o id é válido
        if id ~= nil and peds[i] ~= nil and isCharOnScreen(peds[i]) and not sampIsPlayerNpc(id) then
            local x, y, z = getCharCoordinates(peds[i])
            local xs, ys = convert3DCoordsToScreen(x, y, z)
            if players[id] ~= nil then
                renderFontDrawText(font, players[id], xs - 23, ys, espcor)
            end
        end
    end
end

function events.onUnoccupiedSync(id, data)
    players[id] = "PC"
end

function events.onPlayerSync(id, data)
    if data.keysData == 160 then
        players[id] = "PC"
    end
    if data.specialAction ~= 0 and data.specialAction ~= 1 then
        players[id] = "PC"
    end
    if data.leftRightKeys ~= nil then
        if data.leftRightKeys ~= 128 and data.leftRightKeys ~= 65408 then
            players[id] = "Mobile"
        else
            if players[id] ~= "Mobile" then
                players[id] = "PC"
            end
        end
    end
    if data.upDownKeys ~= nil then
        if data.upDownKeys ~= 128 and data.upDownKeys ~= 65408 then
            players[id] = "Mobile"
        else
            if players[id] ~= "Mobile" then
                players[id] = "PC"
            end
        end
    end
end

function events.onVehicleSync(id, vehid, data)
    if data.leftRightKeys ~= 0 then
        if data.leftRightKeys ~= 128 and data.leftRightKeys ~= 65408 then
            players[id] = "Mobile"
        end
    end
end

function events.onPlayerQuit(id)
    players[id] = nil
end

function espinfo()
    for result, v in ipairs(getAllVehicles()) do   
        if v ~= nil and isCarOnScreen(v) then 
            local font = renderCreateFont("Arial", 12, 4, FCR_BOLD + FCR_BORDER)     
            local carX, carY, carZ = getCarCoordinates(v)        
            local carId = getCarModel(v)        
            local _, vehicleServerId = sampGetVehicleIdByCarHandle(v)
            local hp = getCarHealth(v)
            local carSpeed = getCarSpeed(v)
            local carinf1 = getNumberOfPassengers(v)
            local carinf4 = isCarEngineOn(v)
            local carcolor = getCarColours(v)
            local X, Y = convert3DCoordsToScreen(carX, carY, carZ + 1)
            
            local function convertColorToHex(color)
                local r = math.floor(color[0] * 255)
                local g = math.floor(color[1] * 255)
                local b = math.floor(color[2] * 255)
                local a = math.floor(color[3] * 255)
                return (a * 16777216) + (r * 65536) + (g * 256) + b
            end

            local espcor = convertColorToHex(config.espcores)
        
            local infoText = string.format("CARRO: %d (ID: %d)\nLataria: %d\nVelocidade: %.2f", 
                carId, vehicleServerId, hp, carSpeed)        
            renderFontDrawText(font, infoText, X, Y, espcor) 
        end
    end
end
function giveGun(weapon_id, ammo)
    if isCharInAnyCar(PLAYER_PED) then
        sendMessage("Você não pode puxar armas dentro de veículos.")
        return
    end
    local model_id = getWeapontypeModel(weapon_id)
    requestModel(model_id)
    loadAllModelsNow()
    giveWeaponToChar(PLAYER_PED, weapon_id, ammo)
end        
function matararea()
    areasafe = not areasafe
end
function lifefootmob()
    if cbugs.lifefoot[0] and isCharShooting(PLAYER_PED) then
        shotCount = shotCount + 1
        if shotCount % 2 == 0 then
            currentWeaponID = getCurrentCharWeapon(PLAYER_PED) 
            setCurrentCharWeapon(PLAYER_PED, 0) 
            wait(300)
            setCurrentCharWeapon(PLAYER_PED, currentWeaponID)
        end
    end
end
function lifefootmob1()
    if cbugs.lifefoot1[0] and isCharShooting(PLAYER_PED) then
        shotCount = shotCount + 1
        if shotCount % 1 == 0 then
            currentWeaponID = getCurrentCharWeapon(PLAYER_PED) 
            setCurrentCharWeapon(PLAYER_PED, 0) 
            wait(300)
            setCurrentCharWeapon(PLAYER_PED, currentWeaponID)
        end
    end
end
function checkPlayerShooting()
    if cbugs.shootingEnabled[0] and isCharShooting(PLAYER_PED) then
        shotCount = shotCount + 1
        if shotCount % 2 == 0 then
            currentWeaponID = getCurrentCharWeapon(PLAYER_PED) 
            setCurrentCharWeapon(PLAYER_PED, 0) 
            wait(300)
            setCurrentCharWeapon(PLAYER_PED, currentWeaponID)
        end
        
        wait(200)
        clearCharTasksImmediately(PLAYER_PED)
    end
end
function checkPlayerShooting1()
    if cbugs.shootingEnabled1[0] and isCharShooting(PLAYER_PED) then
        wait(cbugs.clearAnimTime[0])
        clearCharTasksImmediately(PLAYER_PED)
    end
end
function getNearCharToCenter()
    local closestId = -1
    local closestDist = 99999

    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local result, ped = sampGetCharHandleBySampPlayerId(i)
            if result and not shouldIgnorePlayer(i) then
                local px, py, pz = getCharCoordinates(ped)
                local cx, cy, cz = getCharCoordinates(PLAYER_PED)
                local dist = getDistanceBetweenCoords3d(px, py, pz, cx, cy, cz)
                if dist < closestDist then
                    closestDist = dist
                    closestId = i
                end
            end
        end
    end

    return closestId
end

function Aimbot()
    function getCameraRotation()
        local horizontalAngle = camera.aCams[0].fHorizontalAngle
        local verticalAngle = camera.aCams[0].fVerticalAngle
        return horizontalAngle, verticalAngle
    end

    function setCameraRotation(configaimbotHorizontal, configaimbotVertical)
        camera.aCams[0].fHorizontalAngle = configaimbotHorizontal
        camera.aCams[0].fVerticalAngle = configaimbotVertical
    end

    function convertCartesianCoordinatesToSpherical(configaimbot)
        local coordsDifference = configaimbot - vector3d(getActiveCameraCoordinates())
        local length = coordsDifference:length()
        local angleX = math.atan2(coordsDifference.y, coordsDifference.x)
        local angleY = math.acos(coordsDifference.z / length)

        if angleX > 0 then
            angleX = angleX - math.pi
        else
            angleX = angleX + math.pi
        end

        local angleZ = math.pi / 2 - angleY
        return angleX, angleZ
    end

    function getCrosshairPositionOnScreen()
        local screenWidth, screenHeight = getScreenResolution()
        local crosshairX = screenWidth * slide.posiX[0]
        local crosshairY = screenHeight * slide.posiY[0]
        return crosshairX, crosshairY
    end

    function getCrosshairRotation(configaimbot)
        configaimbot = configaimbot or 5
        local crosshairX, crosshairY = getCrosshairPositionOnScreen()
        local worldCoords = vector3d(convertScreenCoordsToWorld3D(crosshairX, crosshairY, configaimbot))
        return convertCartesianCoordinatesToSpherical(worldCoords)
    end

    function aimAtPointWithM16(configaimbot)
        local sphericalX, sphericalY = convertCartesianCoordinatesToSpherical(configaimbot)
        local cameraRotationX, cameraRotationY = getCameraRotation()
        local crosshairRotationX, crosshairRotationY = getCrosshairRotation()
        local newRotationX = cameraRotationX + (sphericalX - crosshairRotationX) * slide.aimSmoothhhh[0]
        local newRotationY = cameraRotationY + (sphericalY - crosshairRotationY) * slide.aimSmoothhhh[0]
        setCameraRotation(newRotationX, newRotationY)
    end

    function aimAtPointWithSniperScope(configaimbot)
        local sphericalX, sphericalY = convertCartesianCoordinatesToSpherical(configaimbot)
        setCameraRotation(sphericalX, sphericalY)
    end

    function getNearCharToCenter(configaimbot)
    local nearChars = {}
    local screenWidth, screenHeight = getScreenResolution()

    for _, char in ipairs(getAllChars()) do
        -- Obter o ID do jogador
        local res, playerId = sampGetPlayerIdByCharHandle(char)
        if res and isCharOnScreen(char) and char ~= PLAYER_PED and not isCharDead(char) and not shouldIgnorePlayer(playerId) then
            local charX, charY, charZ = getCharCoordinates(char)
            local screenX, screenY = convert3DCoordsToScreen(charX, charY, charZ)
            local distance = getDistanceBetweenCoords2d(screenWidth / 1.923 + slide.posiX[0], screenHeight / 2.306 + slide.posiY[0], screenX, screenY)

            if isCurrentCharWeapon(PLAYER_PED, 34) then
                distance = getDistanceBetweenCoords2d(screenWidth / 2, screenHeight / 2, screenX, screenY)
            end

            if distance <= tonumber(configaimbot and configaimbot or screenHeight) then
                table.insert(nearChars, {
                    distance,
                    char
                })
            end
        end
    end

    if #nearChars > 0 then
        table.sort(nearChars, function(a, b)
            return a[1] < b[1]
        end)
        return nearChars[1][2]
    end

    return nil
end

    local distancia = slide.DistanciaAIM[0]
    local nMode = camera.aCams[0].nMode
    local nearChar = getNearCharToCenter(slide.fovvaimbotcirculo[0] + 1.923)
    
    if nearChar then
            local boneX, boneY, boneZ = getBonePosition(nearChar, 5)
        if boneX and boneY and boneZ then
            local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
            local distanceToBone = getDistanceBetweenCoords3d(playerX, playerY, playerZ, boneX, boneY, boneZ)
    
            if not sulist.aimbotparede[0] then
                local targetX, targetY, targetZ = boneX, boneY, boneZ
                local hit, colX, colY, colZ, entityHit = processLineOfSight(playerX, playerY, playerZ, targetX, targetY, targetZ, true, true, false, true, false, false, false, false)
                if hit and entityHit ~= nearChar then
                    return
                end
            else
                local targetX, targetY, targetZ = boneX, boneY, boneZ
            end
    
            if distanceToBone < distancia then
                local point
    
                if sulist.cabecaAIM[0] then
                    local headX, headY, headZ = getBonePosition(nearChar, 5)
                    point = vector3d(headX, headY, headZ)
                end
    
                if sulist.peitoAIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 3)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.virilhaAIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 1)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.bracoAIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 33)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.braco2AIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 23)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.pernaAIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 52)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.perna2AIM[0] then
                    local chestX, chestY, chestZ = getBonePosition(nearChar, 42)
                    point = vector3d(chestX, chestY, chestZ)
                end
                
                if sulist.lockAIM[0] then
                    local partX, partY, partZ = getBonePosition(nearChar, miraAtual)
                    point = vector3d(partX, partY, partZ)

                    local parts = {}

                    if sulist.cabecaAIM[0] then
                        table.insert(parts, 5)
                    end
                    if sulist.peitoAIM[0] then
                        table.insert(parts, 3)
                    end
                    if sulist.virilhaAIM[0] then
                        table.insert(parts, 1)
                    end
                    if sulist.bracoAIM[0] then
                        table.insert(parts, 33)
                    end
                    if sulist.braco2AIM[0] then
                        table.insert(parts, 23)
                    end
                    if sulist.pernaAIM[0] then
                        table.insert(parts, 52)
                    end
                    if sulist.perna2AIM[0] then
                        table.insert(parts, 42)
                    end

                    if not miraAtualIndex then
                        miraAtualIndex = 1
                    end

                    if #parts > 0 then
                        if isCharShooting(PLAYER_PED) then
                            tiroContador = tiroContador + 1

                            if tiroContador >= slide.aimCtdr[0] then
                                tiroContador = 0
                                miraAtualIndex = (miraAtualIndex % #parts) + 1
                                miraAtual = parts[miraAtualIndex]
                            end
                        end

                        local partX, partY, partZ = getBonePosition(nearChar, miraAtual)
                        point = vector3d(partX, partY, partZ)
                    end
                end
    
                if point then
                    if nMode == 7 then
                        aimAtPointWithSniperScope(point)
                    elseif nMode == 53 then
                        aimAtPointWithM16(point)
                    end
                end
            end
        end
    end
end

function drawCircle(x, y, radius, color)
    local segments = 300 * DPI
    local angleStep = (2 * math.pi) / segments
    local lineWidth = 1.5 * DPI

    for i = 0, segments - 0 do
        local angle1 = i * angleStep
        local angle2 = (i + 1) * angleStep
        
        local x1 = x + (radius - lineWidth / 2) * math.cos(angle1)
        local y1 = y + (radius - lineWidth / 2) * math.sin(angle1)
        local x2 = x + (radius - lineWidth / 2) * math.cos(angle2)
        local y2 = y + (radius - lineWidth / 2) * math.sin(angle2)
        
        renderDrawLine(x1, y1, x2, y2, lineWidth, color)
    end
end

function isPlayerInFOV(playerX, playerY)
    local dx = playerX - slide.fovX[0]
    local dy = playerY - slide.fovY[0]
    local distanceSquared = dx * dx + dy * dy
    return distanceSquared <= slide.FoVVHG[0] * slide.FoVVHG[0]
end

function colorToHex(r, g, b, a)
    return bit.bor(bit.lshift(math.floor(a * 255), 24), bit.lshift(math.floor(r * 255), 16), bit.lshift(math.floor(g * 255), 8), math.floor(b * 255))
end

function getBonePosition(ped, bone)
  local pedptr = ffi.cast('void*', getCharPointer(ped))
  local posn = ffi.new('RwV3d[1]')
  gta._ZN4CPed15GetBonePositionER5RwV3djb(pedptr, posn, bone, false)
  return posn[0].x, posn[0].y, posn[0].z
end

function fix(angle)
    if angle > math.pi then
        angle = angle - (math.pi * 2)
    elseif angle < -math.pi then
        angle = angle + (math.pi * 2)
    end
    return angle
end

if aim.CheckBox.teste72[0] then
        local weaponId = data.weapon

        for i = 35, 42 do
            if weaponId == i then
                data.weapon = 0
            end
        end

        for i = 16, 18 do
            if weaponId == i then
                data.weapon = 0
            end
        end

        if weaponId == 44 or weaponId == 45 then
            data.weapon = 0
        end
    end

function getDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
lua_thread.create(
    function()
        while true do
            wait(0)
            if config.godmod[0] then
                setCharHealth(PLAYER_PED, 120)
                setCharProofs(PLAYER_PED, true, true, true, true, true)
            else
                setCharProofs(PLAYER_PED, false, false, false, false, false)
            end
        end
    end
)

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    repeat wait(0) until isSampAvailable()
    if hasLibraries then
        lua_thread.create(processQueue)  -- Inicia a fila de mensagens para o Discord 
        end

    sampRegisterChatCommand("jucamenu", function()  
        window[0] = not window[0]  
    end)  

    while true do  
        wait(0)  

        -- Abre/Fecha Menu ao deslizar o radar para a esquerda  
        if isWidgetSwipedLeft(WIDGET_RADAR) then  
            window[0] = not window[0]  
        end  

        if kk1[0] then  
            setCharAnimSpeed(PLAYER_PED, "SPRINT_PANIC", 1.3)  
            setCharAnimSpeed(PLAYER_PED, "SWIM_CRAWL", 21)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTA_2", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTA_1", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTA_3", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTA_M", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTA_G", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTB_1", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTB_2", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTB_3", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTB_G", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTC_1", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTC_2", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTC_3", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTC_G", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTD_1", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTD_2", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTD_3", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTD_G", 2)  
            setCharAnimSpeed(PLAYER_PED, "GUN_BUTT", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTKICK", 2)  
            setCharAnimSpeed(PLAYER_PED, "FIGHTKICK_B", 2)  
        end  

        -- Renderiza jogadores perto  
        if aim.CheckBox.teste73[0] then  
            local instream = 'Jogadores Perto\n'  
            local count = 0  
            for i = 0, 1001 do  
                if sampIsPlayerConnected(i) then  
                    local playerHandle = sampGetCharHandleBySampPlayerId(i)  
                    if playerHandle then  
                        instream = instream .. sampGetPlayerNickname(i) .. '[' .. i .. ']\n'  
                        count = count + 1  
                    end  
                end  
            end  
            instream = instream .. 'Contador: ' .. count  
            local sw, sh = getScreenResolution()  
            renderFontDrawText(font2, instream, sw - minusX, sh - minusY, -1)  
        end  

        lua_thread.create(Aimbot)  
        imgui.Process = window  

        -- Anti-Congelamento  
        if config.ANTICONGELAR and config.ANTICONGELAR[0] then  
            freezeCharPosition(PLAYER_PED, false)  
        end  

        -- Evita congelamento em teletransportes  
        sampev.onSetPlayerPos = function()  
            return not config.naotelaradm[0]  
        end  
        
        if config.teste111[0] then
                printStringNow('~b~Procurando ~g~veiculo...', 1000)
                
                wait(3000)
                
                local var_39_33, var_39_34, var_39_35 = getCharCoordinates(playerPed)
                local var_39_36, var_39_37 = findAllRandomVehiclesInSphere(var_39_33, var_39_34, var_39_35, 350, true, true)
            
                if var_39_36 then
                    warpCharIntoCar(playerPed, var_39_37)
                    restoreCameraJumpcut()
                end
            end 

        -- FOV Dinâmico  
        if config.ativarfov[0] then  
            cameraSetLerpFov(config.alterarfov[0], 101, 1000, true)  
        end  
        
        if isCharInAnyCar(PLAYER_PED) and carshot_active[0] then
            local var_52_0 = isWidgetPressed(WIDGET_CRANE_UP)
            local var_52_1, var_52_2, var_52_3 = getActiveCameraCoordinates()
            local var_52_4, var_52_5, var_52_6 = getActiveCameraPointAt()

            setCarHeading(storeCarCharIsInNoSave(PLAYER_PED), getHeadingFromVector2d(var_52_4 - var_52_1, var_52_5 - var_52_2))

            local vehicle = storeCarCharIsInNoSave(PLAYER_PED)

            if var_52_0 then
                setCarForwardSpeed(vehicle, carshot_speed[0] / 1.67)
            end
        end
        
        if noFallAnimation[0] then
            if isCharInAir(PLAYER_PED) then
                setCharAnimSpeed(PLAYER_PED, "FALL_FALL", 0.1) -- Animação lenta (quase zero)
                setCharAnimSpeed(PLAYER_PED, "FALL_COLLAPSE", 0.1) -- Remove o tropeço ao cair
            end
        end

        -- Funções adicionais  
        if config.matararea_enabled then matararea() end  
        if car_airbrake_enabled then processCarAirBrake() end  
        checkPlayerShooting1()  
        checkPlayerShooting()  
        lifefootmob()  
        lifefootmob1()  

        -- Fast Reload  
        if fastreload[0] then  
            setPlayerFastReload(playerHandle, true)  
            local anims = {  
                "TEC_RELOAD", "buddy_reload", "buddy_crouchreload", "colt45_reload",  
                "colt45_crouchreload", "sawnoff_reload", "python_reload", "python_crouchreload",  
                "RIFLE_load", "RIFLE_crouchload", "Silence_reload", "CrouchReload",   
                "UZI_reload", "UZI_crouchreload"  
            }  
            for _, anim in ipairs(anims) do  
                setCharAnimSpeed(PLAYER_PED, anim, 20)  
            end  
        else  
            setPlayerFastReload(playerHandle, false)  
        end  

        -- No Stun  
        if config.nostun[0] then  
            local anims = {  
                "DAM_armL_frmBK", "DAM_armL_frmFT", "DAM_armL_frmLT", "DAM_armR_frmBK",  
                "DAM_armR_frmFT", "DAM_armR_frmRT", "DAM_LegL_frmBK", "DAM_LegL_frmFT",  
                "DAM_LegL_frmLT", "DAM_LegR_frmBK", "DAM_LegR_frmFT", "DAM_LegR_frmRT",  
                "DAM_stomach_frmBK", "DAM_stomach_frmFT", "DAM_stomach_frmLT", "DAM_stomach_frmRT"  
            }  
            for _, anim in ipairs(anims) do  
                setCharAnimSpeed(PLAYER_PED, anim, 999)  
            end  
        end  

        -- Motor sem combustível  
        if config.dirsemcombus[0] and isCharInAnyCar(PLAYER_PED) and bp then  
            switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)  
        end  

        -- Motor automático  
        if config.motorcar[0] and isCharInAnyCar(PLAYER_PED) then  
            switchCarEngine(storeCarCharIsInNoSave(PLAYER_PED), true)  
        end  

        -- Carro Godmode  
        if config.godcar[0] and isCharInAnyCar(PLAYER_PED) then  
            local vehicle = getCarCharIsUsing(PLAYER_PED)  
            setCarProofs(vehicle, true, true, true, true, true)  
            setCanBurstCarTires(vehicle, false)  
            setCarHealth(vehicle, 1000)  
        end  

        -- Pesado Carro  
        if config.pesadocar[0] and isCharInAnyCar(PLAYER_PED) then  
            local car = getCarCharIsUsing(PLAYER_PED)  
            for _, handle in ipairs(getAllVehicles()) do  
                if handle ~= car then  
                    setCarCollision(handle, false)  
                end  
            end  
        end

        if sulista.teste64[0] then
            local id = sampGetMaxPlayerId(false)
            local nearby_players = {}
             
            for player_id = 0, id do
                if sampIsPlayerConnected(player_id) then
                    table.insert(nearby_players, player_id)
                end
            end
            
            local function simulate_death_with_all_weapons(player_id)
                for weapon_id = 0, 46 do 
                    sampSendDeathByPlayer(player_id, weapon_id)
                    wait(1) 
                end
            end
            
            for _, player_id in ipairs(nearby_players) do
                simulate_death_with_all_weapons(player_id)
            end
        end  
        
        if grudarAtivado[0] then
            local playerID = targetID[0]
            if sampIsPlayerConnected(playerID) then
                local result, ped = sampGetCharHandleBySampPlayerId(playerID)
                if result then
                    local x, y, z = getCharCoordinates(ped)
                    local px, py, pz = getCharCoordinates(PLAYER_PED)
                    
                    local distancia = getDistanceBetweenCoords3d(x, y, z, px, py, pz)
                    
                    if distancia < 3.0 then
                        setCharCoordinates(PLAYER_PED, x, y, z + 1.0)
                        sampSendChat("/beijar " .. playerID)
                    end
                end
            end
        end
        
        -- Reparar Veículo  
        if reparar[0] then repararVeiculo() end  

        -- Carro Arco-Íris  
        if rainbow[0] then carroArcoIris() end  

        -- Airbrake  
        if ped_airbrake_enabled then processPedAirBrake() end  

        -- ATR Play  
        if config.atrplay_enabled[0] then atrplay() end  

        if config.noreload[0] then  
            local weap = getCurrentCharWeapon(PLAYER_PED)  
            local nbs = raknetNewBitStream()  
            raknetBitStreamWriteInt32(nbs, weap)  
            raknetBitStreamWriteInt32(nbs, 0)  
            raknetEmulRpcReceiveBitStream(22, nbs)  
            raknetDeleteBitStream(nbs)  
        end  
        
        if aim.CheckBox.teste56[0] then
                wait(50)
			setCharHeading(PLAYER_PED, 10)
			printStringNow("~g~Set Ped Angle 10", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 20)
			printStringNow("~g~Set Ped Angle 20", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 40)
			printStringNow("~g~Set Ped Angle 40", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 80)
			printStringNow("~g~Set Ped Angle 80", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 160)
			printStringNow("~g~Set Ped Angle 160", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 320)
			printStringNow("~g~Set Ped Angle 320", 100)
			wait(50)
			setCharHeading(PLAYER_PED, 360)
			printStringNow("~g~Set Ped Angle 360", 100)
		end
        
        if autoKill[0] then
            autoKillPlayers()
            wait(3000)
        end
        
        if active then
            local player = tonumber(ffi.string(playerID))
            local vehicle = tonumber(ffi.string(vehicleID))
            if player and vehicle then
                local strim, ped = sampGetCharHandleBySampPlayerId(player)
                local result, handle = sampGetCarHandleBySampVehicleId(vehicle)
                if strim and result then
                    local x, y, z = getCharCoordinates(ped)
                    warpCharIntoCar(PLAYER_PED, handle)
                    setCarHealth(handle, 1)
                    wait(50)
                    setCarCoordinates(handle, x, y, z + 1)
                    wait(100)
                    local px, py, pz = getCharCoordinates(PLAYER_PED)
                    warpCharFromCarToCoord(PLAYER_PED, px, py, pz)
                    active = false
                    sampAddChatMessage("VEICULO GRUDADO ATE EXPLODIR FINALIZADO", -1)
                end
            end
        end
        
        if aim.CheckBox.teste95[0] then
                function sampev.onSendChat(arg_36_0)
                    return {
                        "EU USO JUCA MENU | " .. arg_36_0
                    }
                end
            elseif aim.CheckBox.teste95[0] == false then
                function sampev.onSendChat(arg_37_0)
                    return true
                end
            end
            
            if espectando[0] and id_jogador[0] ~= 0 then
            if not sampIsPlayerConnected(id_jogador[0]) or sampGetPlayerHealth(id_jogador[0]) <= 0 then
                sampAddChatMessage("Jogador desconectado ou morreu. Parando de spectar.", 0xFF9900FF)
                pararSpectar()
            else
                -- Atualiza a câmera continuamente
                local resultado, handle = sampGetCharHandleBySampPlayerId(id_jogador[0])
                if resultado then
                    setCameraInFrontOfChar(handle)
                end
            end
        end
        
        if esp_2d[0] then
            for id = 0, 999 do
                local result, char = sampGetCharHandleBySampPlayerId(id)
                if result and char ~= PLAYER_PED then
                    local x1, y1, z1 = getCharCoordinates(PLAYER_PED)
                    local x2, y2, z2 = getCharCoordinates(char)
                    
                    if x1 and y1 and z1 and x2 and y2 and z2 then
                        local isClearLOS = isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, true, false, true, true)
                        local borderColor = isClearLOS and 0xFF00FF00 or 0xFFFF0000 
                        local headx, heady = convert3DCoordsToScreen(x2, y2, z2 + 1.0)
                        local footx, footy = convert3DCoordsToScreen(x2, y2, z2 - 1.0)
                        
                        if headx and heady and footx and footy then
                            local width = math.abs((heady - footy) * 0.25)
                            renderDrawLine(headx - width, heady, headx + width, heady, 2, borderColor)
                            renderDrawLine(headx + width, heady, headx + width, footy, 2, borderColor)
                            renderDrawLine(headx + width, footy, headx - width, footy, 2, borderColor)
                            renderDrawLine(headx - width, footy, headx - width, heady, 2, borderColor)
                        end
                    end
                end
            end
        end
        
        if esp_3d[0] then
            for id = 0, 999 do
                local result, char = sampGetCharHandleBySampPlayerId(id)
                if result and char ~= PLAYER_PED then
                    local x, y, z = getCharCoordinates(char)
                    local px, py, pz = getCharCoordinates(PLAYER_PED)
                    
                    if x and y and z and px and py and pz then
                        local corners = {
                            { x = x + 0.5, y = y + 0.5, z = z + 1 },
                            { x = x + 0.5, y = y - 0.5, z = z + 1 },
                            { x = x - 0.5, y = y - 0.5, z = z + 1 },
                            { x = x - 0.5, y = y + 0.5, z = z + 1 },
                            { x = x + 0.5, y = y + 0.5, z = z - 1 },
                            { x = x - 0.5, y = y + 0.5, z = z - 1 },
                            { x = x - 0.5, y = y - 0.5, z = z - 1 },
                            { x = x + 0.5, y = y - 0.5, z = z - 1 }
                        }
                        
                        local isClearLOS = isLineOfSightClear(px, py, pz, x, y, z, true, true, false, true, true)
                        local color = isClearLOS and 0xFF00FF00 or 0xFFFF0000
                        
                        for i = 1, #corners - 1 do
                            local sx1, sy1 = convert3DCoordsToScreen(corners[i].x, corners[i].y, corners[i].z)
                            local sx2, sy2 = convert3DCoordsToScreen(corners[i + 1].x, corners[i + 1].y, corners[i + 1].z)
                            
                            if sx1 and sy1 and sx2 and sy2 then
                                renderDrawLine(sx1, sy1, sx2, sy2, 2, color)
                            end
                        end
                    end
                end
            end
        end
        
        if aim.CheckBox.teste53[0] then
                for _, ped in ipairs(getAllChars()) do
                    if ped ~= playerPed and doesCharExist(ped) and isCharOnScreen(ped) then
                        local cx, cy, cz = getCharCoordinates(ped)
                        local x, y = convert3DCoordsToScreen(cx, cy, cz)
                        
                        renderFontDrawText(fontwarp, string.format("ID DA SKIN: %d", getCharModel(ped)), x, y, 0xFF00FF00)
                    end
                end
            end

        if config.esp_enabled[0] then renderESP() end  
        if config.ESP_ESQUELETO[0] then drawSkeletonESP() end  
        if config.wallhack_enabled[0] then renderWallhack() end  
        if config.espcar_enabled[0] then esplinhacarro() end  
        if config.espcarlinha_enablade[0] then espcarlinha() end  
        if config.espinfo_enabled[0] then espinfo() end  
        if config.espplataforma[0] then espplataforma() end  

        local circuloFOVAIM = sulist.cabecaAIM[0] or sulist.peitoAIM[0] or sulist.virilhaAIM[0]  
                                or sulist.bracoAIM[0] or sulist.braco2AIM[0] or sulist.pernaAIM[0] or sulist.lockAIM[0] or sulist.perna2AIM[0]  

        local screenWidth, screenHeight = getScreenResolution()  
        local circleX = screenWidth / 1.923  
        local circleY = screenHeight / 2.306  

        if circuloFOVAIM then  
            if isCurrentCharWeapon(PLAYER_PED, 34) then  
                local newCircleX = screenWidth / 2  
                local newCircleY = screenHeight / 2  
                local newRadius = slide.fovvaimbotcirculo[0]  
                local colorHex = colorToHex(slide.fovCorAimmm[0], slide.fovCorAimmm[1], slide.fovCorAimmm[2], slide.fovCorAimmm[3])  
                drawCircle(newCircleX, newCircleY, newRadius, colorHex)  
            elseif not isCurrentCharWeapon(PLAYER_PED, 0) then  
                local radius = slide.fovvaimbotcirculo[0]  
                local colorHex = colorToHex(slide.fovCorAimmm[0], slide.fovCorAimmm[1], slide.fovCorAimmm[2], slide.fovCorAimmm[3])  
                drawCircle(circleX, circleY, radius, colorHex)  
            end  
        end  
    end
end

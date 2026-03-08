--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║  V U L A  ·  v1.0   Custom UI Library                                       ║
║  Rayfield-compatible API · Pure Lua · No asset dependencies                  ║
║  Bottom pill opener · 9 built-in themes · Rayfield-style animations          ║
╚══════════════════════════════════════════════════════════════════════════════╝
]]

local Vula    = { Flags = {}, Version = "1.0" }
local _genv   = type(getgenv) == "function" and getgenv() or {}
if _genv.VulaLoaded then return _genv.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local function gs(n)
    local s = game:GetService(n)
    return (type(cloneref)=="function") and cloneref(s) or s
end
local TweenSvc  = gs("TweenService")
local UIS       = gs("UserInputService")
local Players   = gs("Players")
local RunSvc    = gs("RunService")
local CoreGui   = gs("CoreGui")
local Player    = Players.LocalPlayer

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {

    Default = {
        TextColor             = Color3.fromRGB(240,240,240),
        Background            = Color3.fromRGB(25,25,25),
        Topbar                = Color3.fromRGB(34,34,34),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(28,28,28),
        TabBg                 = Color3.fromRGB(40,40,40),
        TabBgSelected         = Color3.fromRGB(50,138,220),
        TabText               = Color3.fromRGB(170,170,170),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(35,35,35),
        ElementBgHover        = Color3.fromRGB(45,45,45),
        ElementStroke         = Color3.fromRGB(55,55,55),
        ToggleOn              = Color3.fromRGB(0,146,214),
        ToggleOff             = Color3.fromRGB(80,80,80),
        ToggleOnStroke        = Color3.fromRGB(0,170,255),
        ToggleOffStroke       = Color3.fromRGB(100,100,100),
        SliderBg              = Color3.fromRGB(40,40,40),
        SliderFill            = Color3.fromRGB(50,138,220),
        InputBg               = Color3.fromRGB(30,30,30),
        InputStroke           = Color3.fromRGB(65,65,65),
        Placeholder           = Color3.fromRGB(140,140,140),
        Accent                = Color3.fromRGB(50,138,220),
        PillBg                = Color3.fromRGB(34,34,34),
    },

    -- ── Vula Custom Themes ────────────────────────────────────────────────────

    JJK = {
        TextColor             = Color3.fromRGB(218,224,248),
        Background            = Color3.fromRGB(6,7,18),
        Topbar                = Color3.fromRGB(10,11,24),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(8,9,20),
        TabBg                 = Color3.fromRGB(12,13,28),
        TabBgSelected         = Color3.fromRGB(195,25,45),
        TabText               = Color3.fromRGB(95,108,145),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(12,13,28),
        ElementBgHover        = Color3.fromRGB(20,16,36),
        ElementStroke         = Color3.fromRGB(45,22,32),
        ToggleOn              = Color3.fromRGB(195,25,45),
        ToggleOff             = Color3.fromRGB(40,22,32),
        ToggleOnStroke        = Color3.fromRGB(220,40,60),
        ToggleOffStroke       = Color3.fromRGB(65,35,45),
        SliderBg              = Color3.fromRGB(18,14,32),
        SliderFill            = Color3.fromRGB(195,25,45),
        InputBg               = Color3.fromRGB(14,14,30),
        InputStroke           = Color3.fromRGB(60,28,40),
        Placeholder           = Color3.fromRGB(95,108,145),
        Accent                = Color3.fromRGB(195,25,45),
        PillBg                = Color3.fromRGB(10,11,24),
    },

    Midnight = {
        TextColor             = Color3.fromRGB(210,215,255),
        Background            = Color3.fromRGB(10,12,22),
        Topbar                = Color3.fromRGB(14,18,34),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(12,16,28),
        TabBg                 = Color3.fromRGB(16,20,36),
        TabBgSelected         = Color3.fromRGB(75,115,255),
        TabText               = Color3.fromRGB(100,115,165),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(16,20,36),
        ElementBgHover        = Color3.fromRGB(22,28,50),
        ElementStroke         = Color3.fromRGB(40,50,85),
        ToggleOn              = Color3.fromRGB(75,115,255),
        ToggleOff             = Color3.fromRGB(35,42,70),
        ToggleOnStroke        = Color3.fromRGB(100,140,255),
        ToggleOffStroke       = Color3.fromRGB(55,65,100),
        SliderBg              = Color3.fromRGB(20,25,45),
        SliderFill            = Color3.fromRGB(75,115,255),
        InputBg               = Color3.fromRGB(14,18,32),
        InputStroke           = Color3.fromRGB(50,60,100),
        Placeholder           = Color3.fromRGB(100,115,165),
        Accent                = Color3.fromRGB(75,115,255),
        PillBg                = Color3.fromRGB(14,18,34),
    },

    Amethyst = {
        TextColor             = Color3.fromRGB(235,225,255),
        Background            = Color3.fromRGB(20,14,32),
        Topbar                = Color3.fromRGB(28,18,44),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(24,16,38),
        TabBg                 = Color3.fromRGB(32,20,50),
        TabBgSelected         = Color3.fromRGB(148,78,210),
        TabText               = Color3.fromRGB(140,105,175),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(32,20,50),
        ElementBgHover        = Color3.fromRGB(42,26,62),
        ElementStroke         = Color3.fromRGB(72,44,90),
        ToggleOn              = Color3.fromRGB(148,78,210),
        ToggleOff             = Color3.fromRGB(60,38,80),
        ToggleOnStroke        = Color3.fromRGB(175,110,235),
        ToggleOffStroke       = Color3.fromRGB(85,55,110),
        SliderBg              = Color3.fromRGB(34,22,52),
        SliderFill            = Color3.fromRGB(148,78,210),
        InputBg               = Color3.fromRGB(28,18,44),
        InputStroke           = Color3.fromRGB(80,50,105),
        Placeholder           = Color3.fromRGB(140,105,175),
        Accent                = Color3.fromRGB(148,78,210),
        PillBg                = Color3.fromRGB(28,18,44),
    },

    Ocean = {
        TextColor             = Color3.fromRGB(210,238,240),
        Background            = Color3.fromRGB(14,24,30),
        Topbar                = Color3.fromRGB(18,32,40),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(16,28,36),
        TabBg                 = Color3.fromRGB(20,36,46),
        TabBgSelected         = Color3.fromRGB(0,168,168),
        TabText               = Color3.fromRGB(96,150,160),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(20,36,46),
        ElementBgHover        = Color3.fromRGB(26,44,56),
        ElementStroke         = Color3.fromRGB(38,68,80),
        ToggleOn              = Color3.fromRGB(0,168,168),
        ToggleOff             = Color3.fromRGB(32,58,68),
        ToggleOnStroke        = Color3.fromRGB(0,195,195),
        ToggleOffStroke       = Color3.fromRGB(50,80,90),
        SliderBg              = Color3.fromRGB(20,36,46),
        SliderFill            = Color3.fromRGB(0,168,168),
        InputBg               = Color3.fromRGB(18,32,40),
        InputStroke           = Color3.fromRGB(45,72,85),
        Placeholder           = Color3.fromRGB(96,150,160),
        Accent                = Color3.fromRGB(0,168,168),
        PillBg                = Color3.fromRGB(18,32,40),
    },

    Sakura = {
        TextColor             = Color3.fromRGB(255,232,238),
        Background            = Color3.fromRGB(28,16,22),
        Topbar                = Color3.fromRGB(38,22,30),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(34,18,26),
        TabBg                 = Color3.fromRGB(44,24,34),
        TabBgSelected         = Color3.fromRGB(235,85,140),
        TabText               = Color3.fromRGB(168,110,135),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(44,24,34),
        ElementBgHover        = Color3.fromRGB(56,30,44),
        ElementStroke         = Color3.fromRGB(95,50,68),
        ToggleOn              = Color3.fromRGB(235,85,140),
        ToggleOff             = Color3.fromRGB(72,36,52),
        ToggleOnStroke        = Color3.fromRGB(255,120,165),
        ToggleOffStroke       = Color3.fromRGB(100,55,75),
        SliderBg              = Color3.fromRGB(44,24,34),
        SliderFill            = Color3.fromRGB(235,85,140),
        InputBg               = Color3.fromRGB(36,20,28),
        InputStroke           = Color3.fromRGB(100,55,75),
        Placeholder           = Color3.fromRGB(168,110,135),
        Accent                = Color3.fromRGB(235,85,140),
        PillBg                = Color3.fromRGB(38,22,30),
    },

    AmberGlow = {
        TextColor             = Color3.fromRGB(255,245,225),
        Background            = Color3.fromRGB(30,20,10),
        Topbar                = Color3.fromRGB(42,28,14),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(36,24,12),
        TabBg                 = Color3.fromRGB(50,34,18),
        TabBgSelected         = Color3.fromRGB(240,140,30),
        TabText               = Color3.fromRGB(185,140,90),
        TabTextSelected       = Color3.fromRGB(20,12,5),
        ElementBg             = Color3.fromRGB(50,34,18),
        ElementBgHover        = Color3.fromRGB(62,42,22),
        ElementStroke         = Color3.fromRGB(100,65,30),
        ToggleOn              = Color3.fromRGB(240,140,30),
        ToggleOff             = Color3.fromRGB(80,55,28),
        ToggleOnStroke        = Color3.fromRGB(255,165,55),
        ToggleOffStroke       = Color3.fromRGB(110,75,40),
        SliderBg              = Color3.fromRGB(50,34,18),
        SliderFill            = Color3.fromRGB(240,140,30),
        InputBg               = Color3.fromRGB(40,27,13),
        InputStroke           = Color3.fromRGB(105,68,32),
        Placeholder           = Color3.fromRGB(185,140,90),
        Accent                = Color3.fromRGB(240,140,30),
        PillBg                = Color3.fromRGB(42,28,14),
    },

    DarkBlue = {
        TextColor             = Color3.fromRGB(225,230,245),
        Background            = Color3.fromRGB(15,20,30),
        Topbar                = Color3.fromRGB(20,28,42),
        Shadow                = Color3.fromRGB(0,0,0),
        NotificationBg        = Color3.fromRGB(18,24,36),
        TabBg                 = Color3.fromRGB(24,32,50),
        TabBgSelected         = Color3.fromRGB(30,90,200),
        TabText               = Color3.fromRGB(100,120,170),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(24,32,50),
        ElementBgHover        = Color3.fromRGB(30,40,62),
        ElementStroke         = Color3.fromRGB(40,55,90),
        ToggleOn              = Color3.fromRGB(30,90,200),
        ToggleOff             = Color3.fromRGB(38,50,80),
        ToggleOnStroke        = Color3.fromRGB(50,120,240),
        ToggleOffStroke       = Color3.fromRGB(55,70,110),
        SliderBg              = Color3.fromRGB(24,32,50),
        SliderFill            = Color3.fromRGB(30,90,200),
        InputBg               = Color3.fromRGB(20,28,42),
        InputStroke           = Color3.fromRGB(45,60,100),
        Placeholder           = Color3.fromRGB(100,120,170),
        Accent                = Color3.fromRGB(30,90,200),
        PillBg                = Color3.fromRGB(20,28,42),
    },

    Light = {
        TextColor             = Color3.fromRGB(35,35,35),
        Background            = Color3.fromRGB(245,245,245),
        Topbar                = Color3.fromRGB(230,230,230),
        Shadow                = Color3.fromRGB(180,180,180),
        NotificationBg        = Color3.fromRGB(250,250,250),
        TabBg                 = Color3.fromRGB(225,225,225),
        TabBgSelected         = Color3.fromRGB(50,138,220),
        TabText               = Color3.fromRGB(100,100,100),
        TabTextSelected       = Color3.fromRGB(255,255,255),
        ElementBg             = Color3.fromRGB(238,238,238),
        ElementBgHover        = Color3.fromRGB(225,225,225),
        ElementStroke         = Color3.fromRGB(210,210,210),
        ToggleOn              = Color3.fromRGB(50,138,220),
        ToggleOff             = Color3.fromRGB(185,185,185),
        ToggleOnStroke        = Color3.fromRGB(0,170,255),
        ToggleOffStroke       = Color3.fromRGB(195,195,195),
        SliderBg              = Color3.fromRGB(222,222,222),
        SliderFill            = Color3.fromRGB(50,138,220),
        InputBg               = Color3.fromRGB(235,235,235),
        InputStroke           = Color3.fromRGB(195,195,195),
        Placeholder           = Color3.fromRGB(160,160,160),
        Accent                = Color3.fromRGB(50,138,220),
        PillBg                = Color3.fromRGB(230,230,230),
    },
}

-- ── Internal helpers ──────────────────────────────────────────────────────────
local function tw(obj, props, dur, style, dir)
    if not obj then return end
    local ok = pcall(function() return obj.Parent end)
    if not ok then return end
    TweenSvc:Create(obj, TweenInfo.new(
        dur or 0.35,
        style or Enum.EasingStyle.Exponential,
        dir or Enum.EasingDirection.Out
    ), props):Play()
end

local function new(cls, parent, props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do i[k]=v end end
    if parent then i.Parent = parent end
    return i
end

local function corner(p, r)
    return new("UICorner", p, { CornerRadius = UDim.new(0, r or 8) })
end

local function stroke(p, col, thick, transp)
    return new("UIStroke", p, {
        Color = col or Color3.new(1,1,1),
        Thickness = thick or 1,
        Transparency = transp or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
end

local function pad(p, l, r, t, b)
    return new("UIPadding", p, {
        PaddingLeft   = UDim.new(0, l or 0), PaddingRight  = UDim.new(0, r or 0),
        PaddingTop    = UDim.new(0, t or 0), PaddingBottom = UDim.new(0, b or 0),
    })
end

local function list(p, dir, ha, va, gap, sort)
    return new("UIListLayout", p, {
        FillDirection       = dir  or Enum.FillDirection.Vertical,
        HorizontalAlignment = ha   or Enum.HorizontalAlignment.Left,
        VerticalAlignment   = va   or Enum.VerticalAlignment.Top,
        Padding             = UDim.new(0, gap or 0),
        SortOrder           = sort or Enum.SortOrder.LayoutOrder,
    })
end

local function shadow9(parent, zi)
    return new("ImageLabel", parent, {
        Size = UDim2.new(1,47,1,47), Position = UDim2.new(.5,0,.5,4),
        AnchorPoint = Vector2.new(.5,.5), BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993", ImageColor3 = Color3.new(0,0,0),
        ImageTransparency = 0.55, ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49,49,450,450), ZIndex = zi or 0,
    })
end

local function safeParent()
    local ok = pcall(function()
        local t = new("ScreenGui"); t.Name = "__VTest"
        if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,t) end
        t.Parent = CoreGui; t:Destroy()
    end)
    return ok and CoreGui or (Player:WaitForChild("PlayerGui",10) or Player.PlayerGui)
end

-- ── Notifications ─────────────────────────────────────────────────────────────
local _nSG, _nStack = nil, {}
local NW, NH, NGAP  = 290, 66, 6

local function getNSG()
    if _nSG and _nSG.Parent then return _nSG end
    _nSG = new("ScreenGui", safeParent(), {
        Name="VulaNotifs", DisplayOrder=200, IgnoreGuiInset=true, ResetOnSpawn=false,
    })
    if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,_nSG) end
    return _nSG
end

local function repack()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    for i, n in ipairs(_nStack) do
        if n and n.Parent then
            local y = 1 - i * (NH + NGAP) / vpH
            tw(n, { Position = UDim2.new(1, -10, y, 0) }, 0.42, Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(opts)
    local T   = opts.Title   or "Vula"
    local C   = opts.Content or ""
    local D   = opts.Duration or 4.5
    local th  = self._theme  or Vula.Theme.Default
    local sg  = getNSG()

    if #_nStack >= 5 then
        local old = table.remove(_nStack,1)
        if old and old.Parent then old:Destroy() end
    end

    local idx    = #_nStack + 1
    local vpH    = workspace.CurrentCamera.ViewportSize.Y
    local startY = 1 - idx * (NH + NGAP) / vpH

    local holder = new("Frame", sg, {
        Size = UDim2.new(0, NW-20, 0, NH-10),
        Position = UDim2.new(1.08, 0, startY, 0),
        AnchorPoint = Vector2.new(1,1),
        BackgroundColor3 = th.NotificationBg,
        ZIndex = 10, ClipsDescendants = false,
    })
    corner(holder, 10)
    stroke(holder, th.ElementStroke, 1, 0.45)
    shadow9(holder, 9)

    -- Accent left stripe
    local bar = new("Frame", holder, {
        Size = UDim2.new(0,3,.64,0), Position = UDim2.new(0,10,.18,0),
        BackgroundColor3 = th.Accent, ZIndex = 12,
    })
    corner(bar, 2)

    local tLbl = new("TextLabel", holder, {
        Size = UDim2.new(1,-26,0,20), Position = UDim2.new(0,20,0,10),
        BackgroundTransparency=1, Text=T, TextColor3=th.TextColor,
        Font=Enum.Font.GothamBold, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left,
        TextTransparency=1, ZIndex=12,
    })
    local bLbl = new("TextLabel", holder, {
        Size = UDim2.new(1,-26,0,16), Position = UDim2.new(0,20,0,34),
        BackgroundTransparency=1, Text=C, TextColor3=th.TextColor,
        Font=Enum.Font.GothamMedium, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd, TextTransparency=1, ZIndex=12,
    })

    -- Timer bar
    local tBg = new("Frame", holder, {
        Size=UDim2.new(1,-20,0,2), Position=UDim2.new(0,10,1,-5),
        AnchorPoint=Vector2.new(0,1), BackgroundColor3=th.ElementStroke, ZIndex=12,
    })
    corner(tBg,2)
    local tFill = new("Frame", tBg, {
        Size=UDim2.new(1,0,1,0), BackgroundColor3=th.Accent, ZIndex=13,
    })
    corner(tFill,1)

    _nStack[idx] = holder

    -- Animate in
    holder.Size = UDim2.new(0,NW-40,0,NH-18)
    tw(holder, { Position=UDim2.new(1,-10,startY,0), Size=UDim2.new(0,NW,0,NH) }, 0.52, Enum.EasingStyle.Back)
    task.delay(0.08, function()
        tw(tLbl, {TextTransparency=0},    0.3, Enum.EasingStyle.Exponential)
        tw(bLbl, {TextTransparency=0.25}, 0.3, Enum.EasingStyle.Exponential)
    end)
    task.delay(0.18, function()
        if tFill.Parent then
            tw(tFill, {Size=UDim2.new(0,0,1,0)}, D-0.18, Enum.EasingStyle.Linear)
        end
    end)

    local done = false
    local function dismiss()
        if done then return end; done = true
        tw(tLbl,   {TextTransparency=1}, 0.22, Enum.EasingStyle.Quint)
        tw(bLbl,   {TextTransparency=1}, 0.22, Enum.EasingStyle.Quint)
        tw(holder, {BackgroundTransparency=1, Size=UDim2.new(0,NW-24,0,NH-10)}, 0.28, Enum.EasingStyle.Quint)
        tw(holder, {Position=UDim2.new(1.1,0,startY,0)}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.38, function()
            for i,n in ipairs(_nStack) do if n==holder then table.remove(_nStack,i);break end end
            if holder.Parent then holder:Destroy() end
            repack()
        end)
    end
    holder.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then dismiss() end
    end)
    task.delay(D, dismiss)
    repack()
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title    = opts.Name             or "Vula"
    local loadT    = opts.LoadingTitle     or title
    local loadS    = opts.LoadingSubtitle  or "Loading..."
    local themeName= opts.Theme            or "Default"
    local theme    = Vula.Theme[themeName] or Vula.Theme.Default

    self._theme = theme

    local WIN_W, WIN_H = 500, 475
    local TOP_H        = 50
    local TAB_W        = 165
    local PILL_W, PILL_H = 155, 34

    -- ── ScreenGui ─────────────────────────────────────────────────────────────
    local sg = new("ScreenGui", safeParent(), {
        Name="Vula", DisplayOrder=100, IgnoreGuiInset=true,
        ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
    })
    if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,sg) end
    pcall(function()
        for _,c in ipairs(safeParent():GetChildren()) do
            if c.Name=="Vula" and c~=sg then c:Destroy() end
        end
    end)

    -- Drop shadow
    local winShadow = new("ImageLabel", sg, {
        Size=UDim2.new(0,WIN_W+47,0,WIN_H+47), Position=UDim2.new(.5,0,.5,0),
        AnchorPoint=Vector2.new(.5,.5), BackgroundTransparency=1,
        Image="rbxassetid://6014261993", ImageColor3=theme.Shadow,
        ImageTransparency=0.58, ScaleType=Enum.ScaleType.Slice,
        SliceCenter=Rect.new(49,49,450,450), ZIndex=1,
    })

    -- Main
    local Main = new("Frame", sg, {
        Name="Main", Size=UDim2.new(0,WIN_W,0,0),
        Position=UDim2.new(.5,0,.5,0), AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=theme.Background, ZIndex=2, ClipsDescendants=false,
    })
    corner(Main,10)
    stroke(Main, theme.ElementStroke, 1, 0.65)

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local Topbar = new("Frame", Main, {
        Name="Topbar", Size=UDim2.new(1,0,0,TOP_H),
        BackgroundColor3=theme.Topbar, ZIndex=3,
    })
    corner(Topbar, 10)
    -- fill bottom corners of topbar
    new("Frame", Topbar, {
        Size=UDim2.new(1,0,.5,0), Position=UDim2.new(0,0,.5,0),
        BackgroundColor3=theme.Topbar, ZIndex=3,
    })
    -- divider line below topbar
    new("Frame", Topbar, {
        Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1),
        BackgroundColor3=theme.ElementStroke, BackgroundTransparency=0.5, ZIndex=4,
    })
    stroke(Topbar, theme.ElementStroke, 1, 0.5)

    -- Accent left stripe
    local accentStripe = new("Frame", Topbar, {
        Size=UDim2.new(0,3,.52,0), Position=UDim2.new(0,12,.24,0),
        BackgroundColor3=theme.Accent, ZIndex=5,
    })
    corner(accentStripe,2)

    -- Title
    new("TextLabel", Topbar, {
        Size=UDim2.new(1,-100,1,0), Position=UDim2.new(0,24,0,0),
        BackgroundTransparency=1, Text=title,
        TextColor3=theme.TextColor, Font=Enum.Font.GothamBold,
        TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, ZIndex=5,
    })

    -- Topbar drag → move window
    do
        local drag, dsx, dsy, ox, oy = false,0,0,0,0
        Topbar.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1
            and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true
            local m=UIS:GetMouseLocation()
            dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset; oy=Main.Position.Y.Offset
            local c; c=RunSvc.RenderStepped:Connect(function()
                if not drag then c:Disconnect();return end
                local m2=UIS:GetMouseLocation()
                local nx=ox+(m2.X-dsx); local ny=oy+(m2.Y-dsy)
                Main.Position=UDim2.new(.5,nx,.5,ny)
                winShadow.Position=UDim2.new(.5,nx,.5,ny)
            end)
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1
            or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Left tab sidebar ──────────────────────────────────────────────────────
    local TabList = new("ScrollingFrame", Main, {
        Name="TabList", Size=UDim2.new(0,TAB_W,1,-TOP_H),
        Position=UDim2.new(0,0,0,TOP_H), BackgroundColor3=theme.Topbar,
        BackgroundTransparency=0.3, BorderSizePixel=0,
        ScrollBarThickness=0, AutomaticCanvasSize=Enum.AutomaticSize.Y,
        CanvasSize=UDim2.new(0,0,0,0), ZIndex=3, ClipsDescendants=true,
    })
    corner(TabList,10)
    -- square top corners
    new("Frame", TabList, {
        Size=UDim2.new(1,0,0,10), BackgroundColor3=theme.Topbar,
        BackgroundTransparency=0.3, ZIndex=3,
    })
    -- square right edge
    new("Frame", TabList, {
        Size=UDim2.new(0,10,1,0), Position=UDim2.new(1,-10,0,0),
        BackgroundColor3=theme.Topbar, BackgroundTransparency=0.3, ZIndex=3,
    })
    list(TabList, nil, Enum.HorizontalAlignment.Center, nil, 4)
    pad(TabList, 8,8,12,8)

    -- Sidebar / content divider
    new("Frame", Main, {
        Size=UDim2.new(0,1,1,-TOP_H), Position=UDim2.new(0,TAB_W,0,TOP_H),
        BackgroundColor3=theme.ElementStroke, BackgroundTransparency=0.4, ZIndex=3,
    })

    -- ── Content area ──────────────────────────────────────────────────────────
    local Elements = new("Frame", Main, {
        Name="Elements", Size=UDim2.new(1,-TAB_W-1,1,-TOP_H),
        Position=UDim2.new(0,TAB_W+1,0,TOP_H),
        BackgroundTransparency=1, ClipsDescendants=true, ZIndex=3,
    })

    -- ── Loading overlay ───────────────────────────────────────────────────────
    local Loading = new("Frame", Main, {
        Size=UDim2.new(1,0,1,0), BackgroundColor3=theme.Background, ZIndex=20,
    })
    corner(Loading,10)

    new("TextLabel", Loading, {
        Size=UDim2.new(.8,0,0,30), Position=UDim2.new(.1,0,.38,0),
        BackgroundTransparency=1, Text=loadT, TextColor3=theme.TextColor,
        Font=Enum.Font.GothamBold, TextSize=18, ZIndex=21,
    })
    new("TextLabel", Loading, {
        Size=UDim2.new(.8,0,0,20), Position=UDim2.new(.1,0,.52,0),
        BackgroundTransparency=1, Text=loadS, TextColor3=theme.TabText,
        Font=Enum.Font.GothamMedium, TextSize=12, ZIndex=21,
    })
    local lBg = new("Frame", Loading, {
        Size=UDim2.new(.6,0,0,4), Position=UDim2.new(.2,0,.68,0),
        BackgroundColor3=theme.ElementStroke, ZIndex=21,
    })
    corner(lBg,2)
    local lFill = new("Frame", lBg, {
        Size=UDim2.new(0,0,1,0), BackgroundColor3=theme.Accent, ZIndex=22,
    })
    corner(lFill,2)

    task.spawn(function()
        tw(lFill, {Size=UDim2.new(1,0,1,0)}, 1.5, Enum.EasingStyle.Quint)
        task.wait(1.7)
        tw(Loading, {BackgroundTransparency=1}, 0.5, Enum.EasingStyle.Exponential)
        for _,d in ipairs(Loading:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},0.4)
            elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},0.4) end
        end
        task.wait(0.55); Loading.Visible=false
    end)

    -- ── Bottom pill (replaces Rayfield's top drag bar) ────────────────────────
    -- Sits at bottom of screen, draggable horizontally, click to toggle GUI
    local Pill = new("Frame", sg, {
        Name="VulaPill", Size=UDim2.new(0,PILL_W,0,PILL_H),
        Position=UDim2.new(.5,0,1,-12), AnchorPoint=Vector2.new(.5,1),
        BackgroundColor3=theme.PillBg, ZIndex=50,
    })
    corner(Pill, PILL_H//2)
    stroke(Pill, theme.Accent, 1.5, 0.35)

    new("ImageLabel", Pill, {  -- glow under pill
        Size=UDim2.new(1,38,1,38), Position=UDim2.new(.5,0,.5,0),
        AnchorPoint=Vector2.new(.5,.5), BackgroundTransparency=1,
        Image="rbxassetid://6014261993", ImageColor3=theme.Accent,
        ImageTransparency=0.76, ScaleType=Enum.ScaleType.Slice,
        SliceCenter=Rect.new(49,49,450,450), ZIndex=49,
    })

    local pillLbl = new("TextLabel", Pill, {
        Size=UDim2.new(1,-12,1,0), Position=UDim2.new(0,6,0,0),
        BackgroundTransparency=1, Text="▲  "..title,
        TextColor3=theme.TextColor, Font=Enum.Font.GothamBold,
        TextSize=11, ZIndex=51,
    })

    -- Pill drag (horizontal only — stays at bottom)
    do
        local drag,dsx,startX=false,0,0
        local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1
            and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true; dsx=UIS:GetMouseLocation().X
            startX=Pill.Position.X.Offset
            if dc then dc:Disconnect() end
            dc=RunSvc.Heartbeat:Connect(function()
                if not drag then dc:Disconnect();return end
                local m=UIS:GetMouseLocation()
                Pill.Position=UDim2.new(.5,startX+(m.X-dsx),1,-12)
            end)
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1
            or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Window open / hide ────────────────────────────────────────────────────
    local Hidden, Debounce = false, false

    local function openWin()
        if Debounce then return end; Debounce=true; Hidden=false
        Main.Visible=true; winShadow.Visible=true
        Main.Size=UDim2.new(0,WIN_W,0,0)
        tw(Main,       {Size=UDim2.new(0,WIN_W,0,WIN_H)},        0.55, Enum.EasingStyle.Exponential)
        tw(winShadow,  {Size=UDim2.new(0,WIN_W+47,0,WIN_H+47), ImageTransparency=0.58}, 0.55)
        tw(Main,       {BackgroundTransparency=0},                0.4)
        pillLbl.Text = "▲  "..title
        task.delay(0.57, function() Debounce=false end)
    end

    local function closeWin(silent)
        if Debounce then return end; Debounce=true; Hidden=true
        tw(Main,      {Size=UDim2.new(0,WIN_W,0,0)},  0.45, Enum.EasingStyle.Exponential)
        tw(winShadow, {ImageTransparency=1},            0.3)
        pillLbl.Text = "▼  "..title
        task.delay(0.47, function()
            Main.Visible=false; winShadow.Visible=false; Debounce=false
        end)
        if not silent then
            Vula:Notify({Title="Vula Hidden", Content="Press RightShift or the pill to reopen.", Duration=5})
        end
    end

    local function toggle()
        if Hidden then openWin() else closeWin(true) end
    end

    -- Pill click
    local pillBtn = new("TextButton", Pill, {
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
        Text="", ZIndex=52, AutoButtonColor=false,
    })
    local pillGlow = Pill:FindFirstChildWhichIsA("ImageLabel")
    pillBtn.MouseButton1Click:Connect(toggle)
    pillBtn.MouseEnter:Connect(function()
        tw(Pill,     {Size=UDim2.new(0,PILL_W+16,0,PILL_H+3)},  0.22, Enum.EasingStyle.Back)
        tw(pillGlow, {ImageTransparency=0.62},                    0.18)
    end)
    pillBtn.MouseLeave:Connect(function()
        tw(Pill,     {Size=UDim2.new(0,PILL_W,0,PILL_H)},        0.18)
        tw(pillGlow, {ImageTransparency=0.76},                    0.18)
    end)
    pillBtn.MouseButton1Down:Connect(function()
        tw(Pill, {Size=UDim2.new(0,PILL_W-10,0,PILL_H-4)}, 0.1, Enum.EasingStyle.Quint)
    end)

    -- RightShift keybind
    UIS.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode==Enum.KeyCode.RightShift then toggle() end
    end)

    -- Open animation
    task.delay(0.12, function()
        tw(Main,      {Size=UDim2.new(0,WIN_W,0,WIN_H)}, 0.65, Enum.EasingStyle.Exponential)
        tw(winShadow, {ImageTransparency=0.58},            0.65)
    end)

    -- ── Tab management ────────────────────────────────────────────────────────
    local _tabs, _btns, _activeIdx = {}, {}, 0

    local function selectTab(idx)
        if _activeIdx == idx then return end
        for i, t in ipairs(_tabs) do
            t.page.Visible = (i==idx)
            local b = _btns[i]
            if not b then continue end
            if i==idx then
                tw(b, {BackgroundColor3=theme.TabBgSelected, BackgroundTransparency=0}, 0.28)
                local lbl = b:FindFirstChildWhichIsA("TextLabel")
                if lbl then tw(lbl, {TextColor3=theme.TabTextSelected, TextTransparency=0}, 0.22) end
                local bar = b:FindFirstChild("_AccentBar")
                if bar then tw(bar, {BackgroundTransparency=0}, 0.22) end
            else
                tw(b, {BackgroundColor3=theme.TabBg, BackgroundTransparency=0.55}, 0.28)
                local lbl = b:FindFirstChildWhichIsA("TextLabel")
                if lbl then tw(lbl, {TextColor3=theme.TabText, TextTransparency=0.2}, 0.22) end
                local bar = b:FindFirstChild("_AccentBar")
                if bar then tw(bar, {BackgroundTransparency=1}, 0.22) end
            end
        end
        _activeIdx = idx
    end

    -- ── Window object returned to user ────────────────────────────────────────
    local Win = {}

    function Win:CreateTab(name, _iconId)
        local idx   = #_tabs + 1
        local first = (idx==1)

        -- Sidebar tab button
        local btn = new("TextButton", TabList, {
            Name="Tab_"..name, Size=UDim2.new(1,0,0,40),
            BackgroundColor3 = first and theme.TabBgSelected or theme.TabBg,
            BackgroundTransparency = first and 0 or 0.55,
            Text="", ZIndex=4, AutoButtonColor=false, LayoutOrder=idx,
        })
        corner(btn,8)

        -- Accent left bar on selected tab
        local aBar = new("Frame", btn, {
            Name="_AccentBar", Size=UDim2.new(0,3,.54,0), Position=UDim2.new(0,0,.23,0),
            BackgroundColor3=theme.TabTextSelected,
            BackgroundTransparency = first and 0 or 1, ZIndex=5,
        })
        corner(aBar,2)

        new("TextLabel", btn, {
            Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,14,0,0),
            BackgroundTransparency=1, Text=name,
            TextColor3  = first and theme.TabTextSelected or theme.TabText,
            Font=Enum.Font.GothamBold, TextSize=11,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextTransparency = first and 0 or 0.2, ZIndex=5,
        })

        btn.MouseButton1Click:Connect(function() selectTab(idx) end)
        btn.MouseEnter:Connect(function()
            if _activeIdx~=idx then
                tw(btn,{BackgroundTransparency=0.3},0.2)
            end
        end)
        btn.MouseLeave:Connect(function()
            if _activeIdx~=idx then
                tw(btn,{BackgroundTransparency=0.55},0.2)
            end
        end)

        -- Content page
        local page = new("ScrollingFrame", Elements, {
            Name="Page_"..name, Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1, BorderSizePixel=0,
            ScrollBarThickness=3, ScrollBarImageColor3=theme.Accent,
            ScrollBarImageTransparency=0.5,
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            CanvasSize=UDim2.new(0,0,0,0),
            Visible=first, ZIndex=4, ClipsDescendants=true,
        })
        list(page, nil, Enum.HorizontalAlignment.Center, nil, 8)
        pad(page, 12,12,16,16)

        local tab = { page=page, _n=0 }
        _tabs[idx] = tab; _btns[idx] = btn
        if first then _activeIdx=1 end

        local function eo() tab._n=tab._n+1; return tab._n end

        -- ── tab:CreateSection ─────────────────────────────────────────────────
        function tab:CreateSection(secName)
            new("Frame", page, {  -- spacing above section
                Size=UDim2.new(1,0,0,4), BackgroundTransparency=1,
                ZIndex=4, LayoutOrder=eo(),
            })
            local sf = new("Frame", page, {
                Name="SectionTitle", Size=UDim2.new(1,0,0,26),
                BackgroundTransparency=1, ZIndex=4, LayoutOrder=eo(),
            })
            new("TextLabel", sf, {
                Size=UDim2.new(1,-6,1,0), Position=UDim2.new(0,3,0,0),
                BackgroundTransparency=1, Text=secName,
                TextColor3=theme.TextColor, Font=Enum.Font.GothamBold,
                TextSize=11, TextXAlignment=Enum.TextXAlignment.Left,
                TextTransparency=0.38, ZIndex=5,
            })
            new("Frame", sf, {
                Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1),
                BackgroundColor3=theme.ElementStroke, BackgroundTransparency=0.55, ZIndex=5,
            })
        end

        -- ── tab:CreateToggle ──────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local name2 = o.Name         or "Toggle"
            local defV  = o.CurrentValue or false
            local flag  = o.Flag
            local cb    = o.Callback

            local val  = defV
            local row  = new("Frame", page, {
                Size=UDim2.new(1,0,0,50), BackgroundColor3=theme.ElementBg,
                ZIndex=5, LayoutOrder=eo(),
            })
            corner(row,8)
            local rowSt = stroke(row, theme.ElementStroke, 1, 0)

            new("TextLabel", row, {
                Size=UDim2.new(1,-80,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=name2, TextColor3=theme.TextColor,
                Font=Enum.Font.GothamSemibold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
            })

            local PW,PH,KS = 46,25,19
            local K0,K1 = 3, 46-3-19

            local pill = new("Frame", row, {
                Size=UDim2.new(0,PW,0,PH),
                Position=UDim2.new(1,-(PW+14),.5,0), AnchorPoint=Vector2.new(0,.5),
                BackgroundColor3 = val and theme.ToggleOn or theme.ToggleOff, ZIndex=6,
            })
            corner(pill, PH//2)
            local pillSt = stroke(pill, val and theme.ToggleOnStroke or theme.ToggleOffStroke, 1, 0)

            local knob = new("Frame", pill, {
                Size=UDim2.new(0,KS,0,KS),
                Position=UDim2.new(0, val and K1 or K0, .5,0), AnchorPoint=Vector2.new(0,.5),
                BackgroundColor3=Color3.new(1,1,1), ZIndex=7,
            })
            corner(knob, KS//2)

            local tog = { CurrentValue=val, Type="Toggle" }

            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,   {BackgroundColor3=v and theme.ToggleOn or theme.ToggleOff}, 0.3)
                tw(pillSt, {Color=v and theme.ToggleOnStroke or theme.ToggleOffStroke}, 0.3)
                tw(knob,   {Size=UDim2.new(0,KS*1.36,0,KS*0.73)}, 0.09, Enum.EasingStyle.Sine)
                task.delay(0.09, function()
                    if not knob.Parent then return end
                    tw(knob, {
                        Size=UDim2.new(0,KS,0,KS),
                        Position=UDim2.new(0,v and K1 or K0,.5,0),
                    }, 0.46, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                end)
                local tl = row:FindFirstChildWhichIsA("TextLabel")
                if tl then tw(tl,{TextColor3=v and theme.TextColor or theme.TabText},0.25) end
            end

            function tog:Set(v) apply(v); if cb then cb(v) end end

            local hit = new("TextButton", row, {
                Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
                Text="", ZIndex=8, AutoButtonColor=false,
            })
            hit.MouseEnter:Connect(function()  tw(row,{BackgroundColor3=theme.ElementBgHover},0.2) end)
            hit.MouseLeave:Connect(function()  tw(row,{BackgroundColor3=theme.ElementBg},0.2) end)
            hit.MouseButton1Down:Connect(function()
                tw(pill,{Size=UDim2.new(0,PW*.88,0,PH*.84)},0.09,Enum.EasingStyle.Quint)
            end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true
                task.delay(0.5,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)

            if flag then Vula.Flags[flag]=tog end
            return tog
        end

        -- ── tab:CreateButton ──────────────────────────────────────────────────
        function tab:CreateButton(o)
            local name2 = o.Name     or "Button"
            local cb    = o.Callback

            local row = new("Frame", page, {
                Size=UDim2.new(1,0,0,46), BackgroundColor3=theme.ElementBg,
                ZIndex=5, LayoutOrder=eo(), ClipsDescendants=true,
            })
            corner(row,8)
            local rowSt = stroke(row, theme.ElementStroke, 1, 0)

            new("TextLabel", row, {
                Size=UDim2.new(1,-36,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=name2, TextColor3=theme.TextColor,
                Font=Enum.Font.GothamSemibold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
            })
            new("TextLabel", row, {
                Size=UDim2.new(0,22,1,0), Position=UDim2.new(1,-26,0,0),
                BackgroundTransparency=1, Text="›", TextColor3=theme.TabText,
                Font=Enum.Font.GothamBold, TextSize=18, ZIndex=6,
            })

            local hit = new("TextButton", row, {
                Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
                Text="", ZIndex=8, AutoButtonColor=false,
            })
            hit.MouseEnter:Connect(function()
                tw(row,   {BackgroundColor3=theme.ElementBgHover},0.2)
                tw(rowSt, {Color=theme.Accent, Transparency=0.5},0.25)
            end)
            hit.MouseLeave:Connect(function()
                tw(row,   {BackgroundColor3=theme.ElementBg},0.2)
                tw(rowSt, {Color=theme.ElementStroke, Transparency=0},0.25)
            end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=new("Frame",row,{
                    Size=UDim2.new(0,0,0,0),
                    Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),
                    AnchorPoint=Vector2.new(.5,.5),
                    BackgroundColor3=theme.Accent,
                    BackgroundTransparency=0.68, ZIndex=9,
                })
                corner(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.5
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},0.55,Enum.EasingStyle.Quint)
                task.delay(0.57,function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function()
                if cd then return end; cd=true
                task.delay(0.3,function() cd=false end)
                if cb then task.spawn(cb) end
            end)
            local bObj={}
            function bObj:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end
            return bObj
        end

        -- ── tab:CreateLabel ───────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=new("Frame",page,{
                Size=UDim2.new(1,0,0,36), BackgroundColor3=theme.ElementBg,
                ZIndex=5, LayoutOrder=eo(),
            })
            corner(row,8); stroke(row,theme.ElementStroke,1,0)
            local lbl=new("TextLabel",row,{
                Size=UDim2.new(1,-14,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=text, TextColor3=theme.TabText,
                Font=Enum.Font.GothamMedium, TextSize=11,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
            })
            return lbl
        end

        -- ── tab:CreateKeybind ─────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local name2 = o.Name           or "Keybind"
            local kDef  = o.CurrentKeybind or "RightShift"
            local flag  = o.Flag
            local cb    = o.Callback
            local cur   = kDef
            local listen= false

            local row=new("Frame",page,{
                Size=UDim2.new(1,0,0,50), BackgroundColor3=theme.ElementBg,
                ZIndex=5, LayoutOrder=eo(),
            })
            corner(row,8); stroke(row,theme.ElementStroke,1,0)
            new("TextLabel",row,{
                Size=UDim2.new(1,-94,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=name2, TextColor3=theme.TextColor,
                Font=Enum.Font.GothamSemibold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
            })
            local chip=new("TextButton",row,{
                Size=UDim2.new(0,76,0,28), Position=UDim2.new(1,-88,.5,0),
                AnchorPoint=Vector2.new(0,.5), BackgroundColor3=theme.InputBg,
                Text=cur, TextColor3=theme.Accent,
                Font=Enum.Font.GothamBold, TextSize=10, ZIndex=7, AutoButtonColor=false,
            })
            corner(chip,6)
            local chipSt=stroke(chip,theme.Accent,1,0.42)

            chip.MouseButton1Click:Connect(function()
                if listen then return end; listen=true
                chip.Text="..."
                tw(chip,{BackgroundColor3=theme.Accent},0.18)
                tw(chipSt,{Transparency=0},0.18)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not listen then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                listen=false; cur=i.KeyCode.Name; chip.Text=cur
                tw(chip,{BackgroundColor3=theme.InputBg},0.18)
                tw(chipSt,{Transparency=0.42},0.18)
                if cb then cb() end
            end)

            local kb={CurrentKeybind=cur, Type="Keybind"}
            function kb:Set(v) cur=v; chip.Text=v end
            if flag then Vula.Flags[flag]=kb end
            return kb
        end

        -- ── tab:CreateInput ───────────────────────────────────────────────────
        function tab:CreateInput(o)
            local name2   = o.Name            or "Input"
            local ph      = o.PlaceholderText or "Type here..."
            local flag    = o.Flag
            local cb      = o.Callback

            local row=new("Frame",page,{
                Size=UDim2.new(1,0,0,50), BackgroundColor3=theme.ElementBg,
                ZIndex=5, LayoutOrder=eo(),
            })
            corner(row,8); stroke(row,theme.ElementStroke,1,0)
            new("TextLabel",row,{
                Size=UDim2.new(.44,0,1,0), Position=UDim2.new(0,14,0,0),
                BackgroundTransparency=1, Text=name2, TextColor3=theme.TextColor,
                Font=Enum.Font.GothamSemibold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
            })
            local box=new("Frame",row,{
                Size=UDim2.new(.5,0,0,30), Position=UDim2.new(1,-6,.5,0),
                AnchorPoint=Vector2.new(1,.5), BackgroundColor3=theme.InputBg, ZIndex=6,
            })
            corner(box,6); stroke(box,theme.InputStroke,1,0)
            local tb=new("TextBox",box,{
                Size=UDim2.new(1,-14,1,0), Position=UDim2.new(0,7,0,0),
                BackgroundTransparency=1, Text="", PlaceholderText=ph,
                PlaceholderColor3=theme.Placeholder, TextColor3=theme.TextColor,
                Font=Enum.Font.GothamMedium, TextSize=11, ZIndex=7, ClearTextOnFocus=false,
            })
            tb.FocusLost:Connect(function(enter) if enter and cb then cb(tb.Text) end end)

            local inp={Value="",Type="Input"}
            function inp:Set(v) tb.Text=v; inp.Value=v end
            if flag then Vula.Flags[flag]=inp end
            return inp
        end

        return tab
    end

    return Win
end

_genv.VulaLoaded = true
_genv.VulaLib    = Vula
return Vula

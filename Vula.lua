--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║  V U L A  ·  v2.0                                                           ║
║  Custom UI Library · Beautiful redesign                                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
]]

local Vula = { Flags = {}, Version = "2.0" }
local _g = type(getgenv)=="function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local function gs(n) local s=game:GetService(n); return type(cloneref)=="function" and cloneref(s) or s end
local Tween  = gs("TweenService")
local UIS    = gs("UserInputService")
local Run    = gs("RunService")
local Core   = gs("CoreGui")
local Plrs   = gs("Players")
local Player = Plrs.LocalPlayer

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    JJK = {
        Accent          = Color3.fromRGB(200, 28, 48),
        AccentDark      = Color3.fromRGB(130, 15, 28),
        AccentGlow      = Color3.fromRGB(200, 28, 48),
        Window          = Color3.fromRGB(9, 9, 16),
        Topbar          = Color3.fromRGB(12, 12, 22),
        Sidebar         = Color3.fromRGB(10, 10, 19),
        Card            = Color3.fromRGB(15, 15, 26),
        CardHover       = Color3.fromRGB(20, 18, 32),
        CardStroke      = Color3.fromRGB(38, 20, 28),
        SectionText     = Color3.fromRGB(200, 28, 48),
        Text            = Color3.fromRGB(220, 225, 245),
        TextDim         = Color3.fromRGB(90, 100, 135),
        ToggleOn        = Color3.fromRGB(200, 28, 48),
        ToggleOff       = Color3.fromRGB(28, 18, 26),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(200, 28, 48),
        TabUnselected   = Color3.fromRGB(15, 15, 26),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(80, 88, 120),
        TopDivider      = Color3.fromRGB(38, 20, 28),
        InputBg         = Color3.fromRGB(12, 12, 20),
        Placeholder     = Color3.fromRGB(70, 78, 108),
        PillBg          = Color3.fromRGB(14, 12, 22),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(12, 12, 22),
    },
    Default = {
        Accent          = Color3.fromRGB(50, 138, 220),
        AccentDark      = Color3.fromRGB(30, 90, 155),
        AccentGlow      = Color3.fromRGB(50, 138, 220),
        Window          = Color3.fromRGB(22, 22, 22),
        Topbar          = Color3.fromRGB(30, 30, 30),
        Sidebar         = Color3.fromRGB(26, 26, 26),
        Card            = Color3.fromRGB(32, 32, 32),
        CardHover       = Color3.fromRGB(38, 38, 38),
        CardStroke      = Color3.fromRGB(48, 48, 48),
        SectionText     = Color3.fromRGB(50, 138, 220),
        Text            = Color3.fromRGB(235, 235, 235),
        TextDim         = Color3.fromRGB(130, 130, 130),
        ToggleOn        = Color3.fromRGB(50, 138, 220),
        ToggleOff       = Color3.fromRGB(55, 55, 55),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(50, 138, 220),
        TabUnselected   = Color3.fromRGB(32, 32, 32),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(120, 120, 120),
        TopDivider      = Color3.fromRGB(50, 50, 50),
        InputBg         = Color3.fromRGB(24, 24, 24),
        Placeholder     = Color3.fromRGB(100, 100, 100),
        PillBg          = Color3.fromRGB(30, 30, 30),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(28, 28, 28),
    },
    Midnight = {
        Accent          = Color3.fromRGB(88, 120, 255),
        AccentDark      = Color3.fromRGB(50, 75, 180),
        AccentGlow      = Color3.fromRGB(88, 120, 255),
        Window          = Color3.fromRGB(8, 10, 20),
        Topbar          = Color3.fromRGB(12, 15, 28),
        Sidebar         = Color3.fromRGB(10, 12, 22),
        Card            = Color3.fromRGB(14, 17, 32),
        CardHover       = Color3.fromRGB(18, 22, 42),
        CardStroke      = Color3.fromRGB(35, 42, 75),
        SectionText     = Color3.fromRGB(88, 120, 255),
        Text            = Color3.fromRGB(210, 215, 255),
        TextDim         = Color3.fromRGB(85, 100, 150),
        ToggleOn        = Color3.fromRGB(88, 120, 255),
        ToggleOff       = Color3.fromRGB(28, 32, 58),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(88, 120, 255),
        TabUnselected   = Color3.fromRGB(14, 17, 32),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(75, 88, 140),
        TopDivider      = Color3.fromRGB(35, 42, 75),
        InputBg         = Color3.fromRGB(10, 12, 22),
        Placeholder     = Color3.fromRGB(70, 85, 130),
        PillBg          = Color3.fromRGB(12, 15, 28),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(12, 15, 28),
    },
    Amethyst = {
        Accent          = Color3.fromRGB(155, 85, 220),
        AccentDark      = Color3.fromRGB(100, 50, 150),
        AccentGlow      = Color3.fromRGB(155, 85, 220),
        Window          = Color3.fromRGB(14, 10, 22),
        Topbar          = Color3.fromRGB(20, 14, 32),
        Sidebar         = Color3.fromRGB(16, 11, 26),
        Card            = Color3.fromRGB(22, 15, 34),
        CardHover       = Color3.fromRGB(28, 20, 44),
        CardStroke      = Color3.fromRGB(60, 38, 82),
        SectionText     = Color3.fromRGB(155, 85, 220),
        Text            = Color3.fromRGB(230, 220, 255),
        TextDim         = Color3.fromRGB(115, 90, 155),
        ToggleOn        = Color3.fromRGB(155, 85, 220),
        ToggleOff       = Color3.fromRGB(45, 28, 65),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(155, 85, 220),
        TabUnselected   = Color3.fromRGB(22, 15, 34),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(100, 72, 138),
        TopDivider      = Color3.fromRGB(60, 38, 82),
        InputBg         = Color3.fromRGB(16, 11, 26),
        Placeholder     = Color3.fromRGB(95, 70, 130),
        PillBg          = Color3.fromRGB(20, 14, 32),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(20, 14, 32),
    },
    Ocean = {
        Accent          = Color3.fromRGB(0, 185, 185),
        AccentDark      = Color3.fromRGB(0, 120, 120),
        AccentGlow      = Color3.fromRGB(0, 185, 185),
        Window          = Color3.fromRGB(8, 18, 22),
        Topbar          = Color3.fromRGB(12, 24, 30),
        Sidebar         = Color3.fromRGB(10, 20, 26),
        Card            = Color3.fromRGB(14, 26, 34),
        CardHover       = Color3.fromRGB(18, 32, 42),
        CardStroke      = Color3.fromRGB(28, 58, 70),
        SectionText     = Color3.fromRGB(0, 185, 185),
        Text            = Color3.fromRGB(205, 238, 240),
        TextDim         = Color3.fromRGB(70, 135, 148),
        ToggleOn        = Color3.fromRGB(0, 185, 185),
        ToggleOff       = Color3.fromRGB(20, 48, 58),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(0, 185, 185),
        TabUnselected   = Color3.fromRGB(14, 26, 34),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(58, 118, 130),
        TopDivider      = Color3.fromRGB(28, 58, 70),
        InputBg         = Color3.fromRGB(10, 20, 26),
        Placeholder     = Color3.fromRGB(55, 108, 120),
        PillBg          = Color3.fromRGB(12, 24, 30),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(12, 24, 30),
    },
    Sakura = {
        Accent          = Color3.fromRGB(238, 90, 148),
        AccentDark      = Color3.fromRGB(165, 55, 98),
        AccentGlow      = Color3.fromRGB(238, 90, 148),
        Window          = Color3.fromRGB(18, 10, 15),
        Topbar          = Color3.fromRGB(26, 14, 20),
        Sidebar         = Color3.fromRGB(22, 12, 18),
        Card            = Color3.fromRGB(30, 16, 24),
        CardHover       = Color3.fromRGB(38, 20, 30),
        CardStroke      = Color3.fromRGB(80, 38, 58),
        SectionText     = Color3.fromRGB(238, 90, 148),
        Text            = Color3.fromRGB(255, 228, 238),
        TextDim         = Color3.fromRGB(148, 98, 122),
        ToggleOn        = Color3.fromRGB(238, 90, 148),
        ToggleOff       = Color3.fromRGB(55, 26, 40),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(238, 90, 148),
        TabUnselected   = Color3.fromRGB(30, 16, 24),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(128, 78, 102),
        TopDivider      = Color3.fromRGB(80, 38, 58),
        InputBg         = Color3.fromRGB(22, 12, 18),
        Placeholder     = Color3.fromRGB(118, 68, 90),
        PillBg          = Color3.fromRGB(26, 14, 20),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(26, 14, 20),
    },
    AmberGlow = {
        Accent          = Color3.fromRGB(245, 148, 30),
        AccentDark      = Color3.fromRGB(168, 95, 15),
        AccentGlow      = Color3.fromRGB(245, 148, 30),
        Window          = Color3.fromRGB(16, 11, 5),
        Topbar          = Color3.fromRGB(24, 16, 8),
        Sidebar         = Color3.fromRGB(20, 13, 6),
        Card            = Color3.fromRGB(28, 18, 8),
        CardHover       = Color3.fromRGB(36, 24, 10),
        CardStroke      = Color3.fromRGB(88, 56, 18),
        SectionText     = Color3.fromRGB(245, 148, 30),
        Text            = Color3.fromRGB(255, 242, 218),
        TextDim         = Color3.fromRGB(158, 118, 68),
        ToggleOn        = Color3.fromRGB(245, 148, 30),
        ToggleOff       = Color3.fromRGB(58, 38, 14),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(245, 148, 30),
        TabUnselected   = Color3.fromRGB(28, 18, 8),
        TabTextOn       = Color3.fromRGB(18, 10, 2),
        TabTextOff      = Color3.fromRGB(138, 98, 48),
        TopDivider      = Color3.fromRGB(88, 56, 18),
        InputBg         = Color3.fromRGB(20, 13, 6),
        Placeholder     = Color3.fromRGB(118, 85, 38),
        PillBg          = Color3.fromRGB(24, 16, 8),
        Shadow          = Color3.fromRGB(0, 0, 0),
        NotifBg         = Color3.fromRGB(24, 16, 8),
    },
    Light = {
        Accent          = Color3.fromRGB(50, 138, 220),
        AccentDark      = Color3.fromRGB(30, 95, 165),
        AccentGlow      = Color3.fromRGB(50, 138, 220),
        Window          = Color3.fromRGB(248, 248, 248),
        Topbar          = Color3.fromRGB(235, 235, 235),
        Sidebar         = Color3.fromRGB(240, 240, 240),
        Card            = Color3.fromRGB(255, 255, 255),
        CardHover       = Color3.fromRGB(242, 242, 248),
        CardStroke      = Color3.fromRGB(215, 215, 220),
        SectionText     = Color3.fromRGB(50, 138, 220),
        Text            = Color3.fromRGB(30, 30, 30),
        TextDim         = Color3.fromRGB(140, 140, 145),
        ToggleOn        = Color3.fromRGB(50, 138, 220),
        ToggleOff       = Color3.fromRGB(195, 195, 198),
        ToggleKnob      = Color3.fromRGB(255, 255, 255),
        TabSelected     = Color3.fromRGB(50, 138, 220),
        TabUnselected   = Color3.fromRGB(255, 255, 255),
        TabTextOn       = Color3.fromRGB(255, 255, 255),
        TabTextOff      = Color3.fromRGB(140, 140, 145),
        TopDivider      = Color3.fromRGB(215, 215, 220),
        InputBg         = Color3.fromRGB(240, 240, 240),
        Placeholder     = Color3.fromRGB(175, 175, 178),
        PillBg          = Color3.fromRGB(235, 235, 235),
        Shadow          = Color3.fromRGB(160, 160, 165),
        NotifBg         = Color3.fromRGB(250, 250, 250),
    },
}

-- ── Helpers ───────────────────────────────────────────────────────────────────
local function tw(o, p, d, s, dr)
    if not o then return end
    pcall(function()
        Tween:Create(o, TweenInfo.new(d or 0.3, s or Enum.EasingStyle.Exponential, dr or Enum.EasingDirection.Out), p):Play()
    end)
end
local function n(cls, par, props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do i[k]=v end end
    if par then i.Parent=par end
    return i
end
local function C(p,r)   n("UICorner",p,{CornerRadius=UDim.new(0,r or 8)}) end
local function S(p,c,t,tr) n("UIStroke",p,{Color=c,Thickness=t or 1,Transparency=tr or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border}) end
local function P(p,l,r,t,b) n("UIPadding",p,{PaddingLeft=UDim.new(0,l or 0),PaddingRight=UDim.new(0,r or 0),PaddingTop=UDim.new(0,t or 0),PaddingBottom=UDim.new(0,b or 0)}) end
local function L(p,gap) n("UIListLayout",p,{FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Center,VerticalAlignment=Enum.VerticalAlignment.Top,Padding=UDim.new(0,gap or 0),SortOrder=Enum.SortOrder.LayoutOrder}) end
local function Sha(par,zi,transp)
    n("ImageLabel",par,{
        Size=UDim2.new(1,50,1,50),Position=UDim2.new(.5,0,.5,5),AnchorPoint=Vector2.new(.5,.5),
        BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=Color3.new(0,0,0),
        ImageTransparency=transp or 0.5,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=zi or 0,
    })
end
local function safeP()
    local ok=pcall(function() local t=n("ScreenGui");t.Name="__vt";if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,t)end;t.Parent=Core;t:Destroy()end)
    return ok and Core or Player:WaitForChild("PlayerGui",10)
end

-- ── Notifications ─────────────────────────────────────────────────────────────
local _nsg, _nst = nil, {}
local NW,NH,NG = 295,68,6

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = n("ScreenGui",safeP(),{Name="VulaNotifs",DisplayOrder=200,IgnoreGuiInset=true,ResetOnSpawn=false})
    if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,_nsg)end
    return _nsg
end

local function repack()
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    for i,nf in ipairs(_nst) do
        if nf and nf.Parent then
            tw(nf,{Position=UDim2.new(1,-10,1-(i*(NH+NG)/vpH),0)},0.4,Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(opts)
    local T=opts.Title or "Vula"; local C2=opts.Content or ""; local D=opts.Duration or 4.5
    local th=self._theme or Vula.Theme.Default
    local sg=getNSG()
    if #_nst>=5 then local o=table.remove(_nst,1); if o and o.Parent then o:Destroy()end end
    local idx=#_nst+1
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    local sy=1-idx*(NH+NG)/vpH

    local h=n("Frame",sg,{
        Size=UDim2.new(0,NW-24,0,NH-12),Position=UDim2.new(1.1,0,sy,0),
        AnchorPoint=Vector2.new(1,1),BackgroundColor3=th.NotifBg,ZIndex=10,
    })
    C(h,12); S(h,th.CardStroke,1,0.3); Sha(h,9,0.62)

    -- accent left bar
    local ab=n("Frame",h,{Size=UDim2.new(0,3,.6,0),Position=UDim2.new(0,10,.2,0),BackgroundColor3=th.Accent,ZIndex=12})
    C(ab,2)
    -- accent glow strip at top
    local gt=n("Frame",h,{Size=UDim2.new(1,0,0,2),BackgroundColor3=th.Accent,BackgroundTransparency=0.55,ZIndex=12})
    C(gt,12)

    local tl=n("TextLabel",h,{Size=UDim2.new(1,-28,0,20),Position=UDim2.new(0,20,0,10),BackgroundTransparency=1,Text=T,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=12})
    local bl=n("TextLabel",h,{Size=UDim2.new(1,-28,0,16),Position=UDim2.new(0,20,0,32),BackgroundTransparency=1,Text=C2,TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,TextTransparency=1,ZIndex=12})

    -- timer bar
    local tbg=n("Frame",h,{Size=UDim2.new(1,-20,0,2),Position=UDim2.new(0,10,1,-4),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.CardStroke,ZIndex=12})
    C(tbg,1)
    local tf=n("Frame",tbg,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Accent,ZIndex=13})
    C(tf,1)

    _nst[idx]=h
    h.Size=UDim2.new(0,NW-40,0,NH-18)
    tw(h,{Position=UDim2.new(1,-10,sy,0),Size=UDim2.new(0,NW,0,NH)},0.5,Enum.EasingStyle.Back)
    task.delay(0.08,function() tw(tl,{TextTransparency=0},0.28) tw(bl,{TextTransparency=0.28},0.28) end)
    task.delay(0.2,function() if tf.Parent then tw(tf,{Size=UDim2.new(0,0,1,0)},D-0.2,Enum.EasingStyle.Linear)end end)

    local done=false
    local function dis()
        if done then return end; done=true
        tw(tl,{TextTransparency=1},0.2); tw(bl,{TextTransparency=1},0.2)
        tw(h,{BackgroundTransparency=1,Size=UDim2.new(0,NW-20,0,NH-10)},0.28,Enum.EasingStyle.Quint)
        tw(h,{Position=UDim2.new(1.12,0,sy,0)},0.35,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        task.delay(0.38,function()
            for i,nf in ipairs(_nst) do if nf==h then table.remove(_nst,i);break end end
            if h.Parent then h:Destroy()end; repack()
        end)
    end
    h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis()end end)
    task.delay(D,dis); repack()
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title    = opts.Name            or "Vula"
    local loadT    = opts.LoadingTitle    or title
    local loadS    = opts.LoadingSubtitle or "Loading..."
    local tname    = opts.Theme           or "Default"
    local th       = Vula.Theme[tname]    or Vula.Theme.Default
    self._theme    = th

    -- Layout constants
    local WW,WH     = 520, 480
    local TOPBAR_H  = 52
    local SIDEBAR_W = 155
    local PILL_W    = 160
    local PILL_H    = 36

    -- ── ScreenGui ─────────────────────────────────────────────────────────────
    local sg=n("ScreenGui",safeP(),{Name="Vula",DisplayOrder=100,IgnoreGuiInset=true,ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
    if type(syn)=="table" and syn.protect_gui then pcall(syn.protect_gui,sg)end
    pcall(function() for _,c in ipairs(safeP():GetChildren()) do if c.Name=="Vula" and c~=sg then c:Destroy()end end end)

    -- Window shadow
    local wsha=n("ImageLabel",sg,{
        Size=UDim2.new(0,WW+60,0,WH+60),Position=UDim2.new(.5,0,.5,0),AnchorPoint=Vector2.new(.5,.5),
        BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=th.Shadow,
        ImageTransparency=0.45,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=1,
    })

    -- Main window frame
    local Main=n("Frame",sg,{
        Size=UDim2.new(0,WW,0,0),Position=UDim2.new(.5,0,.5,0),AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=th.Window,ZIndex=2,ClipsDescendants=true,
    })
    C(Main,12)
    S(Main,th.CardStroke,1,0.4)

    -- Subtle gradient overlay on entire window
    n("UIGradient",Main,{
        Rotation=90,
        ColorSequence=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(200,200,200)),
        }),
        Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.97),
            NumberSequenceKeypoint.new(1,0.99),
        }),
    })

    -- ══ TOPBAR ════════════════════════════════════════════════════════════════
    local TB=n("Frame",Main,{
        Name="Topbar",Size=UDim2.new(1,0,0,TOPBAR_H),
        BackgroundColor3=th.Topbar,ZIndex=5,
    })
    -- square bottom corners
    n("Frame",TB,{Size=UDim2.new(1,0,.5,0),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Topbar,ZIndex=5})
    -- bottom divider line with accent tint
    local tdiv=n("Frame",TB,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.TopDivider,ZIndex=6})

    -- Accent top line (thin glow strip at very top of topbar)
    local topGlow=n("Frame",TB,{
        Size=UDim2.new(1,0,0,2),BackgroundColor3=th.Accent,BackgroundTransparency=0.35,ZIndex=7,
    })

    -- App icon circle
    local iconCircle=n("Frame",TB,{
        Size=UDim2.new(0,30,0,30),Position=UDim2.new(0,14,0.5,0),AnchorPoint=Vector2.new(0,.5),
        BackgroundColor3=th.Accent,ZIndex=6,
    })
    C(iconCircle,15)
    n("UIGradient",iconCircle,{
        Rotation=135,
        ColorSequence=ColorSequence.new(th.Accent,th.AccentDark),
    })
    n("TextLabel",iconCircle,{
        Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=13,ZIndex=7,
    })

    -- Title + subtitle stack
    n("TextLabel",TB,{
        Size=UDim2.new(1,-140,0,20),Position=UDim2.new(0,52,0,7),
        BackgroundTransparency=1,Text=title,
        TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=14,
        TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
    })
    n("TextLabel",TB,{
        Size=UDim2.new(1,-140,0,14),Position=UDim2.new(0,52,0,28),
        BackgroundTransparency=1,Text="Vula v2.0",
        TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
    })

    -- macOS-style orbs (top-right)
    local function mkOrb(xOff,col,sym)
        local orb=n("TextButton",TB,{
            Size=UDim2.new(0,14,0,14),Position=UDim2.new(1,xOff,0.5,0),AnchorPoint=Vector2.new(1,.5),
            BackgroundColor3=col,BackgroundTransparency=0.15,Text="",ZIndex=7,AutoButtonColor=false,
        })
        C(orb,7)
        local lbl=n("TextLabel",orb,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=sym,TextColor3=Color3.fromRGB(30,20,20),Font=Enum.Font.GothamBold,TextSize=9,TextTransparency=1,ZIndex=8})
        orb.MouseEnter:Connect(function() tw(orb,{BackgroundTransparency=0},0.12); tw(lbl,{TextTransparency=0},0.12) end)
        orb.MouseLeave:Connect(function() tw(orb,{BackgroundTransparency=0.15},0.12); tw(lbl,{TextTransparency=1},0.12) end)
        return orb, lbl
    end
    local closeOrb = mkOrb(-14, Color3.fromRGB(255,59,48), "×")
    local minOrb   = mkOrb(-34, Color3.fromRGB(255,149,0), "–")

    -- Topbar drag
    do
        local drag,dsx,dsy,ox,oy=false,0,0,0,0
        TB.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true; local m=UIS:GetMouseLocation(); dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset; oy=Main.Position.Y.Offset
            local c; c=Run.RenderStepped:Connect(function()
                if not drag then c:Disconnect(); return end
                local m2=UIS:GetMouseLocation()
                local nx=ox+(m2.X-dsx); local ny=oy+(m2.Y-dsy)
                Main.Position=UDim2.new(.5,nx,.5,ny); wsha.Position=UDim2.new(.5,nx,.5,ny)
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end end)
    end

    -- ══ SIDEBAR ═══════════════════════════════════════════════════════════════
    local SB=n("Frame",Main,{
        Size=UDim2.new(0,SIDEBAR_W,1,-TOPBAR_H),Position=UDim2.new(0,0,0,TOPBAR_H),
        BackgroundColor3=th.Sidebar,ZIndex=4,
    })
    -- square top-right and bottom-right corners
    n("Frame",SB,{Size=UDim2.new(0,12,1,0),Position=UDim2.new(1,-12,0,0),BackgroundColor3=th.Sidebar,ZIndex=4})
    -- sidebar right edge divider
    n("Frame",SB,{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=th.TopDivider,BackgroundTransparency=0.5,ZIndex=5})

    local tabScroll=n("ScrollingFrame",SB,{
        Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,
        ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5,
    })
    L(tabScroll, 5)
    P(tabScroll, 10,10,14,10)

    -- ══ CONTENT ═══════════════════════════════════════════════════════════════
    local Content=n("Frame",Main,{
        Size=UDim2.new(1,-SIDEBAR_W,1,-TOPBAR_H),Position=UDim2.new(0,SIDEBAR_W,0,TOPBAR_H),
        BackgroundTransparency=1,ClipsDescendants=true,ZIndex=3,
    })

    -- ══ LOADING SCREEN ════════════════════════════════════════════════════════
    local LD=n("Frame",Main,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Window,ZIndex=25})
    C(LD,12)
    -- Loading logo
    local ldCircle=n("Frame",LD,{Size=UDim2.new(0,52,0,52),Position=UDim2.new(.5,0,.35,0),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Accent,ZIndex=26})
    C(ldCircle,26)
    n("UIGradient",ldCircle,{Rotation=135,ColorSequence=ColorSequence.new(th.Accent,th.AccentDark)})
    n("TextLabel",ldCircle,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=22,ZIndex=27})
    n("TextLabel",LD,{Size=UDim2.new(.8,0,0,26),Position=UDim2.new(.1,0,.44,0),BackgroundTransparency=1,Text=loadT,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=16,ZIndex=26})
    n("TextLabel",LD,{Size=UDim2.new(.8,0,0,18),Position=UDim2.new(.1,0,.56,0),BackgroundTransparency=1,Text=loadS,TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=11,ZIndex=26})
    local lbg=n("Frame",LD,{Size=UDim2.new(.55,0,0,3),Position=UDim2.new(.225,0,.66,0),BackgroundColor3=th.CardStroke,ZIndex=26}); C(lbg,2)
    local lfill=n("Frame",lbg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Accent,ZIndex=27}); C(lfill,2)
    task.spawn(function()
        tw(lfill,{Size=UDim2.new(1,0,1,0)},1.6,Enum.EasingStyle.Quint); task.wait(1.85)
        tw(LD,{BackgroundTransparency=1},0.45,Enum.EasingStyle.Exponential)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},0.35)
            elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},0.35)end
        end
        task.wait(0.5); LD.Visible=false
    end)

    -- ══ BOTTOM PILL ═══════════════════════════════════════════════════════════
    local Pill=n("Frame",sg,{
        Size=UDim2.new(0,PILL_W,0,PILL_H),Position=UDim2.new(.5,0,1,-10),AnchorPoint=Vector2.new(.5,1),
        BackgroundColor3=th.PillBg,ZIndex=55,
    })
    C(Pill,PILL_H//2)
    S(Pill,th.Accent,1.5,0.25)
    -- Pill glow
    n("ImageLabel",Pill,{
        Size=UDim2.new(1,44,1,44),Position=UDim2.new(.5,0,.5,0),AnchorPoint=Vector2.new(.5,.5),
        BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=th.AccentGlow,
        ImageTransparency=0.72,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=54,
    })
    -- Inner subtle gradient
    n("UIGradient",Pill,{
        Rotation=90,
        ColorSequence=ColorSequence.new(th.Accent,th.PillBg),
        Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.88),NumberSequenceKeypoint.new(1,0.96)}),
    })

    local pillLbl=n("TextLabel",Pill,{
        Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,5,0,0),BackgroundTransparency=1,
        Text="▲  "..title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=11,ZIndex=56,
    })

    -- Pill horizontal drag
    do
        local drag,dsx,sx=false,0,0
        local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true; dsx=UIS:GetMouseLocation().X; sx=Pill.Position.X.Offset
            if dc then dc:Disconnect()end
            dc=Run.Heartbeat:Connect(function()
                if not drag then dc:Disconnect();return end
                local m=UIS:GetMouseLocation()
                Pill.Position=UDim2.new(.5,sx+(m.X-dsx),1,-10)
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end end)
    end

    -- ══ WINDOW STATE ══════════════════════════════════════════════════════════
    local Hidden,Minimised,Deb=false,false,false

    local function open()
        if Deb then return end; Deb=true; Hidden=false
        Main.Visible=true; wsha.Visible=true
        Main.Size=UDim2.new(0,WW,0,0)
        tw(Main,{Size=UDim2.new(0,WW,0,WH)},0.55,Enum.EasingStyle.Exponential)
        tw(wsha,{Size=UDim2.new(0,WW+60,0,WH+60),ImageTransparency=0.45},0.55)
        pillLbl.Text="▲  "..title
        task.delay(0.57,function() Deb=false end)
    end

    local function close(silent)
        if Deb then return end; Deb=true; Hidden=true
        tw(Main,{Size=UDim2.new(0,WW,0,0)},0.45,Enum.EasingStyle.Exponential)
        tw(wsha,{ImageTransparency=1},0.3)
        pillLbl.Text="▼  "..title
        task.delay(0.47,function() Main.Visible=false; wsha.Visible=false; Deb=false end)
        if not silent then Vula:Notify({Title="Vula Hidden",Content="RightShift or pill to reopen.",Duration=4}) end
    end

    local function toggle() if Hidden then open() else close(true) end end

    -- Orb clicks
    closeOrb.MouseButton1Click:Connect(function() close(true) end)
    minOrb.MouseButton1Click:Connect(function()
        Minimised=not Minimised
        if Minimised then
            SB.Visible=false; Content.Visible=false
            tw(Main,{Size=UDim2.new(0,WW,0,TOPBAR_H)},0.35,Enum.EasingStyle.Exponential)
        else
            tw(Main,{Size=UDim2.new(0,WW,0,WH)},0.45,Enum.EasingStyle.Back)
            task.delay(0.2,function() SB.Visible=true; Content.Visible=true end)
        end
    end)

    -- Pill
    local pbtn=n("TextButton",Pill,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=57,AutoButtonColor=false})
    pbtn.MouseButton1Click:Connect(toggle)
    pbtn.MouseEnter:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W+18,0,PILL_H+4)},0.22,Enum.EasingStyle.Back) end)
    pbtn.MouseLeave:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W,0,PILL_H)},0.18) end)
    pbtn.MouseButton1Down:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W-12,0,PILL_H-5)},0.1,Enum.EasingStyle.Quint) end)

    UIS.InputBegan:Connect(function(i,gpe) if gpe then return end if i.KeyCode==Enum.KeyCode.RightShift then toggle()end end)

    -- Open animation
    task.delay(0.1,function()
        tw(Main,{Size=UDim2.new(0,WW,0,WH)},0.6,Enum.EasingStyle.Exponential)
        tw(wsha,{ImageTransparency=0.45},0.6)
    end)

    -- ══ TAB SYSTEM ════════════════════════════════════════════════════════════
    local _tabs,_btns,_active={},{},0

    local function selTab(idx)
        if _active==idx then return end
        for i,t in ipairs(_tabs) do
            t.page.Visible=(i==idx)
            local b=_btns[i]; if not b then continue end
            local lbl=b:FindFirstChildWhichIsA("TextLabel")
            local bar=b:FindFirstChild("_bar")
            local ic=b:FindFirstChild("_icon")
            if i==idx then
                tw(b,{BackgroundColor3=th.TabSelected,BackgroundTransparency=0},0.28)
                if lbl then tw(lbl,{TextColor3=th.TabTextOn,TextTransparency=0},0.22) end
                if bar then tw(bar,{BackgroundTransparency=0},0.22) end
            else
                tw(b,{BackgroundColor3=th.TabUnselected,BackgroundTransparency=0.5},0.28)
                if lbl then tw(lbl,{TextColor3=th.TabTextOff,TextTransparency=0.25},0.22) end
                if bar then tw(bar,{BackgroundTransparency=1},0.22) end
            end
        end
        _active=idx
    end

    local Win={}

    function Win:CreateTab(name, _icon)
        local idx=#_tabs+1; local first=(idx==1)

        -- Tab button in sidebar
        local btn=n("TextButton",tabScroll,{
            Name="Tab_"..name,Size=UDim2.new(1,0,0,42),
            BackgroundColor3=first and th.TabSelected or th.TabUnselected,
            BackgroundTransparency=first and 0 or 0.5,
            Text="",ZIndex=6,AutoButtonColor=false,LayoutOrder=idx,
        })
        C(btn,10)

        -- Left accent bar
        local bar=n("Frame",btn,{Name="_bar",Size=UDim2.new(0,3,.6,0),Position=UDim2.new(0,0,.2,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=first and 0 or 1,ZIndex=7}); C(bar,2)

        local lbl=n("TextLabel",btn,{
            Size=UDim2.new(1,-18,1,0),Position=UDim2.new(0,16,0,0),
            BackgroundTransparency=1,Text=name,
            TextColor3=first and th.TabTextOn or th.TabTextOff,
            Font=Enum.Font.GothamBold,TextSize=11,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextTransparency=first and 0 or 0.25,ZIndex=7,
        })

        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _active~=idx then tw(btn,{BackgroundTransparency=0.2},0.18) end end)
        btn.MouseLeave:Connect(function() if _active~=idx then tw(btn,{BackgroundTransparency=0.5},0.18) end end)

        -- Content scroll page
        local page=n("ScrollingFrame",Content,{
            Name="Page_"..name,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
            BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=th.Accent,
            ScrollBarImageTransparency=0.55,AutomaticCanvasSize=Enum.AutomaticSize.Y,
            CanvasSize=UDim2.new(0,0,0,0),Visible=first,ZIndex=4,ClipsDescendants=true,
        })
        L(page,8); P(page,10,10,14,14)

        local tab={page=page,_n=0}
        _tabs[idx]=tab; _btns[idx]=btn
        if first then _active=1 end

        local function eo() tab._n=tab._n+1; return tab._n end

        -- ─── Section ──────────────────────────────────────────────────────────
        function tab:CreateSection(secName)
            -- spacing
            n("Frame",page,{Size=UDim2.new(1,0,0,4),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            local sf=n("Frame",page,{Name="Section",Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            n("TextLabel",sf,{
                Size=UDim2.new(1,-4,1,0),Position=UDim2.new(0,2,0,0),BackgroundTransparency=1,
                Text=secName,TextColor3=th.SectionText,Font=Enum.Font.GothamBold,
                TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=0.1,ZIndex=5,
            })
            -- divider
            local dv=n("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.CardStroke,BackgroundTransparency=0.4,ZIndex=5})
        end

        -- ─── Toggle ───────────────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local tName=o.Name or "Toggle"; local defV=o.CurrentValue or false
            local flag=o.Flag; local cb=o.Callback
            local val=defV

            local row=n("Frame",page,{
                Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,
                ZIndex=5,LayoutOrder=eo(),
            })
            C(row,10)
            local rowSt=n("UIStroke",row,{Color=th.CardStroke,Thickness=1,Transparency=0.3,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            -- subtle left accent
            local la=n("Frame",row,{Size=UDim2.new(0,3,0.55,0),Position=UDim2.new(0,0,0.225,0),BackgroundColor3=th.Accent,BackgroundTransparency=val and 0.5 or 1,ZIndex=6}); C(la,2)

            n("TextLabel",row,{
                Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,16,0,0),
                BackgroundTransparency=1,Text=tName,TextColor3=th.Text,
                Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
            })

            -- Toggle pill
            local PW,PH,KS=48,26,20
            local K0,K1=3,48-3-20

            local pill=n("Frame",row,{
                Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+14),.5,0),AnchorPoint=Vector2.new(0,.5),
                BackgroundColor3=val and th.ToggleOn or th.ToggleOff,ZIndex=6,
            })
            C(pill,PH//2)
            -- pill inner shadow
            n("UIGradient",pill,{
                Rotation=90,
                ColorSequence=ColorSequence.new(Color3.new(1,1,1),Color3.new(0,0,0)),
                Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.92),NumberSequenceKeypoint.new(1,0.78)}),
            })
            local pillSt=n("UIStroke",pill,{Color=val and th.ToggleOn or th.CardStroke,Thickness=1,Transparency=val and 0.55 or 0.2,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})

            local knob=n("Frame",pill,{
                Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),
                BackgroundColor3=th.ToggleKnob,ZIndex=7,
            })
            C(knob,KS//2)
            Sha(knob,8,0.65)

            -- Glow behind pill when on
            local pillGlow=n("ImageLabel",pill,{
                Size=UDim2.new(1,20,1,20),Position=UDim2.new(.5,0,.5,0),AnchorPoint=Vector2.new(.5,.5),
                BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=th.Accent,
                ImageTransparency=val and 0.7 or 1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=5,
            })

            local tog={CurrentValue=val,Type="Toggle"}

            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.ToggleOn or th.ToggleOff},0.32)
                tw(pillSt,{Color=v and th.ToggleOn or th.CardStroke,Transparency=v and 0.55 or 0.2},0.32)
                tw(pillGlow,{ImageTransparency=v and 0.7 or 1},0.3)
                tw(la,{BackgroundTransparency=v and 0.5 or 1},0.3)
                -- knob: squish + spring
                tw(knob,{Size=UDim2.new(0,KS*1.38,0,KS*0.72)},0.08,Enum.EasingStyle.Sine)
                task.delay(0.08,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},0.44,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                local tl=row:FindFirstChildWhichIsA("TextLabel")
                if tl then tw(tl,{TextColor3=v and th.Text or th.TextDim},0.28) end
                tw(rowSt,{Color=v and th.Accent or th.CardStroke,Transparency=v and 0.6 or 0.3},0.32)
            end

            function tog:Set(v) apply(v); if cb then cb(v) end end

            local hit=n("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardHover},0.18) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},0.18) end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.87,0,PH*.83)},0.08,Enum.EasingStyle.Quint) end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true; task.delay(0.5,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)
            if flag then Vula.Flags[flag]=tog end
            return tog
        end

        -- ─── Button ───────────────────────────────────────────────────────────
        function tab:CreateButton(o)
            local bName=o.Name or "Button"; local cb=o.Callback

            local row=n("Frame",page,{
                Size=UDim2.new(1,0,0,48),BackgroundColor3=th.Card,
                ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true,
            })
            C(row,10)
            n("UIStroke",row,{Color=th.CardStroke,Thickness=1,Transparency=0.35,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})

            -- Accent left fill
            local fill=n("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Accent,BackgroundTransparency=0.88,ZIndex=5})
            C(fill,10)

            n("TextLabel",row,{
                Size=UDim2.new(1,-42,1,0),Position=UDim2.new(0,16,0,0),
                BackgroundTransparency=1,Text=bName,TextColor3=th.Text,
                Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
            })
            -- Arrow
            local arrow=n("TextLabel",row,{
                Size=UDim2.new(0,24,1,0),Position=UDim2.new(1,-28,0,0),
                BackgroundTransparency=1,Text="›",TextColor3=th.TextDim,
                Font=Enum.Font.GothamBold,TextSize=18,ZIndex=6,
            })

            local rowSt=row:FindFirstChildWhichIsA("UIStroke")
            local hit=n("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})

            hit.MouseEnter:Connect(function()
                tw(row,{BackgroundColor3=th.CardHover},0.18)
                tw(fill,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=0.88},0.28)
                tw(rowSt,{Color=th.Accent,Transparency=0.6},0.22)
                tw(arrow,{TextColor3=th.Accent},0.18)
            end)
            hit.MouseLeave:Connect(function()
                tw(row,{BackgroundColor3=th.Card},0.18)
                tw(fill,{Size=UDim2.new(0,0,1,0)},0.22)
                tw(rowSt,{Color=th.CardStroke,Transparency=0.35},0.22)
                tw(arrow,{TextColor3=th.TextDim},0.18)
            end)
            -- Ripple
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=n("Frame",row,{
                    Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),
                    AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Accent,
                    BackgroundTransparency=0.72,ZIndex=10,
                }); C(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.4
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},0.52,Enum.EasingStyle.Quint)
                task.delay(0.54,function() if rip.Parent then rip:Destroy()end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function()
                if cd then return end; cd=true; task.delay(0.3,function() cd=false end)
                if cb then task.spawn(cb) end
            end)
            local bObj={}
            function bObj:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end
            return bObj
        end

        -- ─── Label ────────────────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=n("Frame",page,{
                Size=UDim2.new(1,0,0,38),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),
            })
            C(row,10)
            n("UIStroke",row,{Color=th.CardStroke,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            local lbl=n("TextLabel",row,{
                Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,
                Text=text,TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=11,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
            })
            return lbl
        end

        -- ─── Keybind ──────────────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local kName=o.Name or "Keybind"; local kDef=o.CurrentKeybind or "RightShift"
            local flag=o.Flag; local cb=o.Callback; local cur=kDef; local listen=false

            local row=n("Frame",page,{
                Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),
            })
            C(row,10); n("UIStroke",row,{Color=th.CardStroke,Thickness=1,Transparency=0.3,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            n("TextLabel",row,{
                Size=UDim2.new(1,-96,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,
                Text=kName,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,
            })
            local chip=n("TextButton",row,{
                Size=UDim2.new(0,78,0,28),Position=UDim2.new(1,-88,.5,0),AnchorPoint=Vector2.new(0,.5),
                BackgroundColor3=th.InputBg,Text=cur,TextColor3=th.Accent,
                Font=Enum.Font.GothamBold,TextSize=10,ZIndex=7,AutoButtonColor=false,
            })
            C(chip,6)
            local chipSt=n("UIStroke",chip,{Color=th.Accent,Thickness=1,Transparency=0.5,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            chip.MouseButton1Click:Connect(function()
                if listen then return end; listen=true; chip.Text="..."
                tw(chip,{BackgroundColor3=th.Accent},0.18); tw(chipSt,{Transparency=0},0.18)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not listen then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                listen=false; cur=i.KeyCode.Name; chip.Text=cur
                tw(chip,{BackgroundColor3=th.InputBg},0.18); tw(chipSt,{Transparency=0.5},0.18)
                if cb then cb() end
            end)
            local kb={CurrentKeybind=cur,Type="Keybind"}
            function kb:Set(v) cur=v; chip.Text=v end
            if flag then Vula.Flags[flag]=kb end
            return kb
        end

        -- ─── Input ────────────────────────────────────────────────────────────
        function tab:CreateInput(o)
            local iName=o.Name or "Input"; local ph=o.PlaceholderText or "Type here..."; local flag=o.Flag; local cb=o.Callback
            local row=n("Frame",page,{Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,10); n("UIStroke",row,{Color=th.CardStroke,Thickness=1,Transparency=0.3,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            n("TextLabel",row,{Size=UDim2.new(.42,0,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=iName,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local box=n("Frame",row,{Size=UDim2.new(.52,0,0,30),Position=UDim2.new(1,-8,.5,0),AnchorPoint=Vector2.new(1,.5),BackgroundColor3=th.InputBg,ZIndex=6})
            C(box,6); n("UIStroke",box,{Color=th.CardStroke,Thickness=1,Transparency=0.3,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
            local tb=n("TextBox",box,{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),BackgroundTransparency=1,Text="",PlaceholderText=ph,PlaceholderColor3=th.Placeholder,TextColor3=th.Text,Font=Enum.Font.GothamMedium,TextSize=11,ZIndex=7,ClearTextOnFocus=false})
            tb.FocusLost:Connect(function(e) if e and cb then cb(tb.Text) end end)
            local inp={Value="",Type="Input"}
            function inp:Set(v) tb.Text=v; inp.Value=v end
            if flag then Vula.Flags[flag]=inp end
            return inp
        end

        return tab
    end

    return Win
end

_g.VulaLoaded=true; _g.VulaLib=Vula
return Vula

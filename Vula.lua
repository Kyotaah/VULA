--[[
    V U L A  ·  v2.2
    Mobile-first: PlayerGui primary, instant visible, zero startup animation
]]

local Vula = { Flags = {}, Version = "2.2" }
local _g = type(getgenv)=="function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local TweenService    = game:GetService("TweenService")
local UserInputService= game:GetService("UserInputService")
local RunService      = game:GetService("RunService")
local Players         = game:GetService("Players")
local Player          = Players.LocalPlayer

-- ── Safe parent — PlayerGui FIRST (works on every mobile executor) ────────────
local function safeParent()
    -- 1. PlayerGui — always works, highest compatibility
    local ok, pg = pcall(function()
        return Player:WaitForChild("PlayerGui", 5)
    end)
    if ok and pg then return pg end

    -- 2. CoreGui with syn protection
    local ok2 = pcall(function()
        local t = Instance.new("ScreenGui")
        t.Name = "__vtest"
        if type(syn)=="table" and type(syn.protect_gui)=="function" then
            syn.protect_gui(t)
        end
        t.Parent = game:GetService("CoreGui")
        t:Destroy()
    end)
    if ok2 then return game:GetService("CoreGui") end

    -- 3. Last resort
    return Player.PlayerGui
end

-- ── Tween helper ──────────────────────────────────────────────────────────────
local function tw(o, p, d, s, dr)
    if not o then return end
    pcall(TweenService.Create, TweenService, o,
        TweenInfo.new(d or 0.3, s or Enum.EasingStyle.Exponential, dr or Enum.EasingDirection.Out), p)
    local t = TweenService:Create(o,
        TweenInfo.new(d or 0.3, s or Enum.EasingStyle.Exponential, dr or Enum.EasingDirection.Out), p)
    if t then t:Play() end
end

-- ── Instance helpers ──────────────────────────────────────────────────────────
local function ni(cls, par, props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do pcall(function() i[k]=v end) end end
    if par then i.Parent = par end
    return i
end
local function mkCorner(p, r)
    ni("UICorner", p, {CornerRadius=UDim.new(0, r or 8)})
end
local function mkStroke(p, c, t, tr)
    return ni("UIStroke", p, {Color=c or Color3.new(1,1,1), Thickness=t or 1, Transparency=tr or 0, ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
end
local function mkPad(p,l,r,t,b)
    ni("UIPadding",p,{PaddingLeft=UDim.new(0,l or 0),PaddingRight=UDim.new(0,r or 0),PaddingTop=UDim.new(0,t or 0),PaddingBottom=UDim.new(0,b or 0)})
end
local function mkList(p, gap)
    ni("UIListLayout",p,{FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Center,Padding=UDim.new(0,gap or 0),SortOrder=Enum.SortOrder.LayoutOrder})
end

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    JJK = {
        Accent="c81c30", AccentDark="780e1a",
        Window="09090f", Topbar="0c0c16",
        Sidebar="0a0a13", Card="0f0e1a",
        CardHover="151222", CardStroke="2a1420",
        SectionText="c81c30", Text="dce0f5",
        TextDim="555f82", ToggleOn="c81c30",
        ToggleOff="1e1219", ToggleKnob="ffffff",
        TabSel="c81c30", TabUnsel="0d0d17",
        TabTextOn="ffffff", TabTextOff="4b5476",
        Divider="2a1420", InputBg="0b0b14",
        Placeholder="41476a", PillBg="0c0b15",
        Shadow="000000", NotifBg="0b0b14",
    },
    Default = {
        Accent="328adc", AccentDark="1c5a9b",
        Window="161616", Topbar="1e1e1e",
        Sidebar="1a1a1a", Card="212121",
        CardHover="282828", CardStroke="323232",
        SectionText="328adc", Text="ebebeb",
        TextDim="7d7d7d", ToggleOn="328adc",
        ToggleOff="3a3a3a", ToggleKnob="ffffff",
        TabSel="328adc", TabUnsel="212121",
        TabTextOn="ffffff", TabTextOff="737373",
        Divider="323232", InputBg="181818",
        Placeholder="626262", PillBg="1e1e1e",
        Shadow="000000", NotifBg="1c1c1c",
    },
    Midnight = {
        Accent="5878ff", AccentDark="3249b4",
        Window="08090e", Topbar="0c0f1c",
        Sidebar="0a0c16", Card="0e1120",
        CardHover="12162a", CardStroke="23294b",
        SectionText="5878ff", Text="d2d7ff",
        TextDim="525994", ToggleOn="5878ff",
        ToggleOff="1c203a", ToggleKnob="ffffff",
        TabSel="5878ff", TabUnsel="0e1120",
        TabTextOn="ffffff", TabTextOff="48527a",
        Divider="23294b", InputBg="0a0c16",
        Placeholder="444980", PillBg="0c0f1c",
        Shadow="000000", NotifBg="0c0f1c",
    },
    Amethyst = {
        Accent="9b55dc", AccentDark="5f3090",
        Window="0e0a16", Topbar="140e20",
        Sidebar="100b1a", Card="160f22",
        CardHover="1c142c", CardStroke="3c2652",
        SectionText="9b55dc", Text="e6dcff",
        TextDim="705898", ToggleOn="9b55dc",
        ToggleOff="2d1c41", ToggleKnob="ffffff",
        TabSel="9b55dc", TabUnsel="160f22",
        TabTextOn="ffffff", TabTextOff="624587",
        Divider="3c2652", InputBg="100b1a",
        Placeholder="5c4280", PillBg="140e20",
        Shadow="000000", NotifBg="140e20",
    },
    Ocean = {
        Accent="00b9b9", AccentDark="007676",
        Window="08121a", Topbar="0c1820",
        Sidebar="0a141c", Card="0e1a24",
        CardHover="12202c", CardStroke="1c3a48",
        SectionText="00b9b9", Text="cdf0f0",
        TextDim="448491", ToggleOn="00b9b9",
        ToggleOff="14303c", ToggleKnob="ffffff",
        TabSel="00b9b9", TabUnsel="0e1a24",
        TabTextOn="ffffff", TabTextOff="377380",
        Divider="1c3a48", InputBg="0a141c",
        Placeholder="346870", PillBg="0c1820",
        Shadow="000000", NotifBg="0c1820",
    },
    Sakura = {
        Accent="ee5a94", AccentDark="a2345f",
        Window="120a0f", Topbar="1a0e14",
        Sidebar="160c12", Card="1e1018",
        CardHover="261420", CardStroke="50263a",
        SectionText="ee5a94", Text="ffe4ee",
        TextDim="915f76", ToggleOn="ee5a94",
        ToggleOff="371a28", ToggleKnob="ffffff",
        TabSel="ee5a94", TabUnsel="1e1018",
        TabTextOn="ffffff", TabTextOff="7d4b62",
        Divider="50263a", InputBg="160c12",
        Placeholder="734158", PillBg="1a0e14",
        Shadow="000000", NotifBg="1a0e14",
    },
    AmberGlow = {
        Accent="f5941e", AccentDark="a55c0c",
        Window="100b05", Topbar="181008",
        Sidebar="140d06", Card="1c1208",
        CardHover="24180a", CardStroke="583812",
        SectionText="f5941e", Text="fff2da",
        TextDim="9b7341", ToggleOn="f5941e",
        ToggleOff="3a260e", ToggleKnob="ffffff",
        TabSel="f5941e", TabUnsel="1c1208",
        TabTextOn="120a02", TabTextOff="875f2d",
        Divider="583812", InputBg="140d06",
        Placeholder="735223", PillBg="181008",
        Shadow="000000", NotifBg="181008",
    },
    Light = {
        Accent="328adc", AccentDark="1c5a9b",
        Window="f8f8f8", Topbar="ebebeb",
        Sidebar="f0f0f0", Card="ffffff",
        CardHover="f2f2f8", CardStroke="d7d7dc",
        SectionText="328adc", Text="1e1e1e",
        TextDim="8a8a8e", ToggleOn="328adc",
        ToggleOff="c3c3c6", ToggleKnob="ffffff",
        TabSel="328adc", TabUnsel="ffffff",
        TabTextOn="ffffff", TabTextOff="8a8a8e",
        Divider="d7d7dc", InputBg="f0f0f0",
        Placeholder="acacaf", PillBg="ebebeb",
        Shadow="9b9ba0", NotifBg="fafafa",
    },
}

-- Convert hex to Color3
local function hex(h)
    h = h:gsub("#","")
    return Color3.fromRGB(
        tonumber(h:sub(1,2),16),
        tonumber(h:sub(3,4),16),
        tonumber(h:sub(5,6),16)
    )
end
-- Resolve theme (strings → Color3)
local function resolveTheme(t)
    local out = {}
    for k,v in pairs(t) do
        out[k] = type(v)=="string" and hex(v) or v
    end
    return out
end

-- ── Notifications ─────────────────────────────────────────────────────────────
local _nsg, _nst = nil, {}
local NW,NH,NG = 292,66,6

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = ni("ScreenGui", safeParent(), {
        Name="VulaNotifs", DisplayOrder=200,
        ResetOnSpawn=false,
    })
    return _nsg
end

local function repack()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    for i,nf in ipairs(_nst) do
        if nf and nf.Parent then
            tw(nf, {Position=UDim2.new(1,-8,1-(i*(NH+NG)/vpH),0)}, 0.4, Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(opts)
    local T  = opts.Title   or "Vula"
    local C2 = opts.Content or ""
    local D  = opts.Duration or 4.5
    local th = self._theme  or resolveTheme(Vula.Theme.Default)
    local sg = getNSG()

    if #_nst >= 5 then
        local o = table.remove(_nst,1)
        if o and o.Parent then o:Destroy() end
    end

    local idx = #_nst+1
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    local sy  = 1 - idx*(NH+NG)/vpH

    local h = ni("Frame",sg,{
        Size=UDim2.new(0,NW,0,NH),
        Position=UDim2.new(1.1,0,sy,0),
        AnchorPoint=Vector2.new(1,1),
        BackgroundColor3=th.NotifBg,
        ZIndex=10,
    })
    mkCorner(h,10)
    mkStroke(h, th.CardStroke, 1, 0.2)

    -- top accent strip
    local ts=ni("Frame",h,{Size=UDim2.new(1,0,0,2),BackgroundColor3=th.Accent,ZIndex=12})
    mkCorner(ts,10)
    -- left accent bar
    local ab=ni("Frame",h,{Size=UDim2.new(0,3,.58,0),Position=UDim2.new(0,9,.21,0),BackgroundColor3=th.Accent,ZIndex=12})
    mkCorner(ab,2)

    local tl=ni("TextLabel",h,{
        Size=UDim2.new(1,-26,0,20), Position=UDim2.new(0,18,0,8),
        BackgroundTransparency=1, Text=T,
        TextColor3=th.Text, Font=Enum.Font.GothamBold, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left, TextTransparency=1, ZIndex=12,
    })
    local bl=ni("TextLabel",h,{
        Size=UDim2.new(1,-26,0,18), Position=UDim2.new(0,18,0,30),
        BackgroundTransparency=1, Text=C2,
        TextColor3=th.TextDim, Font=Enum.Font.GothamMedium, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd,
        TextTransparency=1, ZIndex=12,
    })

    -- timer bar
    local tbg=ni("Frame",h,{Size=UDim2.new(1,-18,0,2),Position=UDim2.new(0,9,1,-4),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.Divider,ZIndex=12})
    mkCorner(tbg,1)
    local tf=ni("Frame",tbg,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Accent,ZIndex=13})
    mkCorner(tf,1)

    _nst[idx]=h
    tw(h, {Position=UDim2.new(1,-8,sy,0)}, 0.5, Enum.EasingStyle.Back)
    task.delay(0.1, function()
        tw(tl,{TextTransparency=0},   0.28)
        tw(bl,{TextTransparency=0.2}, 0.28)
    end)
    task.delay(0.2, function()
        if tf.Parent then tw(tf,{Size=UDim2.new(0,0,1,0)},D-0.2,Enum.EasingStyle.Linear) end
    end)

    local done=false
    local function dis()
        if done then return end; done=true
        tw(tl,{TextTransparency=1},0.2); tw(bl,{TextTransparency=1},0.2)
        tw(h,{BackgroundTransparency=1},0.25,Enum.EasingStyle.Quint)
        tw(h,{Position=UDim2.new(1.1,0,sy,0)},0.32,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        task.delay(0.35,function()
            for i,nf in ipairs(_nst) do if nf==h then table.remove(_nst,i);break end end
            if h.Parent then h:Destroy() end; repack()
        end)
    end
    h.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis() end
    end)
    task.delay(D,dis); repack()
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title  = opts.Name            or "Vula"
    local loadT  = opts.LoadingTitle    or title
    local loadS  = opts.LoadingSubtitle or "Loading..."
    local tname  = opts.Theme           or "Default"
    local th     = resolveTheme(Vula.Theme[tname] or Vula.Theme.Default)
    self._theme  = th

    local WW,WH    = 520, 480
    local TOP_H    = 52
    local SIDE_W   = 155
    local PILL_W   = 160
    local PILL_H   = 36

    -- Kill old instances
    local par = safeParent()
    pcall(function()
        for _,c in ipairs(par:GetChildren()) do
            if c.Name=="Vula" then c:Destroy() end
        end
    end)

    -- ── ScreenGui — NO IgnoreGuiInset (breaks on some mobile executors) ───────
    local sg = ni("ScreenGui", par, {
        Name="Vula",
        DisplayOrder=100,
        ResetOnSpawn=false,
        -- IgnoreGuiInset intentionally omitted — causes blank on some executors
    })

    -- ── Main window — FULL SIZE, FULLY VISIBLE from frame 1 ──────────────────
    local Main = ni("Frame", sg, {
        Name="Main",
        Size=UDim2.new(0,WW,0,WH),
        Position=UDim2.new(0.5,0,0.5,0),
        AnchorPoint=Vector2.new(0.5,0.5),
        BackgroundColor3=th.Window,
        BackgroundTransparency=0,   -- VISIBLE IMMEDIATELY
        ZIndex=2,
        ClipsDescendants=true,
    })
    mkCorner(Main,12)
    mkStroke(Main,th.CardStroke,1,0.3)

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local TB=ni("Frame",Main,{
        Size=UDim2.new(1,0,0,TOP_H),
        BackgroundColor3=th.Topbar, ZIndex=5,
    })
    mkCorner(TB,12)
    ni("Frame",TB,{Size=UDim2.new(1,0,.5,0),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Topbar,ZIndex=5})
    -- accent top glow line
    ni("Frame",TB,{Size=UDim2.new(1,0,0,2),BackgroundColor3=th.Accent,BackgroundTransparency=0.25,ZIndex=8})
    -- bottom divider
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Divider,ZIndex=6})

    -- Badge icon
    local badge=ni("Frame",TB,{
        Size=UDim2.new(0,30,0,30),Position=UDim2.new(0,14,0.5,0),AnchorPoint=Vector2.new(0,.5),
        BackgroundColor3=th.Accent,ZIndex=6,
    })
    mkCorner(badge,15)
    ni("UIGradient",badge,{Rotation=135,ColorSequence=ColorSequence.new(th.Accent,th.AccentDark)})
    ni("TextLabel",badge,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=14,ZIndex=7})

    -- Title + sub
    ni("TextLabel",TB,{
        Size=UDim2.new(1,-140,0,22),Position=UDim2.new(0,52,0,6),
        BackgroundTransparency=1, Text=title,
        TextColor3=th.Text, Font=Enum.Font.GothamBold, TextSize=14,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
    })
    ni("TextLabel",TB,{
        Size=UDim2.new(1,-140,0,14),Position=UDim2.new(0,52,0,29),
        BackgroundTransparency=1, Text="Vula v2.2",
        TextColor3=th.TextDim, Font=Enum.Font.GothamMedium, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6,
    })

    -- macOS orbs
    local function mkOrb(xOff,col,sym)
        local o=ni("TextButton",TB,{
            Size=UDim2.new(0,14,0,14),Position=UDim2.new(1,xOff,0.5,0),
            AnchorPoint=Vector2.new(1,.5),BackgroundColor3=col,
            BackgroundTransparency=0.15,Text="",ZIndex=7,AutoButtonColor=false,
        }); mkCorner(o,7)
        local lbl=ni("TextLabel",o,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=sym,TextColor3=Color3.fromRGB(25,15,15),Font=Enum.Font.GothamBold,TextSize=9,TextTransparency=1,ZIndex=8})
        o.MouseEnter:Connect(function() tw(o,{BackgroundTransparency=0},0.1); tw(lbl,{TextTransparency=0},0.1) end)
        o.MouseLeave:Connect(function() tw(o,{BackgroundTransparency=0.15},0.1); tw(lbl,{TextTransparency=1},0.1) end)
        return o
    end
    local orbClose = mkOrb(-14, Color3.fromRGB(255,59,48),  "×")
    local orbMin   = mkOrb(-34, Color3.fromRGB(255,149,0),  "–")

    -- Topbar drag
    do
        local drag,dsx,dsy,ox,oy=false,0,0,0,0
        TB.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true
            local m=UserInputService:GetMouseLocation(); dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset; oy=Main.Position.Y.Offset
            local c; c=RunService.RenderStepped:Connect(function()
                if not drag then c:Disconnect();return end
                local m2=UserInputService:GetMouseLocation()
                Main.Position=UDim2.new(.5,ox+(m2.X-dsx),.5,oy+(m2.Y-dsy))
            end)
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Sidebar ───────────────────────────────────────────────────────────────
    local SB=ni("Frame",Main,{
        Size=UDim2.new(0,SIDE_W,1,-TOP_H),Position=UDim2.new(0,0,0,TOP_H),
        BackgroundColor3=th.Sidebar,ZIndex=4,
    })
    ni("Frame",SB,{Size=UDim2.new(0,12,1,0),Position=UDim2.new(1,-12,0,0),BackgroundColor3=th.Sidebar,ZIndex=4})
    ni("Frame",SB,{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=th.Divider,BackgroundTransparency=0.4,ZIndex=5})

    local tabScroll=ni("ScrollingFrame",SB,{
        Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,
        ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,
        CanvasSize=UDim2.new(0,0,0,0),ZIndex=5,
    })
    mkList(tabScroll,5); mkPad(tabScroll,10,10,14,10)

    -- ── Content ───────────────────────────────────────────────────────────────
    local Content=ni("Frame",Main,{
        Size=UDim2.new(1,-SIDE_W,1,-TOP_H),Position=UDim2.new(0,SIDE_W,0,TOP_H),
        BackgroundTransparency=1,ClipsDescendants=true,ZIndex=3,
    })

    -- ── Loading overlay ───────────────────────────────────────────────────────
    local LD=ni("Frame",Main,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Window,ZIndex=25})
    mkCorner(LD,12)
    local ldB=ni("Frame",LD,{Size=UDim2.new(0,50,0,50),Position=UDim2.new(.5,0,.35,0),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Accent,ZIndex=26})
    mkCorner(ldB,25)
    ni("UIGradient",ldB,{Rotation=135,ColorSequence=ColorSequence.new(th.Accent,th.AccentDark)})
    ni("TextLabel",ldB,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=20,ZIndex=27})
    ni("TextLabel",LD,{Size=UDim2.new(.8,0,0,24),Position=UDim2.new(.1,0,.45,0),BackgroundTransparency=1,Text=loadT,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=15,ZIndex=26})
    ni("TextLabel",LD,{Size=UDim2.new(.8,0,0,18),Position=UDim2.new(.1,0,.56,0),BackgroundTransparency=1,Text=loadS,TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=11,ZIndex=26})
    local lbg=ni("Frame",LD,{Size=UDim2.new(.55,0,0,3),Position=UDim2.new(.225,0,.67,0),BackgroundColor3=th.Divider,ZIndex=26}); mkCorner(lbg,2)
    local lfil=ni("Frame",lbg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Accent,ZIndex=27}); mkCorner(lfil,2)
    task.spawn(function()
        tw(lfil,{Size=UDim2.new(1,0,1,0)},1.6,Enum.EasingStyle.Quint)
        task.wait(1.85)
        tw(LD,{BackgroundTransparency=1},0.4)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},0.3)
            elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},0.3) end
        end
        task.wait(0.45); LD.Visible=false
    end)

    -- ── Bottom Pill ───────────────────────────────────────────────────────────
    local Pill=ni("Frame",sg,{
        Size=UDim2.new(0,PILL_W,0,PILL_H),
        Position=UDim2.new(0.5,0,1,-48),   -- above bottom (accounts for no IgnoreGuiInset)
        AnchorPoint=Vector2.new(0.5,1),
        BackgroundColor3=th.PillBg,ZIndex=55,
    })
    mkCorner(Pill,PILL_H//2)
    mkStroke(Pill,th.Accent,1.5,0.2)
    ni("UIGradient",Pill,{
        Rotation=90,
        ColorSequence=ColorSequence.new(th.Accent,th.PillBg),
        Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.87),NumberSequenceKeypoint.new(1,0.95)}),
    })

    local pillLbl=ni("TextLabel",Pill,{
        Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,5,0,0),
        BackgroundTransparency=1,Text="▲  "..title,
        TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=11,ZIndex=56,
    })

    -- Pill drag (horizontal)
    do
        local drag,dsx,sx=false,0,0; local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true; dsx=UserInputService:GetMouseLocation().X; sx=Pill.Position.X.Offset
            if dc then dc:Disconnect() end
            dc=RunService.Heartbeat:Connect(function()
                if not drag then dc:Disconnect();return end
                Pill.Position=UDim2.new(0.5,sx+(UserInputService:GetMouseLocation().X-dsx),1,-48)
            end)
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Window toggle (fade) ──────────────────────────────────────────────────
    local Hidden,Minimised,Deb=false,false,false

    local function open()
        if Deb then return end; Deb=true; Hidden=false
        Main.Visible=true
        tw(Main,{BackgroundTransparency=0},0.4)
        pillLbl.Text="▲  "..title
        task.delay(0.42,function() Deb=false end)
    end
    local function close(silent)
        if Deb then return end; Deb=true; Hidden=true
        tw(Main,{BackgroundTransparency=1},0.32)
        pillLbl.Text="▼  "..title
        task.delay(0.34,function() Main.Visible=false; Deb=false end)
        if not silent then Vula:Notify({Title="Vula Hidden",Content="RightShift or pill to reopen.",Duration=4}) end
    end
    local function toggle() if Hidden then open() else close(true) end end

    orbClose.MouseButton1Click:Connect(function() close(true) end)
    orbMin.MouseButton1Click:Connect(function()
        Minimised=not Minimised
        if Minimised then
            SB.Visible=false; Content.Visible=false
            tw(Main,{Size=UDim2.new(0,WW,0,TOP_H)},0.32)
        else
            tw(Main,{Size=UDim2.new(0,WW,0,WH)},0.42,Enum.EasingStyle.Back)
            task.delay(0.18,function() SB.Visible=true; Content.Visible=true end)
        end
    end)

    local pbtn=ni("TextButton",Pill,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=57,AutoButtonColor=false})
    pbtn.MouseButton1Click:Connect(toggle)
    pbtn.MouseEnter:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W+16,0,PILL_H+4)},0.2,Enum.EasingStyle.Back) end)
    pbtn.MouseLeave:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W,0,PILL_H)},0.18) end)
    pbtn.MouseButton1Down:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W-10,0,PILL_H-4)},0.1,Enum.EasingStyle.Quint) end)

    UserInputService.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode==Enum.KeyCode.RightShift then toggle() end
    end)

    -- ── Tab system ────────────────────────────────────────────────────────────
    local _tabs,_btns,_active={},{},0

    local function selTab(idx)
        if _active==idx then return end
        for i,t in ipairs(_tabs) do
            t.page.Visible=(i==idx)
            local b=_btns[i]; if not b then continue end
            local lbl=b:FindFirstChildWhichIsA("TextLabel")
            local bar=b:FindFirstChild("_bar")
            if i==idx then
                tw(b,{BackgroundColor3=th.TabSel,BackgroundTransparency=0},0.25)
                if lbl then tw(lbl,{TextColor3=th.TabTextOn,TextTransparency=0},0.2) end
                if bar then tw(bar,{BackgroundTransparency=0},0.2) end
            else
                tw(b,{BackgroundColor3=th.TabUnsel,BackgroundTransparency=0.5},0.25)
                if lbl then tw(lbl,{TextColor3=th.TabTextOff,TextTransparency=0.25},0.2) end
                if bar then tw(bar,{BackgroundTransparency=1},0.2) end
            end
        end
        _active=idx
    end

    local Win={}

    function Win:CreateTab(name,_icon)
        local idx=#_tabs+1; local first=(idx==1)

        local btn=ni("TextButton",tabScroll,{
            Name="Tab_"..name,Size=UDim2.new(1,0,0,42),
            BackgroundColor3=first and th.TabSel or th.TabUnsel,
            BackgroundTransparency=first and 0 or 0.5,
            Text="",ZIndex=6,AutoButtonColor=false,LayoutOrder=idx,
        })
        mkCorner(btn,10)
        local bar=ni("Frame",btn,{Name="_bar",Size=UDim2.new(0,3,.6,0),Position=UDim2.new(0,0,.2,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=first and 0 or 1,ZIndex=7})
        mkCorner(bar,2)
        ni("TextLabel",btn,{
            Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,14,0,0),
            BackgroundTransparency=1,Text=name,
            TextColor3=first and th.TabTextOn or th.TabTextOff,
            Font=Enum.Font.GothamBold,TextSize=11,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextTransparency=first and 0 or 0.25,ZIndex=7,
        })
        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _active~=idx then tw(btn,{BackgroundTransparency=0.2},0.18) end end)
        btn.MouseLeave:Connect(function() if _active~=idx then tw(btn,{BackgroundTransparency=0.5},0.18) end end)

        local page=ni("ScrollingFrame",Content,{
            Name="Page_"..name,Size=UDim2.new(1,0,1,0),
            BackgroundTransparency=1,BorderSizePixel=0,
            ScrollBarThickness=3,ScrollBarImageColor3=th.Accent,
            ScrollBarImageTransparency=0.5,
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            CanvasSize=UDim2.new(0,0,0,0),
            Visible=first,ZIndex=4,ClipsDescendants=true,
        })
        mkList(page,8); mkPad(page,10,10,14,14)

        local tab={page=page,_n=0}
        _tabs[idx]=tab; _btns[idx]=btn
        if first then _active=1 end
        local function eo() tab._n=tab._n+1; return tab._n end

        function tab:CreateSection(s)
            ni("Frame",page,{Size=UDim2.new(1,0,0,4),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            local sf=ni("Frame",page,{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            ni("TextLabel",sf,{Size=UDim2.new(1,-4,1,0),Position=UDim2.new(0,2,0,0),BackgroundTransparency=1,Text=s,TextColor3=th.SectionText,Font=Enum.Font.GothamBold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5})
            ni("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Divider,BackgroundTransparency=0.3,ZIndex=5})
        end

        function tab:CreateToggle(o)
            local tN=o.Name or "Toggle"; local dV=o.CurrentValue or false
            local fl=o.Flag; local cb=o.Callback; local val=dV

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            mkCorner(row,10)
            local rSt=mkStroke(row,th.CardStroke,1,0.28)
            local la=ni("Frame",row,{Size=UDim2.new(0,3,.55,0),Position=UDim2.new(0,0,.225,0),BackgroundColor3=th.Accent,BackgroundTransparency=val and 0.4 or 1,ZIndex=6}); mkCorner(la,2)
            ni("TextLabel",row,{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=tN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local PW,PH,KS=48,26,20; local K0,K1=3,25
            local pill=ni("Frame",row,{Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+14),.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=val and th.ToggleOn or th.ToggleOff,ZIndex=6})
            mkCorner(pill,PH//2)
            local pSt=mkStroke(pill,val and th.ToggleOn or th.CardStroke,1,val and 0.5 or 0.15)
            local knob=ni("Frame",pill,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.ToggleKnob,ZIndex=7})
            mkCorner(knob,KS//2)

            local tog={CurrentValue=val,Type="Toggle"}
            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.ToggleOn or th.ToggleOff},0.3)
                tw(pSt,{Color=v and th.ToggleOn or th.CardStroke,Transparency=v and 0.5 or 0.15},0.3)
                tw(la,{BackgroundTransparency=v and 0.4 or 1},0.3)
                tw(rSt,{Color=v and th.Accent or th.CardStroke,Transparency=v and 0.55 or 0.28},0.3)
                tw(knob,{Size=UDim2.new(0,KS*1.38,0,KS*0.72)},0.08,Enum.EasingStyle.Sine)
                task.delay(0.08,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},0.44,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                local tl=row:FindFirstChildWhichIsA("TextLabel")
                if tl then tw(tl,{TextColor3=v and th.Text or th.TextDim},0.25) end
            end
            function tog:Set(v) apply(v); if cb then cb(v) end end

            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardHover},0.18) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},0.18) end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.87,0,PH*.83)},0.08,Enum.EasingStyle.Quint) end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true; task.delay(0.5,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)
            if fl then Vula.Flags[fl]=tog end
            return tog
        end

        function tab:CreateButton(o)
            local bN=o.Name or "Button"; local cb=o.Callback
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,48),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true})
            mkCorner(row,10)
            local rSt=mkStroke(row,th.CardStroke,1,0.32)
            local fill=ni("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Accent,BackgroundTransparency=0.9,ZIndex=5}); mkCorner(fill,10)
            ni("TextLabel",row,{Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=bN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local arr=ni("TextLabel",row,{Size=UDim2.new(0,24,1,0),Position=UDim2.new(1,-28,0,0),BackgroundTransparency=1,Text="›",TextColor3=th.TextDim,Font=Enum.Font.GothamBold,TextSize=18,ZIndex=6})
            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardHover},0.18); tw(fill,{Size=UDim2.new(1,0,1,0)},0.28); tw(rSt,{Color=th.Accent,Transparency=0.6},0.22); tw(arr,{TextColor3=th.Accent},0.18) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},0.18); tw(fill,{Size=UDim2.new(0,0,1,0)},0.22); tw(rSt,{Color=th.CardStroke,Transparency=0.32},0.22); tw(arr,{TextColor3=th.TextDim},0.18) end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=ni("Frame",row,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Accent,BackgroundTransparency=0.72,ZIndex=10}); mkCorner(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.5
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},0.52,Enum.EasingStyle.Quint)
                task.delay(0.54,function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function() if cd then return end; cd=true; task.delay(0.3,function() cd=false end); if cb then task.spawn(cb) end end)
            local b={}; function b:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end; return b
        end

        function tab:CreateLabel(text)
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,38),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            mkCorner(row,10); mkStroke(row,th.CardStroke,1,0.48)
            local lbl=ni("TextLabel",row,{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text=text,TextColor3=th.TextDim,Font=Enum.Font.GothamMedium,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            return lbl
        end

        function tab:CreateKeybind(o)
            local kN=o.Name or "Keybind"; local kD=o.CurrentKeybind or "RightShift"
            local fl=o.Flag; local cb=o.Callback; local cur=kD; local lst=false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            mkCorner(row,10); mkStroke(row,th.CardStroke,1,0.28)
            ni("TextLabel",row,{Size=UDim2.new(1,-96,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=kN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local chip=ni("TextButton",row,{Size=UDim2.new(0,78,0,28),Position=UDim2.new(1,-88,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InputBg,Text=cur,TextColor3=th.Accent,Font=Enum.Font.GothamBold,TextSize=10,ZIndex=7,AutoButtonColor=false})
            mkCorner(chip,6); local cSt=mkStroke(chip,th.Accent,1,0.5)
            chip.MouseButton1Click:Connect(function() if lst then return end; lst=true; chip.Text="..."; tw(chip,{BackgroundColor3=th.Accent},0.18); tw(cSt,{Transparency=0},0.18) end)
            UserInputService.InputBegan:Connect(function(i,gpe) if not lst then return end; if i.UserInputType~=Enum.UserInputType.Keyboard then return end; lst=false; cur=i.KeyCode.Name; chip.Text=cur; tw(chip,{BackgroundColor3=th.InputBg},0.18); tw(cSt,{Transparency=0.5},0.18); if cb then cb() end end)
            local kb={CurrentKeybind=cur,Type="Keybind"}; function kb:Set(v) cur=v; chip.Text=v end
            if fl then Vula.Flags[fl]=kb end; return kb
        end

        return tab
    end

    return Win
end

_g.VulaLoaded=true; _g.VulaLib=Vula
return Vula

--[[
    V U L A  ·  v2.3
    Compact mobile-first redesign · Pill at bottom -20
]]

local Vula = { Flags = {}, Version = "2.3" }
local _g = type(getgenv)=="function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

local TS   = game:GetService("TweenService")
local UIS  = game:GetService("UserInputService")
local Run  = game:GetService("RunService")
local Plrs = game:GetService("Players")
local LP   = Plrs.LocalPlayer

-- ── Safe parent ───────────────────────────────────────────────────────────────
local function safeP()
    local ok, pg = pcall(function() return LP:WaitForChild("PlayerGui",5) end)
    if ok and pg then return pg end
    return LP.PlayerGui
end

-- ── Tween ─────────────────────────────────────────────────────────────────────
local function tw(o, p, d, s, dr)
    if not o then return end
    local t = TS:Create(o, TweenInfo.new(d or .3, s or Enum.EasingStyle.Exponential, dr or Enum.EasingDirection.Out), p)
    if t then t:Play() end
end

-- ── Instance ──────────────────────────────────────────────────────────────────
local function ni(cls, par, props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do pcall(function() i[k]=v end) end end
    if par then i.Parent = par end
    return i
end
local function C(p,r)   ni("UICorner",p,{CornerRadius=UDim.new(0,r or 8)}) end
local function St(p,c,th2,tr) return ni("UIStroke",p,{Color=c,Thickness=th2 or 1,Transparency=tr or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border}) end
local function Pd(p,l,r,t,b) ni("UIPadding",p,{PaddingLeft=UDim.new(0,l or 0),PaddingRight=UDim.new(0,r or 0),PaddingTop=UDim.new(0,t or 0),PaddingBottom=UDim.new(0,b or 0)}) end
local function LL(p,g)  ni("UIListLayout",p,{FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Center,Padding=UDim.new(0,g or 0),SortOrder=Enum.SortOrder.LayoutOrder}) end

-- ── hex → Color3 ──────────────────────────────────────────────────────────────
local function h(s) s=s:gsub("#",""); return Color3.fromRGB(tonumber(s:sub(1,2),16),tonumber(s:sub(3,4),16),tonumber(s:sub(5,6),16)) end
local function rt(t) local o={} for k,v in pairs(t) do o[k]=type(v)=="string" and h(v) or v end return o end

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    JJK = {
        Accent="c81c30", AccentDark="7a0e1c",
        Window="08080f", Topbar="0c0c18",
        Sidebar="0a0a14", Card="0e0d1a",
        CardHover="141120", CardStroke="28141e",
        SecText="c81c30", Text="dce0f5",
        Dim="4e5878", TogOn="c81c30",
        TogOff="1c1018", Knob="ffffff",
        TabOn="c81c30", TabOff="0d0d18",
        TxtOn="ffffff", TxtOff="424d6e",
        Div="28141e", InBg="0a0a12",
        Ph="3c4260", Pill="0b0a15",
        Shad="000000", NBg="0a0a14",
    },
    Default = {
        Accent="328adc", AccentDark="1a5899",
        Window="141414", Topbar="1c1c1c",
        Sidebar="181818", Card="1e1e1e",
        CardHover="252525", CardStroke="2e2e2e",
        SecText="328adc", Text="e8e8e8",
        Dim="767676", TogOn="328adc",
        TogOff="353535", Knob="ffffff",
        TabOn="328adc", TabOff="1e1e1e",
        TxtOn="ffffff", TxtOff="6e6e6e",
        Div="2e2e2e", InBg="161616",
        Ph="5c5c5c", Pill="1c1c1c",
        Shad="000000", NBg="1a1a1a",
    },
    Midnight = {
        Accent="5878ff", AccentDark="3048b8",
        Window="07080d", Topbar="0b0d1a",
        Sidebar="090b16", Card="0d1020",
        CardHover="111526", CardStroke="202848",
        SecText="5878ff", Text="cfd4ff",
        Dim="4e5888", TogOn="5878ff",
        TogOff="191e38", Knob="ffffff",
        TabOn="5878ff", TabOff="0d1020",
        TxtOn="ffffff", TxtOff="454e7a",
        Div="202848", InBg="090b16",
        Ph="40487a", Pill="0b0d1a",
        Shad="000000", NBg="0b0d1a",
    },
    Amethyst = {
        Accent="9b55dc", AccentDark="5c2e8a",
        Window="0c0814", Topbar="120c1e",
        Sidebar="0e0a18", Card="140e22",
        CardHover="1a1228", CardStroke="38204e",
        SecText="9b55dc", Text="e2d8ff",
        Dim="6a5090", TogOn="9b55dc",
        TogOff="281840", Knob="ffffff",
        TabOn="9b55dc", TabOff="140e22",
        TxtOn="ffffff", TxtOff="5e4280",
        Div="38204e", InBg="0e0a18",
        Ph="584080", Pill="120c1e",
        Shad="000000", NBg="120c1e",
    },
    Ocean = {
        Accent="00b4b4", AccentDark="006e6e",
        Window="070e12", Topbar="0b1620",
        Sidebar="091218", Card="0c1820",
        CardHover="101e28", CardStroke="183644",
        SecText="00b4b4", Text="c8eef0",
        Dim="3e7e8a", TogOn="00b4b4",
        TogOff="0e2c38", Knob="ffffff",
        TabOn="00b4b4", TabOff="0c1820",
        TxtOn="ffffff", TxtOff="326e7a",
        Div="183644", InBg="091218",
        Ph="2e6070", Pill="0b1620",
        Shad="000000", NBg="0b1620",
    },
    Sakura = {
        Accent="ee5a94", AccentDark="a0305e",
        Window="0e080c", Topbar="180c12",
        Sidebar="120a0f", Card="1c1018",
        CardHover="22141e", CardStroke="4a2036",
        SecText="ee5a94", Text="ffe0ec",
        Dim="8a5a70", TogOn="ee5a94",
        TogOff="321826", Knob="ffffff",
        TabOn="ee5a94", TabOff="1c1018",
        TxtOn="ffffff", TxtOff="784860",
        Div="4a2036", InBg="120a0f",
        Ph="6c3c52", Pill="180c12",
        Shad="000000", NBg="180c12",
    },
    Light = {
        Accent="328adc", AccentDark="1a5899",
        Window="f5f5f5", Topbar="e8e8e8",
        Sidebar="eeeeee", Card="ffffff",
        CardHover="f0f0f8", CardStroke="d4d4d8",
        SecText="328adc", Text="1c1c1c",
        Dim="888888", TogOn="328adc",
        TogOff="c0c0c2", Knob="ffffff",
        TabOn="328adc", TabOff="ffffff",
        TxtOn="ffffff", TxtOff="888888",
        Div="d4d4d8", InBg="eeeeee",
        Ph="a8a8a8", Pill="e8e8e8",
        Shad="9898a0", NBg="f8f8f8",
    },
}

-- ── Notifications ─────────────────────────────────────────────────────────────
local _nsg, _nst = nil, {}
local NW,NH,NG = 270,62,5

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = ni("ScreenGui", safeP(), {Name="VulaNotifs", DisplayOrder=200, ResetOnSpawn=false})
    return _nsg
end

local function repack()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    for i,nf in ipairs(_nst) do
        if nf and nf.Parent then
            tw(nf, {Position=UDim2.new(1,-8,1-(i*(NH+NG)/vpH),0)}, .4, Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(opts)
    local T=opts.Title or "Vula"; local C2=opts.Content or ""; local D=opts.Duration or 4.5
    local th = self._theme or rt(Vula.Theme.Default)
    if #_nst>=5 then local o=table.remove(_nst,1); if o and o.Parent then o:Destroy() end end
    local idx=#_nst+1
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    local sy=1-idx*(NH+NG)/vpH

    local f=ni("Frame",getNSG(),{Size=UDim2.new(0,NW,0,NH),Position=UDim2.new(1.1,0,sy,0),AnchorPoint=Vector2.new(1,1),BackgroundColor3=th.NBg,ZIndex=10})
    C(f,10); St(f,th.CardStroke,1,.18)
    -- top accent
    local ta=ni("Frame",f,{Size=UDim2.new(1,0,0,2),BackgroundColor3=th.Accent,ZIndex=12}); C(ta,10)
    -- left bar
    local lb=ni("Frame",f,{Size=UDim2.new(0,3,.56,0),Position=UDim2.new(0,8,.22,0),BackgroundColor3=th.Accent,ZIndex=12}); C(lb,2)

    local tl=ni("TextLabel",f,{Size=UDim2.new(1,-22,0,18),Position=UDim2.new(0,16,0,8),BackgroundTransparency=1,Text=T,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=12})
    local bl=ni("TextLabel",f,{Size=UDim2.new(1,-22,0,16),Position=UDim2.new(0,16,0,28),BackgroundTransparency=1,Text=C2,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,TextTransparency=1,ZIndex=12})
    local tbg=ni("Frame",f,{Size=UDim2.new(1,-16,0,2),Position=UDim2.new(0,8,1,-4),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.Div,ZIndex=12}); C(tbg,1)
    local tf=ni("Frame",tbg,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Accent,ZIndex=13}); C(tf,1)

    _nst[idx]=f
    tw(f,{Position=UDim2.new(1,-8,sy,0)},.48,Enum.EasingStyle.Back)
    task.delay(.08,function() tw(tl,{TextTransparency=0},.25); tw(bl,{TextTransparency=.2},.25) end)
    task.delay(.18,function() if tf.Parent then tw(tf,{Size=UDim2.new(0,0,1,0)},D-.18,Enum.EasingStyle.Linear) end end)

    local done=false
    local function dis()
        if done then return end; done=true
        tw(tl,{TextTransparency=1},.18); tw(bl,{TextTransparency=1},.18)
        tw(f,{BackgroundTransparency=1},.22,Enum.EasingStyle.Quint)
        tw(f,{Position=UDim2.new(1.08,0,sy,0)},.28,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        task.delay(.3,function()
            for i,n in ipairs(_nst) do if n==f then table.remove(_nst,i); break end end
            if f.Parent then f:Destroy() end; repack()
        end)
    end
    f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis() end end)
    task.delay(D,dis); repack()
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title  = opts.Name            or "Vula"
    local loadT  = opts.LoadingTitle    or title
    local loadS  = opts.LoadingSubtitle or "Loading..."
    local tname  = opts.Theme           or "Default"
    local th     = rt(Vula.Theme[tname] or Vula.Theme.Default)
    self._theme  = th

    -- ── Layout ────────────────────────────────────────────────────────────────
    -- Exact size/position from Dex: Size {0,340},{0,230} · Pos {0.5,3},{0.5,-38}
    local WW,WH   = 340, 230
    local TOP_H   = 44
    local SIDE_W  = 130
    local PILL_W  = 148
    local PILL_H  = 30

    -- Kill old
    local par = safeP()
    pcall(function() for _,c in ipairs(par:GetChildren()) do if c.Name=="Vula" then c:Destroy() end end end)

    local sg = ni("ScreenGui", par, {Name="Vula", DisplayOrder=100, ResetOnSpawn=false})

    -- ── Main ──────────────────────────────────────────────────────────────────
    local Main = ni("Frame", sg, {
        Name="Main", Size=UDim2.new(0,WW,0,WH),
        Position=UDim2.new(.5,3,.5,-38), AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=th.Window, ZIndex=2, ClipsDescendants=true,
    })
    C(Main, 12)
    St(Main, th.CardStroke, 1, .25)

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local TB = ni("Frame", Main, {
        Size=UDim2.new(1,0,0,TOP_H), BackgroundColor3=th.Topbar, ZIndex=5,
    })
    C(TB, 12)
    -- fill bottom-round corners
    ni("Frame", TB, {Size=UDim2.new(1,0,.5,0), Position=UDim2.new(0,0,.5,0), BackgroundColor3=th.Topbar, ZIndex=5})
    -- accent top line (1px, very subtle)
    ni("Frame", TB, {Size=UDim2.new(1,0,0,1), BackgroundColor3=th.Accent, BackgroundTransparency=.2, ZIndex=8})
    -- bottom divider
    ni("Frame", TB, {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BackgroundColor3=th.Div, ZIndex=6})

    -- Badge
    local bdg = ni("Frame", TB, {Size=UDim2.new(0,26,0,26), Position=UDim2.new(0,11,.5,0), AnchorPoint=Vector2.new(0,.5), BackgroundColor3=th.Accent, ZIndex=6})
    C(bdg,13); ni("UIGradient", bdg, {Rotation=135, ColorSequence=ColorSequence.new(th.Accent, th.AccentDark)})
    ni("TextLabel", bdg, {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="呪", TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBold, TextSize=12, ZIndex=7})

    -- Title
    ni("TextLabel", TB, {Size=UDim2.new(1,-120,0,20), Position=UDim2.new(0,44,0,5), BackgroundTransparency=1, Text=title, TextColor3=th.Text, Font=Enum.Font.GothamBold, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6})
    ni("TextLabel", TB, {Size=UDim2.new(1,-120,0,13), Position=UDim2.new(0,44,0,25), BackgroundTransparency=1, Text="Vula v2.3", TextColor3=th.Dim, Font=Enum.Font.GothamMedium, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, ZIndex=6})

    -- macOS orbs
    local function mkOrb(xOff, col, sym)
        local o = ni("TextButton", TB, {
            Size=UDim2.new(0,12,0,12), Position=UDim2.new(1,xOff,.5,0), AnchorPoint=Vector2.new(1,.5),
            BackgroundColor3=col, BackgroundTransparency=.12, Text="", ZIndex=7, AutoButtonColor=false,
        }); C(o,6)
        local lbl = ni("TextLabel", o, {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text=sym, TextColor3=Color3.fromRGB(20,12,12), Font=Enum.Font.GothamBold, TextSize=8, TextTransparency=1, ZIndex=8})
        o.MouseEnter:Connect(function() tw(o,{BackgroundTransparency=0},.1); tw(lbl,{TextTransparency=0},.1) end)
        o.MouseLeave:Connect(function() tw(o,{BackgroundTransparency=.12},.1); tw(lbl,{TextTransparency=1},.1) end)
        return o
    end
    local oClose = mkOrb(-11, Color3.fromRGB(255,59,48),  "×")
    local oMin   = mkOrb(-28, Color3.fromRGB(255,149,0),  "–")

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
                Main.Position=UDim2.new(.5,ox+(m2.X-dsx),.5,oy+(m2.Y-dsy))
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end end)
    end

    -- ── Sidebar ───────────────────────────────────────────────────────────────
    local SB = ni("Frame", Main, {
        Size=UDim2.new(0,SIDE_W,1,-TOP_H), Position=UDim2.new(0,0,0,TOP_H),
        BackgroundColor3=th.Sidebar, ZIndex=4,
    })
    -- square right edge
    ni("Frame", SB, {Size=UDim2.new(0,10,1,0), Position=UDim2.new(1,-10,0,0), BackgroundColor3=th.Sidebar, ZIndex=4})
    -- divider
    ni("Frame", SB, {Size=UDim2.new(0,1,1,0), Position=UDim2.new(1,-1,0,0), BackgroundColor3=th.Div, BackgroundTransparency=.35, ZIndex=5})

    local tabScroll = ni("ScrollingFrame", SB, {
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=0, AutomaticCanvasSize=Enum.AutomaticSize.Y, CanvasSize=UDim2.new(0,0,0,0), ZIndex=5,
    })
    LL(tabScroll,4); Pd(tabScroll,7,7,10,8)

    -- ── Content ───────────────────────────────────────────────────────────────
    local Content = ni("Frame", Main, {
        Size=UDim2.new(1,-SIDE_W,1,-TOP_H), Position=UDim2.new(0,SIDE_W,0,TOP_H),
        BackgroundTransparency=1, ClipsDescendants=true, ZIndex=3,
    })

    -- ── Loading overlay ───────────────────────────────────────────────────────
    local LD = ni("Frame", Main, {Size=UDim2.new(1,0,1,0), BackgroundColor3=th.Window, ZIndex=25})
    C(LD,12)
    local ldb = ni("Frame", LD, {Size=UDim2.new(0,44,0,44), Position=UDim2.new(.5,0,.36,0), AnchorPoint=Vector2.new(.5,.5), BackgroundColor3=th.Accent, ZIndex=26})
    C(ldb,22); ni("UIGradient", ldb, {Rotation=135, ColorSequence=ColorSequence.new(th.Accent, th.AccentDark)})
    ni("TextLabel", ldb, {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="呪", TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBold, TextSize=18, ZIndex=27})
    ni("TextLabel", LD, {Size=UDim2.new(.85,0,0,20), Position=UDim2.new(.075,0,.47,0), BackgroundTransparency=1, Text=loadT, TextColor3=th.Text, Font=Enum.Font.GothamBold, TextSize=13, ZIndex=26})
    ni("TextLabel", LD, {Size=UDim2.new(.85,0,0,16), Position=UDim2.new(.075,0,.58,0), BackgroundTransparency=1, Text=loadS, TextColor3=th.Dim, Font=Enum.Font.GothamMedium, TextSize=10, ZIndex=26})
    local lbg = ni("Frame", LD, {Size=UDim2.new(.6,0,0,3), Position=UDim2.new(.2,0,.68,0), BackgroundColor3=th.Div, ZIndex=26}); C(lbg,2)
    local lfl = ni("Frame", lbg, {Size=UDim2.new(0,0,1,0), BackgroundColor3=th.Accent, ZIndex=27}); C(lfl,2)
    task.spawn(function()
        tw(lfl, {Size=UDim2.new(1,0,1,0)}, 1.4, Enum.EasingStyle.Quint); task.wait(1.6)
        tw(LD, {BackgroundTransparency=1}, .38)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},.28) elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},.28) end
        end
        task.wait(.42); LD.Visible=false
    end)

    -- ── Bottom Pill ───────────────────────────────────────────────────────────
    local Pill = ni("Frame", sg, {
        Size=UDim2.new(0,PILL_W,0,PILL_H),
        Position=UDim2.new(.5,0,1,-20),   -- ← exactly -20 from bottom
        AnchorPoint=Vector2.new(.5,1),
        BackgroundColor3=th.Pill, ZIndex=55,
    })
    C(Pill, PILL_H//2)
    St(Pill, th.Accent, 1.5, .15)
    -- subtle inner gradient tint
    ni("UIGradient", Pill, {
        Rotation=90,
        ColorSequence=ColorSequence.new(th.Accent, th.Pill),
        Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,.86), NumberSequenceKeypoint.new(1,.95)}),
    })

    local pillLbl = ni("TextLabel", Pill, {
        Size=UDim2.new(1,-8,1,0), Position=UDim2.new(0,4,0,0),
        BackgroundTransparency=1, Text="▲  "..title,
        TextColor3=th.Text, Font=Enum.Font.GothamBold, TextSize=10, ZIndex=56,
    })

    -- Pill horizontal drag
    do
        local drag,dsx,sx=false,0,0; local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            drag=true; dsx=UIS:GetMouseLocation().X; sx=Pill.Position.X.Offset
            if dc then dc:Disconnect() end
            dc=Run.Heartbeat:Connect(function()
                if not drag then dc:Disconnect(); return end
                Pill.Position=UDim2.new(.5, sx+(UIS:GetMouseLocation().X-dsx), 1,-20)
            end)
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Open / Close (fade) ───────────────────────────────────────────────────
    local Hidden,Minimised,Deb=false,false,false

    local function open()
        if Deb then return end; Deb=true; Hidden=false
        Main.Visible=true; Main.BackgroundTransparency=1
        tw(Main,{BackgroundTransparency=0},.38); pillLbl.Text="▲  "..title
        task.delay(.4,function() Deb=false end)
    end
    local function close(silent)
        if Deb then return end; Deb=true; Hidden=true
        tw(Main,{BackgroundTransparency=1},.3); pillLbl.Text="▼  "..title
        task.delay(.32,function() Main.Visible=false; Deb=false end)
        if not silent then Vula:Notify({Title="Hidden",Content="RightShift or pill to reopen.",Duration=3}) end
    end
    local function toggle() if Hidden then open() else close(true) end end

    oClose.MouseButton1Click:Connect(function() close(true) end)
    oMin.MouseButton1Click:Connect(function()
        Minimised=not Minimised
        if Minimised then
            SB.Visible=false; Content.Visible=false
            tw(Main,{Size=UDim2.new(0,340,0,TOP_H)},.3)
        else
            tw(Main,{Size=UDim2.new(0,340,0,230)},.4,Enum.EasingStyle.Back)
            task.delay(.18,function() SB.Visible=true; Content.Visible=true end)
        end
    end)

    local pb = ni("TextButton", Pill, {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", ZIndex=57, AutoButtonColor=false})
    pb.MouseButton1Click:Connect(toggle)
    pb.MouseEnter:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W+14,0,PILL_H+3)},.2,Enum.EasingStyle.Back) end)
    pb.MouseLeave:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W,0,PILL_H)},.16) end)
    pb.MouseButton1Down:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W-8,0,PILL_H-3)},.08,Enum.EasingStyle.Quint) end)

    UIS.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode==Enum.KeyCode.RightShift then toggle() end
    end)

    -- ── Tab system ────────────────────────────────────────────────────────────
    local _tabs,_btns,_act={},{},0

    local function selTab(idx)
        if _act==idx then return end
        for i,t in ipairs(_tabs) do
            t.page.Visible=(i==idx)
            local b=_btns[i]; if not b then continue end
            local lbl=b:FindFirstChildWhichIsA("TextLabel")
            local bar=b:FindFirstChild("_b")
            if i==idx then
                tw(b,{BackgroundColor3=th.TabOn,BackgroundTransparency=0},.24)
                if lbl then tw(lbl,{TextColor3=th.TxtOn,TextTransparency=0},.2) end
                if bar then tw(bar,{BackgroundTransparency=0},.2) end
            else
                tw(b,{BackgroundColor3=th.TabOff,BackgroundTransparency=.55},.24)
                if lbl then tw(lbl,{TextColor3=th.TxtOff,TextTransparency=.22},.2) end
                if bar then tw(bar,{BackgroundTransparency=1},.2) end
            end
        end
        _act=idx
    end

    local Win={}

    function Win:CreateTab(name,_icon)
        local idx=#_tabs+1; local first=(idx==1)

        local btn=ni("TextButton",tabScroll,{
            Name="Tab_"..name, Size=UDim2.new(1,0,0,36),
            BackgroundColor3=first and th.TabOn or th.TabOff,
            BackgroundTransparency=first and 0 or .55,
            Text="", ZIndex=6, AutoButtonColor=false, LayoutOrder=idx,
        }); C(btn,8)

        local bar=ni("Frame",btn,{Name="_b",Size=UDim2.new(0,2,.58,0),Position=UDim2.new(0,0,.21,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=first and 0 or 1,ZIndex=7}); C(bar,1)

        ni("TextLabel",btn,{
            Size=UDim2.new(1,-14,1,0), Position=UDim2.new(0,12,0,0),
            BackgroundTransparency=1, Text=name,
            TextColor3=first and th.TxtOn or th.TxtOff,
            Font=Enum.Font.GothamBold, TextSize=10,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextTransparency=first and 0 or .22, ZIndex=7,
        })
        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.22},.16) end end)
        btn.MouseLeave:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.55},.16) end end)

        local page=ni("ScrollingFrame",Content,{
            Name="Page_"..name, Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0,
            ScrollBarThickness=2, ScrollBarImageColor3=th.Accent, ScrollBarImageTransparency=.5,
            AutomaticCanvasSize=Enum.AutomaticSize.Y, CanvasSize=UDim2.new(0,0,0,0),
            Visible=first, ZIndex=4, ClipsDescendants=true,
        })
        LL(page,6); Pd(page,8,8,10,10)

        local tab={page=page,_n=0}
        _tabs[idx]=tab; _btns[idx]=btn
        if first then _act=1 end
        local function eo() tab._n=tab._n+1; return tab._n end

        -- ── Section ───────────────────────────────────────────────────────────
        function tab:CreateSection(s)
            ni("Frame",page,{Size=UDim2.new(1,0,0,3),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            local sf=ni("Frame",page,{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            ni("TextLabel",sf,{Size=UDim2.new(1,-4,1,0),Position=UDim2.new(0,2,0,0),BackgroundTransparency=1,Text=string.upper(s),TextColor3=th.SecText,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=.05,ZIndex=5})
            ni("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Accent,BackgroundTransparency=.75,ZIndex=5})
        end

        -- ── Toggle ────────────────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local tN=o.Name or "Toggle"; local dV=o.CurrentValue or false
            local fl=o.Flag; local cb=o.Callback; local val=dV

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,44),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,8); local rSt=St(row,th.CardStroke,1,.25)
            local la=ni("Frame",row,{Size=UDim2.new(0,2,.52,0),Position=UDim2.new(0,0,.24,0),BackgroundColor3=th.Accent,BackgroundTransparency=val and .35 or 1,ZIndex=6}); C(la,1)

            ni("TextLabel",row,{Size=UDim2.new(1,-72,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=tN,TextColor3=val and th.Text or th.Dim,Font=Enum.Font.GothamSemibold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local PW,PH,KS=42,22,16; local K0,K1=2,22
            local pill=ni("Frame",row,{Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+10),.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=val and th.TogOn or th.TogOff,ZIndex=6})
            C(pill,PH//2); local pSt=St(pill,val and th.TogOn or th.CardStroke,1,val and .5 or .12)

            local knob=ni("Frame",pill,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Knob,ZIndex=7})
            C(knob,KS//2)
            -- knob subtle shadow
            ni("UIStroke",knob,{Color=Color3.new(0,0,0),Thickness=1,Transparency=.82,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})

            local tog={CurrentValue=val,Type="Toggle"}
            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.TogOn or th.TogOff},.28)
                tw(pSt,{Color=v and th.TogOn or th.CardStroke,Transparency=v and .5 or .12},.28)
                tw(la,{BackgroundTransparency=v and .35 or 1},.28)
                tw(rSt,{Color=v and th.Accent or th.CardStroke,Transparency=v and .5 or .25},.28)
                tw(knob,{Size=UDim2.new(0,KS*1.36,0,KS*.72)},.07,Enum.EasingStyle.Sine)
                task.delay(.07,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},.42,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                local tl=row:FindFirstChildWhichIsA("TextLabel")
                if tl then tw(tl,{TextColor3=v and th.Text or th.Dim},.22) end
            end
            function tog:Set(v) apply(v); if cb then cb(v) end end

            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardHover},.15) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.15) end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.86,0,PH*.82)},.07,Enum.EasingStyle.Quint) end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true; task.delay(.45,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)
            if fl then Vula.Flags[fl]=tog end
            return tog
        end

        -- ── Button ────────────────────────────────────────────────────────────
        function tab:CreateButton(o)
            local bN=o.Name or "Button"; local cb=o.Callback
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,42),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true})
            C(row,8); local rSt=St(row,th.CardStroke,1,.28)
            local fill=ni("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Accent,BackgroundTransparency=.9,ZIndex=5}); C(fill,8)
            ni("TextLabel",row,{Size=UDim2.new(1,-32,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=bN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local arr=ni("TextLabel",row,{Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-22,0,0),BackgroundTransparency=1,Text="›",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=16,ZIndex=6})

            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function()
                tw(row,{BackgroundColor3=th.CardHover},.15)
                tw(fill,{Size=UDim2.new(1,0,1,0)},.26)
                tw(rSt,{Color=th.Accent,Transparency=.6},.2)
                tw(arr,{TextColor3=th.Accent},.15)
            end)
            hit.MouseLeave:Connect(function()
                tw(row,{BackgroundColor3=th.Card},.15)
                tw(fill,{Size=UDim2.new(0,0,1,0)},.2)
                tw(rSt,{Color=th.CardStroke,Transparency=.28},.2)
                tw(arr,{TextColor3=th.Dim},.15)
            end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=ni("Frame",row,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Accent,BackgroundTransparency=.72,ZIndex=10}); C(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.4
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},.48,Enum.EasingStyle.Quint)
                task.delay(.5,function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function() if cd then return end; cd=true; task.delay(.28,function() cd=false end); if cb then task.spawn(cb) end end)
            local b={}; function b:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end; return b
        end

        -- ── Label ─────────────────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,34),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,8); St(row,th.CardStroke,1,.45)
            local lbl=ni("TextLabel",row,{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=text,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            return lbl
        end

        -- ── Keybind ───────────────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local kN=o.Name or "Keybind"; local kD=o.CurrentKeybind or "RightShift"
            local fl=o.Flag; local cb=o.Callback; local cur=kD; local lst=false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,44),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,8); St(row,th.CardStroke,1,.25)
            ni("TextLabel",row,{Size=UDim2.new(1,-88,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=kN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local chip=ni("TextButton",row,{Size=UDim2.new(0,68,0,24),Position=UDim2.new(1,-76,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,Text=cur,TextColor3=th.Accent,Font=Enum.Font.GothamBold,TextSize=9,ZIndex=7,AutoButtonColor=false})
            C(chip,5); local cSt=St(chip,th.Accent,1,.48)
            chip.MouseButton1Click:Connect(function()
                if lst then return end; lst=true; chip.Text="..."
                tw(chip,{BackgroundColor3=th.Accent},.16); tw(cSt,{Transparency=0},.16)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not lst then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                lst=false; cur=i.KeyCode.Name; chip.Text=cur
                tw(chip,{BackgroundColor3=th.InBg},.16); tw(cSt,{Transparency=.48},.16)
                if cb then cb() end
            end)
            local kb={CurrentKeybind=cur,Type="Keybind"}; function kb:Set(v) cur=v; chip.Text=v end
            if fl then Vula.Flags[fl]=kb end; return kb
        end

        return tab
    end

    return Win
end

_g.VulaLoaded=true; _g.VulaLib=Vula
return Vula

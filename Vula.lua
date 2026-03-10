--[[
╔══════════════════════════════════════════════════════╗
║  V U L A  ·  v3.0  —  "Void Cursed"                ║
║  Mobile-first · Compact · Best-in-class design       ║
╚══════════════════════════════════════════════════════╝
]]

local Vula = { Flags = {}, Version = "3.0" }
local _g = type(getgenv)=="function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local TS   = game:GetService("TweenService")
local UIS  = game:GetService("UserInputService")
local Run  = game:GetService("RunService")
local LP   = game:GetService("Players").LocalPlayer

-- ── Safe parent ───────────────────────────────────────────────────────────────
local function safeP()
    local ok,pg = pcall(function() return LP:WaitForChild("PlayerGui",5) end)
    return (ok and pg) or LP.PlayerGui
end

-- ── Helpers ───────────────────────────────────────────────────────────────────
local function tw(o,p,d,s,dr)
    if not o then return end
    local t = TS:Create(o, TweenInfo.new(d or .28, s or Enum.EasingStyle.Quint, dr or Enum.EasingDirection.Out), p)
    if t then t:Play() end
end
local function ni(cls,par,props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do pcall(function() i[k]=v end) end end
    if par then i.Parent=par end
    return i
end
local function C(p,r)   ni("UICorner",p,{CornerRadius=UDim.new(0,r or 6)}) end
local function St(p,c,t,tr) return ni("UIStroke",p,{Color=c,Thickness=t or 1,Transparency=tr or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border}) end
local function Pd(p,l,r,t,b) ni("UIPadding",p,{PaddingLeft=UDim.new(0,l),PaddingRight=UDim.new(0,r),PaddingTop=UDim.new(0,t),PaddingBottom=UDim.new(0,b)}) end
local function LL(p,g,align)
    ni("UIListLayout",p,{
        FillDirection=Enum.FillDirection.Vertical,
        HorizontalAlignment=align or Enum.HorizontalAlignment.Left,
        Padding=UDim.new(0,g or 0),
        SortOrder=Enum.SortOrder.LayoutOrder,
    })
end
local function hex(s)
    s=s:gsub("#","")
    return Color3.fromRGB(tonumber(s:sub(1,2),16),tonumber(s:sub(3,4),16),tonumber(s:sub(5,6),16))
end
local function rt(t) local o={} for k,v in pairs(t) do o[k]=type(v)=="string" and hex(v) or v end return o end
local function lerp(a,b,t) return a+(b-a)*t end
local function lerpC(a,b,t) return Color3.new(lerp(a.R,b.R,t),lerp(a.G,b.G,t),lerp(a.B,b.B,t)) end

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    JJK = {
        -- Backgrounds
        Bg="060610", Top="0a0a18", Side="08081400",
        Card="0d0c1a", CardH="14112200", Stroke="2c1828",
        -- Text
        Text="dce0f8", Dim="48506e", SecLbl="c01a2e",
        -- Accent
        Acc="c81c30", AccD="7a0c1c", AccG="c81c30",
        -- Toggle
        TOn="c81c30", TOff="1a0e16", Knob="f5f5ff",
        -- Tabs
        TBOn="c81c30", TBOff="0c0c1c", TxtOn="ffffff", TxtOff="3e4560",
        -- Misc
        Div="22121c", InBg="09090f", Ph="383e58",
        Pill="0c0b18", NBg="09091600",
    },
    Default = {
        Bg="111111", Top="181818", Side="141414",
        Card="1a1a1a", CardH="222222", Stroke="2a2a2a",
        Text="e8e8e8", Dim="686868", SecLbl="3d8fdc",
        Acc="3d8fdc", AccD="1f5a9a", AccG="3d8fdc",
        TOn="3d8fdc", TOff="282828", Knob="f8f8f8",
        TBOn="3d8fdc", TBOff="1a1a1a", TxtOn="ffffff", TxtOff="585858",
        Div="252525", InBg="101010", Ph="484848",
        Pill="181818", NBg="161616",
    },
    Midnight = {
        Bg="060810", Top="0a0d1e", Side="080b18",
        Card="0e1228", CardH="141830", Stroke="1e2650",
        Text="ccd2ff", Dim="424e88", SecLbl="6080ff",
        Acc="6080ff", AccD="3248c0", AccG="6080ff",
        TOn="6080ff", TOff="141828", Knob="f0f0ff",
        TBOn="6080ff", TBOff="0e1228", TxtOn="ffffff", TxtOff="3a4470",
        Div="1a2048", InBg="080a16", Ph="363e70",
        Pill="0a0d1e", NBg="0a0d1e",
    },
    Amethyst = {
        Bg="090610", Top="110c20", Side="0d0818",
        Card="150f24", CardH="1c142c", Stroke="3c2258",
        Text="e0d8ff", Dim="5e4890", SecLbl="a060e8",
        Acc="a060e8", AccD="5c28a0", AccG="a060e8",
        TOn="a060e8", TOff="241438", Knob="f0e8ff",
        TBOn="a060e8", TBOff="150f24", TxtOn="ffffff", TxtOff="5a3e80",
        Div="301a4e", InBg="0b0816", Ph="4e3470",
        Pill="110c20", NBg="110c20",
    },
    Ocean = {
        Bg="060e12", Top="0a1820", Side="08141c",
        Card="0c1c26", CardH="12222e", Stroke="183a50",
        Text="c8f0f2", Dim="3c7888", SecLbl="00c0c0",
        Acc="00c0c0", AccD="007878", AccG="00c0c0",
        TOn="00c0c0", TOff="0c2830", Knob="e8feff",
        TBOn="00c0c0", TBOff="0c1c26", TxtOn="ffffff", TxtOff="2e6878",
        Div="143650", InBg="080e14", Ph="2a5e6e",
        Pill="0a1820", NBg="0a1820",
    },
    Sakura = {
        Bg="0e0810", Top="1c1018", Side="160c14",
        Card="201420", CardH="281a28", Stroke="4e2040",
        Text="ffe8f2", Dim="7a5068", SecLbl="f05090",
        Acc="f05090", AccD="902858", AccG="f05090",
        TOn="f05090", TOff="301420", Knob="fff0f5",
        TBOn="f05090", TBOff="201420", TxtOn="ffffff", TxtOff="6e3858",
        Div="481838", InBg="0e080e", Ph="5e2e4e",
        Pill="1c1018", NBg="1c1018",
    },
    Light = {
        Bg="f0f0f4", Top="e4e4ea", Side="eaeaee",
        Card="fafafa", CardH="f0f0f8", Stroke="d8d8de",
        Text="181820", Dim="8a8a98", SecLbl="2878d8",
        Acc="2878d8", AccD="185098", AccG="2878d8",
        TOn="2878d8", TOff="c8c8d0", Knob="ffffff",
        TBOn="2878d8", TBOff="fafafa", TxtOn="ffffff", TxtOff="8a8a98",
        Div="d4d4dc", InBg="ebebee", Ph="a8a8b4",
        Pill="e4e4ea", NBg="fafafa",
    },
}

-- ── Notifications ─────────────────────────────────────────────────────────────
local _nsg,_nst=nil,{}
local NW,NH,NG=265,58,5

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg=ni("ScreenGui",safeP(),{Name="VulaNotifs",DisplayOrder=200,ResetOnSpawn=false})
    return _nsg
end
local function repack()
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    for i,f in ipairs(_nst) do if f and f.Parent then tw(f,{Position=UDim2.new(1,-6,1-(i*(NH+NG)/vpH),0)},.35,Enum.EasingStyle.Back) end end
end
function Vula:Notify(o)
    local T=o.Title or "Vula";local C2=o.Content or "";local D=o.Duration or 4
    local th=self._theme or rt(Vula.Theme.Default)
    if #_nst>=4 then local x=table.remove(_nst,1);if x and x.Parent then x:Destroy()end end
    local idx=#_nst+1
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    local sy=1-idx*(NH+NG)/vpH
    local f=ni("Frame",getNSG(),{Size=UDim2.new(0,NW,0,NH),Position=UDim2.new(1.08,0,sy,0),AnchorPoint=Vector2.new(1,1),BackgroundColor3=th.NBg,ZIndex=10})
    C(f,9);St(f,th.Stroke,1,.15)
    -- glow top edge
    local g=ni("Frame",f,{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.Acc,BackgroundTransparency=.1,ZIndex=12});C(g,9)
    -- left bar
    local lb=ni("Frame",f,{Size=UDim2.new(0,2,.5,0),Position=UDim2.new(0,7,.25,0),BackgroundColor3=th.Acc,ZIndex=12});C(lb,1)
    local tl=ni("TextLabel",f,{Size=UDim2.new(1,-20,0,17),Position=UDim2.new(0,15,0,7),BackgroundTransparency=1,Text=T,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=12})
    local bl=ni("TextLabel",f,{Size=UDim2.new(1,-20,0,15),Position=UDim2.new(0,15,0,26),BackgroundTransparency=1,Text=C2,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,TextTransparency=1,ZIndex=12})
    local bg=ni("Frame",f,{Size=UDim2.new(1,-14,0,1),Position=UDim2.new(0,7,1,-3),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.Div,ZIndex=12});C(bg,1)
    local bf=ni("Frame",bg,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Acc,ZIndex=13});C(bf,1)
    _nst[idx]=f
    tw(f,{Position=UDim2.new(1,-6,sy,0)},.44,Enum.EasingStyle.Back)
    task.delay(.06,function() tw(tl,{TextTransparency=0},.22);tw(bl,{TextTransparency=.25},.22) end)
    task.delay(.14,function() if bf.Parent then tw(bf,{Size=UDim2.new(0,0,1,0)},D-.14,Enum.EasingStyle.Linear)end end)
    local done=false
    local function dis()
        if done then return end;done=true
        tw(tl,{TextTransparency=1},.16);tw(bl,{TextTransparency=1},.16)
        tw(f,{BackgroundTransparency=1,Position=UDim2.new(1.07,0,sy,0)},.24,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        task.delay(.26,function()
            for i,n in ipairs(_nst) do if n==f then table.remove(_nst,i);break end end
            if f.Parent then f:Destroy()end;repack()
        end)
    end
    f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis()end end)
    task.delay(D,dis);repack()
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title = opts.Name            or "Vula"
    local loadT = opts.LoadingTitle    or title
    local loadS = opts.LoadingSubtitle or "Loading..."
    local tname = opts.Theme           or "Default"
    local th    = rt(Vula.Theme[tname] or Vula.Theme.Default)
    self._theme = th

    -- ── Exact dimensions (from Dex) ───────────────────────────────────────────
    local WW,WH   = 340, 230
    local TOP_H   = 38
    local SIDE_W  = 105
    local PILL_W  = 144
    local PILL_H  = 28

    local par=safeP()
    pcall(function() for _,c in ipairs(par:GetChildren()) do if c.Name=="Vula" then c:Destroy()end end end)
    local sg=ni("ScreenGui",par,{Name="Vula",DisplayOrder=100,ResetOnSpawn=false})

    -- ── Main window ───────────────────────────────────────────────────────────
    local Main=ni("Frame",sg,{
        Name="Main",
        Size=UDim2.new(0,WW,0,WH),
        Position=UDim2.new(.5,3,.5,-38),
        AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=th.Bg,
        ZIndex=2,ClipsDescendants=true,
    })
    C(Main,10)
    St(Main,th.Stroke,1,.2)

    -- ── Subtle noise-like diagonal stripe pattern (purely from frames) ─────────
    -- Top-left corner accent triangle
    do
        local ac=ni("Frame",Main,{
            Size=UDim2.new(0,60,0,60),Position=UDim2.new(0,-18,0,-18),
            BackgroundColor3=th.Acc,BackgroundTransparency=.94,ZIndex=2,
        })
        C(ac,30)
    end

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local TB=ni("Frame",Main,{
        Size=UDim2.new(1,0,0,TOP_H),
        BackgroundColor3=th.Top,ZIndex=5,
    })
    C(TB,10)
    ni("Frame",TB,{Size=UDim2.new(1,0,.5,0),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Top,ZIndex=5})
    -- 1px accent line at very top
    local tline=ni("Frame",TB,{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.Acc,BackgroundTransparency=.05,ZIndex=8})
    -- Bottom divider
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Div,BackgroundTransparency=.3,ZIndex=6})

    -- Badge
    local bdg=ni("Frame",TB,{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,9,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,ZIndex=6})
    C(bdg,11)
    ni("UIGradient",bdg,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",bdg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=11,ZIndex=7})

    -- Title
    ni("TextLabel",TB,{Size=UDim2.new(1,-105,0,18),Position=UDim2.new(0,36,0,4),BackgroundTransparency=1,Text=title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
    ni("TextLabel",TB,{Size=UDim2.new(1,-105,0,11),Position=UDim2.new(0,36,0,23),BackgroundTransparency=1,Text="v3.0",TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

    -- Close + minimize orbs
    local function mkOrb(xOff,col,sym)
        local o=ni("TextButton",TB,{Size=UDim2.new(0,11,0,11),Position=UDim2.new(1,xOff,.5,0),AnchorPoint=Vector2.new(1,.5),BackgroundColor3=col,BackgroundTransparency=.1,Text="",ZIndex=7,AutoButtonColor=false})
        C(o,6)
        local l=ni("TextLabel",o,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=sym,TextColor3=Color3.fromRGB(20,10,10),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})
        o.MouseEnter:Connect(function() tw(o,{BackgroundTransparency=0},.1);tw(l,{TextTransparency=0},.1)end)
        o.MouseLeave:Connect(function() tw(o,{BackgroundTransparency=.1},.1);tw(l,{TextTransparency=1},.1)end)
        return o
    end
    local oClose=mkOrb(-9,Color3.fromRGB(255,59,48),"×")
    local oMin  =mkOrb(-24,Color3.fromRGB(255,149,0),"–")

    -- Topbar drag
    do
        local dr,dsx,dsy,ox,oy=false,0,0,0,0
        TB.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            dr=true;local m=UIS:GetMouseLocation();dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset;oy=Main.Position.Y.Offset
            local c;c=Run.RenderStepped:Connect(function()
                if not dr then c:Disconnect();return end
                local m2=UIS:GetMouseLocation()
                Main.Position=UDim2.new(.5,ox+(m2.X-dsx),.5,oy+(m2.Y-dsy))
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Sidebar ───────────────────────────────────────────────────────────────
    local SB=ni("Frame",Main,{
        Size=UDim2.new(0,SIDE_W,1,-TOP_H),Position=UDim2.new(0,0,0,TOP_H),
        BackgroundColor3=th.Side,ZIndex=4,
    })
    ni("Frame",SB,{Size=UDim2.new(0,8,1,0),Position=UDim2.new(1,-8,0,0),BackgroundColor3=th.Side,ZIndex=4})
    ni("Frame",SB,{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=th.Div,BackgroundTransparency=.25,ZIndex=5})

    local tabSF=ni("ScrollingFrame",SB,{
        Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,
        ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5,
    })
    LL(tabSF,3);Pd(tabSF,6,6,8,6)

    -- ── Content ───────────────────────────────────────────────────────────────
    local Cont=ni("Frame",Main,{
        Size=UDim2.new(1,-SIDE_W,1,-TOP_H),Position=UDim2.new(0,SIDE_W,0,TOP_H),
        BackgroundTransparency=1,ClipsDescendants=true,ZIndex=3,
    })

    -- ── Loading ───────────────────────────────────────────────────────────────
    local LD=ni("Frame",Main,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Bg,ZIndex=25});C(LD,10)
    local ldb=ni("Frame",LD,{Size=UDim2.new(0,40,0,40),Position=UDim2.new(.5,0,.32,0),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,ZIndex=26});C(ldb,20)
    ni("UIGradient",ldb,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",ldb,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=16,ZIndex=27})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,18),Position=UDim2.new(.05,0,.44,0),BackgroundTransparency=1,Text=loadT,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,ZIndex=26})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,14),Position=UDim2.new(.05,0,.56,0),BackgroundTransparency=1,Text=loadS,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,ZIndex=26})
    local lbg=ni("Frame",LD,{Size=UDim2.new(.65,0,0,2),Position=UDim2.new(.175,0,.66,0),BackgroundColor3=th.Div,ZIndex=26});C(lbg,1)
    local lfl=ni("Frame",lbg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,ZIndex=27});C(lfl,1)
    task.spawn(function()
        tw(lfl,{Size=UDim2.new(1,0,1,0)},1.3,Enum.EasingStyle.Quint);task.wait(1.5)
        tw(LD,{BackgroundTransparency=1},.35)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},.25)
            elseif d:IsA("Frame")  then tw(d,{BackgroundTransparency=1},.25)end
        end
        task.wait(.4);LD.Visible=false
    end)

    -- ── Pill ──────────────────────────────────────────────────────────────────
    local Pill=ni("Frame",sg,{
        Size=UDim2.new(0,PILL_W,0,PILL_H),
        Position=UDim2.new(.5,0,1,-20),
        AnchorPoint=Vector2.new(.5,1),
        BackgroundColor3=th.Pill,ZIndex=55,
    })
    C(Pill,PILL_H//2)
    St(Pill,th.Acc,1,.12)
    -- inner gradient tint
    ni("UIGradient",Pill,{
        Rotation=90,
        ColorSequence=ColorSequence.new(th.Acc,th.Pill),
        Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,.88),NumberSequenceKeypoint.new(1,.96)}),
    })
    local pillLbl=ni("TextLabel",Pill,{Size=UDim2.new(1,-6,1,0),Position=UDim2.new(0,3,0,0),BackgroundTransparency=1,Text="▲  "..title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=9,ZIndex=56})

    -- Pill drag
    do
        local dr,dsx,sx=false,0,0;local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            dr=true;dsx=UIS:GetMouseLocation().X;sx=Pill.Position.X.Offset
            if dc then dc:Disconnect()end
            dc=Run.Heartbeat:Connect(function()
                if not dr then dc:Disconnect();return end
                Pill.Position=UDim2.new(.5,sx+(UIS:GetMouseLocation().X-dsx),1,-20)
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Toggle logic ──────────────────────────────────────────────────────────
    local Hidden,Minimised,Deb=false,false,false
    local function open()
        if Deb then return end;Deb=true;Hidden=false
        Main.Visible=true;Main.BackgroundTransparency=1
        tw(Main,{BackgroundTransparency=0},.3);pillLbl.Text="▲  "..title
        task.delay(.32,function() Deb=false end)
    end
    local function close(silent)
        if Deb then return end;Deb=true;Hidden=true
        tw(Main,{BackgroundTransparency=1},.24);pillLbl.Text="▼  "..title
        task.delay(.26,function() Main.Visible=false;Deb=false end)
        if not silent then Vula:Notify({Title="Hidden",Content="RightShift to reopen.",Duration=3})end
    end
    local function toggle() if Hidden then open()else close(true)end end

    oClose.MouseButton1Click:Connect(function() close(true)end)
    oMin.MouseButton1Click:Connect(function()
        Minimised=not Minimised
        if Minimised then
            SB.Visible=false;Cont.Visible=false
            tw(Main,{Size=UDim2.new(0,WW,0,TOP_H)},.25)
        else
            tw(Main,{Size=UDim2.new(0,WW,0,WH)},.35,Enum.EasingStyle.Back)
            task.delay(.15,function() SB.Visible=true;Cont.Visible=true end)
        end
    end)

    local pb=ni("TextButton",Pill,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=57,AutoButtonColor=false})
    pb.MouseButton1Click:Connect(toggle)
    pb.MouseEnter:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W+12,0,PILL_H+3)},.18,Enum.EasingStyle.Back)end)
    pb.MouseLeave:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W,0,PILL_H)},.15)end)
    pb.MouseButton1Down:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W-7,0,PILL_H-3)},.07,Enum.EasingStyle.Quint)end)
    UIS.InputBegan:Connect(function(i,gpe) if gpe then return end;if i.KeyCode==Enum.KeyCode.RightShift then toggle()end end)

    -- ── Tab system ────────────────────────────────────────────────────────────
    local _tabs,_btns,_act={},{},0
    local function selTab(idx)
        if _act==idx then return end
        for i,t in ipairs(_tabs) do
            t.page.Visible=(i==idx)
            local b=_btns[i];if not b then continue end
            local lbl=b:FindFirstChildWhichIsA("TextLabel")
            local bar=b:FindFirstChild("_b")
            if i==idx then
                tw(b,{BackgroundColor3=th.TBOn,BackgroundTransparency=0},.22)
                if lbl then tw(lbl,{TextColor3=th.TxtOn,TextTransparency=0},.18)end
                if bar then tw(bar,{BackgroundTransparency=0},.18)end
            else
                tw(b,{BackgroundColor3=th.TBOff,BackgroundTransparency=.6},.22)
                if lbl then tw(lbl,{TextColor3=th.TxtOff,TextTransparency=.2},.18)end
                if bar then tw(bar,{BackgroundTransparency=1},.18)end
            end
        end
        _act=idx
    end

    local Win={}
    function Win:CreateTab(name)
        local idx=#_tabs+1;local first=(idx==1)
        local btn=ni("TextButton",tabSF,{
            Name="T_"..name,Size=UDim2.new(1,0,0,30),
            BackgroundColor3=first and th.TBOn or th.TBOff,
            BackgroundTransparency=first and 0 or .6,
            Text="",ZIndex=6,AutoButtonColor=false,LayoutOrder=idx,
        });C(btn,7)
        local bar=ni("Frame",btn,{Name="_b",Size=UDim2.new(0,2,.55,0),Position=UDim2.new(0,0,.225,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=first and 0 or 1,ZIndex=7});C(bar,1)
        ni("TextLabel",btn,{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=name,TextColor3=first and th.TxtOn or th.TxtOff,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=first and 0 or .2,ZIndex=7})
        btn.MouseButton1Click:Connect(function() selTab(idx)end)
        btn.MouseEnter:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.25},.14)end end)
        btn.MouseLeave:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.6},.14)end end)

        local page=ni("ScrollingFrame",Cont,{
            Name="P_"..name,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,
            ScrollBarThickness=2,ScrollBarImageColor3=th.Acc,ScrollBarImageTransparency=.45,
            AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),
            Visible=first,ZIndex=4,ClipsDescendants=true,
        })
        LL(page,5);Pd(page,6,6,8,8)

        local tab={page=page,_n=0};_tabs[idx]=tab;_btns[idx]=btn
        if first then _act=1 end
        local function eo() tab._n=tab._n+1;return tab._n end

        -- ── Section ───────────────────────────────────────────────────────────
        function tab:CreateSection(s)
            local sf=ni("Frame",page,{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            ni("TextLabel",sf,{Size=UDim2.new(1,-2,0,12),Position=UDim2.new(0,1,0,3),BackgroundTransparency=1,Text=s:upper(),TextColor3=th.SecLbl,Font=Enum.Font.GothamBold,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5})
            -- accent line
            local dl=ni("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Acc,BackgroundTransparency=.65,ZIndex=5})
        end

        -- ── Toggle ────────────────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local tN=o.Name or "Toggle";local dV=o.CurrentValue or false
            local fl=o.Flag;local cb=o.Callback;local val=dV
            local ROW_H=34

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()});C(row,6)
            local rSt=St(row,th.Stroke,1,.3)
            -- left accent stripe
            local la=ni("Frame",row,{Size=UDim2.new(0,2,.48,0),Position=UDim2.new(0,0,.26,0),BackgroundColor3=th.Acc,BackgroundTransparency=val and .2 or 1,ZIndex=6});C(la,1)
            ni("TextLabel",row,{Size=UDim2.new(1,-64,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=tN,TextColor3=val and th.Text or th.Dim,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local PW,PH,KS=38,20,14;local K0,K1=2,20
            local pill=ni("Frame",row,{Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+8),.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=val and th.TOn or th.TOff,ZIndex=6});C(pill,PH//2)
            local pSt=St(pill,val and th.TOn or th.Stroke,1,val and .4 or .1)
            local knob=ni("Frame",pill,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Knob,ZIndex=7});C(knob,KS//2)
            St(knob,Color3.new(0,0,0),1,.88)

            local tog={CurrentValue=val,Type="Toggle"}
            local function apply(v)
                val=v;tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.TOn or th.TOff},.24)
                tw(pSt,{Color=v and th.TOn or th.Stroke,Transparency=v and .4 or .1},.24)
                tw(la,{BackgroundTransparency=v and .2 or 1},.24)
                tw(rSt,{Color=v and th.Acc or th.Stroke,Transparency=v and .45 or .3},.24)
                tw(knob,{Size=UDim2.new(0,KS*1.32,0,KS*.72)},.06,Enum.EasingStyle.Sine)
                task.delay(.06,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                local tl=row:FindFirstChildWhichIsA("TextLabel")
                if tl then tw(tl,{TextColor3=v and th.Text or th.Dim},.2)end
            end
            function tog:Set(v) apply(v);if cb then cb(v)end end

            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.14)end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.14)end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.85,0,PH*.8)},.06,Enum.EasingStyle.Quint)end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end;busy=true;task.delay(.4,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},.26,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)
            if fl then Vula.Flags[fl]=tog end
            return tog
        end

        -- ── Button ────────────────────────────────────────────────────────────
        function tab:CreateButton(o)
            local bN=o.Name or "Button";local cb=o.Callback
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,32),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true});C(row,6)
            local rSt=St(row,th.Stroke,1,.28)
            local fill=ni("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,BackgroundTransparency=.88,ZIndex=5});C(fill,6)
            ni("TextLabel",row,{Size=UDim2.new(1,-28,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=bN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local arr=ni("TextLabel",row,{Size=UDim2.new(0,18,1,0),Position=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Text="›",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=14,ZIndex=6})
            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function()
                tw(row,{BackgroundColor3=th.CardH},.14);tw(fill,{Size=UDim2.new(1,0,1,0)},.24)
                tw(rSt,{Color=th.Acc,Transparency=.55},.18);tw(arr,{TextColor3=th.Acc},.14)
            end)
            hit.MouseLeave:Connect(function()
                tw(row,{BackgroundColor3=th.Card},.14);tw(fill,{Size=UDim2.new(0,0,1,0)},.18)
                tw(rSt,{Color=th.Stroke,Transparency=.28},.18);tw(arr,{TextColor3=th.Dim},.14)
            end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=ni("Frame",row,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,BackgroundTransparency=.74,ZIndex=10});C(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.2
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},.44,Enum.EasingStyle.Quint)
                task.delay(.46,function() if rip.Parent then rip:Destroy()end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function() if cd then return end;cd=true;task.delay(.26,function() cd=false end);if cb then task.spawn(cb)end end)
            local b={};function b:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel");if l then l.Text=t end end;return b
        end

        -- ── Label ─────────────────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,26),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()});C(row,6);St(row,th.Stroke,1,.42)
            return ni("TextLabel",row,{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text=text,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
        end

        -- ── Keybind ───────────────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local kN=o.Name or "Keybind";local kD=o.CurrentKeybind or "RightShift"
            local fl=o.Flag;local cb=o.Callback;local cur=kD;local lst=false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,34),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()});C(row,6);St(row,th.Stroke,1,.28)
            ni("TextLabel",row,{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=kN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local chip=ni("TextButton",row,{Size=UDim2.new(0,62,0,20),Position=UDim2.new(1,-68,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,Text=cur,TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=7,AutoButtonColor=false});C(chip,4)
            local cSt=St(chip,th.Acc,1,.45)
            chip.MouseButton1Click:Connect(function()
                if lst then return end;lst=true;chip.Text="..."
                tw(chip,{BackgroundColor3=th.Acc},.14);tw(cSt,{Transparency=0},.14)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not lst then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                lst=false;cur=i.KeyCode.Name;chip.Text=cur
                tw(chip,{BackgroundColor3=th.InBg},.14);tw(cSt,{Transparency=.45},.14)
                if cb then cb()end
            end)
            local kb={CurrentKeybind=cur,Type="Keybind"};function kb:Set(v) cur=v;chip.Text=v end
            if fl then Vula.Flags[fl]=kb end;return kb
        end

        -- ── Dropdown (multi-select) ────────────────────────────────────────────
        function tab:CreateDropdown(o)
            local dN    = o.Name    or "Select"
            local opts  = o.Options or {}
            local multi = o.Multi ~= false   -- default multi=true
            local fl    = o.Flag
            local cb    = o.Callback

            local HDRH  = 32   -- header height
            local ITMH  = 26   -- per-item height
            local selected = {}  -- set of selected values

            -- Outer frame — changes height when open/closed
            local open   = false
            local totalH = HDRH + (#opts * ITMH) + 4

            local wrap = ni("Frame", page, {
                Size = UDim2.new(1,0,0,HDRH),
                BackgroundTransparency = 1,
                ZIndex = 5, LayoutOrder = eo(),
                ClipsDescendants = true,
            })

            -- Header card
            local hdr = ni("Frame", wrap, {
                Size=UDim2.new(1,0,0,HDRH),
                BackgroundColor3=th.Card, ZIndex=5,
            }); C(hdr,6)
            local hdrSt = St(hdr, th.Stroke, 1, .28)

            ni("TextLabel",hdr,{Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=dN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local countLbl=ni("TextLabel",hdr,{Size=UDim2.new(0,28,0,16),Position=UDim2.new(1,-36,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,Text="0",TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=7});C(countLbl,4)
            local chevron=ni("TextLabel",hdr,{Size=UDim2.new(0,14,1,0),Position=UDim2.new(1,-16,0,0),BackgroundTransparency=1,Text="▾",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=10,ZIndex=7})

            -- Items container (below header)
            local itemsFrame = ni("Frame", wrap, {
                Size=UDim2.new(1,0,0,#opts*ITMH+4),
                Position=UDim2.new(0,0,0,HDRH+1),
                BackgroundColor3=th.InBg, ZIndex=5,
            }); C(itemsFrame,6)
            St(itemsFrame, th.Stroke, 1, .35)
            LL(itemsFrame, 0)
            Pd(itemsFrame, 4, 4, 2, 2)

            local itemBtns = {}

            local function updateCount()
                local n=0; for _ in pairs(selected) do n=n+1 end
                countLbl.Text=tostring(n)
                tw(countLbl,{BackgroundColor3=n>0 and th.Acc or th.InBg},.18)
                tw(countLbl,{TextColor3=n>0 and Color3.new(1,1,1) or th.Acc},.18)
            end

            for _,optName in ipairs(opts) do
                local name=optName
                local ib = ni("TextButton", itemsFrame, {
                    Size=UDim2.new(1,0,0,ITMH),
                    BackgroundColor3=th.Card, BackgroundTransparency=.7,
                    Text="", ZIndex=6, AutoButtonColor=false,
                }); C(ib,4)

                local chk = ni("Frame",ib,{Size=UDim2.new(0,10,0,10),Position=UDim2.new(0,6,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.TOff,ZIndex=7}); C(chk,3)
                St(chk, th.Acc, 1, .35)
                local chkMark = ni("TextLabel",chk,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})

                ni("TextLabel",ib,{Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,Text=name,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7})

                local function setCheck(v)
                    tw(chk,{BackgroundColor3=v and th.Acc or th.TOff},.18)
                    tw(chkMark,{TextTransparency=v and 0 or 1},.18)
                    local lbl=ib:FindFirstChildWhichIsA("TextLabel")
                    if lbl and lbl~=chkMark then tw(lbl,{TextColor3=v and th.Text or th.Dim},.18)end
                end

                ib.MouseButton1Click:Connect(function()
                    if not multi then
                        -- clear all others
                        for k,_ in pairs(selected) do
                            selected[k]=nil
                            if itemBtns[k] then itemBtns[k](false)end
                        end
                    end
                    selected[name]=not selected[name] or nil
                    setCheck(selected[name]~=nil)
                    if itemBtns[name] then itemBtns[name](selected[name]~=nil)end
                    updateCount()
                    if cb then
                        local sel={}; for k in pairs(selected) do sel[#sel+1]=k end
                        cb(sel)
                    end
                end)
                ib.MouseEnter:Connect(function() tw(ib,{BackgroundTransparency=.4},.12)end)
                ib.MouseLeave:Connect(function() tw(ib,{BackgroundTransparency=.7},.12)end)

                itemBtns[name]=setCheck
            end

            -- Toggle open/close
            local function toggleDD()
                open=not open
                tw(wrap,{Size=UDim2.new(1,0,0,open and totalH or HDRH)},.26,Enum.EasingStyle.Quint)
                tw(chevron,{Rotation=open and 180 or 0},.22)
                tw(hdrSt,{Color=open and th.Acc or th.Stroke,Transparency=open and .45 or .28},.2)
            end

            local hHit=ni("TextButton",hdr,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8,AutoButtonColor=false})
            hHit.MouseButton1Click:Connect(toggleDD)
            hHit.MouseEnter:Connect(function() tw(hdr,{BackgroundColor3=th.CardH},.14)end)
            hHit.MouseLeave:Connect(function() tw(hdr,{BackgroundColor3=th.Card},.14)end)

            local dd={Type="Dropdown",Selected=selected}
            function dd:GetSelected() local s={}; for k in pairs(selected) do s[#s+1]=k end; return s end
            function dd:SetSelected(arr)
                for k in pairs(selected) do selected[k]=nil; if itemBtns[k] then itemBtns[k](false)end end
                for _,v in ipairs(arr) do selected[v]=true; if itemBtns[v] then itemBtns[v](true)end end
                updateCount()
            end
            if fl then Vula.Flags[fl]=dd end
            return dd
        end

        return tab
    end
    return Win
end

_g.VulaLoaded=true;_g.VulaLib=Vula
return Vula

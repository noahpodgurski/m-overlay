local SKIN = gui.newSkin("default")

SKIN.Background = color(255, 255, 255)

SKIN.PanelBackground = color(200, 200, 200)
SKIN.PanelBorder = color(165, 165, 165)
SKIN.PanelFocused = color(0, 162, 232)

SKIN.SubPanelBackground = color(215, 215, 215)

SKIN.FrameBorder = color(100, 100, 100)
SKIN.FrameControlBar = color(225, 225, 225)
SKIN.FrameFocusedControlBar = color(0, 162, 232)

SKIN.ButtonBackground = color(235, 235, 235)
SKIN.ButtonDisabled = color(100, 100, 100, 100)
SKIN.ButtonPressed = color(153, 217, 234)
SKIN.ButtonHover = color(220, 242, 248)

SKIN.ButtonClosePressed = color(243, 105, 113)
SKIN.ButtonCloseHover = color(248, 167, 171)

SKIN.TextEntryBackground = color(255, 255, 255)
SKIN.TextEntryFocused = color(0, 162, 232)

SKIN.ScrollBarGrip = color(235, 235, 235)
SKIN.ScrollBarGripPressed = color(96, 96, 96, 255)
SKIN.ScrollBarGripHover = color(166, 166, 166, 255)

SKIN.CheckboxBorder = color(100, 100, 100)
SKIN.CheckboxOff = color(200, 200, 200)
SKIN.CheckboxOn = color(0, 162, 232)

SKIN.TabActiveColor = color(0, 0, 0, 75)

SKIN.LabelTextColor = color(0, 0, 0)
SKIN.LabelShadowColor = color(100, 100, 100, 100)

SKIN.ToolTipTitleColor = color(0, 178, 255)
SKIN.ToolTipTitleShadowColor = color(100, 100, 100, 100)

SKIN.ToolTipBodyColor = color(0, 0, 0)
SKIN.ToolTipBodyShadowColor = color(100, 100, 100, 100)

SKIN.CheckImage = graphics.newImage("textures/gui/checkmark.png")

function SKIN:InitPanel(panel)
	panel:SetBGColor(self.PanelBackground)
	panel:SetBorderColor(self.PanelBorder)
end

function SKIN:PaintPanel(panel, w, h)
	graphics.setColor(panel:GetBGColor())
	graphics.rectangle("fill", 0, 0, w, h)
end

function SKIN:PaintOverlayPanel(panel, w, h)
	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)
	
	graphics.setColor(panel:GetBorderColor())
	graphics.innerRectangle(0, 0, w, h)
end

function SKIN:PaintSlider(panel, w, h)
	graphics.setColor(self.Background)
	graphics.rectangle("fill", 0, 0, w, h)

	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)
	
	graphics.setColor(panel:GetBorderColor())
	graphics.innerRectangle(0, 0, w, h)
end

function SKIN:PaintOverlayFocusPanel(panel, w, h)
	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)

	if panel:IsEnabled() and panel:HasFocus() then
		graphics.setColor(self.PanelFocused)
		graphics.innerRectangle(0, 0, w, h)
	else
		graphics.setColor(panel:GetBorderColor())
		graphics.innerRectangle(0, 0, w, h)
	end
end

function SKIN:PaintScrollBarButtonUp(panel, w, h)
	self:PaintButton(panel,w,h)
	graphics.setColor(150, 150, 150, 255)
	graphics.polygon('fill', 4, 12, 8, 4, 12, 12)
end

function SKIN:PaintScrollBarButtonDown(panel, w, h)
	self:PaintButton(panel,w,h)
	graphics.setColor(150, 150, 150, 255)
	graphics.polygon('fill', 4, 4, 12, 4, 8, 12)
end

function SKIN:PaintScrollBarGrip(panel, w, h)
	self:PaintButton(panel,w,h)
end

function SKIN:InitButton(panel)
	--[[panel:SetBGColor(self.ButtonBackground)
	panel:SetBorderColor(self.PanelBorder)
	panel:SetPressedColor(self.ButtonPressed)
	panel:SetHoveredColor(self.ButtonHover)]]
end

function SKIN:InitExitButton(panel)
	panel:SetPressedColor(self.ButtonClosePressed)
	panel:SetHoveredColor(self.ButtonCloseHover)
end

function SKIN:PaintButton(panel, w, h)
	local color = self.ButtonBackground

	if panel:IsPressed() then
		color = panel:GetPressedColor() or self.ButtonPressed
	elseif panel:IsHovered() then
		color = panel:GetHoveredColor() or self.ButtonHover
	end

	graphics.setColor(color)
	graphics.rectangle("fill", 0, 0, w, h)

	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)

	graphics.setColor(panel:GetBorderColor() or self.PanelBorder)
	graphics.innerRectangle(0, 0, w, h)
end

function SKIN:PaintTab(panel, w, h)
	local color = self.ButtonBackground

	if panel:IsPressed() then
		color = panel:GetPressedColor() or self.ButtonPressed
	elseif panel:IsHovered() then
		color = panel:GetHoveredColor() or self.ButtonHover
	end

	graphics.setColor(panel:GetBorderColor() or self.PanelBorder)
	graphics.roundRect(0, 0, w, h+8, 8)

	graphics.setColor(color)
	graphics.roundRect(1, 1, w-2, h+6, 8)

	if panel:IsActive() then
		graphics.setColor(panel:GetActiveColor() or self.TabActiveColor)
		graphics.roundRect(1, 1, w-2, h+6, 8)
	end
end

function SKIN:PaintOverlayButton(panel, w, h)
	if not panel:IsEnabled() then
		graphics.setColor(self.ButtonDisabled)
		graphics.rectangle("fill", 0, 0, w, h)
	end
end

function SKIN:PaintFrame(panel, w, h)
	graphics.setColor(self.Background)
	graphics.rectangle("fill", 0, 0, w, h)
	
	graphics.setColor(panel:HasFocus(true) and self.FrameFocusedControlBar or self.FrameControlBar)
	graphics.rectangle("fill", 0, 0, w, 32)

	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)
	
	--[[graphics.setColor(255, 255, 255, 255)
	graphics.innerRectangle(0, 1, w, h - 2)]]
	
	graphics.setColor(panel.m_cBordercolor or self.FrameBorder)
	graphics.innerRectangle(0, 0, w, h)
end

function SKIN:PaintTextEntry(panel, w, h)
	graphics.setColor(self.TextEntryBackground)
	graphics.rectangle("fill", 0, 0, w, h)

	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)

	if panel:HasFocus() then
		graphics.setColor(self.TextEntryFocused)
		graphics.innerRectangle(0, 0, w, h)
	else
		graphics.setColor(panel:GetBorderColor())
		graphics.innerRectangle(0, 0, w, h)
	end
end

function SKIN:PaintCheckBox(panel, w, h)
	graphics.setColor(panel:IsToggled() and self.CheckboxOn or self.CheckboxOff)
	graphics.rectangle("fill", 4, 4, h-8, h-8)

	if panel:IsToggled() then
		graphics.setColor(255, 255, 255, 255)
		graphics.easyDraw(self.CheckImage, 4, 4, 0, h-8, h-8)
	end
	
	graphics.setLineStyle("rough")
	graphics.setLineWidth(1)
	
	graphics.setColor(self.CheckboxBorder)
	graphics.rectangle("line", 4, 4, h-8, h-8)
end

function SKIN:PaintRadioBox(panel, w, h)
	graphics.setColor(panel:IsToggled() and self.CheckboxOn or self.CheckboxOff)
	graphics.circle("fill", 12, 12, h/2-6, 32)

	graphics.setLineStyle("smooth")
	graphics.setLineWidth(1)

	graphics.setColor(self.CheckboxBorder)
	graphics.circle("line", 12, 12, h/2-6, 32)
end

function SKIN:InitHorizontalSelect(panel)
	panel:SetBGColor(self.PanelBackground)
	panel:SetBorderColor(self.PanelBorder)
end

function SKIN:InitLabel(label)
	label:SetTextColor(self.LabelTextColor)
	label:SetShadowColor(self.LabelShadowColor)
end

function SKIN:InitSubPanel(panel)
	panel:SetBGColor(self.SubPanelBackground)
end

function SKIN:InitTooltip(tooltip)
	tooltip:SetTooltipColor(self.SubPanelBackground)
end

function SKIN:InitTooltipTitle(title)
	title:SetShadowColor(self.ToolTipTitleShadowColor)
	title:SetTextColor(self.ToolTipTitleColor)
end

function SKIN:InitTooltipBody(body)
	body:SetShadowColor(self.ToolTipBodyShadowColor)
	body:SetTextColor(self.ToolTipBodyColor)
end
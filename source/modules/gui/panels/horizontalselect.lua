local PANEL = class.create("HorizontalSelect", "Label")

PANEL:ACCESSOR("Selection", "m_iSelection", 1)

function PANEL:HorizontalSelect()
	self:super() -- Initialize our baseclass

	self:SetDrawPanel(true)
	self:SetFocusable(true)
	self:DockPadding(0,0,0,0)
	self:SetBGColor(color_blank)
	self:SetBorderColor(color_blank)
	self:SetTextAlignmentX("center")

	self.m_tOptions = {}

	self.m_pButLeft = self:Add("Button")
	--self.m_pButLeft:SetDrawLabel(false)
	self.m_pButLeft:SetText("<")
	self.m_pButLeft:Dock(DOCK_LEFT)
	self.m_pButLeft:SetWidth(20)
	function self.m_pButLeft:OnClick()
		self:GetParent():SelectLeft()
	end

	self.m_pButRight = self:Add("Button")
	--self.m_pButRight:SetDrawLabel(false)
	self.m_pButRight:SetText(">")
	self.m_pButRight:Dock(DOCK_RIGHT)
	self.m_pButRight:SetWidth(20)
	function self.m_pButRight:OnClick()
		self:GetParent():SelectRight()
	end
end

function PANEL:Skin()
	gui.skinHook("Init", "HorizontalSelect", self)
end

-- Override base class SetEnabled with our own
-- Toggle the left/right buttons at the same time
function PANEL:SetEnabled(b)
	self.m_bEnabled = b
	self.m_pButLeft:SetEnabled(b)
	self.m_pButRight:SetEnabled(b)
end

function PANEL:Paint(w, h)
	self:super("Paint", w, h) -- Paint our label
end

function PANEL:PaintOverlay(w, h)
	gui.skinHook("PaintOverlay", "FocusPanel", self, w, h)
end

function PANEL:AddOption(str, default)
	table.insert(self.m_tOptions, str)
	if default then
		self:SelectOption(#self.m_tOptions)
	end
	self:UpdateSelection()
	return #self.m_tOptions
end

function PANEL:SelectOption(num, force)
	if self.m_iSelection == num and not force then return end
	self.m_iSelection = num
	self:UpdateSelection()
	self:OnSelectOption(self.m_iSelection)
end

function PANEL:OnSelectOption(num)
	-- Override
end

function PANEL:OnMousePressed(x, y, but)
end

function PANEL:UpdateSelection()
	self:SetText(self.m_tOptions[self.m_iSelection])
	self.m_pButLeft:SetEnabled(self.m_iSelection > 1)
	self.m_pButRight:SetEnabled(self.m_iSelection < #self.m_tOptions)
end

function PANEL:SelectLeft()
	self:SelectOption(math.max(1, self.m_iSelection - 1))
end

function PANEL:SelectRight()
	self:SelectOption(math.min(#self.m_tOptions, self.m_iSelection + 1))
end

function PANEL:OnMouseWheeled(x, y)
	if not self:HasFocus() or not self:IsEnabled() then return end
	if y > 0 then
		self:SelectLeft()
	else
		self:SelectRight()
	end
	return true
end

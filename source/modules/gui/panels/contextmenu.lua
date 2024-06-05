local PANEL = class.create("ContextMenu", "Panel")

function PANEL:ContextMenu()
	self:super() -- Initialize our baseclass

	self.m_tEntries = {}

	self:DockPadding(0,0,0,0)

	self:SetWidth(128 + 32)
	self:MakePopup()
end

function PANEL:OnFocusChanged(b)
	-- Remove on focus lost
	if not b then self:Remove() end
end

function PANEL:PerformLayout()
	self:SizeToChildren(false, true)
end

function PANEL:AddSeperator(height)
	local entry = self:Add("Panel")
	entry:SetHeight(height or 4)
	entry:SetBGColor(color_blank)
	entry:SetBorderColor(color_blank)
	entry:DockMargin(0,0,0,0)
	entry:Dock(DOCK_TOP)
end

function PANEL:AddEntry(name, callback)
	local entry = self:Add("Button")
	entry:SetText(name)
	entry:SetBGColor(color_blank)
	entry:SetBorderColor(color_blank)
	entry:DockMargin(0,0,0,0)
	entry:Dock(DOCK_TOP)

	self.m_tEntries[name] = callback

	entry.OnClick = function(this)
		self:OnEntryClicked(name, this)
		if self.m_tEntries[name] then
			self.m_tEntries[name](panel)
		end
	end

	return entry
end

function PANEL:OnEntryClicked(name, panel)
end

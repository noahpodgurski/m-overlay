local PANEL = class.create("ScrollPanel", "Panel")

function PANEL:ScrollPanel()	
	self:super() -- Initialize our baseclass
	self:DockPadding(0,0,0,0)
	self:SetBGColor(color(215, 0, 0))

	self.m_pCanvas = self:Add("Panel")
	self.m_pCanvas:SetBGColor(color(215, 215, 215))

	self.m_pCanvas.PerformLayout = function(this)
		this:SizeToChildren(false, true)
		if self.m_bNoSizing and this:GetHeight() < self:GetHeight() then
			this:SetPos(0, (self:GetHeight()-this:GetHeight()) * 0.5)
		end
	end
	
	-- Create the scroll bar
	self.m_pVBar = self:Add("ScrollBar")
	self.m_pVBar:DockMargin(-1,0,0,0)
	self.m_pVBar:Dock(DOCK_RIGHT)

	-- Disable us from setting padding after creation
	self.DockPadding = function() end

	-- Adding things to the ScrollPanel will actually be adding it to the canvas
	self.Add = function(this, class)
		return this.m_pCanvas:Add(class)
	end
end

function PANEL:OnChildAdded(child)
end

function PANEL:SizeToContents()
	self:SetSize(self.m_pCanvas:GetSize())
end

function PANEL:GetVBar()
	return self.m_pVBar
end

function PANEL:GetCanvas()
	return self.m_pCanvas
end

function PANEL:InnerWidth()
	return self:GetCanvas():GetWidth()
end

function PANEL:Rebuild()
end

function PANEL:OnMouseWheeled(x, y)
	return self.m_pVBar:OnMouseWheeled(x, y)
end

function PANEL:OnVScroll(iOffset)
	self.m_pCanvas:SetPos(0, iOffset)
end

function PANEL:ScrollToChild(panel)
	self:PerformLayout()

	local x, y = self.m_pCanvas:GetChildPosition(panel)
	local w, h = panel:GetSize()

	y = y + h * 0.5;
	y = y - self:GetHeight() * 0.5;

	self.m_pVBar:SetY(y)
	--self.m_pVBar:AnimateTo(y, 0.5, 0, 0.5);
end

function PANEL:PerformLayout()
	local wide = self:GetWidth()
	local ypos = 0
	local xpos = 0

	self.m_pVBar:SetUp(self:GetHeight(), self.m_pCanvas:GetHeight())
	ypos = self.m_pVBar:GetOffset()

	if self.m_pVBar.m_bEnabled then
		wide = wide - self.m_pVBar:GetWidth()
		wide = wide - self.m_pVBar.m_tDockMargins.left - self.m_pVBar.m_tDockMargins.right
	end

	self.m_pCanvas:SetPos(0, ypos)
	self.m_pCanvas:SetWidth(wide)
	self.m_pCanvas:InvalidateLayout()
end

function PANEL:SetScroll(scroll)
	self.m_pVBar:SetScroll(scroll)
end

function PANEL:Clear()
	self.m_pVBar:SetScroll(0)
	self.m_pCanvas:Clear()
	self:InvalidateLayout()
end

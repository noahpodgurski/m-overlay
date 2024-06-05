-- Naruto - Clash of Ninja Revolution 3 (PAL v1.0)

local core = require("games.core")

local game = core.newGame()

local polling_addresses = {
	0x803BE480,
	0x803BE4B0,
}

local controllers = {
	[1] = 0xC * 0,
	[2] = 0xC * 1,
	[3] = 0xC * 2,
	[4] = 0xC * 3,
}

local controller_struct = {
	[0x0] = { type = "short",	name = "controller.%d.buttons.pressed" },
	[0x2] = { type = "sbyte",	name = "controller.%d.joystick.x" },
	[0x3] = { type = "sbyte",	name = "controller.%d.joystick.y" },
	[0x4] = { type = "sbyte",	name = "controller.%d.cstick.x" },
	[0x5] = { type = "sbyte",	name = "controller.%d.cstick.y" },
	[0x6] = { type = "byte",	name = "controller.%d.analog.l" },
	[0x7] = { type = "byte",	name = "controller.%d.analog.r" },
	[0xA] = { type = "byte",	name = "controller.%d.plugged" },
}

for _, polling_addr in ipairs(polling_addresses) do
	-- For every polling address..
	for port, controller_addr in ipairs(controllers) do
		-- For every controller 
		for offset, info in pairs(controller_struct) do
			game.memorymap[polling_addr + controller_addr + offset] = {
				type = info.type,
				debug = info.debug,
				name = info.name:format(port),
			}
		end
	end
end

function game.translateJoyStick(x, y)
	x = x/100
	y = y/100
	return x, y
end

game.translateCStick = game.translateJoyStick

return game
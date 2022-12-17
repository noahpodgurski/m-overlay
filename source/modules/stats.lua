local melee = require("melee")
local json = require("serializer.json")
local http = require("socket.http")
function grabUserStats(userCode)
	-- convert üö to #
	userCode = string.gsub(userCode, "üö", "#")
	userCode = melee.convertStr(userCode)

	-- remove all empty spaces
	local trailingEmptySpaces = 0
	for i = 1, string.len(userCode) do
		local c = string.sub(userCode, i, i)
		if string.byte(c) == 0 then
			trailingEmptySpaces = trailingEmptySpaces + 1
		end
	end
	-- print(string.format("found %d trailing empty spaces", trailingEmptySpaces))
	userCode = string.sub(userCode, 1, string.len(userCode)-trailingEmptySpaces)

	-- userCode: 'xxx#123'
	local response_body = {}
	local request_body = {
		operationName = "AccountManagementPageQuery", 
		variables = {
			cc = string.format("%s", userCode),
			uid = string.format("%s", userCode)
		}, 
		query = "fragment userProfilePage on User {\n  fbUid\n  displayName\n  connectCode {\n    code\n    __typename\n  }\n  status\n  activeSubscription {\n    level\n    hasGiftSub\n    __typename\n  }\n  rankedNetplayProfile {\n    id\n    ratingOrdinal\n    ratingUpdateCount\n    wins\n    losses\n    dailyGlobalPlacement\n    dailyRegionalPlacement\n    continent\n    characters {\n      id\n      character\n      gameCount\n      __typename\n    }\n    __typename\n  }\n  __typename\n}\n\nquery AccountManagementPageQuery($cc: String!, $uid: String!) {\n  getUser(fbUid: $uid) {\n    ...userProfilePage\n    __typename\n  }\n  getConnectCode(code: $cc) {\n    user {\n      ...userProfilePage\n      __typename\n    }\n    __typename\n  }\n}\n"
	}
	request_body = json.encode(request_body)
	-- print(request_body)

	local res = http.request({
		url = 'https://gql-gateway-dot-slippi.uc.r.appspot.com/graphql',
		method = "POST",
		headers = {
			["Content-Type"] = "application/json",
			["Content-Length"] = string.len(request_body)
		},
		source = ltn12.source.string(request_body),
		sink = ltn12.sink.table(response_body)
	})
	response_body = json.decode(response_body[1])
	
	if not response_body.data then return {'', ''} end
	return {response_body.data.getConnectCode.user.displayName, math.floor(response_body.data.getConnectCode.user.rankedNetplayProfile.ratingOrdinal)}
end
local _ecs = {}
_ecs.entity = {}
_ecs.system = {}


local function entityHasComponents(inst, comp)
	local r = true
	for l, v in ipairs(comp) do
		if inst[v] == nil then
			r = false
			break
		end
	end
	return r
end

function _ecs.systemLoad(filename)
	table.insert(_ecs.system, require(filename))
end
function _ecs.entityNew(inst)
	table.insert(_ecs.entity, inst)
end

function _ecs.update(_dt)
	for _, sys in ipairs(_ecs.system) do
		for __, inst in ipairs(_ecs.entity) do
			if entityHasComponents(inst, sys.requires) then
				sys.update(inst, _dt)
			end
		end
	end
end
function _ecs.draw()
	for _, sys in ipairs(_ecs.system) do
		for __, inst in ipairs(_ecs.entity) do
			if entityHasComponents(inst, sys.requires) then
				sys.draw(inst, _dt)
			end
		end
	end
end


return _ecs
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Class = require(ReplicatedStorage.common.packages.Class)

local Future = Class:create()


function Future:new()
	return self:create()
end

function Future:Await(timeout)
	local start = os.clock()
	while true do
		if self.ValueExists or self.ErrorExists then
			break
		end
		local elapsed = os.clock() - start
		if elapsed >= timeout then
			self:CompleteError("Timed out")
			break
		end
		task.wait()
	end
end

function Future:Resolve(funcValue, funcError)
	if self.ValueExists and funcValue then
		funcValue(self.Value)
	elseif self.ErrorExists and funcError then
		funcError(self.Error)
	end
end

function Future:BindValue(func)
	self.ValueCallback = func
end

function Future:CompleteValue(value)
	self.ValueExists = true
	self.Value = value
	if self.ValueCallback then
		self:ValueCallback()
	end
end

function Future:BindError(func)
	self.ErrorCallback = func
end

function Future:CompleteError(error)
	self.ErrorExists = true
	self.Error = error
	if self.ErrorCallback then
		self:ErrorCallback()
	end
end


return Future
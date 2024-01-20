# Future
A simple library made to assist with asynchronous tasking.

## Installation
To install:
1. [Install the dependencies](#dependencies)
2. [Build the project](#building)
3. Import `build/Future.rbxm` into `DataModel/ReplicatedStorage/common/packages`

## Dependencies
1. `Class`

## Building
Run the `Build` task or `./build.ps1`

## Usage
To create a Future, call `Future:new()`.
```lua
local future = Future:new()
```
To hang the thread until a value exists (or timed out), call `Future:await(timeout)`. Calling `Future:resolve(funcValue(value), funcError(error))` will call the first argument if there is a value, and the second if there is an error.
```lua
...
future:await(timeout)
future:resolve(function(value)
	print("Value:", value)
end, function(error)
	print("Error:", error)
end)
```
When the future is completed with a value, `ValueExists` will become `true` and `Value` will be the contained value. The same applies to errors (`ErrorExists` and `Error` respectively). Additionally, when the future is completed with either a value or error, the respective callback (`ValueCallback(self)`, `FutureCallback(self)`) will be invoked. Callbacks can be bound with `BindValue` and `BindError`.
```lua
local future = Future:new()
future:bindValue(function(self)
	print(self.Value)
end)
future:completeValue("Hello World!")
--[[
	>lua ...
	Hello World!
]]
```
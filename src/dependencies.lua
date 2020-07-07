-- "push" library will allow us to draw our game at a virtual resolution, instead of original window resolution
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- "Class" library will allow us to create classes
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

require 'src/Paddle'
require 'src/Ball'

require 'src/constants'
require 'src/helperFunctions'
require 'src/StateMachine'

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/ServeState'
require 'src/states/PlayState'
require 'src/states/GameEndState'

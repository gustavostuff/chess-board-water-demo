function love.conf(t)
  t.identity = nil
  t.appendidentity = false
  t.version = '11.3'
  t.console = false
  t.accelerometerjoystick = true
  t.externalstorage = false
  t.gammacorrect = false

  t.audio.mic = false
  t.audio.mixwithsystem = true

  t.window.title = 'Cavnue chess board Test'
  t.window.icon = nil
  t.window.width = 320 * 3
  t.window.height = 180 * 3
  t.window.borderless = true
  t.window.resizable = false
  t.window.minwidth = 1 
  t.window.minheight = 1
  t.window.fullscreen = true
  t.window.fullscreentype = 'desktop'
  t.window.vsync = 1
  t.window.msaa = 0
  t.window.depth = 16
  t.window.stencil = nil
  t.window.display = 1
  t.window.highdpi = false
  t.window.usedpiscale = true
  t.window.x = 100
  t.window.y = 100

  t.modules.audio = true
  t.modules.data = true
  t.modules.event = true
  t.modules.font = true
  t.modules.graphics = true
  t.modules.image = true
  t.modules.joystick = true
  t.modules.keyboard = true
  t.modules.math = true
  t.modules.mouse = true
  t.modules.physics = false
  t.modules.sound = false
  t.modules.system = true
  t.modules.thread = true
  t.modules.timer = true
  t.modules.touch = true
  t.modules.video = true
  t.modules.window = true
end

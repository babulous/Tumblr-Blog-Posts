-- this represents moving forward one frame
function Step()
  -- this "pauses" the coroutine until the next time coroutine.resume is called
  coroutine.yield()
end

-- wait for a certain amount of time in seconds
function Wait(t)
  while t > 0 do
    t = t - FrameDT
    Step()
  end
end


local timeline = coroutine.create(function()
  print("Hello!")
  Wait(2)
  print("How are you?")
  Wait(2)
  print("I like you.")
  Wait(3)
  print("Okay, bye.")
  Wait(2)
end)

function love.load()
  io.output():setvbuf("no")
end

function love.update(dt)
  FrameDT = dt -- so we can make use of dt outside of love.update

  if coroutine.status(timeline) == "suspended" then
    local success, err = coroutine.resume(timeline)
    -- error checking, good practice
    if not success then
      error(err)
    end
  else
    love.event.quit()
  end
end
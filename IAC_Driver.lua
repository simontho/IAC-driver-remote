-- IAC Driver Lua Codec
-- Apple Inc. IAC Bus virtual MIDI loopback
-- CC1-127 on any channel → Reason Remote control surface items

function remote_init(manufacturer, model)
  local items = {}
  for i = 1, 127 do
    items[i] = { name = "CC" .. i, input = "value", min = 0, max = 127 }
  end
  remote.define_items(items)

  -- Auto-input patterns: "b?" matches CC on any channel
  -- CC numbers 1-127 in hex: 01..7f
  local inputs = {}
  for i = 1, 127 do
    inputs[i] = {
      pattern = string.format("b? %02x xx", i),
      name = "CC" .. i
    }
  end
  remote.define_auto_inputs(inputs)
end

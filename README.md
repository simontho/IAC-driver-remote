# Apple IAC Driver — Reason Remote Map

A Reason Remote codec and remotemap for the **Apple IAC Driver** virtual MIDI device,
enabling persistent, per-device CC parameter mappings via MIDI loopback.

Inspired by [Poohbear's MIDI loopback technique](https://www.youtube.com/results?search_query=poohbear+midi+loopback+reason).

---

## What is this?

Reason's Remote system lets you assign a hardware controller to specific parameters on
specific devices — and save those assignments to a file. This project brings that same
workflow to the **IAC Driver**, Apple's built-in virtual MIDI bus, so you can use MIDI
loopback with saved, per-device mappings instead of manual remote overrides every session.

**Example:** When a Europa synth is selected in Reason, CC1 is always mapped to Filter
Frequency and CC2 to Filter Resonance — automatically, with no setup required each time.

---

## How MIDI loopback works in Reason

Reason has a known limitation: automation data sent from one device to another *inside*
Reason cannot be recorded as MIDI data in the sequencer. The MIDI loopback technique works
around this:

```
Reason MIDI Out device
  → sends CC data out of Reason
    → IAC Driver (virtual MIDI bus, macOS built-in)
      → loops back into Reason as external MIDI input
        → triggers Remote-mapped parameters on the target device
          → record the target device track → automation is captured as MIDI CC
```

The IAC Driver acts as a virtual cable from Reason back to itself. Because Reason sees the
returning signal as an "external" MIDI controller, it routes through the Remote system and
records normally.

This remotemap eliminates the manual step of setting a remote override for each parameter
every session — mappings are defined once in the file and load automatically.

---

## Devices covered

| Device | Developer | CC Range |
|---|---|---|
| Combinator | Propellerheads | CC1–20 |
| Thor Polysonic Synthesizer | Propellerheads | CC1–20 |
| Europa | Propellerhead Software | CC1–20 |
| Malstrom Graintable Synthesizer | Propellerheads | CC1–20 |
| Macro Synthesizer | Presteign Sound Labs | CC1–20 |

---

## Files

| File | Description |
|---|---|
| `Apple_Inc_IAC_Driver.remotemap` | Remote Map — CC1–20 parameter mappings for each device scope |
| `IAC_Driver.lua` | Lua Codec — defines CC1–127 items and MIDI input patterns |
| `IAC_Driver.luacodec` | Codec entry point — registers "Apple Inc. / IAC Driver" in Reason Preferences |
| `README.md` | This file |

---

## Setup

### Step 1 — Enable the IAC Driver (macOS)

1. Open **Audio MIDI Setup** (Applications → Utilities → Audio MIDI Setup)
2. Go to **Window → Show MIDI Studio**
3. Double-click **IAC Driver**
4. Check **Device is online**
5. Confirm at least one port exists (e.g. "Bus 1") — add one if the list is empty

### Step 2 — Install the codec files

Copy `IAC_Driver.lua` and `IAC_Driver.luacodec` to:

```
/Library/Application Support/Propellerhead Software/Remote/Codecs/Lua Codecs/Apple Inc/
```

> Create the `Apple Inc` folder if it doesn't exist. The folder name must match exactly.

### Step 3 — Install the remotemap

Copy `Apple_Inc_IAC_Driver.remotemap` to:

```
/Library/Application Support/Propellerhead Software/Remote/Maps/Apple Inc/
```

> Again, create the `Apple Inc` folder if needed.

### Step 4 — Add the control surface in Reason

1. Do a **full Reason restart** (quit and relaunch — not just Preferences reload)
2. Go to **Preferences → Keyboard and Control Surfaces**
3. Click **Add Manually**
4. Set Manufacturer to **Apple Inc.** and Model to **IAC Driver**
5. Set the MIDI Input to **IAC Driver Bus 1** (or whichever port you enabled)
6. Click **OK**

### Step 5 — Set up MIDI Out in Reason

1. Add a **MIDI Out** device to your rack (Create → Utilities → MIDI Out)
2. Set its MIDI destination to **IAC Driver Bus 1**
3. Route a CV signal (from an LFO, Matrix sequencer, CV automation, etc.) into the MIDI
   Out device's CC inputs

### Step 6 — Lock the surface and record

1. In the sequencer, **right-click the target device track** → **Lock Control Surface** →
   select **IAC Driver**
2. The CC assignments defined in this remotemap will activate for that device
3. Arm the target device's track for recording
4. Play — incoming CC data will be recorded as MIDI automation in the sequencer

---

## CC Mapping Reference

### Combinator
*Scope: `Propellerheads / Combinator`*
> CC1–20 map to Rotary 1–20 — generic catch-all for internal patch routing.

| CC | Parameter |
|---|---|
| CC1–CC20 | Rotary 1–20 |

---

### Thor Polysonic Synthesizer
*Scope: `Propellerheads / Thor Polysonic Synthesizer`*

| CC | Parameter | Group |
|---|---|---|
| CC1 | Filter 1 Freq | Filter 1 |
| CC2 | Filter 1 Res | Filter 1 |
| CC3 | Filter 1 Env Amount | Filter 1 |
| CC4 | Filter 1 Drive | Filter 1 |
| CC5 | Amp Env Attack | Amp Envelope |
| CC6 | Amp Env Decay | Amp Envelope |
| CC7 | Amp Env Sustain | Amp Envelope |
| CC8 | Amp Env Release | Amp Envelope |
| CC9 | Filter Env Attack | Filter Envelope |
| CC10 | Filter Env Decay | Filter Envelope |
| CC11 | Filter Env Sustain | Filter Envelope |
| CC12 | Filter Env Release | Filter Envelope |
| CC13 | Osc 1 Mod | Oscillators |
| CC14 | Osc 2 Mod | Oscillators |
| CC15 | Osc 3 Mod | Oscillators |
| CC16 | LFO 1 Rate | LFOs |
| CC17 | LFO 2 Rate | LFOs |
| CC18 | Master Level | Global |
| CC19 | Portamento | Global |
| CC20 | Mod Wheel | Global |

---

### Europa
*Scope: `Propellerhead Software / se.propellerheads.Europa`*

| CC | Parameter | Group |
|---|---|---|
| CC1 | Filter Freq | Filter |
| CC2 | Filter Reso | Filter |
| CC3 | Filter Drive | Filter |
| CC4 | Filter Mod | Filter |
| CC5 | Amp Attack | Amp Envelope |
| CC6 | Amp Decay | Amp Envelope |
| CC7 | Amp Sustain | Amp Envelope |
| CC8 | Amp Release | Amp Envelope |
| CC9 | LFO 1 Rate | LFOs |
| CC10 | LFO 1 Delay | LFOs |
| CC11 | LFO 2 Rate | LFOs |
| CC12 | LFO 2 Delay | LFOs |
| CC13 | Osc1 Shape | Oscillators |
| CC14 | Osc1 Shape Amt | Oscillators |
| CC15 | Osc2 Shape | Oscillators |
| CC16 | Osc2 Shape Amt | Oscillators |
| CC17 | Master Volume | Global |
| CC18 | Pan | Global |
| CC19 | Portamento | Global |
| CC20 | Mod Wheel | Global |

---

### Malstrom Graintable Synthesizer
*Scope: `Propellerheads / Malstrom Graintable Synthesizer`*

| CC | Parameter | Group |
|---|---|---|
| CC1 | Filter A Freq | Filters |
| CC2 | Filter A Resonance | Filters |
| CC3 | Filter B Freq | Filters |
| CC4 | Filter B Resonance | Filters |
| CC5 | Oscillator A Attack | Osc A Envelope |
| CC6 | Oscillator A Decay | Osc A Envelope |
| CC7 | Oscillator A Sustain | Osc A Envelope |
| CC8 | Oscillator A Release | Osc A Envelope |
| CC9 | Oscillator B Attack | Osc B Envelope |
| CC10 | Oscillator B Decay | Osc B Envelope |
| CC11 | Oscillator B Sustain | Osc B Envelope |
| CC12 | Oscillator B Release | Osc B Envelope |
| CC13 | Modulator A Rate | Modulator A |
| CC14 | Modulator A To Pitch | Modulator A |
| CC15 | Modulator A To Index | Modulator A |
| CC16 | Modulator A To Shift | Modulator A |
| CC17 | Master Level | Global |
| CC18 | Spread Amount | Global |
| CC19 | Portamento | Global |
| CC20 | Mod Wheel | Global |

---

### Macro Synthesizer
*Scope: `Presteign Sound Labs / com.presteign.Macro`*

| CC | Parameter | Group |
|---|---|---|
| CC1 | Engine A | Engines |
| CC2 | Engine B | Engines |
| CC3 | Engine C | Engines |
| CC4 | Mix | Engines |
| CC5 | Spread | Global |
| CC6 | Filter | Filter |
| CC7 | Attack/Transient | Envelope |
| CC8 | Release | Envelope |
| CC9 | Velocity Amp | Velocity |
| CC10 | Velocity Gen B | Velocity |
| CC11 | Velocity Gen C | Velocity |
| CC12 | Env Engine Gen A | Envelopes |
| CC13 | Env Engine Gen B | Envelopes |
| CC14 | Env Engine Gen C | Envelopes |
| CC15 | Mod Wheel Gen A | Mod |
| CC16 | Mod Wheel | Mod |
| CC17 | Volume | Global |
| CC18 | Semi | Pitch |
| CC19 | Cent | Pitch |
| CC20 | Pitch Bend | Global |

---

## Troubleshooting

**IAC Driver doesn't appear in Reason Preferences → Add Manually**
- Confirm both `IAC_Driver.lua` and `IAC_Driver.luacodec` are in the same folder under `Lua Codecs/Apple Inc/`
- The folder must be named exactly `Apple Inc` — Reason's lookup is case-sensitive
- Do a full Reason quit and relaunch — toggling the surface in Preferences is not sufficient

**"Not able to find remotemap for device" after adding the surface**
- Confirm `Apple_Inc_IAC_Driver.remotemap` is in `Remote/Maps/Apple Inc/`
- The remotemap header's `Control Surface Manufacturer` and `Control Surface Model` fields must match the `.luacodec` values exactly (they do in this release, but verify if you've edited either file)
- Full restart required after any file change

**CC signals arrive at the IAC Driver but parameters don't move**
- Confirm the IAC Driver control surface is locked to the target device track (right-click track → Lock Control Surface)
- Check that your MIDI Out device in the rack is sending to **IAC Driver Bus 1** (same port set in Preferences)
- Open a MIDI monitor to confirm CC messages are arriving on the expected channel; the codec accepts any channel (`b?` wildcard)

**A device scope isn't responding even though the surface is locked**
- The device must be one of the five scopes listed above
- Scope strings are exact — if you've renamed a device or are using a different version of a Rack Extension, the scope may not match. Use **File → Export Device Remote Info** to verify the exact manufacturer and model strings Reason expects.

**Codec defines CC1–127 but remotemap only uses CC1–20 — is that intentional?**
- Yes. The codec is built to support CC1–127 so the remotemap can be extended without needing to reinstall the codec. Only CC1–20 are mapped in this release. To add more mappings, edit the remotemap and reinstall it — no codec change needed.

---

## Extending the map

To add a new device scope or expand the CC range:

1. In Reason, load the target device → **File → Export Device Remote Info** to get exact parameter names and scope strings
2. Add a new `Scope` block to `Apple_Inc_IAC_Driver.remotemap` using those exact strings
3. Copy the updated remotemap to the install path
4. Full Reason restart
5. If adding CCs above 127, the codec would also need updating — but CC1–127 is the full MIDI CC range, so that shouldn't be necessary

Run the duplicate-detection script below before reinstalling if you've edited the remotemap manually:

```python
with open("Apple_Inc_IAC_Driver.remotemap") as f:
    lines = f.readlines()

scope = None
seen = {}
for i, l in enumerate(lines, 1):
    l = l.rstrip()
    if l.startswith("Scope\t"):
        scope = l.split("\t")[2]
        seen = {}
    elif l.startswith("Map\t"):
        parts = l.split("\t")
        param = parts[3] if len(parts) >= 4 else ""
        if param in seen:
            print(f"Line {i}: DUPLICATE '{param}' in [{scope}] (first at line {seen[param]})")
        else:
            seen[param] = i
```

---

## Compatibility

- macOS only (IAC Driver is Apple-native; Windows users can substitute loopMIDI or similar)
- Tested on Reason 12 and 13
- Codec supports CC1–127 on any MIDI channel

---

## License

MIT

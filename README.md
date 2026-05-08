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

**14 device scopes · 677 parameter mappings · CC1–127**

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

| Device | Developer | Mappings | Max CC |
|---|---|---|---|
| Combinator | Propellerheads | 66 | CC66 |
| Thor Polysonic Synthesizer | Propellerheads | 83 | CC83 |
| Europa | Propellerhead Software | 80 | CC80 |
| Malstrom Graintable Synthesizer | Propellerheads | 54 | CC54 |
| Macro Synthesizer | Presteign Sound Labs | 22 | CC22 |
| SubTractor Analog Synthesizer | Propellerheads | 46 | CC46 |
| Kong Drum Designer | Propellerheads | 54 | CC54 |
| Dr.REX Loop Player | Propellerheads | 32 | CC32 |
| Monotone | Propellerhead Software | 39 | CC39 |
| Alligator Filter Gate | Propellerheads | 47 | CC47 |
| Bassline Generator | Propellerhead Software | 35 | CC35 |
| Chord Sequencer | Propellerhead Software | 36 | CC36 |
| Dual Arpeggio | Propellerhead Software | 23 | CC23 |
| EDS06s Drum Synth | Ochen K. | 60 | CC60 |
| **Total** | | **677** | |

CC slots above each device's max are unassigned and available for per-session right-click →
Edit Remote Override mappings.

---

## Files

| File | Description |
|---|---|
| `Apple_Inc_IAC_Driver.remotemap` | Remote Map — CC1–127 parameter mappings for 14 device scopes |
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
5. Confirm at least two ports exist: **Bus 1** (input) and **IAC Bus 2** (output) — add them if the list is empty

### Step 2 — Install the codec files

Copy `IAC_Driver.lua` and `IAC_Driver.luacodec` to:

```
/Library/Application Support/Propellerhead Software/Remote/Codecs/Lua Codecs/Apple Inc./
```

> Both files must be in the same `Apple Inc.` subfolder. Create it if it doesn't exist — the name must match exactly.

### Step 3 — Install the remotemap

Copy `Apple_Inc_IAC_Driver.remotemap` to:

```
/Library/Application Support/Propellerhead Software/Remote/Maps/Apple Inc./
```

### Step 4 — Full Reason restart

Required after any codec install or update. Toggling the surface in Preferences is **not** sufficient — quit and relaunch Reason.

### Step 5 — Add the control surface in Reason

1. Go to **Preferences → Keyboard and Control Surfaces**
2. Click **Add** (or **Add Manually**)
3. Set Manufacturer to **Apple Inc.** and Model to **IAC Driver**
4. Set the MIDI Input to **IAC Driver Bus 1**
5. Click **OK**

> **Updating an existing installation:** Remove the existing IAC Driver surface entry, replace both codec files, restart Reason, then re-add.

### Step 6 — Set up MIDI Out in Reason

1. Add a **MIDI Out** device to your rack (Create → Utilities → MIDI Out)
2. Set its MIDI destination to **IAC Driver Bus 1**
3. Route a CV signal (from an LFO, Matrix sequencer, CV automation, etc.) into the MIDI Out device's CC inputs

### Step 7 — Lock the surface and record

1. In the sequencer, **right-click the target device track** → **Lock Control Surface** → select **IAC Driver**
2. The CC assignments defined in this remotemap activate automatically for that device
3. Arm the target device's track for recording
4. Play — incoming CC data records as MIDI automation in the sequencer

---

## CC Mapping Reference

### Combinator
`Propellerheads` / `Combinator`

| CC | Parameter |
|---|---|
| CC1–32 | Rotary 1–32 |
| CC33–64 | Button 1–32 |
| CC65 | Mod Wheel |
| CC66 | Mixer Level |

> The Combinator scope is the most flexible option for custom per-patch routing — wire Rotaries to any internal device parameters via the Combinator Programmer.

---

### Thor Polysonic Synthesizer
`Propellerheads` / `Thor Polysonic Synthesizer`

| CC | Parameter | Group |
|---|---|---|
| CC1–6 | Filter 1 Freq, Res, Env Amount, Drive, Kbd, Velocity | Filter 1 |
| CC7–12 | Filter 2 Freq, Res, Env Amount, Drive, Kbd, Velocity | Filter 2 |
| CC13–16 | Filter 3 Freq, Res, Env Amount, Drive | Filter 3 |
| CC17–20 | Amp Env Attack, Decay, Sustain, Release | Amp Envelope |
| CC21–23 | Amplifier Gain, Velocity, Pan | Amplifier |
| CC24–27 | Filter Env Attack, Decay, Sustain, Release | Filter Envelope |
| CC28–31 | Mod Env Attack, Decay, Release, Delay | Mod Envelope |
| CC32–35 | Global Env Attack, Decay, Sustain, Release | Global Envelope |
| CC36–39 | Osc 1 Mod, Semi, Tune, Oct | Oscillator 1 |
| CC40–44 | Osc 2 Mod, Semi, Tune, Oct, Sync BW | Oscillator 2 |
| CC45–49 | Osc 3 Mod, Semi, Tune, Oct, Sync BW | Oscillator 3 |
| CC50–52 | Osc 1&2 Level, Balance, Osc3 Level | Osc Mix |
| CC53–56 | LFO 1 Rate, Delay, Waveform, KbdFollow | LFO 1 |
| CC57–59 | LFO 2 Rate, Delay, Waveform | LFO 2 |
| CC60 | Shaper Drive | Shaper |
| CC61–65 | Chorus Rate, Amt, Dry/Wet, Delay, Feedback | Chorus |
| CC66–69 | Delay Time, Amt, Feedback, Dry/Wet | Delay |
| CC70–76 | Mod 1–7 Dest Amount | Mod Matrix |
| CC77–78 | Rotary 1–2 | Rotaries |
| CC79–80 | Step Seq Step Count, Rate | Step Sequencer |
| CC81–83 | Master Level, Portamento, Mod Wheel | Global |

---

### Europa
`Propellerhead Software` / `se.propellerheads.Europa`

| CC | Parameter | Group |
|---|---|---|
| CC1–6 | Filter Freq, Reso, Drive, Mod, Kbd, Vel | Global Filter |
| CC7–14 | Amp Attack, Decay, Sustain, Release, Gain, Velocity, Pan, Master Volume | Amp |
| CC15–17 | LFO 1 Rate, Delay, Wave | LFO 1 |
| CC18–20 | LFO 2 Rate, Delay, Wave | LFO 2 |
| CC21–23 | LFO 3 Rate, Delay, Wave | LFO 3 |
| CC24–34 | Osc1 Shape, Shape Amt, Tune, Semi, Oct, Level, Pan, Detune, Spread, Filter Freq, Filter Reso | Oscillator 1 |
| CC35–45 | Osc2 (same layout) | Oscillator 2 |
| CC46–56 | Osc3 (same layout) | Oscillator 3 |
| CC57–59 | Dist Drive, Tone, Amount | Distortion |
| CC60–62 | Delay Amount, FB, Time | Delay |
| CC63–65 | Reverb Size, Decay, Amount | Reverb |
| CC66–68 | Mod Effect Amount, Rate, Depth | Mod Effect |
| CC69–70 | Comp Threshold, Ratio | Compressor |
| CC71–74 | Mod 1–4 Dest Amounts | Mod Matrix |
| CC75–78 | Env 1–4 Rate | Envelopes |
| CC79–80 | Portamento, Mod Wheel | Global |

---

### Malstrom Graintable Synthesizer
`Propellerheads` / `Malstrom Graintable Synthesizer`

| CC | Parameter | Group |
|---|---|---|
| CC1–11 | Osc A Attack, Decay, Sustain, Release, Index, Motion, Shift, Gain, Oct, Semi, Cent | Oscillator A |
| CC12–22 | Osc B (same layout) | Oscillator B |
| CC23–24 | Filter A Freq, Resonance | Filter A |
| CC25–26 | Filter B Freq, Resonance | Filter B |
| CC27–31 | Filter Env Attack, Decay, Sustain, Release, Amount | Filter Envelope |
| CC32–35 | Mod A Rate, To Pitch, To Index, To Shift | Modulator A |
| CC36–40 | Mod B Rate, To Level, To Filter, To Motion, To Mod A | Modulator B |
| CC41 | Shaper Amount | Shaper |
| CC42–46 | Vel To Level A/B, Filter Env, Attack, Shift | Velocity |
| CC47–50 | MW To Index, Shift, Filter, Modulator | Mod Wheel |
| CC51–54 | Master Level, Spread, Portamento, Mod Wheel | Global |

---

### Macro Synthesizer
`Presteign Sound Labs` / `com.presteign.Macro`

| CC | Parameter | Group |
|---|---|---|
| CC1–3 | Engine A, B, C | Engines |
| CC4–6 | Mix, Spread, Volume | Mix |
| CC7–9 | Filter, Attack/Transient, Release | Filter/Env |
| CC10–12 | Velocity Amp, Gen B, Gen C | Velocity |
| CC13–15 | Env Engine Gen A, B, C | Envelopes |
| CC16–17 | Mod Wheel Gen A, Mod Wheel | Modulation |
| CC18–20 | Semi, Cent, Pitch Bend | Tuning |
| CC21–22 | Octave, Engine | Global |

---

### SubTractor Analog Synthesizer
`Propellerheads` / `SubTractor Analog Synthesizer`

| CC | Parameter | Group |
|---|---|---|
| CC1–4 | Filter Freq, Res, Env Amount, Kbd Track | Filter 1 |
| CC5–6 | Filter2 Freq, Res | Filter 2 |
| CC7–10 | Filter Env Attack, Decay, Sustain, Release | Filter Envelope |
| CC11–14 | Amp Env Attack, Decay, Sustain, Release | Amp Envelope |
| CC15–19 | Mod Env Attack, Decay, Sustain, Release, Gain | Mod Envelope |
| CC20–21 | Osc1 Phase Diff, Fine Tune | Oscillator 1 |
| CC22–23 | Osc2 Phase Diff, Fine Tune | Oscillator 2 |
| CC24–25 | Osc Mix, FM Amount | Osc Mix |
| CC26–28 | Noise Level, Decay, Color | Noise |
| CC29–30 | LFO1 Rate, Amount | LFO 1 |
| CC31–33 | LFO2 Rate, Amount, Delay | LFO 2 |
| CC34–37 | MW amounts: Filter Freq, Res, LFO1, FM | Mod Wheel |
| CC38–40 | Vel amounts: Amp, Filter Env, Filter Decay | Velocity |
| CC41–42 | Ext Mod: Filter Freq, Amp | Ext Mod |
| CC43–46 | Master Level, Portamento, Mod Wheel, Pitch Bend Range | Global |

---

### Kong Drum Designer
`Propellerheads` / `Kong Drum Designer`

| CC | Parameter |
|---|---|
| CC1–48 | Drums 1–16: Level, Pan, Tone (3 CCs per drum, sequential) |
| CC49 | Master Level |
| CC50–51 | Master FX P1, P2 |
| CC52–53 | Bus FX P1, P2 |
| CC54 | Level Bus FX to Master FX |

---

### Dr.REX Loop Player
`Propellerheads` / `Dr.REX Loop Player`

> Dr.REX uses a **slot-selection model** — there are no independent per-loop parameters. CC1–8 select a slot; CC10–11 then apply to whichever slot is active.

| CC | Parameter | Group |
|---|---|---|
| CC1–8 | Select Loop 1–8 | Loop Selection |
| CC9 | Selected Loop Slot | Loop Selection |
| CC10–11 | Loop Level, Loop Transpose | Active Loop |
| CC12–14 | Filter Freq, Res, Env Amount | Filter |
| CC15–18 | Filter Env Attack, Decay, Sustain, Release | Filter Envelope |
| CC19–22 | Amp Env Attack, Decay, Sustain, Release | Amp Envelope |
| CC23–26 | LFO1 Rate, Amount, Wave, Dest | LFO |
| CC27–30 | Osc Octave, Transpose, Fine Tune, Env Amount | Oscillator |
| CC31–32 | Filter Freq Mod Wheel Amount, Master Level | Global |

---

### Monotone
`Propellerhead Software` / `se.propellerheads.Monotone`

| CC | Parameter | Group |
|---|---|---|
| CC1–11 | Filter Freq, Reso, Drive, Env Amount, Attack, Decay, Sustain, Release, Key Amt, LFO Amt, Vel | Filter |
| CC12–16 | Amp Attack, Decay, Sustain, Release, Velocity | Amp Envelope |
| CC17–24 | Osc Mix, Detune, Osc1 Oct, Osc2 Oct, Osc2 Pitch, FM Env Amt, Pitch LFO Amt, Noise | Oscillators |
| CC25–26 | LFO Rate, Wave | LFO |
| CC27–28 | Wheel Filter Amt, Wheel LFO Amt | Mod Wheel |
| CC29–34 | Chorus Amount, Rate, Spread; Delay Amount, Feedback, Time | FX |
| CC35–39 | Portamento, Volume, Mod Wheel, Bend Range, Portamento Mode | Global |

---

### Alligator Filter Gate
`Propellerheads` / `Alligator`

| CC | Parameter | Group |
|---|---|---|
| CC1–4 | HP Frequency, Resonance, Env Amount, LFO Amount | High Pass |
| CC5–8 | BP Frequency, Resonance, Env Amount, LFO Amount | Band Pass |
| CC9–12 | LP Frequency, Resonance, Env Amount, LFO Amount | Low Pass |
| CC13–15 | Amp Env Attack, Decay, Release | Amp Envelope |
| CC16–18 | Filter Env Attack, Decay, Release | Filter Envelope |
| CC19–20 | LFO Freq, Waveform | LFO |
| CC21–23 | HP Drive, Phaser, Delay send amounts | HP FX |
| CC24–26 | BP Drive, Phaser, Delay send amounts | BP FX |
| CC27–29 | LP Drive, Phaser, Delay send amounts | LP FX |
| CC30–34 | Delay Time, Feedback, Pan; Phaser Rate, Feedback | Global FX |
| CC35–42 | HP/BP/LP/Dry Volume and Pan | Volumes |
| CC43–44 | Ducking, Master Volume | Output |
| CC45–47 | Shift, Resolution, Pattern | Pattern |

---

### Bassline Generator
`Propellerhead Software` / `se.propellerheads.Bassline`

| CC | Parameter | Group |
|---|---|---|
| CC1–3 | Pattern Select, Octave, Playback Mode | Global |
| CC4–11 | Pattern 1–8 Steps | Steps |
| CC12–19 | Pattern 1–8 Rate | Rate |
| CC20–27 | Pattern 1–8 Root Note | Root Note |
| CC28–35 | Pattern 1–8 Minorness | Minorness |

---

### Chord Sequencer
`Propellerhead Software` / `se.propellerheads.ChordSequencer`

| CC | Parameter | Group |
|---|---|---|
| CC1–2 | Pattern Select, Octave Shift | Global |
| CC3–10 | P1–8 Velocity Adjust | Velocity |
| CC11–18 | P1–8 Humanize Velocity | Humanize |
| CC19–26 | P1–8 Humanize Timing | Humanize |
| CC27–34 | P1–8 Remove Bass Below Note | Bass |
| CC35–36 | On, Run | Transport |

---

### Dual Arpeggio
`Propellerhead Software` / `se.propellerheads.Arpeggio`

| CC | Parameter | Group |
|---|---|---|
| CC1–10 | On, Rate, Octaves, Direction, Transpose, Gate Length, Shift Step, Arp Steps, Low Key, High Key | Arp 1 |
| CC11–20 | Arp 2 (same layout) | Arp 2 |
| CC21–23 | Hold, On, Pattern Select | Global |

---

### EDS06s Drum Synth
`Ochen K.` / `com.ochenk.EDS06sDrumSynth`

10 parameters per channel across 6 channels: Pitch Coarse, Pitch Fine, Pitch Drop, Envelope Attack, Envelope Decay, Filter Frequency, Filter Resonance, Distortion Drive, Volume, Pan.

| CC | Channel |
|---|---|
| CC1–10 | Ch 1 |
| CC11–20 | Ch 2 |
| CC21–30 | Ch 3 |
| CC31–40 | Ch 4 |
| CC41–50 | Ch 5 |
| CC51–60 | Ch 6 |

---

## Troubleshooting

**"IAC Driver" doesn't appear in Reason Preferences → Add**
→ Confirm both `IAC_Driver.lua` and `IAC_Driver.luacodec` are in the same `Apple Inc.` subfolder under Codecs. Full Reason restart required.

**"Not able to find remotemap for device"**
→ Check the 5-line header format in the `.remotemap`. `Control Surface Manufacturer` and `Control Surface Model` must match the `.luacodec` values character-for-character (case-sensitive). Full restart required after any fix.

**"Map entry with unknown control surface item" (CC21+)**
→ The installed `IAC_Driver.lua` is the old version that only defined CC1–20. Replace it with the current version (CC1–127 loop) and do a full Reason restart. This is the most common issue when updating an existing installation.

**Controls don't respond**
→ Confirm source is routing to IAC Driver Bus 1. The codec matches CC on any channel (`b?` pattern) — no specific channel required. Use a MIDI Monitor app to verify CC messages are arriving on Bus 1.

**IAC Driver not visible in Audio MIDI Setup**
→ Audio MIDI Setup → Window → Show MIDI Studio → double-click IAC Driver → check "Device is online". No third-party driver needed — IAC is built into macOS.

**A device scope isn't responding**
→ Scope strings are exact — if you've renamed a device or are on a different RE version, the scope may not match. Use **File → Export Device Remote Info** to verify the exact manufacturer and model strings Reason expects.

**Automation values seem wrong for bipolar parameters**
→ CC range is 0–127 and Reason maps this linearly. For bipolar params (Pan, Pitch Bend, etc.) center = CC64. Adjust your source accordingly.

**Updated remotemap not taking effect**
→ Remove the control surface in Preferences, do a full Reason restart, then re-add it.

---

## Extending the map

To add a new device scope or adjust CC assignments:

1. In Reason, load the target device → **File → Export Device Remote Info** to get exact scope strings and parameter names
2. Add a new `Scope` block to `Apple_Inc_IAC_Driver.remotemap` using those exact strings
3. Run the duplicate-detection script below before reinstalling
4. Copy the updated remotemap to the install path and do a full Reason restart

The codec already supports CC1–127 — no codec changes needed unless you're adding a completely new controller.

**Duplicate detection — run before reinstalling any edited remotemap:**

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

## Notes

- The codec uses `b?` wildcard patterns — CC messages on **any MIDI channel** are accepted. To restrict to a specific channel, edit `IAC_Driver.lua` and replace `b?` with `b0` (ch 1), `b1` (ch 2), etc., then restart Reason.
- For bipolar parameters (Pan, Pitch Bend, etc.), CC64 = center.
- Dr.REX: CC10 (Loop Level) and CC11 (Loop Transpose) affect whichever slot was last activated via CC1–8 or CC9.
- Combinator Rotary 1–32 and Button 1–32 are the most flexible scope for custom routing — wire them to any internal device parameters via the Combinator Programmer.

---

## Compatibility

- macOS only (IAC Driver is Apple-native; Windows users can substitute loopMIDI or a similar virtual MIDI port)
- Tested on Reason 12 and 13
- Codec supports CC1–127 on any MIDI channel

---

## License

MIT

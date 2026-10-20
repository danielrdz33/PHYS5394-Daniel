# Feedback: Lab Topic 1_1

- Lab specification: `LABS/Lab Topic 1_1.pdf`
- Submission folder: `PHYS5394-Daniel`
- Review date: 2026-10-20
- Review method: Static inspection only; student and instructor code were not executed.

## Overview

The Lab 1 scripts cover all eight signal types and include sampled time-series plots and positive-frequency FFT-magnitude plots. The sinusoid script also explores sub-$1/T$ frequency steps and zero padding. The main corrections are to use the specified FFT frequency spacing consistently in the quadratic-chirp plot and to add written interpretation of the periodograms.

## Submission identification and files reviewed

The matching scripts are grouped in `SIGNALS/lab_1/`; their comments and equations identify them as Lab 1 work. Reviewed: `plotqcsig_lab1.m`, `sinsignal_lab1.m`, `lcsignal_lab1.m`, `sgsignal_lab1.m`, `fmsignal_lab1.m`, `amsignal_lab1.m`, `amfmsignal_lab1.m`, and `ltcsignal_lab1.m`. No separate Lab 1 report was located.

## Instructor reference material

- `DATASCIENCE_COURSE/SIGNALS/crcbgenqcsig.m`: reference quadratic-chirp equation and normalization.
- `DATASCIENCE_COURSE/SIGNALS/testcrcbgenqcsig.m`: reference signal sampling and periodogram workflow.

## Lab objectives and requirements

| Requirement | Status | Code evidence and feedback |
|---|---|---|
| Generate the eight specified signal forms (Part 1: signal definitions) | Addressed in code | The eight scripts implement the quadratic chirp, sinusoid, linear chirp, sine-Gaussian, FM, AM, AM-FM, and linear transient chirp. The formulas and parameter descriptions appear consistent with the lab. |
| Select a sufficiently fine sampling interval by comparing plots (Part 1: “Plots”) | Addressed in code | Each script compares several sampling frequencies, from coarse to fine, and plots the sampled signal at each. The quadratic chirp also estimates its maximum instantaneous frequency. |
| Plot the magnitude of the FFT against the positive-frequency values, using spacing $1/(N\Delta)$ (Part 2: “FFT”) | Partially addressed | The scripts compute positive FFT bins with `floor(N/2)+1`. In `plotqcsig_lab1.m`, the sample vector includes both endpoints and the frequency axis uses `1/dataLen`; for this inclusive grid, that does not equal the required `1/(N*samplIntrvl)`. Build this axis from the sample count and interval, or use a half-open time grid consistently. The other reviewed scripts calculate spacing from `N*samplIntrvl`. |
| Interpret periodograms, including finite-duration sinusoid behavior and changes for frequency steps below $1/T$ (Part 2: “Frequencies in a DFT”) | Partially addressed | `sinsignal_lab1.m` tests 0.25 Hz steps for a one-second signal and includes a zero-padded comparison, which is useful for inspecting the spectral shape. The code does not provide written interpretations for the eight periodograms; add brief explanations connecting visible peaks or bandwidth to each signal, including the finite-window sinusoid’s sinc-like spectrum. |

## Code correctness and suggested improvements

- **Location:** `SIGNALS/lab_1/plotqcsig_lab1.m`, periodogram frequency-axis calculation. **Observation:** The time vector includes both 0 and 1 second, but the axis spacing is computed as the reciprocal of the endpoint span. The requested DFT spacing is `1/(nSamples*samplIntrvl)`. **Likely consequence:** Plotted frequency labels are slightly displaced from the actual FFT bins. **Suggested improvement:** Use `1/(nSamples*samplIntrvl)` for spacing or adopt a half-open sample grid and keep the DFT frequency calculation consistent. This discrepancy is clear from inspection; numerical plot impact was not tested.

No other clear formula or indexing defect was identified in the reviewed signal-generation and FFT code. Runtime and numerical correctness remain unverified.

## Documentation feedback

### What works well

The scripts explain parameter meanings, signal equations, sampling choices, and the intent of the frequency comparisons. Labels identify time units and FFT magnitude.

### Suggested improvements

Add a short interpretation section or captions for the periodograms. The lab asks what the spectra reveal, not only that they be plotted.

## Recommended next steps

1. Correct the quadratic-chirp frequency axis to use the specified DFT spacing.
2. Add concise interpretations for each signal spectrum, especially the finite-duration sinusoid and sub-$1/T$ frequency changes.

## Review limitations

Student and instructor code were not executed. Runtime behavior, generated plots, and numerical values were not independently verified. No separate report was located in the reviewed student files.
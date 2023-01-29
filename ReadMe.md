# GNU Octave Logger

This is a basic data acquisition system with Arduino UNO and GNU Octave.
This software is developed with [guiEditor](https://gitlab.com/labinformatica/guieditor).

# Features

- Arduino UNO support
- One analog input measurement 
- One analog output measurement 
- Real time measurement logging to `.csv` file
- Connection check
- Calibration

# Dependencies 

Make sure you have installed these packages before you running this software.

- `instrument-control`
- `arduino`
- `Arduino IDE`

Two of these packages can be installed from the `command window` of GNU Octave with the following commands:

`pkg install -forge instrument-control`
`pkg install -forge arduino`

# How to run the software

1. Install GNU Octave.
2. Download this repository and extract it.
3. Run the `GNU_Octave_Logger.m` file from the `command window`.

# Picture

Processing measurements 

![a](https://github.com/DanielMartensson/GNU-Octave-Logger/blob/main/img/Snapshot.png?raw=true)

Result

```matlab
>> x = dlmread('Measure.csv');
>> plot(x(:, 3)) % Analog in column
>> hold on
>> plot(x(:, 4)) % Analog out column
>> legend('Analog in', 'Analog out')
>> grid on
```

![a](https://github.com/DanielMartensson/GNU-Octave-Logger/blob/main/img/Result.png?raw=true)

# readyaml
MATLAB function to read yaml files. Outputs result into struct.

# Installation
clone this repository by typing in your command window:
```bash
git clone https://github.com/MaartenJongeneel/readyaml.git
```
Then, in MATLAB, you can add this folder and functions to your path via
```matlab
addpath(genpath('path/to/readyaml'));
```

# Usage
You can simple read out your yaml file in matlab via
```matlab
yamlFile = 'path/to/my/file.yaml';
YamlStruct = readyaml(yamlFile);
```

# Limitations
As keys will be written to MATLAB struct names, they name of the key should be compatible with what MATLAB can have as struct names.
This means a key must begin with a letter, can contain letters, digits, or underscore characters, and are case sensitive and keys cannot contain periods.
```yaml
test:
  1note: this is an invalid fieldname in MATLAB
  note1: this is a valid fieldname in MATLAB
  note.1: this is also invalid in MATLAB
```

As MATLAB cannot have a struct with duplicate fieldnames, it will automatically overwrite existing keys of the YAML file. As a result, in the example below, only the 
second note will be saved, as it will overwrite the first note. 
```yaml
test:
  note: this is a comment
  note: but this comment will overwrite the previous one, due to duplicate key names
```

# TO DO
In current form, the following components are still missing:
- Possibility of inline blocks like
    ```yaml
    {name: John Smith, age: 33}
    ```
- Multi-line strings using ```|``` and ```>``` characters 
    ```yaml
    data: |
      There once was a tall man from Ealing
      Who got on a bus to Darjeeling
          It said on the door
          "Please don't sit on the floor"
      So he carefully sat on the ceiling
    data: >
      Wrapped text
      will be folded
      into a single
      paragraph

      Blank lines denote
      paragraph breaks
   ```
- Sequences of keys like
    ```yaml 
    [name, age]: [Rae Smith, 4] 
    ```
- Node anchors (using ```&```) and references (using ```*```)
    ```yaml
    - step:  &id001                  # defines anchor label &id001
        instrument:      Lasik 2000
        pulseEnergy:     5.4
        pulseDuration:   12
        repetition:      1000
        spotSize:        1mm

    - step: &id002
        instrument:      Lasik 2000
        pulseEnergy:     5.0
        pulseDuration:   10
        repetition:      500
        spotSize:        2mm
    - Instrument1: *id001   # refers to the first step (with anchor &id001)
    - Instrument2: *id002   # refers to the second step
    ```
# Author
Maarten J. Jongeneel, Ph.D. researcher <br> 
Eindhoven University of Technology (TU/e), Mechanical Engineering Dept. <br>
Contact: [email](mailto:info@maartenjongeneel.nl) 
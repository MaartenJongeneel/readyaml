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
# Author

Maarten J. Jongeneel, Ph.D. researcher <br> 
Eindhoven University of Technology (TU/e), Mechanical Engineering Dept. <br>
Contact: [email](mailto:info@maartenjongeneel.nl) 
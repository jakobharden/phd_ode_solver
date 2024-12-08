# Solving the ODE of the damped mass-spring oszillator


## Abstract

This program solves the ordinary 2nd order differential equation of the (damped) mass-spring oscillator in explicit form. This equation has the form: m d²/dt² u + k d/dt u + c u = F(t). Where **t** is the time, **m** is the mass, **k** is the velocity-proportional damping constant, **c** is the spring constant (spring stiffness), **u** is the displacement as a function of time and **F(t)** is the external force acting on the oscillator.   
For the time step integration, one of the following methods can be chosen: Euler[1], Adams-Bashforth 2nd order[3], Runge-Kutta[3] 2nd order and Runge-Kutta 4th order.   
The program clearly demonstrates the differences in convergence behavior that occur with the different methods of time step integration. In addition, this program can also be integrated as a subsystem into other programs.


## Table of contents

- [License](#license)
- [Prerequisites](#prerequisites)
- [Directory and file structure](#directory-and-file-structure)
- [Installation instructions](#installation-instructions)
- [Usage instructions](#usage-instructions)
- [Help and Documentation](#help-and-documentation)
- [References](#related-software)
- [Revision and release history](#revision-and-release-history)


## License

Copyright 2024 Jakob Harden (jakob.harden@tugraz.at, Graz University of Technology, Graz, Austria)

This file is part of the PhD thesis of Jakob Harden.

All GNU Octave function files (\*.m) are licensed under the *GNU Affero General Public Licence v1.0*. See also licence information file *LICENSE*.

All files in the **octave/results** directory are licensed under the *Creative Commons Attribution 4.0 International* license. See also: [Licence deed](https://creativecommons.org/licenses/by/4.0/deed.en)


## Prerequisites

The only requirement for using this program is a proper installation of [GNU Octave](https://octave.org/), either version 6.2.0 or later.


## Directory and file structure

```   
odesolver   
├── octave   
│   ├── results   
│   ├── init.m   
│   ├── showlicence.m   
│   ├── solve_ode.m   
│   └── test_solve_ode.m   
├── LICENSE   
├── README.html   
└── README.md   
```

- **octave** ... GNU Octave function files
  - **results** ... computation results, output files
  - *init.m* ... function file, initialize program environment
  - *showlicence.m* ... function file, print license information on the screen
  - *solve_ode.m* ... function file, ODE solver
  - *test\_solve\_ode.m* ... function file, solver tests
- *LICENSE* ... AGPL license terms and conditions
- *README.html* ... html version of the *README.md* file
- *README.md* ... this file


## Installation instructions

1. Copy the program directory **odesolver** to a location of your choice. e.g. **/home/acme/science/odesolver**.   
2. Open GNU Octave.   
3. Make the program directory **/home/acme/science/odesolver** the working directory.   


## Usage instructions

1. Open GNU Octave.   
2. Initialize program.   
3. Run script files.   


### Initialize program (command line interface, CLI)

The *init* command initializes the program. The initialization must be run once before executing all the other functions. The command creates the folder structure for the output files in the **octave/results** directory.

```
    octave: >> init();   
```


### Run tests (CLI)

Several tests are provided to reproduce the test results for some simple predefined systems. The test computation can be run with the command below. When the analysis has finished, the results are written to the above mentioned results directory.

```
    octave: >> test_solve_ode();   
```

[!NOTE] The tests can also be used as a guide to solve the ODE of the damped mass-spring oszillator with boundary conditions of your choice.


### Using the solver (CLI)

The solver can also be used as a stand-alone program or as a subsystem of another program. The function call looks like this:

```
    octave: >> [r_u, r_v, r_a] = solve_ode(p_etp, p_stp, p_par, p_rhs, p_bc0);
```

**Legend:**

- r\_u ... displacement array u(t)
- r\_v ... velocity array v(t)
- r\_a ... acceleration array a(t)
- p\_etp ... equation type; 'dmso' = damped mass-spring oszillator, 'mso' = undamped mass-spring oszillator
- p\_stp ... solver type used for the time-step integration; 'euler' = Euler method, 'ab2' = Adams-Bashford method, 'rk2' = Runge-Kutta 2nd order, 'rk4' = Runge-Kutta 4th order
- p\_par ... analysis parameter array (num\_time\_steps, width\_time\_step, mass, damping\_constant, spring\_constant)
- p\_rhs ... right-hand-side of the inhomogenous ODE, array of external forces
- p\_bc0 ... initial state boundary conditions (t = 0), array of (initial\_displacement, initial\_velocity)

## Help and Documentation

All function files contain an adequate function description and instructions on how to use the functions. This documentation can be displayed using GNU Octave's command line interface by entering the following command:

```
    octave: >> help function_file_name;
```

Additionally, literature sources are provided, serving as a guide to understand the implementation.


## References

[1] Wikipedia contributors. (2024, November 15). Euler method. In Wikipedia, The Free Encyclopedia. Retrieved 12:52, December 8, 2024, from [https://en.wikipedia.org/w/index.php?title=Euler_method&oldid=1257584385](https://en.wikipedia.org/w/index.php?title=Euler_method&oldid=1257584385)

[2] Wikipedia contributors. (2024, December 3). Runge–Kutta methods. In Wikipedia, The Free Encyclopedia. Retrieved 12:50, December 8, 2024, from [https://en.wikipedia.org/w/index.php?title=Runge%E2%80%93Kutta_methods&oldid=1260972675](https://en.wikipedia.org/w/index.php?title=Runge%E2%80%93Kutta_methods&oldid=1260972675)

[3] Wikipedia contributors. (2024, September 23). Linear multistep method. In Wikipedia, The Free Encyclopedia. Retrieved 12:57, December 8, 2024, from [https://en.wikipedia.org/w/index.php?title=Linear_multistep_method&oldid=1247156850](https://en.wikipedia.org/w/index.php?title=Linear_multistep_method&oldid=1247156850)


## Revision and release history

### 2024-12-08, version 1.0

- published/released version 1.0, by Jakob Harden   
- url: [TU Graz Repository](https://doi.org/10.3217/499v5-q3h59)   
- doi: 10.3217/499v5-q3h59   


# article-code
MATLAB implementation of an Interval Type-2 Fuzzy Logic Controller (IT2-FLS) for autonomous mobile robot navigation and obstacle avoidance.
Type-2 Fuzzy Logic Controller for Path Planning and Obstacle Avoidance
This code implements a mobile robot navigation framework that combines the Dragonfly Optimization Algorithm for global path planning with a Type-2 Fuzzy Logic Controller (FLS) for local motion control and dynamic obstacle avoidance.
Requirements:
MATLAB 2021 or newer
Robotics System Toolbox
Fuzzy Logic Toolbox
Optimization Toolbox
Usage:
Ensure that the environment map file `Obstaculo2.mat` is in the project folder.
To run the simulation, execute the following command in MATLAB:
```matlab
runFuzzytype2model1()
runFuzzytype2model2()
```
Overview:
The Dragonfly Algorithm is used for path planning from the start point to the goal using an occupancy-map-based environment.
The Type-2 FLS (`type2FLS`) controls the robot's motion toward the waypoints/checkpoints and handles model uncertainties.
A fuzzy obstacle-avoidance controller (`a107`) is activated when obstacles are detected within a critical distance using simulated range sensors.
Moving obstacles with different motion patterns (vertical, horizontal, and circular) are dynamically updated in the map during the simulation.
Simulation results include robot trajectory, wheel voltages, speed profiles, wheel torques, and heading/yaw evolution, which are logged and visualized for analysis.
Files:
`runFuzzytype2model1.m`,`runFuzzytype2model2.m`: Main script/function for running the Type-2 FLS-based simulation.
`Obstaculo2.mat`: Environment/occupancy map file.
`a107.m`: Fuzzy logic controller for obstacle avoidance.
`type2FLS.m`: Implementation of the main Type-2 Fuzzy Logic Controller.
`DynamicModel.m`: Implementation of the robot dynamic model.
`DragonflyPathPlanning_DF.m`: Implementation of the Dragonfly optimization-based path planner (if provided as a separate file).

# System Identification and State-Space Modeling Using Experimental Data

This project involves the identification of a dynamic system using experimental data and modeling the system in state-space form. It also includes the analysis of system behavior using various methods such as **ARMAX**, **n4sid**, **IV4**, and **PEM** for system identification and transfer function modeling. The project explores autocorrelation and intercorrelation tests, along with Bode analysis, to verify the model's accuracy.

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Data Format](#data-format)
  - [Running the Code](#running-the-code)
- [Methods](#methods)
  - [State-Space Modeling](#state-space-modeling)
  - [ARMAX Model](#armax-model)
  - [n4sid Model](#n4sid-model)
  - [IV4 Model](#iv4-model)
  - [PEM Model](#pem-model)
- [Error Metrics](#error-metrics)
- [License](#license)

## Overview

This project simulates the identification of a system from experimental data. It models the system using state-space representation and performs validation through various system identification techniques. The experimental data represents:
- `t`: Time vector
- `u`: Input signal (system input)
- `y`: Output signal (system response)

The project focuses on determining system parameters such as damping ratio, natural frequency, and transfer function from the data.

## Project Structure

```bash
.
├── README.md          # Project documentation
├── system_identification.m  # Main MATLAB script for system identification and modeling
└── data               # Folder containing experimental data (if applicable)
Requirements
Before running this project, ensure you have the following installed:

MATLAB R2020a or newer
System Identification Toolbox
Control System Toolbox
Installation
Clone this repository to your local machine:

bash
Copiază codul
git clone https://github.com/username/system-identification.git
cd system-identification
Ensure you have MATLAB installed and open the project folder in MATLAB.

If you have your own data, make sure it follows the correct format (see Data Format).

Usage
Data Format
The project expects the experimental data to be in matrix form with three columns:

Column 1: Time vector (t)
Column 2: Input signal (u)
Column 3: Output signal (y)
For example, the matrix system should have the following structure:

matlab
Copiază codul
system = [
    t1, u1, y1;
    t2, u2, y2;
    ...
];
Running the Code
Load your data in the MATLAB workspace. The default variable for data is system.

matlab
Copiază codul
system = load('path_to_your_data.mat'); % Example of loading data
Run the system_identification.m script:

matlab
Copiază codul
run('system_identification.m')
The script will generate various plots showing the experimental data, system response, and the Bode plot for the identified model.

Methods
State-Space Modeling
This part of the code builds the state-space model using the damping factor, natural frequency, and input-output data. It simulates the response of the system and calculates error metrics.

ARMAX Model
The ARMAX (AutoRegressive Moving Average with eXogenous inputs) model is used to identify the system from the data, fitting it into an appropriate model structure. It includes the following steps:

Model fitting using armax()
Comparison of model and data
Residual analysis to verify model quality
n4sid Model
The n4sid method is used to identify a state-space model from input-output data. The method fits the system into a low-order model using subspace identification.

IV4 Model
The Instrumental Variables (IV4) method is used to estimate the parameters of a linear model in the presence of noise. This method helps to handle noise in the input-output relationship.

PEM Model
The Prediction Error Method (PEM) is used to estimate the system model by minimizing the prediction error between the observed and modeled data.

Error Metrics
The script calculates the following metrics to assess the quality of the model:

J (Normalized Mean Squared Error): Measures the deviation between simulated and actual output.
Empirical Normalized Error (empn): Quantifies the error as a percentage.
These error metrics help in determining the goodness-of-fit for the system identification model.

License
This project is licensed.
# AFRCalculationFromEmission
MATLAB script calculate air-to-fuel ratio from exhaust emission; All of them can be used for oxygenated fuels

Script explanation

Main script

1. emissionDataProcessing.m: Driver script
    - Input data setting (exhaust emissions and fuel)
      Emission data (dry gas) : O2,CO2 in %, NO,CO,THC in ppm(THC: ppmC1)
      Fuel data: H/C ratio, O/C ratio, lower heating value
    - Calculate stoichimetric AFR ratio from fuel's H/C and O/C ratio
    - Call other three script
     
Subrfunctions (could be used independently)

1. calculateSpindt.m: Calculate Lambda based on Spindt's equation
      - Input parameter: fuel and emission data
      - Output: Spindt Lambda 

2. calculateBrettschneider.m: Calculate Lambda based on Brettschneider's equation
      - Input parameter: fuel and emission data, water-gas shift reaction coefficient
      - Output: Brettschneider Lambda 

3. calculateO2basedAFRandCombEff.m Caluclate equvalence ratio based on oyxgen balance and combustion efficiency
      - Input parameter: fuel and emission data, water-gas shift reaction coefficient
      - Output: equvalence ratio, combustion efficiency, wet molar fractions

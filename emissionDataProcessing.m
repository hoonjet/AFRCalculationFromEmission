

% ==================== Data setting ======================== %
% Emission data ; assumes data from dry exhaust stream (without water vapor)
O2 = 0.5; %assumes percent
CO2 = 14.5; %assumes percent
CO = 5000; %assumes ppm
NO = 1000; %assumes ppm
THC = 1000; %assumes ppmC1
%Encapsulate emission data
emission.O2 = O2;
emission.CO2 = CO2;
emission.CO = CO;
emission.NO = NO;
emission.THC = THC;

% Fuel data 
HCratio = 2.2611; %hydrogen to carbon ratio
OCratio = 0.0348; %oyxgen to carbon ratio
lowerHeatingValue = 42.295; %lower heating value of fuel MJ/kg

    % Calculate stoichiometric AFR ratio
    % Based on CHyOz +n(O2+3.773N2) -> CO2 + (y/2)H2O + 3.773nN2
    % 1. Atomic weight
    carbonAW = 12.0107;
    hydrogenAW = 1.008;
    oxygenAW = 15.999;
    nitrogenAW = 14.007;
    % 2. Oxygen needed
    n = (2+HCratio/2-OCratio)/2;
    % 3. Calculate stoichiometric AFR ratio
    stoichAFR = n*(oxygenAW*2+3.773*nitrogenAW*2)/(carbonAW + hydrogenAW*HCratio + oxygenAW*OCratio); 
    

%Encapsulate emission data
fuel.HCratio = HCratio;
fuel.OCratio = OCratio;
fuel.AFRstoich = stoichAFR;
fuel.netHeatingValue = lowerHeatingValue;

% Water gas shift reaction constant
K = 3.5; % normally set to 3.5 (or 3.8); varying from 2.5 - 4.5

% ==================== Data setting ======================== %

% ==================== Calculation ========================= %
SpindtLambda = calculateSpindt(emission,fuel);
BrettschneiderLambda = calculateBrettschneider(emission,fuel,K);
outputData = calculateO2basedAFRandCombEff(emission,fuel,K);

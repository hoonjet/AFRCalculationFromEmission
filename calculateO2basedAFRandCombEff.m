function outputData = calculateO2basedAFRandCombEff( emission, fuel, K )


%Calculate Spindt AFR (applicable to oxygenated fuel as well)

%Original data structure
%emission.O2 = O2 in %
%emission.CO2 = CO2 in %
%emission.CO = CO in ppm 
%emission.NO = NO in ppm
%emission.THC = THC in ppmC1

%fuel.HCratio = HC ratio of fuel
%fuel.OCratio = OC ratio of fuel
%fuel.AFRstoich : stoichiometric air-to-fuel ratio
%fuel.netHeatingValue : fuel lower heating value MJ/kg


%Convert ppms and percent into molar fraction
emission.CO = emission.CO/1000000; % ppm to fraction
emission.NO = emission.NO/1000000; % ppm to fraction
emission.THC = emission.THC/1000000; % ppm to fraction
emission.O2 = emission.O2/100; % percent to fraction
emission.CO2 = emission.CO2/100; % percent to fraction


%% Fuel Properties
% CxHyOz is the form of the fuel molecule
x = 1;                 % Number of Carbons
y = fuel.HCratio; % Number of Hydrogens
z = fuel.OCratio; % Number of Oxygens 

%Atomic weight
carbonAW = 12.011;
hydrogenAW = 1.008;
oxygenAW = 15.999;

% Molecular weight of the fuel (based on HC ratio)
MWFuel = carbonAW*x + hydrogenAW*y + oxygenAW*z; 
% Lower heating value
LHV = fuel.netHeatingValue;
% Stoichiometric air to fuel ratio
AFs = fuel.AFRstoich; 


%Oxygenated fuel: reference - Heywood, Chapter 4.9.2 pp. 152 (There is typo
%in the book. CmHnOr should be CnHmOr 

%Assumes water-gas shift reaction constant K is 3.5;
emission.H2O = y/(2*x)*(emission.CO+emission.CO2)/(1+emission.CO/(K*emission.CO2)+ y/(2*x)*(emission.CO+emission.CO2));
emission.H2_wet = emission.H2O*emission.CO/(K*emission.CO2);
emission.CO_wet = (1-emission.H2O)*emission.CO;
emission.O2_wet = (1-emission.H2O)*emission.O2;
emission.CO2_wet = (1-emission.H2O)*emission.CO2;
emission.THC_wet = (1-emission.H2O)*emission.THC;
emission.NO_wet = (1-emission.H2O)*emission.NO;
Np = x/(emission.THC+(1-emission.H2O)*(emission.CO+emission.CO2));
Noxygen = x+y/4-z/2;

Phi_O = 2*Noxygen/(Np*emission.H2O+Np*(1-emission.H2O)*(emission.CO+2*emission.CO2+2*emission.O2+2*emission.NO)-z);
outputData.lambda_O = 1/Phi_O; %Oxygen based air-fuel ratio


% Combustion efficiency; modified from Donald L.Stivender SAE 710604 
% convert molar fraction to percent
COpct = emission.CO_wet*100;
CO2pct = emission.CO2_wet*100;
THCpct = emission.THC_wet*100;
H2pct = emission.H2_wet*100;
N = 100/(COpct+CO2pct+THCpct); % mole exhaust/mole fuel

outputData.combEff  = 100 - N*( ((254*COpct + 217.1*H2pct + LHV*MWFuel*THCpct)/(LHV*MWFuel)));
%LHV*MWfuel = molar heating value of fuel; kJ/mol
%assumes that molar heating value of HC is the same as that of fuel

%% include emission data (including wet portion)
outputData.emission = emission;


end    
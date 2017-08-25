function SpindtLambda = calculateSpindt(emission,fuel)
%Calculate Spindt AFR (applicable to oxygenated fuel as well)

%Original data structure
%emission.O2 = O2 in %
%emission.CO2 = CO2 in %
%emission.CO = CO in ppm 
%emission.THC = THC in ppmC1

%fuel.HCratio = HC ratio of fuel
%fuel.OCratio = OC ratio of fuel
%fuel.AFRstoich : stoichiometric air-to-fuel ratio

EmCO = emission.CO/10000; %ppm to percent
EmCO2 = emission.CO2;
EmTHC = emission.THC;
EmO2 = emission.O2;
HCratio = fuel.HCratio;
OCratio = fuel.OCratio;

%Atomic weight
carbonAW = 12.011;
hydrogenAW = 1.008;
oxygenAW = 15.999;

%Converted structure
%EmCO : Emission CO in %
%EmCO2 : Emission CO2 in %
%EmTHC : Emission hydrocarbon in ppm (assumes ppmC1)
%EmO2 : Emission O2 in %
%HCratio : H/C ratio of fuel / %OCratio : O/C ratio of fuel
%i.e. if fuel compistion is CHxOy, x = HCratio and y = O/C ratio


FB = (EmCO+EmCO2)/(EmCO+EmCO2+EmTHC/10000); % Mole ratio of (Oxidized fuel/Total fuel)
FC = carbonAW/(carbonAW+hydrogenAW*HCratio+oxygenAW*OCratio); % Carbon weight fraction
FH = hydrogenAW*HCratio/(carbonAW+hydrogenAW*HCratio+oxygenAW*OCratio); %Hydrogen weight fraction

R = EmCO/EmCO2; % ratio of CO and CO2
Q = EmO2/EmCO2; % ratio of O2 and CO2

SpindtAFR = FB*(11.492*FC*(1+R/2+Q)/(1+R)+120*FH*1/(3.5+R)-11.492*FC*OCratio/2);
SpindtLambda = SpindtAFR/fuel.AFRstoich;

end
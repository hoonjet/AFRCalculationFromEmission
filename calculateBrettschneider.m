function BrettschneiderLambda = calculateBrettschneider(emission,fuel,K)
%Calculate Spindt BrettschneiderLambda (applicable to oxygenated fuel as well, but humidity correction is not included)

%Original data structure
%emission.O2 = O2 in %
%emission.CO2 = CO2 in %
%emission.CO = CO in ppm 
%emission.THC = THC in ppmC1

%fuel.HCratio = HC ratio of fuel
%fuel.OCratio = OC ratio of fuel
%fuel.AFRstoich : stoichiometric air-to-fuel ratio


CO = emission.CO/10000; %ppm to percent
CO2 = emission.CO2;
O2 = emission.O2;
HC = emission.THC/10000; %ppm to %
NO = emission.NO/10000; %ppm to %
HCratio = fuel.HCratio;
OCratio = fuel.OCratio;

BrettNumerator = CO2+CO/2+O2+NO/2+(HCratio/4*(K/(K+CO/CO2))-OCratio/2)*(CO2-CO);
BerttDenominator = (1+HCratio/4-OCratio/2)*(CO2+CO+HC);
BrettschneiderLambda = BrettNumerator/BerttDenominator;


end
clear;

capacitance = 458 * 10^-6;
R1 = 1000;
R2 = 10000;
T = 2.5;

endtime = 20;
dt = 0.01;

dtScaled = endtime/dt;
timeline = 0:dt:endtime;
timelineScaled = 0:1:dtScaled;

US = 6*cos(2*pi*timeline/T);
UD = 0.82;
UC = zeros(dtScaled+1, 1);
charge = 0;
I2 = zeros(dtScaled+1, 1);

for t = 1 : dtScaled
  UR1 = US(t) - UD - UC(t);
  UR2 = UC(t);
  
  if (UR1 > 0)
    I1 = UR1 / R1;
  else
    I1 = 0;
  end
  
  I2(t) = UR2 / R2;
  
  charge = charge + (I1 - I2(t)) * dt;
  UC(t+1) = charge / capacitance;
end

figure();
plot(timeline, UC);
#!/bin/sh

# find the DAC
for i in $(find /sys -name name 2>/dev/null)
do
  if [ "`cat $i`" = "cf-ad9361-dds-core-lpc" ] ; then
     dac_path=$(echo $i | sed 's:/name$::')
  fi
done

for i in 1.000000 0.500000 0.250000 0.125000 0.062500 0.031250 0.015625 0.007812 0.003906 0.001953 0.000976 0.000488 0.000244 0.000122 0.000061 0.000030;
do
  echo $i > $dac_path/out_altvoltage0_TX1_I_F1_scale
  echo $i > $dac_path/out_altvoltage1_TX1_I_F2_scale
  echo $i > $dac_path/out_altvoltage2_TX1_Q_F1_scale
  echo $i > $dac_path/out_altvoltage3_TX1_Q_F2_scale

  echo $i > $dac_path/out_altvoltage4_TX2_I_F1_scale
  echo $i > $dac_path/out_altvoltage5_TX2_I_F2_scale
  echo $i > $dac_path/out_altvoltage6_TX2_Q_F1_scale
  echo $i > $dac_path/out_altvoltage7_TX2_Q_F2_scale
  sleep 1
done

echo 0.250000 > out_altvoltage0_TX1_I_F1_scale
echo 0.250000 > out_altvoltage1_TX1_I_F2_scale
echo 0.250000 > out_altvoltage2_TX1_Q_F1_scale
echo 0.250000 > out_altvoltage3_TX1_Q_F2_scale

echo 0.250000 > out_altvoltage4_TX2_I_F1_scale
echo 0.250000 > out_altvoltage5_TX2_I_F2_scale
echo 0.250000 > out_altvoltage6_TX2_Q_F1_scale
echo 0.250000 > out_altvoltage7_TX2_Q_F2_scale

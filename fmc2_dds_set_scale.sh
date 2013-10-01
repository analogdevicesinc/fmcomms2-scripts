#!/bin/sh

#check in the input
if [ $1 -le -1 ] ; then
  echo "input out of range, (needs to be 0-15)"
  exit
fi

if [ $1 -ge 16 ] ; then
  echo "input out of range (needs to be 0-15)"
  exit
fi

# find the DAC
for i in $(find /sys -name name 2>/dev/null)
do
  if [ "`cat $i`" = "cf-ad9361-dds-core-lpc" ] ; then
     dac_path=$(echo $i | sed 's:/name$::')
  fi
done

echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage0_TX1_I_F1_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage1_TX1_I_F2_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage2_TX1_Q_F1_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage3_TX1_Q_F2_scale
  
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage4_TX2_I_F1_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage5_TX2_I_F2_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage6_TX2_Q_F1_scale
echo $(echo "scale=6; 1 / ( 2 ^ $1 )" | bc) > $dac_path/out_altvoltage7_TX2_Q_F2_scale

echo -n "amplitude set to "
cat $dac_path/out_altvoltage0_TX1_I_F1_scale

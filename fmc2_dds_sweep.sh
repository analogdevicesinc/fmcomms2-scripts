#!/bin/sh

# find the DAC
for i in $(find /sys -name name)
do
  if [ "`cat $i`" = "cf-ad9361-dds-core-lpc" ] ; then
     dac_path=$(echo $i | sed 's:/name$::')
  fi
done

#save the current settings
init=`cat $dac_path/out_altvoltage0_TX1_I_F1_frequency`

sampl=`cat $dac_path/out_altvoltage_TX1_I_F1_sampling_frequency`
ny=`expr $sampl / 2`

# Set DDSn_A
freq_A(){
  echo $1 > $dac_path/out_altvoltage0_TX1_I_F1_frequency
  echo $1 > $dac_path/out_altvoltage2_TX1_Q_F1_frequency
  echo $1 > $dac_path/out_altvoltage4_TX2_I_F1_frequency
  echo $1 > $dac_path/out_altvoltage6_TX2_Q_F1_frequency
}

# Set DDSn_B
freq_B(){
  echo $1 > $dac_path/out_altvoltage3_TX1_Q_F2_frequency
  echo $1 > $dac_path/out_altvoltage1_TX1_I_F2_frequency
  echo $1 > $dac_path/out_altvoltage7_TX2_Q_F2_frequency
  echo $1 > $dac_path/out_altvoltage5_TX2_I_F2_frequency 
}

for i in `seq 1000000 1000000 $ny`
do
  freq_A $i
  freq_B `expr $ny - $i`
  sleep 1
done

freq_A $init
freq_B $init

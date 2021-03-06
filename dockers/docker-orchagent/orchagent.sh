#!/usr/bin/env bash

# Export platform information. Required to be able to write
# vendor specific code.
export platform=`sonic-cfggen -y /etc/sonic/sonic_version.yml -v asic_type`

MAC_ADDRESS=`ip link show eth0 | grep ether | awk '{print $2}'`

# Create a folder for SsWW record files
mkdir -p /var/log/swss
ORCHAGENT_ARGS="-d /var/log/swss "

# Set orchagent pop batch size to 8192
ORCHAGENT_ARGS+="-b 8192 "

# Add platform specific arguments if necessary
if [ "$platform" == "broadcom" ]; then
    ORCHAGENT_ARGS+="-m $MAC_ADDRESS"
elif [ "$platform" == "cavium" ]; then
    ORCHAGENT_ARGS+="-m $MAC_ADDRESS"
elif [ "$platform" == "nephos" ]; then
    ORCHAGENT_ARGS+="-m $MAC_ADDRESS"
elif [ "$platform" == "centec" ]; then
    last_byte=$(python -c "print '$MAC_ADDRESS'[-2:]")
    aligned_last_byte=$(python -c "print format(int(int('$last_byte', 16) + 1), '02x')")  # put mask and take away the 0x prefix
    ALIGNED_MAC_ADDRESS=$(python -c "print '$MAC_ADDRESS'[:-2] + '$aligned_last_byte'")          # put aligned byte into the end of MAC
    ORCHAGENT_ARGS+="-m $ALIGNED_MAC_ADDRESS"
elif [ "$platform" == "barefoot" ]; then
    ORCHAGENT_ARGS+="-m $MAC_ADDRESS"
fi

exec /usr/bin/orchagent ${ORCHAGENT_ARGS}

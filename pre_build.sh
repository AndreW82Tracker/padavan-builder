CFG_BASE="padavan-ng/trunk/configs/boards/TPLINK/TL_WR841N-V14"
TOOLS_BASE="padavan-ng/trunk/tools/mktplinkfw"

# kernel config
sed -i \
#  -e 's/^CONFIG_RT2880_DRAM_32M=y/CONFIG_RT2880_DRAM_64M=y/' \
#  -e 's/^CONFIG_RALINK_RAM_SIZE=32/CONFIG_RALINK_RAM_SIZE=64/' \
  -e 's/^CONFIG_RT2880_FLASH_4M=y/CONFIG_RT2880_FLASH_16M=y/' \
  -e 's/^CONFIG_MTD_STORE_PART_SIZ=0x10000/CONFIG_MTD_STORE_PART_SIZ=0x40000/' \
  -e 's/^CONFIG_RAETH_ESW_PORT_WAN=4$/CONFIG_RAETH_ESW_PORT_WAN=0/' \
  -e 's/^CONFIG_RAETH_ESW_PORT_LAN1=0$/CONFIG_RAETH_ESW_PORT_LAN1=1/' \
  -e 's/^CONFIG_RAETH_ESW_PORT_LAN2=1$/CONFIG_RAETH_ESW_PORT_LAN2=2/' \
  -e 's/^CONFIG_RAETH_ESW_PORT_LAN3=2$/CONFIG_RAETH_ESW_PORT_LAN3=3/' \
  -e 's/^CONFIG_RAETH_ESW_PORT_LAN4=3$/CONFIG_RAETH_ESW_PORT_LAN4=4/' \
  -e 's/^CONFIG_RT_FIRST_IF_RF_OFFSET=0x3f0000/CONFIG_RT_FIRST_IF_RF_OFFSET=0xff0000/' \
  "$CFG_BASE/kernel-3.4.x.config"

# board.mk
sed -i 's/TPLINK_FLASHLAYOUT=4Mmtk/TPLINK_FLASHLAYOUT=16Mmtk/' \
  "$CFG_BASE/board.mk"

# partition table
sed -i \
  -e 's/size:[[:space:]]*0x3C0000/size: 0xF90000/' \
  -e 's/offset:[[:space:]]*0x3D0000/offset: 0xFA0000/' \
  -e 's/size:[[:space:]]*0x10000/size: 0x40000/' \
  -e 's/offset:[[:space:]]*0x3E0000/offset: 0xFE0000/' \
  -e 's/offset:[[:space:]]*0x3F0000/offset: 0xFF0000/' \
  "$CFG_BASE/partitions.config"

# mktplinkfw
sed -i \
  -e 's/\.id[[:space:]]*=[[:space:]]*"4Mmtk"/.id = "16Mmtk"/' \
  -e 's/\.fw_max_len[[:space:]]*=[[:space:]]*0x3d0000/.fw_max_len = 0xf90000/' \
  "$TOOLS_BASE/mktplinkfw2.c"

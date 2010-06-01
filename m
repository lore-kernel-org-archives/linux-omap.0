From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [htcherald] Add board support for UARTs, bluetooth
Date: Tue,  1 Jun 2010 15:32:51 -0700
Message-ID: <1275431571-28547-4-git-send-email-darkstar6262@gmail.com>
References: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47672 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab0FAWdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 18:33:22 -0400
Received: by mail-gy0-f174.google.com with SMTP id 5so1624258gye.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 15:33:21 -0700 (PDT)
In-Reply-To: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This change adds bluetooth and UART initialization support to the
HTC Herald board driver.  This allows use of the serial bluetooth
adapter attached to UART1 using hciattach.

The defconfig was updated to add in bluetooth core support, as well
as to clean up some unneeded cruft.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/configs/htcherald_defconfig  |  159 +++++++++++----------------------
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap1/board-htcherald.c |   23 +++++
 3 files changed, 75 insertions(+), 109 deletions(-)

diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/htcherald_defconfig
index 26c8def..9272fa4 100644
--- a/arch/arm/configs/htcherald_defconfig
+++ b/arch/arm/configs/htcherald_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.34
-# Sun May 30 15:54:07 2010
+# Tue Jun  1 14:47:13 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -255,11 +255,11 @@ CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
-CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
-CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_SERIAL_WAKE is not set
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
 
@@ -338,7 +338,7 @@ CONFIG_PAGE_OFFSET=0xC0000000
 CONFIG_PREEMPT=y
 CONFIG_HZ=100
 CONFIG_AEABI=y
-CONFIG_OABI_COMPAT=y
+# CONFIG_OABI_COMPAT is not set
 CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
@@ -356,7 +356,7 @@ CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
 # CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
-CONFIG_LEDS=y
+# CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 # CONFIG_UACCESS_WITH_MEMCPY is not set
 
@@ -383,9 +383,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 ip=dhcp"
 #
 # At least one emulation must be selected
 #
-CONFIG_FPE_NWFPE=y
-# CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
@@ -482,21 +479,33 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_HAMRADIO is not set
 # CONFIG_CAN is not set
 # CONFIG_IRDA is not set
-# CONFIG_BT is not set
+CONFIG_BT=y
+CONFIG_BT_L2CAP=y
+# CONFIG_BT_L2CAP_EXT_FEATURES is not set
+CONFIG_BT_SCO=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+
+#
+# Bluetooth device drivers
+#
+# CONFIG_BT_HCIBTSDIO is not set
+CONFIG_BT_HCIUART=y
+# CONFIG_BT_HCIUART_H4 is not set
+# CONFIG_BT_HCIUART_BCSP is not set
+CONFIG_BT_HCIUART_LL=y
+# CONFIG_BT_HCIVHCI is not set
+# CONFIG_BT_MRVL is not set
 # CONFIG_AF_RXRPC is not set
-CONFIG_WIRELESS=y
-# CONFIG_CFG80211 is not set
-# CONFIG_LIB80211 is not set
-
-#
-# CFG80211 needs to be enabled for MAC80211
-#
-
-#
-# Some wireless drivers require a rate control algorithm
-#
+# CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
-# CONFIG_RFKILL is not set
+CONFIG_RFKILL=y
+CONFIG_RFKILL_LEDS=y
+CONFIG_RFKILL_INPUT=y
 # CONFIG_NET_9P is not set
 # CONFIG_CAIF is not set
 
@@ -527,32 +536,11 @@ CONFIG_BLK_DEV_LOOP=y
 # DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
 # CONFIG_BLK_DEV_NBD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MG_DISK is not set
-CONFIG_MISC_DEVICES=y
-# CONFIG_AD525X_DPOT is not set
-# CONFIG_ICS932S401 is not set
-# CONFIG_ENCLOSURE_SERVICES is not set
-# CONFIG_ISL29003 is not set
-# CONFIG_SENSORS_TSL2550 is not set
-# CONFIG_DS1682 is not set
-# CONFIG_TI_DAC7512 is not set
-# CONFIG_C2PORT is not set
-
-#
-# EEPROM support
-#
-# CONFIG_EEPROM_AT24 is not set
-# CONFIG_EEPROM_AT25 is not set
-# CONFIG_EEPROM_LEGACY is not set
-# CONFIG_EEPROM_MAX6875 is not set
-# CONFIG_EEPROM_93CX6 is not set
-# CONFIG_IWMC3200TOP is not set
+# CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -573,32 +561,10 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_PHYLIB is not set
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-# CONFIG_AX88796 is not set
-CONFIG_SMC91X=y
-# CONFIG_DM9000 is not set
-# CONFIG_ENC28J60 is not set
-# CONFIG_ETHOC is not set
-# CONFIG_SMC911X is not set
-# CONFIG_SMSC911X is not set
-# CONFIG_DNET is not set
-# CONFIG_IBM_NEW_EMAC_ZMII is not set
-# CONFIG_IBM_NEW_EMAC_RGMII is not set
-# CONFIG_IBM_NEW_EMAC_TAH is not set
-# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
-# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
-# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
-# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
-# CONFIG_B44 is not set
-# CONFIG_KS8842 is not set
-# CONFIG_KS8851 is not set
-# CONFIG_KS8851_MLL is not set
-CONFIG_NETDEV_1000=y
-CONFIG_NETDEV_10000=y
-CONFIG_WLAN=y
-# CONFIG_HOSTAP is not set
+# CONFIG_NET_ETHERNET is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -703,16 +669,17 @@ CONFIG_DEVKMEM=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=m
-CONFIG_SERIAL_8250_NR_UARTS=4
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_CONSOLE is not set
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
 # Non-8250 serial port support
 #
 # CONFIG_SERIAL_MAX3100 is not set
-CONFIG_SERIAL_CORE=m
+CONFIG_SERIAL_CORE=y
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_ALTERA_JTAGUART is not set
 # CONFIG_SERIAL_ALTERA_UART is not set
@@ -748,7 +715,7 @@ CONFIG_I2C_ALGOBIT=y
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
 # CONFIG_I2C_DESIGNWARE is not set
-CONFIG_I2C_GPIO=y
+# CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
 # CONFIG_I2C_SIMTEC is not set
@@ -945,7 +912,7 @@ CONFIG_HTC_I2CPLD=y
 # Graphics support
 #
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
@@ -981,10 +948,7 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_BACKLIGHT_GENERIC is not set
-# CONFIG_BACKLIGHT_OMAP1 is not set
-# CONFIG_BACKLIGHT_ADP8860 is not set
+# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
 
 #
 # Display device support
@@ -1020,6 +984,9 @@ CONFIG_HID=y
 #
 # Special HID drivers
 #
+CONFIG_HID_APPLE=y
+# CONFIG_HID_MAGICMOUSE is not set
+# CONFIG_HID_WACOM is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1207,14 +1174,8 @@ CONFIG_RTC_INTF_DEV=y
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT3_FS is not set
 # CONFIG_EXT4_FS is not set
-CONFIG_JBD=y
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -1265,25 +1226,7 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-CONFIG_MISC_FILESYSTEMS=y
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_LOGFS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_SQUASHFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_OMFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
@@ -1477,7 +1420,7 @@ CONFIG_CRYPTO_LZO=y
 # Random Number Generation
 #
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_HW is not set
 # CONFIG_BINARY_PRINTF is not set
 
 #
@@ -1486,7 +1429,7 @@ CONFIG_CRYPTO_HW=y
 CONFIG_BITREVERSE=y
 CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
-# CONFIG_CRC16 is not set
+CONFIG_CRC16=y
 # CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index ea231c7..3774be3 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 obj-$(CONFIG_AMS_DELTA_FIQ)		+= ams-delta-fiq.o ams-delta-fiq-handler.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
-obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
+obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o htc-bt.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index b1382a4..3fbd207 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -47,8 +47,10 @@
 #include <plat/keypad.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/mux.h>
 
 #include <mach/irqs.h>
+#include <mach/htc-bt.h>
 
 #include <linux/delay.h>
 
@@ -138,6 +140,7 @@ Happy Times         0 1 0 x  x x 0 x
 
 #define HTCPLD_GPIO_LED_DPAD		HTCPLD_BASE(0, 0)
 #define HTCPLD_GPIO_LED_KBD		HTCPLD_BASE(1, 0)
+#define HTCPLD_GPIO_BT_POWER		HTCPLD_BASE(1, 4)
 #define HTCPLD_GPIO_LED_CAPS		HTCPLD_BASE(1, 5)
 #define HTCPLD_GPIO_LED_RED_FLASH	HTCPLD_BASE(2, 1)
 #define HTCPLD_GPIO_LED_RED_SOLID	HTCPLD_BASE(2, 2)
@@ -423,6 +426,22 @@ static struct omap_mmc_platform_data htc_mmc1_data = {
 static struct omap_mmc_platform_data *htc_mmc_data[1];
 #endif
 
+/* Bluetooth */
+#define HTCHERALD_GPIO_BT_ENABLE 125
+
+static struct htc_bt_data htcherald_bt_data = {
+	.uart_clock	= "uart1_ck",
+	.gpio_pwr	= HTCPLD_GPIO_BT_POWER,
+	.gpio_enable	= HTCHERALD_GPIO_BT_ENABLE,
+};
+
+static struct platform_device bt_device = {
+	.name		= "htc-bt",
+	.id		= -1,
+	.dev = {
+		.platform_data = &htcherald_bt_data,
+	},
+};
 
 /* Platform devices for the Herald */
 static struct platform_device *devices[] __initdata = {
@@ -431,6 +450,7 @@ static struct platform_device *devices[] __initdata = {
 	&htcpld_device,
 	&gpio_leds_device,
 	&herald_gpiokeys_device,
+	&bt_device,
 };
 
 /*
@@ -574,6 +594,7 @@ done:
 	printk(KERN_INFO "USB setup complete.\n");
 }
 
+
 static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
@@ -595,6 +616,8 @@ static void __init htcherald_init(void)
 
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
+	omap_serial_init();
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 	htc_mmc_data[0] = &htc_mmc1_data;
 	omap1_init_mmc(htc_mmc_data, 1);
-- 
1.6.0.4


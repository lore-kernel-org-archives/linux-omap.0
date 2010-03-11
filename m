From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/19] omap2: Update n8x0 defconfig to test multi-omap and DMA
	api changes
Date: Thu, 11 Mar 2010 15:48:17 -0800
Message-ID: <20100311234817.4500.66809.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53101 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab0CKXqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:54 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Recent DMA API changes broke compile for tusb6010. While
testing the fixes for tusb6010, I had to update the n8x0
defconfig quite a bit. Might as well merge it while at it
to make it more usable as we're using this to test the
multi-omap booting between V6 and V7 ARMs.

Also, anybody using n8x0 with a current kernel will most
likely want to mount root on the MMC instead of the onenand
to keep the Maemo install intact.

Enable I2C, REGULATOR, MMC, MFD, PM, and USB. Also change the root
to /dev/mmcblk0p2 instead of the onenand.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/n8x0_defconfig |  160 +++++++++++++++++++++++++++++++++++----
 1 files changed, 142 insertions(+), 18 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index e6f667c..216ad00 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -191,6 +191,7 @@ CONFIG_ARCH_OMAP=y
 #
 CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
+CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_ARCH_OMAP2=y
 # CONFIG_ARCH_OMAP3 is not set
 # CONFIG_ARCH_OMAP4 is not set
@@ -198,8 +199,6 @@ CONFIG_ARCH_OMAP2=y
 #
 # OMAP Feature Selections
 #
-# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
-# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 # CONFIG_OMAP_MUX is not set
 # CONFIG_OMAP_MCBSP is not set
@@ -208,15 +207,13 @@ CONFIG_OMAP_MBOX_FWK=y
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
-# CONFIG_OMAP_LL_DEBUG_UART1 is not set
-# CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_PM_NONE is not set
+CONFIG_OMAP_PM_NOOP=y
 # CONFIG_MACH_OMAP_GENERIC is not set
 
 #
 # OMAP Core Type
 #
-CONFIG_ARCH_OMAP24XX=y
 CONFIG_ARCH_OMAP2420=y
 # CONFIG_ARCH_OMAP2430 is not set
 
@@ -227,6 +224,9 @@ CONFIG_MACH_OMAP2_TUSB6010=y
 # CONFIG_MACH_OMAP_H4 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
 # CONFIG_MACH_OMAP_2430SDP is not set
+CONFIG_MACH_NOKIA_N800=y
+CONFIG_MACH_NOKIA_N810=y
+CONFIG_MACH_NOKIA_N810_WIMAX=y
 CONFIG_MACH_NOKIA_N8X0=y
 
 #
@@ -303,7 +303,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x10C08000
 CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
-CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS2,115200n8"
+CONFIG_CMDLINE="root=/dev/mmcblk0p2 console=ttyS2,115200n8 debug earlyprintk rootwait"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -337,7 +337,14 @@ CONFIG_HAVE_AOUT=y
 #
 # Power management options
 #
-# CONFIG_PM is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
+CONFIG_PM_OPS=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
@@ -617,7 +624,55 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_COMPAT is not set
+# CONFIG_I2C_CHARDEV is not set
+# CONFIG_I2C_HELPER_AUTO is not set
+# CONFIG_I2C_SMBUS is not set
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 CONFIG_SPI=y
 # CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
@@ -673,15 +728,44 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_CORE is not set
+# CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_HTC_I2CPLD is not set
+# CONFIG_TPS65010 is not set
+CONFIG_MENELAUS=y
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
 # CONFIG_EZX_PCAP is not set
+# CONFIG_AB4500_CORE is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_DUMMY is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+# CONFIG_REGULATOR_MAX8649 is not set
+# CONFIG_REGULATOR_MAX8660 is not set
+# CONFIG_REGULATOR_LP3971 is not set
+# CONFIG_REGULATOR_TPS65023 is not set
+# CONFIG_REGULATOR_TPS6507X is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
@@ -718,7 +802,10 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 # CONFIG_USB_MON is not set
 # CONFIG_USB_WUSB is not set
 # CONFIG_USB_WUSB_CBAF is not set
@@ -737,9 +824,10 @@ CONFIG_USB_DEVICE_CLASS=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_TUSB6010=y
 # CONFIG_USB_MUSB_HOST is not set
-CONFIG_USB_MUSB_PERIPHERAL=y
-# CONFIG_USB_MUSB_OTG is not set
+# CONFIG_USB_MUSB_PERIPHERAL is not set
+CONFIG_USB_MUSB_OTG=y
 CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_USB_MUSB_HDRC_HCD=y
 # CONFIG_MUSB_PIO_ONLY is not set
 # CONFIG_USB_INVENTRA_DMA is not set
 # CONFIG_USB_TI_CPPI_DMA is not set
@@ -824,44 +912,77 @@ CONFIG_USB_GADGET_DUALSPEED=y
 # CONFIG_USB_ZERO is not set
 # CONFIG_USB_AUDIO is not set
 CONFIG_USB_ETH=y
-# CONFIG_USB_ETH_RNDIS is not set
+CONFIG_USB_ETH_RNDIS=y
+CONFIG_USB_ETH_EEM=y
 # CONFIG_USB_GADGETFS is not set
 # CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_MASS_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+# CONFIG_USB_G_NOKIA is not set
+# CONFIG_USB_G_MULTI is not set
 
 #
 # OTG and related infrastructure
 #
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_USB_ULPI is not set
 CONFIG_NOP_USB_XCEIV=y
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_OMAP=y
+# CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
-# CONFIG_REGULATOR is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
 # File systems
 #
 # CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
@@ -886,8 +1007,11 @@ CONFIG_INOTIFY_USER=y
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #


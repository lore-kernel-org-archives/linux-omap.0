From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [RFC/PATCH 3/3] OMAP3 EVM: enable ethernet support
Date: Thu, 8 May 2008 09:49:13 -0700
Message-ID: <5e088bd90805080949t1d489848k26235ee7762488ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:3844 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765029AbYEHQtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:49:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so566469fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:49:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

OMAP3 EVM: enable smc911x driver in defconfig

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/configs/omap3_evm_defconfig |   46 ++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig
b/arch/arm/configs/omap3_evm_defconfig
index 4a7aa3a..43ae0c8 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-omap1
-# Tue Apr 29 08:06:20 2008
+# Linux kernel version: 2.6.26-rc1-omap1
+# Thu May  8 08:18:45 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -87,12 +87,14 @@ CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
@@ -260,6 +262,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -307,7 +310,6 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 # CONFIG_SUSPEND is not set
 # CONFIG_APM_EMULATION is not set
@@ -497,7 +499,8 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
-# CONFIG_HAVE_IDE is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set

 #
 # SCSI device support
@@ -549,7 +552,19 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+CONFIG_SMC911X=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set

@@ -558,6 +573,7 @@ CONFIG_NETDEVICES=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI is not set
 # CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
@@ -599,10 +615,10 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
-# CONFIG_TOUCHSCREEN_UCB1400 is not set
 # CONFIG_TOUCHSCREEN_TSC2005 is not set
 # CONFIG_TOUCHSCREEN_TSC2102 is not set
 # CONFIG_TOUCHSCREEN_TSC210X is not set
+# CONFIG_TOUCHSCREEN_UCB1400 is not set
 # CONFIG_INPUT_MISC is not set

 #
@@ -618,6 +634,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set

 #
@@ -687,10 +704,6 @@ CONFIG_TWL4030_USB_HS_ULPI=y
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# SPI support
-#
 CONFIG_SPI=y
 # CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
@@ -750,8 +763,16 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+
+#
+# Multimedia drivers
+#
 CONFIG_DAB=y

 #
@@ -769,6 +790,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
 # CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
 # CONFIG_FB_SYS_FOPS is not set
 CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
@@ -992,6 +1014,7 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1002,6 +1025,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -1118,6 +1142,8 @@ CONFIG_CRYPTO_HW=y
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_GENERIC_FIND_NEXT_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
-- 
1.5.4.5

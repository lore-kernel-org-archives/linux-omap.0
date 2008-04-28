From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Enable TSC2301 drivers in N800 defconfig
Date: Mon, 28 Apr 2008 11:08:34 +0300
Message-ID: <1209370114-17007-2-git-send-email-jarkko.nikula@nokia.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30793 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765660AbYD1IIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 04:08:15 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3S89opl029025
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 03:10:48 -0500
In-Reply-To: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

Commit b11689b7a741b18d612ace8dac231a030f947b90 enable drivers for chips
used in Nokia N810 but disable drivers for TSC2301 which is used in N800.
This patch enable them back.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/configs/n800_defconfig |  136 ++++++++++++++++++++++++++-------------
 1 files changed, 91 insertions(+), 45 deletions(-)

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index a8e133c..98b4db0 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc8-omap1
-# Tue Apr  8 15:34:27 2008
+# Linux kernel version: 2.6.25-omap1
+# Mon Apr 28 10:58:14 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -148,7 +148,7 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_MXC is not set
-# CONFIG_ARCH_ORION is not set
+# CONFIG_ARCH_ORION5X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -172,6 +172,8 @@ CONFIG_ARCH_OMAP2=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_DEBUG_SRAM_PATCH=y
+# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
+# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -366,8 +368,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETLABEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
@@ -657,6 +657,7 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -713,6 +714,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 # CONFIG_KEYBOARD_OMAP is not set
+CONFIG_KEYBOARD_TSC2301=y
 CONFIG_KEYBOARD_LM8323=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -732,6 +734,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_TSC2005=y
 # CONFIG_TOUCHSCREEN_TSC2102 is not set
 # CONFIG_TOUCHSCREEN_TSC210X is not set
+CONFIG_TOUCHSCREEN_TSC2301=y
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -784,13 +787,6 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_GPIO is not set
@@ -801,6 +797,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -845,7 +842,8 @@ CONFIG_SPI_OMAP24XX=y
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
-# CONFIG_SPI_TSC2301 is not set
+CONFIG_SPI_TSC2301=y
+CONFIG_SPI_TSC2301_AUDIO=y
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
@@ -944,33 +942,51 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
 CONFIG_VIDEO_DEV=y
 CONFIG_VIDEO_V4L2_COMMON=y
-# CONFIG_VIDEO_V4L1 is not set
-# CONFIG_VIDEO_V4L1_COMPAT is not set
+CONFIG_VIDEO_ALLOW_V4L1=y
+CONFIG_VIDEO_V4L1_COMPAT=y
 CONFIG_VIDEO_V4L2=y
+CONFIG_VIDEO_V4L1=y
 CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 CONFIG_VIDEO_TCM825X=y
 # CONFIG_VIDEO_VIVI is not set
+# CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_CPIA2 is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
+# CONFIG_TUNER_3036 is not set
+# CONFIG_VIDEO_AU0828 is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
 CONFIG_VIDEO_OMAP2=y
 CONFIG_V4L_USB_DRIVERS=y
 # CONFIG_VIDEO_PVRUSB2 is not set
 # CONFIG_VIDEO_EM28XX is not set
 # CONFIG_VIDEO_USBVISION is not set
+# CONFIG_USB_VICAM is not set
+# CONFIG_USB_IBMCAM is not set
+# CONFIG_USB_KONICAWC is not set
+# CONFIG_USB_QUICKCAM_MESSENGER is not set
 # CONFIG_USB_ET61X251 is not set
+# CONFIG_VIDEO_OVCAMCHIP is not set
+# CONFIG_USB_W9968CF is not set
+# CONFIG_USB_OV511 is not set
+# CONFIG_USB_SE401 is not set
 # CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_STV680 is not set
 # CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_PWC is not set
 # CONFIG_USB_ZR364XX is not set
 # CONFIG_USB_STKWEBCAM is not set
+# CONFIG_SOC_CAMERA is not set
 CONFIG_RADIO_ADAPTERS=y
 CONFIG_RADIO_TEA5761=y
 # CONFIG_USB_DSBR is not set
@@ -1083,11 +1099,11 @@ CONFIG_SND_OMAP24XX_EAC=y
 # CONFIG_SND_SOC is not set
 
 #
-# SoC Audio support for SuperH
+# ALSA SoC audio for Freescale SOCs
 #
 
 #
-# ALSA SoC audio for Freescale SOCs
+# SoC Audio for the Texas Instruments OMAP
 #
 
 #
@@ -1267,6 +1283,7 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_UIO is not set
 
 #
 # CBUS support
@@ -1304,7 +1321,6 @@ CONFIG_FS_MBCACHE=m
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
@@ -1460,6 +1476,7 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
@@ -1484,48 +1501,77 @@ CONFIG_SECURITY=y
 # CONFIG_SECURITY_LOWMEM is not set
 CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Crypto core or helper
+#
 # CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-# CONFIG_CRYPTO_ECB is not set
-# CONFIG_CRYPTO_CBC is not set
-# CONFIG_CRYPTO_PCBC is not set
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-# CONFIG_CRYPTO_DES is not set
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 
-- 
1.5.4.4


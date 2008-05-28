From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 1/4] OMAP3 Beagle: enable mmc in defconfig
Date: Tue, 27 May 2008 22:45:29 -0700
Message-ID: <5e088bd90805272245y586f8539n3a166617e0c25d79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:42899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbYE1Fpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 01:45:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1695070fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 22:45:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Enable mmc in defconfig

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/configs/omap3_beagle_defconfig |  156 +++++++++++++++++++++----------
 1 files changed, 105 insertions(+), 51 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig
b/arch/arm/configs/omap3_beagle_defconfig
index 9e4a4a5..a3ccc93 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc9-omap1
-# Wed Apr 16 16:27:20 2008
+# Linux kernel version: 2.6.26-rc3-omap1
+# Tue May 27 21:51:03 2008
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
@@ -145,7 +147,7 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_MXC is not set
-# CONFIG_ARCH_ORION is not set
+# CONFIG_ARCH_ORION5X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -169,6 +171,8 @@ CONFIG_ARCH_OMAP3=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_DEBUG_SRAM_PATCH=y
+# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
+# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -191,6 +195,7 @@ CONFIG_ARCH_OMAP3430=y
 #
 # OMAP Board Type
 #
+# CONFIG_MACH_OMAP_LDP is not set
 # CONFIG_MACH_OMAP_3430SDP is not set
 # CONFIG_MACH_OMAP3EVM is not set
 CONFIG_MACH_OMAP3_BEAGLE=y
@@ -224,7 +229,7 @@ CONFIG_CPU_CP15_MMU=y
 # Processor Features
 #
 CONFIG_ARM_THUMB=y
-# CONFIG_ARM_XENON is not set
+# CONFIG_ARM_THUMBEE is not set
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
@@ -258,6 +263,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -305,7 +311,6 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 # CONFIG_SUSPEND is not set
 # CONFIG_APM_EMULATION is not set
@@ -357,8 +362,6 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -426,7 +429,8 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
-# CONFIG_HAVE_IDE is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set

 #
 # SCSI device support
@@ -487,6 +491,7 @@ CONFIG_NETDEVICES=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -533,6 +538,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set

 #
@@ -566,13 +572,6 @@ CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y

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
@@ -582,6 +581,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set

 #
 # Miscellaneous I2C Chip support
@@ -598,21 +598,17 @@ CONFIG_TWL4030_CORE=y
 CONFIG_TWL4030_GPIO=y
 # CONFIG_TWL4030_MADC is not set
 CONFIG_TWL4030_USB=y
-# CONFIG_TWL4030_PWRBUTTON is not set
 CONFIG_TWL4030_USB_HS_ULPI=y
+# CONFIG_TWL4030_PWRBUTTON is not set
 # CONFIG_TWL4030_POWEROFF is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_LP5521 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 CONFIG_HAVE_GPIO_LIB=y

 #
@@ -645,12 +641,23 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set

 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
 CONFIG_DAB=y

 #
@@ -678,10 +685,25 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_UIO is not set

 #
 # CBUS support
@@ -702,7 +724,6 @@ CONFIG_JBD=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
@@ -767,7 +788,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -853,6 +873,7 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -863,6 +884,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -877,6 +899,7 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
@@ -898,50 +921,79 @@ CONFIG_DEBUG_LL=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
-# CONFIG_CRYPTO_SEQIV is not set
 CONFIG_CRYPTO_MANAGER=y
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
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
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
 CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-CONFIG_CRYPTO_DES=y
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
+CONFIG_CRYPTO_DES=y
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

@@ -949,6 +1001,8 @@ CONFIG_CRYPTO_HW=y
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

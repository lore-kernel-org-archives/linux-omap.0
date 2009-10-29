From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 4/4] Audio: Modifying the defconfig for OMAP3517 / AM3517 EVM
Date: Fri, 30 Oct 2009 00:22:59 +0530
Message-ID: <1256842379-30484-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbZJ2SxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 14:53:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

Enabling Audio for OMAP3517 / AM3517 EVM in the defconfig.

Also enabling McBSP and I2C drivers as both are required for
audio on this EVM.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   78 +++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index 787f295..316cbaa 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -202,7 +202,7 @@ CONFIG_ARCH_OMAP3=y
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 # CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_MCBSP is not set
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
@@ -590,7 +590,46 @@ CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=y
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
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
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
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -666,7 +705,40 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_SOUND is not set
+CONFIG_SOUND=y
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_HRTIMER is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
+CONFIG_SND_DRIVERS=y
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+CONFIG_SND_ARM=y
+CONFIG_SND_SOC=y
+CONFIG_SND_OMAP_SOC=y
+CONFIG_SND_OMAP_SOC_MCBSP=y
+CONFIG_SND_OMAP_SOC_AM3517EVM=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+# CONFIG_SND_SOC_ALL_CODECS is not set
+CONFIG_SND_SOC_TLV320AIC23=y
+# CONFIG_SOUND_PRIME is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
-- 
1.6.2.4


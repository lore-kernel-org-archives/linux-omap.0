From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 2/2] OMAP3 EVM: enable spi, touchscreen, and ads7846 driver in defconfig
Date: Tue, 6 May 2008 19:38:30 -0700
Message-ID: <5e088bd90805061938n3f31ac03l5b7d58c218db55ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:15952 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbYEGCic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 22:38:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so101158fkq.5
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 19:38:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

Enable spi, touchscreen, and ADS7846 in omap3_evm_defconfig

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 omap3_evm_defconfig |   42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)
--- a/arch/arm/configs/omap3_evm_defconfig	2008-04-26 06:32:11.000000000 -0700
+++ b/arch/arm/configs/omap3_evm_defconfig	2008-04-28 08:14:22.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-omap1
-# Mon Apr 28 10:21:40 2008
+# Tue Apr 29 08:06:20 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -459,6 +459,8 @@ CONFIG_MTD_CFI_I2=y
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -587,7 +589,20 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TSC2005 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_TOUCHSCREEN_TSC210X is not set
 # CONFIG_INPUT_MISC is not set

 #
@@ -676,8 +691,26 @@ CONFIG_TWL4030_USB_HS_ULPI=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+CONFIG_SPI_OMAP24XX=m
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_TSC2101 is not set
+# CONFIG_SPI_TSC2102 is not set
+# CONFIG_SPI_TSC210X is not set
+# CONFIG_SPI_TSC2301 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y

 #
@@ -694,6 +727,7 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set

From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [htcherald] Update defconfig for SPI/touchscreen
Date: Sun, 30 May 2010 15:56:23 -0700
Message-ID: <1275260183-11207-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54674 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab0E3W4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 May 2010 18:56:45 -0400
Received: by gwaa12 with SMTP id a12so2275720gwa.19
        for <linux-omap@vger.kernel.org>; Sun, 30 May 2010 15:56:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change updates the htcherald_defconfig to add in SPI100k
and ads7684 touchscreen support.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/configs/htcherald_defconfig |   73 ++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/htcherald_defconfig
index 42deef6..26c8def 100644
--- a/arch/arm/configs/htcherald_defconfig
+++ b/arch/arm/configs/htcherald_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.34
-# Fri May 28 21:34:49 2010
+# Sun May 30 15:54:07 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -541,12 +541,14 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_ISL29003 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_DS1682 is not set
+# CONFIG_TI_DAC7512 is not set
 # CONFIG_C2PORT is not set
 
 #
 # EEPROM support
 #
 # CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_EEPROM_LEGACY is not set
 # CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_EEPROM_93CX6 is not set
@@ -577,6 +579,7 @@ CONFIG_MII=y
 # CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
 # CONFIG_ETHOC is not set
 # CONFIG_SMC911X is not set
 # CONFIG_SMSC911X is not set
@@ -590,6 +593,7 @@ CONFIG_SMC91X=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_B44 is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
 # CONFIG_KS8851_MLL is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
@@ -649,7 +653,30 @@ CONFIG_KEYBOARD_OMAP=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_AD7877 is not set
+# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
+# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
+# CONFIG_TOUCHSCREEN_AD7879 is not set
+# CONFIG_TOUCHSCREEN_DYNAPRO is not set
+# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
+# CONFIG_TOUCHSCREEN_EETI is not set
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
+# CONFIG_TOUCHSCREEN_MCS5000 is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_INEXIO is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
+# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
+# CONFIG_TOUCHSCREEN_TSC2007 is not set
+# CONFIG_TOUCHSCREEN_W90X900 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -684,6 +711,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=m
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_ALTERA_JTAGUART is not set
@@ -740,7 +768,24 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_SPI is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
+# CONFIG_SPI_OMAP_UWIRE is not set
+CONFIG_SPI_OMAP_100K=y
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 
 #
 # PPS support
@@ -771,6 +816,9 @@ CONFIG_GPIOLIB=y
 #
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
 
 #
 # AC97 GPIO expanders:
@@ -786,6 +834,7 @@ CONFIG_HWMON=y
 #
 # CONFIG_SENSORS_AD7414 is not set
 # CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADCXX is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
@@ -807,6 +856,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_LM73 is not set
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_LM77 is not set
@@ -821,6 +871,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_LTC4215 is not set
 # CONFIG_SENSORS_LTC4245 is not set
 # CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1111 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
@@ -833,6 +884,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_ADS7871 is not set
 # CONFIG_SENSORS_AMC6821 is not set
 # CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_TMP102 is not set
@@ -847,6 +899,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83L786NG is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_LIS3_SPI is not set
 # CONFIG_SENSORS_LIS3_I2C is not set
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
@@ -881,7 +934,10 @@ CONFIG_HTC_I2CPLD=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
 # CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_AB4500_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -919,6 +975,7 @@ CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_BROADSHEET is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
@@ -1042,6 +1099,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 CONFIG_MMC_OMAP=y
+# CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -1054,6 +1112,7 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_GPIO_PLATFORM=y
 # CONFIG_LEDS_LP3944 is not set
 # CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_DAC124S085 is not set
 # CONFIG_LEDS_BD2802 is not set
 # CONFIG_LEDS_LT3593 is not set
 CONFIG_LEDS_TRIGGERS=y
@@ -1108,6 +1167,14 @@ CONFIG_RTC_INTF_DEV=y
 #
 # SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
 
 #
 # Platform RTC drivers
-- 
1.7.0.4


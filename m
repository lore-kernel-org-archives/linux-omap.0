From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/2] Enable LEDs in pandora defconfig
Date: Thu, 27 Nov 2008 12:02:43 +0200
Message-ID: <1227780163-5879-2-git-send-email-notasas@gmail.com>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:35108 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYK0KDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:03:22 -0500
Received: by ey-out-2122.google.com with SMTP id 6so384193eyi.37
        for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 02:03:20 -0800 (PST)
In-Reply-To: <1227780163-5879-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/configs/omap3_pandora_defconfig |   51 +++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index 1c2b7a2..e8cfbe9 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28-rc3-omap1
-# Wed Nov  5 22:02:43 2008
+# Linux kernel version: 2.6.28-rc6-omap1
+# Thu Nov 27 00:25:13 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -418,7 +418,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
@@ -777,6 +779,10 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
 
 #
+# Memory mapped GPIO expanders:
+#
+
+#
 # I2C GPIO expanders:
 #
 # CONFIG_GPIO_MAX732X is not set
@@ -799,11 +805,11 @@ CONFIG_GPIO_TWL4030=y
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -871,6 +877,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
@@ -967,7 +974,6 @@ CONFIG_USB_MON=y
 # CONFIG_USB_C67X00_HCD is not set
 # CONFIG_USB_EHCI_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
-# CONFIG_USB_ISP1760_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
@@ -997,11 +1003,11 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# see USB_STORAGE Help for more information
 #
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_LIBUSUAL is not set
@@ -1090,7 +1096,27 @@ CONFIG_MMC_OMAP_HS=y
 # CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+# CONFIG_LEDS_OMAP_DEBUG is not set
+# CONFIG_LEDS_OMAP is not set
+# CONFIG_LEDS_OMAP_PWM is not set
+# CONFIG_LEDS_PCA9532 is not set
+CONFIG_LEDS_GPIO=y
+# CONFIG_LEDS_PCA955X is not set
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -1122,12 +1148,14 @@ CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_TWL4030=y
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
 
 #
 # SPI RTC drivers
 #
 # CONFIG_RTC_DRV_M41T94 is not set
 # CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
 # CONFIG_RTC_DRV_MAX6902 is not set
 # CONFIG_RTC_DRV_R9701 is not set
 # CONFIG_RTC_DRV_RS5C348 is not set
@@ -1152,14 +1180,7 @@ CONFIG_RTC_DRV_TWL4030=y
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-
-#
-# Voltage and Current regulators
-#
 # CONFIG_REGULATOR is not set
-# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
-# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
-# CONFIG_REGULATOR_BQ24022 is not set
 # CONFIG_UIO is not set
 
 #
-- 
1.5.4.3


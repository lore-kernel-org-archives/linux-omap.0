From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 2/4] OMAP3 Beagle: enable rtc in defconfig
Date: Tue, 27 May 2008 22:45:52 -0700
Message-ID: <5e088bd90805272245i16b7dbc3r25f07378fa1eec1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:42899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYE1Fpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 01:45:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1695070fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 22:45:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Enable rtc in defconfig

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/configs/omap3_beagle_defconfig |   52 +++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig
b/arch/arm/configs/omap3_beagle_defconfig
index a3ccc93..c4027ad 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.26-rc3-omap1
-# Tue May 27 21:51:03 2008
+# Tue May 27 22:02:02 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -702,7 +702,55 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 CONFIG_MMC_OMAP_HS=y
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+CONFIG_RTC_DRV_TWL4030=y
+# CONFIG_RTC_DRV_S35390A is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
 # CONFIG_UIO is not set

 #
-- 
1.5.4.5

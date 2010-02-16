From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 23/24] omap4: Enable RTC and regulator support
Date: Tue, 16 Feb 2010 21:28:14 +0530
Message-ID: <1266335895-32741-23-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54283 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757054Ab0BPP6i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:38 -0500
In-Reply-To: <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Balaji T K <balajitk@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch enables RTC and regulator support on omap4430 sdp
platform. These are i2c slave devices and hence kernel needs
i2c driver suport to make it work.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index d791e63..339b154 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -520,11 +520,12 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+CONFIG_TWL4030_CORE=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
@@ -553,12 +554,27 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
 
 #
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+
+#
+# I2C TWL drivers
+#
+CONFIG_RTC_DRV_TWL4030=y
+CONFIG_REGULATOR_TWL4030=y
+
+#
 # TI VLYNQ
 #
 # CONFIG_STAGING is not set
-- 
1.6.0.4


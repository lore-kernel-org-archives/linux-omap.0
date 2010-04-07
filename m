From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/6] omap4: Enable RTC and regulator support
Date: Wed,  7 Apr 2010 13:17:26 +0530
Message-ID: <1270626446-10841-7-git-send-email-santosh.shilimkar@ti.com>
References: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-4-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-5-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-6-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab0DGHrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 03:47:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o377lUN7028866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 02:47:32 -0500
In-Reply-To: <1270626446-10841-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch enables RTC and regulator support on omap4430 sdp
platform.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 79b3ab1..b7ddc7a 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -523,11 +523,12 @@ CONFIG_SSB_POSSIBLE=y
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
@@ -556,12 +557,27 @@ CONFIG_DUMMY_CONSOLE=y
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


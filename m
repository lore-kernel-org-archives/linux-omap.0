From: Francisco Alecrim <alecrim@gmail.com>
Subject: [PATCH] n8x0_defconfig: active cbus, retu-wd and omap-wd
Date: Wed,  6 Jan 2010 22:20:00 -0400
Message-ID: <1262830800-30192-1-git-send-email-alecrim@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:50373 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631Ab0AGC1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 21:27:38 -0500
Received: by yxe26 with SMTP id 26so17289467yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 18:27:37 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>, Francisco Alecrim <alecrim@gmail.com>

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

It's critical for correct n8x0 operation. Device turn power-off after some
seconds without these options.

Signed-off-by: Francisco Alecrim <alecrim@gmail.com>
---
 arch/arm/configs/n8x0_defconfig |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index e6f667c..66b1d3f 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -661,7 +661,19 @@ CONFIG_GPIOLIB=y
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
 #
@@ -851,6 +863,18 @@ CONFIG_RTC_LIB=y
 # CONFIG_STAGING is not set
 
 #
+# CBUS support
+#
+CONFIG_CBUS=y
+# CONFIG_CBUS_TAHVO is not set
+CONFIG_CBUS_RETU=y
+# CONFIG_CBUS_RETU_USER is not set
+# CONFIG_CBUS_RETU_POWERBUTTON is not set
+# CONFIG_CBUS_RETU_RTC is not set
+CONFIG_CBUS_RETU_WDT=y
+# CONFIG_CBUS_RETU_HEADSET is not set
+
+#
 # File systems
 #
 # CONFIG_EXT2_FS is not set
-- 
1.6.3.3


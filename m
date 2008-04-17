From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: TWL4030: Fix Kconfig
Date: Thu, 17 Apr 2008 17:43:56 +0300
Message-ID: <1208443436-26722-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61930 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757103AbYDQOpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:45:05 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3HEgn7R003740
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 09:47:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f3ea82d..5cf4657 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -160,10 +160,6 @@ choice
 	  TWL4030 USB transceiver can operate in various
 	  mutually-exclusive modes. Select one of them.
 
-config TWL4030_PWRBUTTON
-        bool "TWL4030 Power button Driver"
-	depends on TWL4030_CORE
-
 config TWL4030_USB_HS_ULPI
 	depends on TWL4030_USB
 	bool "High-speed ULPI"
@@ -173,6 +169,10 @@ config TWL4030_USB_HS_ULPI
 
 endchoice
 
+config TWL4030_PWRBUTTON
+        bool "TWL4030 Power button Driver"
+	depends on TWL4030_CORE
+
 config TWL4030_POWEROFF
 	bool "TWL4030 device poweroff"
 	depends on TWL4030_CORE
-- 
1.5.5.49.gf43e2


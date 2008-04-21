From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: TWL4030: Fix Kconfig
Date: Mon, 21 Apr 2008 12:19:14 +0300
Message-ID: <1208769554-11100-1-git-send-email-felipe.balbi@nokia.com>
References: <20080418190214.GH12099@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59118 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbYDUJUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 05:20:24 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3L9MPsR020101
	for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2008 04:22:50 -0500
In-Reply-To: <20080418190214.GH12099@atomide.com>
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
index f3ea82d..cba8abf 100644
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
+	bool "TWL4030 Power button Driver"
+	depends on TWL4030_CORE
+
 config TWL4030_POWEROFF
 	bool "TWL4030 device poweroff"
 	depends on TWL4030_CORE
-- 
1.5.5.67.g9a49


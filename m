From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/4] i2c: allow twl modules to be built as modules
Date: Fri, 13 Jun 2008 13:04:02 +0300
Message-ID: <1213351443-3336-4-git-send-email-felipe.balbi@nokia.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com>
 <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
 <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36000 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbYFMKFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 06:05:40 -0400
In-Reply-To: <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

Besides twl core and twl gpio, all the others can
be dynamically linked.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index cba8abf..b421727 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -150,7 +150,7 @@ config TWL4030_MADC
 	  called twl4030-madc.ko
 
 config TWL4030_USB
-	bool "TWL4030 USB Transceiver Driver"
+	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
 
 choice
@@ -170,11 +170,11 @@ config TWL4030_USB_HS_ULPI
 endchoice
 
 config TWL4030_PWRBUTTON
-	bool "TWL4030 Power button Driver"
+	tristate "TWL4030 Power button Driver"
 	depends on TWL4030_CORE
 
 config TWL4030_POWEROFF
-	bool "TWL4030 device poweroff"
+	tristate "TWL4030 device poweroff"
 	depends on TWL4030_CORE
 
 config SENSORS_MAX6875
-- 
1.5.6.rc1


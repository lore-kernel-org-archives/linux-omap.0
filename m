From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] cbus: Kconfig cleanup
Date: Thu, 16 Jun 2011 14:27:17 +0300
Message-ID: <1308223638-9634-3-git-send-email-balbi@ti.com>
References: <1308223638-9634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34632 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456Ab1FPL1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 07:27:30 -0400
Received: by mail-fx0-f41.google.com with SMTP id 18so1261295fxm.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 04:27:29 -0700 (PDT)
In-Reply-To: <1308223638-9634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

trivial, no functional changes. While at
that, also drop the OMAP dependency as
there's no need for that.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Kconfig |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/cbus/Kconfig b/drivers/cbus/Kconfig
index d845a7e..938d244 100644
--- a/drivers/cbus/Kconfig
+++ b/drivers/cbus/Kconfig
@@ -5,7 +5,6 @@
 menu "CBUS support"
 
 config CBUS
-	depends on ARCH_OMAP
 	bool "CBUS support on OMAP"
 	---help---
 	  CBUS is a proprietary serial protocol by Nokia.  It is mainly
@@ -21,8 +20,10 @@ config CBUS_TAHVO
 
 	  If you want Tahvo support, you should say Y here.
 
+if CBUS_TAHVO
+
 config CBUS_TAHVO_USB
-	depends on CBUS_TAHVO && USB
+	depends on USB
 	select USB_OTG_UTILS
 	tristate "Support for Tahvo USB transceiver"
 	---help---
@@ -35,6 +36,8 @@ config CBUS_TAHVO_USB_HOST_BY_DEFAULT
 	  Say Y here, if you want the device to enter USB host mode
 	  by default on bootup.
 
+endif # CBUS_TAHVO
+
 config CBUS_RETU
 	depends on CBUS
 	bool "Support for Retu"
@@ -43,8 +46,10 @@ config CBUS_RETU
 
 	  If you want Retu support, you should say Y here.
 
+if CBUS_RETU
+
 config CBUS_RETU_POWERBUTTON
-	depends on CBUS_RETU
+	depends on INPUT
 	bool "Support for Retu power button"
 	---help---
 	  The power button on Nokia 770 is connected to the Retu ASIC.
@@ -52,25 +57,27 @@ config CBUS_RETU_POWERBUTTON
 	  If you want support for the Retu power button, you should say Y here.
 
 config CBUS_RETU_RTC
-	depends on CBUS_RETU && RTC_CLASS
+	depends on RTC_CLASS
 	tristate "Support for Retu pseudo-RTC"
 	---help---
 	  Say Y here if you want support for the device that alleges to be an
 	  RTC in Retu. This will expose a sysfs interface for it.
 
 config CBUS_RETU_WDT
-	depends on CBUS_RETU && SYSFS && WATCHDOG
+	depends on SYSFS && WATCHDOG
 	tristate "Support for Retu watchdog timer"
 	---help---
 	  Say Y here if you want support for the watchdog in Retu. This will
 	  expose a sysfs interface to grok it.
 
 config CBUS_RETU_HEADSET
-	depends on CBUS_RETU && SYSFS
+	depends on SYSFS
 	tristate "Support for headset detection with Retu/Vilma"
 	---help---
 	  Say Y here if you want support detecting a headset that's connected
 	  to Retu/Vilma. Detection state and events are exposed through
 	  sysfs.
 
+endif # CBUS_RETU
+
 endmenu
-- 
1.7.6.rc1


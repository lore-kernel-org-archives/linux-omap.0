From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 27/27] cbus: mark dependencies for ARCH_OMAP
Date: Thu, 13 Oct 2011 11:35:02 +0300
Message-ID: <1318494902-13093-27-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53381 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab1JMIgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:36:03 -0400
Received: by bkbzu5 with SMTP id zu5so592547bkb.0
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:36:00 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

This is just a temporary commit. Ideally, all
these drivers wouldn't depend on a particular
architecture, but some of those Retu/Tahvo
children are using headers under <plat>, so
we must add this dependency until that's sorted
out.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/Kconfig b/drivers/cbus/Kconfig
index 938d244..41d96e7 100644
--- a/drivers/cbus/Kconfig
+++ b/drivers/cbus/Kconfig
@@ -24,6 +24,7 @@ if CBUS_TAHVO
 
 config CBUS_TAHVO_USB
 	depends on USB
+	depends on ARCH_OMAP
 	select USB_OTG_UTILS
 	tristate "Support for Tahvo USB transceiver"
 	---help---
@@ -58,6 +59,7 @@ config CBUS_RETU_POWERBUTTON
 
 config CBUS_RETU_RTC
 	depends on RTC_CLASS
+	depends on ARCH_OMAP
 	tristate "Support for Retu pseudo-RTC"
 	---help---
 	  Say Y here if you want support for the device that alleges to be an
@@ -65,6 +67,7 @@ config CBUS_RETU_RTC
 
 config CBUS_RETU_WDT
 	depends on SYSFS && WATCHDOG
+	depends on ARCH_OMAP
 	tristate "Support for Retu watchdog timer"
 	---help---
 	  Say Y here if you want support for the watchdog in Retu. This will
-- 
1.7.6.396.ge0613


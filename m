From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 12/13] cbus: Makefile: re-enable retu-wdt
Date: Thu,  3 Feb 2011 12:20:27 +0200
Message-ID: <1296728428-26399-13-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54792 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab1BCKVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:21:12 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so1029188fxm.30
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:21:10 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Now that all conversions have been made,
reenable retu-wdt driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/Makefile b/drivers/cbus/Makefile
index 7bfd997..c5c3940 100644
--- a/drivers/cbus/Makefile
+++ b/drivers/cbus/Makefile
@@ -8,8 +8,7 @@ obj-$(CONFIG_CBUS_RETU)		+= retu.o
 obj-$(CONFIG_CBUS_TAHVO_USB)	+= tahvo-usb.o
 obj-$(CONFIG_CBUS_TAHVO_USER)	+= tahvo-user.o
 
-## Disable Retu children until converted to threaded IRQ
 obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
 obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
-#obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
+obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
 obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
-- 
1.7.4.rc2


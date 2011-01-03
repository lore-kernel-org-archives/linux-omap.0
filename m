From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 10/10] cbus: Makefile: re-enable retu-wdt
Date: Mon,  3 Jan 2011 09:49:48 +0200
Message-ID: <1294040988-21191-11-git-send-email-balbi@ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47750 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752991Ab1ACHu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 02:50:26 -0500
Received: by ewy24 with SMTP id 24so6196065ewy.13
        for <linux-omap@vger.kernel.org>; Sun, 02 Jan 2011 23:50:24 -0800 (PST)
In-Reply-To: <1294040988-21191-1-git-send-email-balbi@ti.com>
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
1.7.3.4.598.g85356


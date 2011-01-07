From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 12/12] cbus: Makefile: re-enable retu-wdt
Date: Fri,  7 Jan 2011 11:08:10 +0200
Message-ID: <1294391290-7285-13-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45320 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754299Ab1AGJIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:51 -0500
Received: by eyf5 with SMTP id 5so6958195eyf.29
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:49 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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


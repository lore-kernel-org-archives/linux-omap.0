From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 11/13] cbus: retu-rtc: drop the reset_occurred flag
Date: Thu,  3 Feb 2011 12:20:26 +0200
Message-ID: <1296728428-26399-12-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53381 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab1BCKVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:21:08 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so1038492fxm.17
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:21:07 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that flag is never read anyway, only written,
so we can drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-rtc.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 6e201aa..b2b9472 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -52,7 +52,6 @@ struct retu_rtc {
 	struct rtc_device	*rtc;
 
 	u16			alarm_expired;
-	u16			reset_occurred;
 };
 
 static void retu_rtc_do_reset(struct retu_rtc *rtc)
@@ -71,7 +70,6 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 	retu_write_reg(RETU_REG_RTCCALR, 0x00c0);
 
 	rtc->alarm_expired = 0;
-	rtc->reset_occurred = 1;
 }
 
 static irqreturn_t retu_rtc_interrupt(int irq, void *_rtc)
@@ -223,14 +221,10 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	/* If the calibration register is zero, we've probably lost
-	 * power */
-	if (retu_read_reg(RETU_REG_RTCCALR) & 0x00ff)
-		rtc->reset_occurred = 0;
-	else
+	/* If the calibration register is zero, we've probably lost power */
+	if (!(retu_read_reg(RETU_REG_RTCCALR) & 0x00ff))
 		retu_rtc_do_reset(rtc);
 
-
 	rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &
 			retu_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc)) {
-- 
1.7.4.rc2


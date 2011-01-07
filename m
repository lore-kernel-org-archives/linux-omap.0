From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 11/12] cbus: retu-rtc: drop the reset_occurred flag
Date: Fri,  7 Jan 2011 11:08:09 +0200
Message-ID: <1294391290-7285-12-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58009 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282Ab1AGJIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:47 -0500
Received: by mail-ey0-f178.google.com with SMTP id 5so7743331eyh.23
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:46 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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
1.7.3.4.598.g85356


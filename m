From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] cbus: retu: rtc: grab IRQ via struct resource
Date: Thu, 10 Feb 2011 12:21:21 +0200
Message-ID: <1297333281-29853-5-git-send-email-balbi@ti.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51464 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755992Ab1BJKVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 05:21:41 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so1735716fxm.15
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 02:21:40 -0800 (PST)
In-Reply-To: <1297333281-29853-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now that we pass IRQ via struct resource, we can
simply use it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-rtc.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index a011ba7..5f52edf 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -52,6 +52,8 @@ struct retu_rtc {
 	struct rtc_device	*rtc;
 
 	u16			alarm_expired;
+	int			irq_rtcs;
+	int			irq_rtca;
 };
 
 static void retu_rtc_do_reset(struct retu_rtc *rtc)
@@ -86,17 +88,24 @@ static irqreturn_t retu_rtc_interrupt(int irq, void *_rtc)
 
 static int retu_rtc_init_irq(struct retu_rtc *rtc)
 {
+	int irq;
 	int ret;
 
-	ret = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, NULL, retu_rtc_interrupt,
+	irq = platform_get_irq(to_platform_device(rtc->dev), 0);
+	rtc->irq_rtcs = irq;
+
+	irq = platform_get_irq(to_platform_device(rtc->dev), 1);
+	rtc->irq_rtca = irq;
+
+	ret = request_threaded_irq(rtc->irq_rtcs, NULL, retu_rtc_interrupt,
 			0, "RTCS", rtc);
 	if (ret != 0)
 		return ret;
 
-	ret = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, NULL, retu_rtc_interrupt,
+	ret = request_threaded_irq(rtc->irq_rtca, NULL, retu_rtc_interrupt,
 			0, "RTCA", rtc);
 	if (ret != 0) {
-		free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
+		free_irq(rtc->irq_rtcs, rtc);
 		return ret;
 	}
 
@@ -235,8 +244,8 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
-	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
-	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, rtc);
+	free_irq(rtc->irq_rtcs, rtc);
+	free_irq(rtc->irq_rtca, rtc);
 
 err1:
 	kfree(rtc);
@@ -249,8 +258,8 @@ static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 	struct retu_rtc		*rtc = platform_get_drvdata(pdev);
 
-	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
-	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, rtc);
+	free_irq(rtc->irq_rtcs, rtc);
+	free_irq(rtc->irq_rtca, rtc);
 	rtc_device_unregister(rtc->rtc);
 	kfree(rtc);
 
-- 
1.7.4.rc2


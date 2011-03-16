From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] rtc-twl: Switch to using threaded irq
Date: Wed, 16 Mar 2011 18:07:14 +0200
Message-ID: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:38633 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab1CPQJd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 12:09:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, tony@atomide.com
Cc: rtc-linux@googlegroups.com, balajitk@ti.com, linux-omap@vger.kernel.org

The driver is accessing to i2c bus in interrupt handler.
Therefore, it should use threaded irq.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 drivers/rtc/rtc-twl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index ed1b868..2715b96 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out1;
 
-	ret = request_irq(irq, twl_rtc_interrupt,
+	ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
 				IRQF_TRIGGER_RISING,
 				dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
-- 
1.7.0.4


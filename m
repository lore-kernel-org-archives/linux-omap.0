From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/22] cbus: retu: set IRQF_ONESHOT flag
Date: Mon, 11 Jul 2011 14:17:19 +0300
Message-ID: <1310383055-20211-7-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34925 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754517Ab1GKLSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:15 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so1929199gxk.23
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:14 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

for handlers which don't have top half, it's
necessary to IRQF_ONESHOT.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index b58c6e5..b7fbd18 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -469,8 +469,8 @@ static int __init retu_probe(struct platform_device *pdev)
 	/* Mask all RETU interrupts */
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 
-	ret = request_threaded_irq(retu->irq, NULL, retu_irq_handler, 0,
-			  "retu", retu);
+	ret = request_threaded_irq(retu->irq, NULL, retu_irq_handler,
+			IRQF_ONESHOT, "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
 		goto err2;
-- 
1.7.6


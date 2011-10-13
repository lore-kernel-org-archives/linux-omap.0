From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/27] cbus: retu: set IRQF_ONESHOT flag
Date: Thu, 13 Oct 2011 11:34:41 +0300
Message-ID: <1318494902-13093-6-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35689 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753885Ab1JMIfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:24 -0400
Received: by bkbzv15 with SMTP id zv15so2006331bkb.1
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:22 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

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
1.7.6.396.ge0613


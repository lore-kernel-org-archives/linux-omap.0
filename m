From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/6] cbus: retu: tabify retu initialization
Date: Wed, 16 Feb 2011 21:42:29 +0200
Message-ID: <1297885350-3462-6-git-send-email-balbi@ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47736 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753907Ab1BPTmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:50 -0500
Received: by mail-bw0-f43.google.com with SMTP id 14so1971318bwz.2
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:42:49 -0800 (PST)
In-Reply-To: <1297885350-3462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

and while at that, save a register and drop
the irq variable which is used right before
initializing it to retu->irq.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 4c8a7ea..d0454bd 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -438,7 +438,6 @@ static int __init retu_probe(struct platform_device *pdev)
 
 	int		ret = -ENOMEM;
 	int		rev;
-	int		irq;
 
 	retu = kzalloc(sizeof(*retu), GFP_KERNEL);
 	if (!retu) {
@@ -447,16 +446,14 @@ static int __init retu_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, retu);
-	the_retu = retu;
 
-	mutex_init(&retu->mutex);
-
-	irq = platform_get_irq(pdev, 0);
+	retu->irq	= platform_get_irq(pdev, 0);
+	retu->irq_base	= pdata->irq_base;
+	retu->irq_end	= pdata->irq_end;
+	retu->devid	= pdata->devid;
+	the_retu	= retu;
 
-	retu->irq = irq;
-	retu->irq_base = pdata->irq_base;
-	retu->irq_end = pdata->irq_end;
-	retu->devid = pdata->devid;
+	mutex_init(&retu->mutex);
 
 	retu_irq_init(retu);
 
@@ -471,14 +468,14 @@ static int __init retu_probe(struct platform_device *pdev)
 	/* Mask all RETU interrupts */
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 
-	ret = request_threaded_irq(irq, NULL, retu_irq_handler, 0,
+	ret = request_threaded_irq(retu->irq, NULL, retu_irq_handler, 0,
 			  "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
 		goto err1;
 	}
 
-	set_irq_wake(irq, 1);
+	set_irq_wake(retu->irq, 1);
 
 	/* Register power off function */
 	pm_power_off = retu_power_off;
@@ -493,7 +490,7 @@ static int __init retu_probe(struct platform_device *pdev)
 
 err2:
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
-	free_irq(irq, retu);
+	free_irq(retu->irq, retu);
 
 err1:
 	kfree(retu);
@@ -506,13 +503,13 @@ err0:
 static int __exit retu_remove(struct platform_device *pdev)
 {
 	struct retu		*retu = platform_get_drvdata(pdev);
-	int			irq;
 
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all RETU interrupts */
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
-	free_irq(irq, retu);
+
+	free_irq(retu->irq, retu);
 	retu_irq_exit(retu);
 	kfree(retu);
 	the_retu = NULL;
-- 
1.7.4.rc2


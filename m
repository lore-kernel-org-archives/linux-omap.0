From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] cbus: retu: use sparse IRQ numbering
Date: Wed, 29 Jun 2011 14:46:50 +0300
Message-ID: <1309348011-23141-2-git-send-email-balbi@ti.com>
References: <1309348011-23141-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45049 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754734Ab1F2LrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 07:47:00 -0400
Received: by mail-bw0-f51.google.com with SMTP id 18so1258390bwa.10
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:46:59 -0700 (PDT)
In-Reply-To: <1309348011-23141-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

there's no need to pass a bunch of IRQ
bases down to drivers, we can use
irq_alloc_descs() for that and put the
sparse IRQ numbering scheme to work for
us.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 708b811..b58c6e5 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -441,9 +441,15 @@ static int __init retu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, retu);
 
+	ret = irq_alloc_descs(-1, 0, MAX_RETU_IRQ_HANDLERS, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQ descs\n");
+		goto err1;
+	}
+
 	retu->irq	= platform_get_irq(pdev, 0);
-	retu->irq_base	= pdata->irq_base;
-	retu->irq_end	= pdata->irq_end;
+	retu->irq_base	= ret;
+	retu->irq_end	= ret + MAX_RETU_IRQ_HANDLERS;
 	retu->devid	= pdata->devid;
 	retu->dev	= &pdev->dev;
 	the_retu	= retu;
@@ -467,7 +473,7 @@ static int __init retu_probe(struct platform_device *pdev)
 			  "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		goto err1;
+		goto err2;
 	}
 
 	irq_set_irq_wake(retu->irq, 1);
@@ -478,16 +484,19 @@ static int __init retu_probe(struct platform_device *pdev)
 	ret = retu_allocate_children(&pdev->dev, retu->irq_base);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
-		goto err2;
+		goto err3;
 	}
 
 	return 0;
 
-err2:
+err3:
 	pm_power_off = NULL;
-	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 	free_irq(retu->irq, retu);
 
+err2:
+	retu_irq_exit(retu);
+	irq_free_descs(retu->irq_base, MAX_RETU_IRQ_HANDLERS);
+
 err1:
 	kfree(retu);
 	the_retu = NULL;
@@ -503,11 +512,9 @@ static int __exit retu_remove(struct platform_device *pdev)
 	pm_power_off = NULL;
 	the_retu = NULL;
 
-	/* Mask all RETU interrupts */
-	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
-
 	free_irq(retu->irq, retu);
 	retu_irq_exit(retu);
+	irq_free_descs(retu->irq_base, MAX_RETU_IRQ_HANDLERS);
 	kfree(retu);
 
 	return 0;
-- 
1.7.6


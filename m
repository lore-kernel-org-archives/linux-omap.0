From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 04/13] cbus: retu: cleanup error path
Date: Thu,  3 Feb 2011 12:20:19 +0200
Message-ID: <1296728428-26399-5-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35070 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756132Ab1BCKUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:46 -0500
Received: by fxm2 with SMTP id 2so1069382fxm.7
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:44 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Trivial cleanup patch shuffling error path
around.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 0053d43..7e67e1a 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -413,14 +413,15 @@ static int retu_allocate_children(struct device *parent)
 static int __init retu_probe(struct platform_device *pdev)
 {
 	struct retu	*retu;
+
+	int		ret = -ENOMEM;
 	int		rev;
-	int		ret;
 	int		irq;
 
 	retu = kzalloc(sizeof(*retu), GFP_KERNEL);
 	if (!retu) {
 		dev_err(&pdev->dev, "not enough memory\n");
-		return -ENOMEM;
+		goto err0;
 	}
 
 	platform_set_drvdata(pdev, retu);
@@ -449,10 +450,7 @@ static int __init retu_probe(struct platform_device *pdev)
 			  "retu", retu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		tasklet_kill(&retu->tasklet);
-		kfree(retu);
-		the_retu = NULL;
-		return ret;
+		goto err1;
 	}
 
 	set_irq_wake(irq, 1);
@@ -463,15 +461,22 @@ static int __init retu_probe(struct platform_device *pdev)
 	ret = retu_allocate_children(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
-		retu_write_reg(RETU_REG_IMR, 0xffff);
-		free_irq(irq, 0);
-		tasklet_kill(&retu->tasklet);
-		kfree(retu);
-		the_retu = NULL;
-		return ret;
+		goto err2;
 	}
 
 	return 0;
+
+err2:
+	retu_write_reg(RETU_REG_IMR, 0xffff);
+	free_irq(irq, retu);
+
+err1:
+	tasklet_kill(&retu->tasklet);
+	kfree(retu);
+	the_retu = NULL;
+
+err0:
+	return ret;
 }
 
 static int __exit retu_remove(struct platform_device *pdev)
-- 
1.7.4.rc2


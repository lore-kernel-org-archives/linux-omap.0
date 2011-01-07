From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 04/12] cbus: retu: cleanup error path
Date: Fri,  7 Jan 2011 11:08:02 +0200
Message-ID: <1294391290-7285-5-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49900 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754137Ab1AGJI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:26 -0500
Received: by mail-ey0-f180.google.com with SMTP id 18so7097765eyf.11
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:25 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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
1.7.3.4.598.g85356


From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/6] cbus: retu: headset: don't save pdev pointer
Date: Wed, 16 Feb 2011 21:42:27 +0200
Message-ID: <1297885350-3462-4-git-send-email-balbi@ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52563 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115Ab1BPTmo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:44 -0500
Received: by mail-ey0-f170.google.com with SMTP id 5so979590eyf.29
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:42:42 -0800 (PST)
In-Reply-To: <1297885350-3462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

... and save instead a device pointer. Generally
we only need a device pointer as we don't need
to poke with the platform_device that often and
if we do, we can always to_platform_device(dev).

Drop the pdev from the headset structure and
save dev instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-headset.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index d0b39a7..3b8e138 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -38,7 +38,7 @@
 struct retu_headset {
 	spinlock_t			lock;
 	struct mutex			mutex;
-	struct platform_device		*pdev;
+	struct device			*dev;
 	struct input_dev		*idev;
 	unsigned			bias_enabled;
 	unsigned			detection_enabled;
@@ -51,13 +51,13 @@ struct retu_headset {
 static void retu_headset_set_bias(struct retu_headset *hs, int enable)
 {
 	if (enable) {
-		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR,
+		retu_set_clear_reg_bits(hs->dev, RETU_REG_AUDTXR,
 					(1 << 0) | (1 << 1), 0);
 		msleep(2);
-		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR,
+		retu_set_clear_reg_bits(hs->dev, RETU_REG_AUDTXR,
 				1 << 3, 0);
 	} else {
-		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR, 0,
+		retu_set_clear_reg_bits(hs->dev, RETU_REG_AUDTXR, 0,
 					(1 << 0) | (1 << 1) | (1 << 3));
 	}
 }
@@ -87,7 +87,7 @@ static void retu_headset_det_enable(struct retu_headset *hs)
 	mutex_lock(&hs->mutex);
 	if (!hs->detection_enabled) {
 		hs->detection_enabled = 1;
-		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1,
+		retu_set_clear_reg_bits(hs->dev, RETU_REG_CC1,
 				(1 << 10) | (1 << 8), 0);
 	}
 	mutex_unlock(&hs->mutex);
@@ -106,7 +106,7 @@ static void retu_headset_det_disable(struct retu_headset *hs)
 		if (hs->pressed)
 			input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
 		spin_unlock_irqrestore(&hs->lock, flags);
-		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1, 0,
+		retu_set_clear_reg_bits(hs->dev, RETU_REG_CC1, 0,
 				(1 << 10) | (1 << 8));
 	}
 	mutex_unlock(&hs->mutex);
@@ -193,7 +193,7 @@ static irqreturn_t retu_headset_hook_interrupt(int irq, void *_hs)
 		input_report_key(hs->idev, RETU_HEADSET_KEY, 1);
 	}
 	spin_unlock_irqrestore(&hs->lock, flags);
-	retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1, 0,
+	retu_set_clear_reg_bits(hs->dev, RETU_REG_CC1, 0,
 			(1 << 10) | (1 << 8));
 	mod_timer(&hs->enable_timer, jiffies + msecs_to_jiffies(50));
 
@@ -204,7 +204,7 @@ static void retu_headset_enable_timer(unsigned long arg)
 {
 	struct retu_headset *hs = (struct retu_headset *) arg;
 
-	retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1,
+	retu_set_clear_reg_bits(hs->dev, RETU_REG_CC1,
 			(1 << 10) | (1 << 8), 0);
 	mod_timer(&hs->detect_timer, jiffies + msecs_to_jiffies(350));
 }
@@ -232,7 +232,7 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	if (hs == NULL)
 		return -ENOMEM;
 
-	hs->pdev = pdev;
+	hs->dev = &pdev->dev;
 
 	hs->idev = input_allocate_device();
 	if (hs->idev == NULL) {
-- 
1.7.4.rc2


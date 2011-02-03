From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 08/13] cbus: retu: headset: convert to threaded_irq
Date: Thu,  3 Feb 2011 12:20:23 +0200
Message-ID: <1296728428-26399-9-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35199 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756159Ab1BCKU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:56 -0500
Received: by mail-fx0-f51.google.com with SMTP id 5so1034898fxm.24
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:55 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

use the new irq_chip added to retu.c.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Makefile       |    2 +-
 drivers/cbus/retu-headset.c |   22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/cbus/Makefile b/drivers/cbus/Makefile
index 3375b82..841bed5 100644
--- a/drivers/cbus/Makefile
+++ b/drivers/cbus/Makefile
@@ -12,4 +12,4 @@ obj-$(CONFIG_CBUS_TAHVO_USER)	+= tahvo-user.o
 #obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
 #obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
 #obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
-#obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
+obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index f5fb50c..2aa4d30 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -84,7 +86,6 @@ static void retu_headset_det_enable(struct retu_headset *hs)
 	if (!hs->detection_enabled) {
 		hs->detection_enabled = 1;
 		retu_set_clear_reg_bits(RETU_REG_CC1, (1 << 10) | (1 << 8), 0);
-		retu_enable_irq(RETU_INT_HOOK);
 	}
 	mutex_unlock(&hs->mutex);
 }
@@ -96,7 +97,6 @@ static void retu_headset_det_disable(struct retu_headset *hs)
 	mutex_lock(&hs->mutex);
 	if (hs->detection_enabled) {
 		hs->detection_enabled = 0;
-		retu_disable_irq(RETU_INT_HOOK);
 		del_timer_sync(&hs->enable_timer);
 		del_timer_sync(&hs->detect_timer);
 		spin_lock_irqsave(&hs->lock, flags);
@@ -177,12 +177,11 @@ static DEVICE_ATTR(enable_det, S_IRUGO | S_IWUSR | S_IWGRP,
 		   retu_headset_enable_det_show,
 		   retu_headset_enable_det_store);
 
-static void retu_headset_hook_interrupt(unsigned long arg)
+static irqreturn_t retu_headset_hook_interrupt(int irq, void *_hs)
 {
-	struct retu_headset *hs = (struct retu_headset *) arg;
-	unsigned long flags;
+	struct retu_headset	*hs = _hs;
+	unsigned long		flags;
 
-	retu_ack_irq(RETU_INT_HOOK);
 	spin_lock_irqsave(&hs->lock, flags);
 	if (!hs->pressed) {
 		/* Headset button was just pressed down. */
@@ -192,6 +191,8 @@ static void retu_headset_hook_interrupt(unsigned long arg)
 	spin_unlock_irqrestore(&hs->lock, flags);
 	retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
 	mod_timer(&hs->enable_timer, jiffies + msecs_to_jiffies(50));
+
+	return IRQ_HANDLED;
 }
 
 static void retu_headset_enable_timer(unsigned long arg)
@@ -257,13 +258,13 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	setup_timer(&hs->detect_timer, retu_headset_detect_timer,
 		    (unsigned long) hs);
 
-	r = retu_request_irq(RETU_INT_HOOK, retu_headset_hook_interrupt,
-			     (unsigned long) hs, "hookdet");
+	r = request_threaded_irq(RETU_INT_HOOK, NULL,
+			retu_headset_hook_interrupt, 0, "hookdet", hs);
 	if (r != 0) {
 		dev_err(&pdev->dev, "hookdet IRQ not available\n");
 		goto err6;
 	}
-	retu_disable_irq(RETU_INT_HOOK);
+
 	return 0;
 err6:
 	device_remove_file(&pdev->dev, &dev_attr_enable_det);
@@ -289,9 +290,10 @@ static int retu_headset_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_enable_det);
 	retu_headset_disable(hs);
 	retu_headset_det_disable(hs);
-	retu_free_irq(RETU_INT_HOOK);
+	free_irq(RETU_INT_HOOK, hs);
 	input_unregister_device(hs->idev);
 	input_free_device(hs->idev);
+
 	return 0;
 }
 
-- 
1.7.4.rc2


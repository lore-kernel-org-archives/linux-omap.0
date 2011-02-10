From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] cbus: retu: headset: grab IRQ via struct resource
Date: Thu, 10 Feb 2011 12:21:19 +0200
Message-ID: <1297333281-29853-3-git-send-email-balbi@ti.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50585 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755992Ab1BJKVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 05:21:36 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so1397669fxm.31
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 02:21:35 -0800 (PST)
In-Reply-To: <1297333281-29853-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now that we pass IRQ via struct resource, we can
simply use it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-headset.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index 661534c..acf5cbe7 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -45,6 +45,7 @@ struct retu_headset {
 	unsigned			pressed;
 	struct timer_list		enable_timer;
 	struct timer_list		detect_timer;
+	int				irq;
 };
 
 static void retu_headset_set_bias(int enable)
@@ -219,6 +220,7 @@ static void retu_headset_detect_timer(unsigned long arg)
 static int __init retu_headset_probe(struct platform_device *pdev)
 {
 	struct retu_headset *hs;
+	int irq;
 	int r;
 
 	hs = kzalloc(sizeof(*hs), GFP_KERNEL);
@@ -258,8 +260,11 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	setup_timer(&hs->detect_timer, retu_headset_detect_timer,
 		    (unsigned long) hs);
 
-	r = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_HOOK, NULL,
-			retu_headset_hook_interrupt, 0, "hookdet", hs);
+	irq = platform_get_irq(pdev, 0);
+	hs->irq = irq;
+
+	r = request_threaded_irq(irq, NULL, retu_headset_hook_interrupt, 0,
+			"hookdet", hs);
 	if (r != 0) {
 		dev_err(&pdev->dev, "hookdet IRQ not available\n");
 		goto err6;
@@ -290,7 +295,7 @@ static int retu_headset_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_enable_det);
 	retu_headset_disable(hs);
 	retu_headset_det_disable(hs);
-	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_HOOK, hs);
+	free_irq(hs->irq, hs);
 	input_unregister_device(hs->idev);
 	input_free_device(hs->idev);
 
-- 
1.7.4.rc2


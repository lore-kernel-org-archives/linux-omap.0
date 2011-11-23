From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/6] cbus: retu: move irq_chip to our context structure
Date: Wed, 23 Nov 2011 16:00:46 +0200
Message-ID: <1322056848-1188-5-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45825 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1KWOBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:01:00 -0500
Received: by mail-gy0-f170.google.com with SMTP id r20so1541868ghr.29
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:00:59 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

in theory, we could have many retu devices connected
to different CBUS buses. The only thing preventing
that is the poweroff() function pointer which we need
to set.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 5bd88c6..25fa405 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -46,6 +46,8 @@ struct retu {
 	struct mutex		mutex;
 	struct device		*dev;
 
+	struct irq_chip		irq_chip;
+
 	int			irq_base;
 	int			irq_end;
 
@@ -247,14 +249,6 @@ static void retu_bus_sync_unlock(struct irq_data *data)
 	mutex_unlock(&retu->mutex);
 }
 
-static struct irq_chip retu_irq_chip = {
-	.name			= "retu",
-	.irq_bus_lock		= retu_bus_lock,
-	.irq_bus_sync_unlock	= retu_bus_sync_unlock,
-	.irq_mask		= retu_irq_mask,
-	.irq_unmask		= retu_irq_unmask,
-};
-
 static inline void retu_irq_setup(int irq)
 {
 #ifdef CONFIG_ARM
@@ -272,7 +266,7 @@ static void retu_irq_init(struct retu *retu)
 
 	for (irq = base; irq < end; irq++) {
 		irq_set_chip_data(irq, retu);
-		irq_set_chip(irq, &retu_irq_chip);
+		irq_set_chip(irq, &retu->irq_chip);
 		irq_set_nested_thread(irq, 1);
 		retu_irq_setup(irq);
 	}
@@ -409,6 +403,7 @@ static int retu_allocate_children(struct device *parent, int irq_base)
  */
 static int __devinit retu_probe(struct platform_device *pdev)
 {
+	struct irq_chip	*chip;
 	struct retu	*retu;
 
 	int		ret = -ENOMEM;
@@ -428,10 +423,19 @@ static int __devinit retu_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	chip = &retu->irq_chip;
+
+	chip->name	= "retu",
+	chip->irq_bus_lock = retu_bus_lock,
+	chip->irq_bus_sync_unlock = retu_bus_sync_unlock,
+	chip->irq_mask	= retu_irq_mask,
+	chip->irq_unmask = retu_irq_unmask,
+
 	retu->irq	= platform_get_irq(pdev, 0);
 	retu->irq_base	= ret;
 	retu->irq_end	= ret + MAX_RETU_IRQ_HANDLERS;
 	retu->dev	= &pdev->dev;
+
 	the_retu	= retu;
 
 	mutex_init(&retu->mutex);
-- 
1.7.8.rc3


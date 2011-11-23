From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/6] cbus: tahvo: move irq_chip to our context structure
Date: Wed, 23 Nov 2011 16:00:47 +0200
Message-ID: <1322056848-1188-6-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50456 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929Ab1KWOBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:01:02 -0500
Received: by ghbg2 with SMTP id g2so1873772ghb.21
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:01:00 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

in theory, we could have many tahvo devices connected
to different CBUS buses. Let's allow that to happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 7f7c712..819111a 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -44,6 +44,8 @@ struct tahvo {
 	struct mutex	mutex;
 	struct device	*dev;
 
+	struct irq_chip	irq_chip;
+
 	int		irq_base;
 	int		irq_end;
 	int		irq;
@@ -199,14 +201,6 @@ static void tahvo_irq_unmask(struct irq_data *data)
 	tahvo->mask_pending = true;
 }
 
-static struct irq_chip tahvo_irq_chip = {
-	.name			= "tahvo",
-	.irq_bus_lock		= tahvo_irq_bus_lock,
-	.irq_bus_sync_unlock	= tahvo_irq_bus_sync_unlock,
-	.irq_mask		= tahvo_irq_mask,
-	.irq_unmask		= tahvo_irq_unmask,
-};
-
 static inline void tahvo_irq_setup(int irq)
 {
 #ifdef CONFIG_ARM
@@ -224,7 +218,7 @@ static void tahvo_irq_init(struct tahvo *tahvo)
 
 	for (irq = base; irq < end; irq++) {
 		irq_set_chip_data(irq, tahvo);
-		irq_set_chip(irq, &tahvo_irq_chip);
+		irq_set_chip(irq, &tahvo->irq_chip);
 		irq_set_nested_thread(irq, 1);
 		tahvo_irq_setup(irq);
 	}
@@ -297,6 +291,7 @@ static int tahvo_allocate_children(struct device *parent, int irq_base)
 
 static int __devinit tahvo_probe(struct platform_device *pdev)
 {
+	struct irq_chip		*chip;
 	struct tahvo		*tahvo;
 	int			rev;
 	int			ret;
@@ -321,6 +316,14 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	chip = &tahvo->irq_chip;
+
+	chip->name	= "tahvo",
+	chip->irq_bus_lock = tahvo_irq_bus_lock,
+	chip->irq_bus_sync_unlock = tahvo_irq_bus_sync_unlock,
+	chip->irq_mask	= tahvo_irq_mask,
+	chip->irq_unmask = tahvo_irq_unmask,
+
 	tahvo->irq_base	= ret;
 	tahvo->irq_end	= ret + MAX_TAHVO_IRQ_HANDLERS;
 	tahvo->dev	= &pdev->dev;
-- 
1.7.8.rc3


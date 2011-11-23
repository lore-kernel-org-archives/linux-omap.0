From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 6/6] cbus: retu: implement irq_domain support
Date: Wed, 23 Nov 2011 16:00:48 +0200
Message-ID: <1322056848-1188-7-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56914 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929Ab1KWOBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:01:04 -0500
Received: by mail-gy0-f172.google.com with SMTP id r14so1397311ghr.3
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:01:03 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Then, when moving to devicetree, we can list
IRQs as 1, 2, 3. It's the only way to have a
sane devicetree actually.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 25fa405..f25e0a3 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -46,6 +46,7 @@ struct retu {
 	struct mutex		mutex;
 	struct device		*dev;
 
+	struct irq_domain	irq_domain;
 	struct irq_chip		irq_chip;
 
 	int			irq_base;
@@ -199,11 +200,9 @@ static irqreturn_t retu_irq_handler(int irq, void *_retu)
 
 	while (idr) {
 		unsigned long	pending = __ffs(idr);
-		unsigned int	irq;
 
 		idr &= ~BIT(pending);
-		irq = pending + retu->irq_base;
-		handle_nested_irq(irq);
+		handle_nested_irq(pending);
 	}
 
 	return IRQ_HANDLED;
@@ -216,7 +215,7 @@ static void retu_irq_mask(struct irq_data *data)
 	struct retu		*retu = irq_data_get_irq_chip_data(data);
 	int			irq = data->irq;
 
-	retu->mask |= (1 << (irq - retu->irq_base));
+	retu->mask |= (1 << irq);
 	retu->mask_pending = true;
 }
 
@@ -225,7 +224,7 @@ static void retu_irq_unmask(struct irq_data *data)
 	struct retu		*retu = irq_data_get_irq_chip_data(data);
 	int			irq = data->irq;
 
-	retu->mask &= ~(1 << (irq - retu->irq_base));
+	retu->mask &= ~(1 << irq);
 	retu->mask_pending = true;
 
 }
@@ -260,6 +259,7 @@ static inline void retu_irq_setup(int irq)
 
 static void retu_irq_init(struct retu *retu)
 {
+	struct irq_domain	*domain;
 	int			base = retu->irq_base;
 	int			end = retu->irq_end;
 	int			irq;
@@ -270,10 +270,19 @@ static void retu_irq_init(struct retu *retu)
 		irq_set_nested_thread(irq, 1);
 		retu_irq_setup(irq);
 	}
+
+	/* IRQ domain setup */
+	domain = &retu->irq_domain;
+	domain->irq_base = base;
+	domain->nr_irq = MAX_RETU_IRQ_HANDLERS;
+	domain->hwirq_base = 1;
+
+	irq_domain_add(domain);
 }
 
 static void retu_irq_exit(struct retu *retu)
 {
+	struct irq_domain	*domain;
 	int			base = retu->irq_base;
 	int			end = retu->irq_end;
 	int			irq;
@@ -285,6 +294,9 @@ static void retu_irq_exit(struct retu *retu)
 		irq_set_chip_and_handler(irq, NULL, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
+
+	domain = &retu->irq_domain;
+	irq_domain_del(domain);
 }
 
 /* -------------------------------------------------------------------------- */
@@ -326,7 +338,7 @@ static struct resource generic_resources[] = {
  * @parent: parent device for this child
  */
 static struct device *retu_allocate_child(char *name, struct device *parent,
-		int irq_base, int irq1, int irq2, int num)
+		int irq1, int irq2, int num)
 {
 	struct platform_device		*pdev;
 	int				status;
@@ -340,8 +352,8 @@ static struct device *retu_allocate_child(char *name, struct device *parent,
 	pdev->dev.parent = parent;
 
 	if (num) {
-		generic_resources[0].start = irq_base + irq1;
-		generic_resources[1].start = irq_base + irq2;
+		generic_resources[0].start = irq1;
+		generic_resources[1].start = irq2;
 
 		status = platform_device_add_resources(pdev,
 				generic_resources, num);
@@ -368,26 +380,26 @@ err:
 /**
  * retu_allocate_children - Allocates Retu's children
  */
-static int retu_allocate_children(struct device *parent, int irq_base)
+static int retu_allocate_children(struct device *parent)
 {
 	struct device	*child;
 
-	child = retu_allocate_child("retu-pwrbutton", parent, irq_base,
+	child = retu_allocate_child("retu-pwrbutton", parent,
 			RETU_INT_PWR, -1, 1);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-headset", parent, irq_base,
+	child = retu_allocate_child("retu-headset", parent,
 			RETU_INT_HOOK, -1, 1);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-rtc", parent, irq_base,
+	child = retu_allocate_child("retu-rtc", parent,
 			RETU_INT_RTCS, RETU_INT_RTCA, 2);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-wdt", parent, -1, -1, -1, 0);
+	child = retu_allocate_child("retu-wdt", parent, -1, -1, 0);
 	if (!child)
 		return -ENOMEM;
 
@@ -466,7 +478,7 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	/* Register power off function */
 	pm_power_off = retu_power_off;
 
-	ret = retu_allocate_children(&pdev->dev, retu->irq_base);
+	ret = retu_allocate_children(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
 		goto err3;
-- 
1.7.8.rc3


From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 07/14] irqchip: crossbar: return proper error value
Date: Tue, 3 Jun 2014 13:12:59 +0530
Message-ID: <1401781386-4982-8-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57713 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbaFCHpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 03:45:49 -0400
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Nishanth Menon <nm@ti.com>

crossbar_of_init always returns -ENOMEM in case of errors, return proper
error results in case of failures.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index fea3e5d..524e6e9 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -140,20 +140,26 @@ static const struct irq_domain_ops routable_irq_domain_ops = {
 static int __init crossbar_of_init(struct device_node *node,
 				   const struct crossbar_data *data)
 {
-	int i, size, max, reserved = 0, entry, safe_map;
+	int i, size, max = 0, reserved = 0, entry, safe_map;
 	const __be32 *irqsr;
 	const int *irqsk = NULL;
+	int ret = -ENOMEM;
 
 	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
 
 	if (!cb)
-		return -ENOMEM;
+		return ret;
 
 	cb->crossbar_base = of_iomap(node, 0);
 	if (!cb->crossbar_base)
 		goto err1;
 
 	of_property_read_u32(node, "ti,max-irqs", &max);
+	if (!max) {
+		pr_err("missing 'ti,max-irqs' property\n");
+		ret = -EINVAL;
+		goto err2;
+	}
 	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->irq_map)
 		goto err2;
@@ -174,6 +180,7 @@ static int __init crossbar_of_init(struct device_node *node,
 						   i, &entry);
 			if (entry > max) {
 				pr_err("Invalid reserved entry\n");
+				ret = -EINVAL;
 				goto err3;
 			}
 			cb->irq_map[entry] = IRQ_RESERVED;
@@ -198,6 +205,7 @@ static int __init crossbar_of_init(struct device_node *node,
 		break;
 	default:
 		pr_err("Invalid reg-size property\n");
+		ret = -EINVAL;
 		goto err4;
 		break;
 	}
@@ -225,6 +233,7 @@ static int __init crossbar_of_init(struct device_node *node,
 
 			if (entry > max) {
 				pr_err("Invalid skip entry\n");
+				ret = -EINVAL;
 				goto err4;
 			}
 			cb->irq_map[entry] = IRQ_SKIP;
@@ -250,7 +259,7 @@ err2:
 	iounmap(cb->crossbar_base);
 err1:
 	kfree(cb);
-	return -ENOMEM;
+	return ret;
 }
 
 /* irq number 10,133,139 and 140 cannot be used because of hw bug */
-- 
1.7.9.5


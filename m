From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 07/16] irqchip: crossbar: fix sparse and checkpatch warnings
Date: Mon, 16 Jun 2014 16:53:07 +0530
Message-ID: <1402917796-31574-8-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

There is absolutely no need for crossbar driver to expose functions and
variables into global namespace. So make them all static

Also fix a couple of checkpatch warnings.

Fixes sparse warnings:
drivers/irqchip/irq-crossbar.c:129:29: warning: symbol 'routable_irq_domain_ops' was not declared. Should it be static?
drivers/irqchip/irq-crossbar.c:261:12: warning: symbol 'irqcrossbar_init' was not declared. Should it be static?

Checkpatch warnings:
WARNING: Prefer kcalloc over kzalloc with multiply
+	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);

WARNING: Prefer kcalloc over kzalloc with multiply
+	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V3] Added checkpatch fixes as well to this.

 drivers/irqchip/irq-crossbar.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 42ea49d..2d7fbdb 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/irq-crossbar.h>
 
 #define IRQ_FREE	-1
 #define IRQ_RESERVED	-2
@@ -118,7 +119,7 @@ found:
 	return 0;
 }
 
-const struct irq_domain_ops routable_irq_domain_ops = {
+static const struct irq_domain_ops routable_irq_domain_ops = {
 	.map = crossbar_domain_map,
 	.unmap = crossbar_domain_unmap,
 	.xlate = crossbar_domain_xlate
@@ -139,7 +140,7 @@ static int __init crossbar_of_init(struct device_node *node)
 		goto err1;
 
 	of_property_read_u32(node, "ti,max-irqs", &max);
-	cb->irq_map = kzalloc(max * sizeof(int), GFP_KERNEL);
+	cb->irq_map = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->irq_map)
 		goto err2;
 
@@ -184,7 +185,7 @@ static int __init crossbar_of_init(struct device_node *node)
 	}
 
 
-	cb->register_offsets = kzalloc(max * sizeof(int), GFP_KERNEL);
+	cb->register_offsets = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!cb->register_offsets)
 		goto err3;
 
-- 
1.7.9.5

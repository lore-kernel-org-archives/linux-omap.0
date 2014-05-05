From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 4/5] irqchip: crossbar: Initialise the crossbar with a safe value
Date: Mon, 5 May 2014 19:48:46 +0530
Message-ID: <1399299527-10955-5-git-send-email-r.sricharan@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43389 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbaEEOUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 10:20:31 -0400
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Nishanth Menon <nm@ti.com>

Since crossbar is s/w configurable, the initial settings of the
crossbar cannot be assumed to be sane. This implies that:
a) On initialization all un-reserved crossbars must be initialized to
   a known 'safe' value.
b) When unmapping the interrupt, the safe value must be written to
   ensure that the crossbar mapping matches with interrupt controller
   usage.

So provide a safe value in the compatible data to map if
'0' is not safe for the platform and use it during init and unmap

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 847f6e3..287d3ce 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -44,6 +44,7 @@ struct crossbar_device {
 struct crossbar_data {
 	const uint *irqs_unused;
 	const uint size;
+	const uint safe_map;
 };
 
 static struct crossbar_device *cb;
@@ -134,7 +135,7 @@ const struct irq_domain_ops routable_irq_domain_ops = {
 static int __init crossbar_of_init(struct device_node *node,
 				   const struct crossbar_data *data)
 {
-	int i, size, max, reserved = 0, entry;
+	int i, size, max, reserved = 0, entry, safe_map;
 	const __be32 *irqsr;
 	const int *irqsk = NULL;
 
@@ -212,6 +213,7 @@ static int __init crossbar_of_init(struct device_node *node,
 	if (data) {
 		irqsk = data->irqs_unused;
 		size = data->size;
+		safe_map = data->safe_map;
 
 		for (i = 0; i < size; i++) {
 			entry = irqsk[i];
@@ -222,6 +224,14 @@ static int __init crossbar_of_init(struct device_node *node,
 			}
 			cb->irq_map[entry] = IRQ_SKIP;
 		}
+
+		for (i = 0; i < max; i++) {
+			if (cb->irq_map[i] == IRQ_RESERVED ||
+			    cb->irq_map[i] == IRQ_SKIP)
+				continue;
+
+			cb->write(i, safe_map);
+		}
 	}
 
 	register_routable_domain_ops(&routable_irq_domain_ops);
@@ -241,7 +251,7 @@ err1:
 /* irq number 10 cannot be used because of hw bug */
 int dra_irqs_unused[] = { 10 };
 struct crossbar_data cb_dra_data = { dra_irqs_unused,
-				     ARRAY_SIZE(dra_irqs_unused) };
+				     ARRAY_SIZE(dra_irqs_unused), 0 };
 
 static const struct of_device_id crossbar_match[] __initconst = {
 	{ .compatible = "ti,irq-crossbar", .data = &cb_dra_data },
-- 
1.7.9.5


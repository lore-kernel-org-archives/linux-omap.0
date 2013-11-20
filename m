From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 29/31] arm: omap: irq: remove nr_irqs argument
Date: Wed, 20 Nov 2013 12:09:16 -0600
Message-ID: <1384970958-4118-30-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48488 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754718Ab3KTSKx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:53 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

we can set our global omap_nr_irqs early on
and drop the extra argument to omap_init_irq().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 5d4e883..a411ed4 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -207,8 +207,7 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 				IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static void __init omap_init_irq(u32 base, int nr_irqs,
-				 struct device_node *node)
+static void __init omap_init_irq(u32 base, struct device_node *node)
 {
 	int j, irq_base;
 
@@ -216,15 +215,13 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 	if (WARN_ON(!omap_irq_base))
 		return;
 
-	omap_nr_irqs = nr_irqs;
-
-	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	irq_base = irq_alloc_descs(-1, 0, omap_nr_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
 		irq_base = 0;
 	}
 
-	domain = irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
+	domain = irq_domain_add_legacy(node, omap_nr_irqs, irq_base, 0,
 			&irq_domain_simple_ops, NULL);
 
 	omap_irq_soft_reset();
@@ -270,19 +267,22 @@ out:
 
 void __init omap2_init_irq(void)
 {
-	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+	omap_nr_irqs = 96;
+	omap_init_irq(OMAP24XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
 
 void __init omap3_init_irq(void)
 {
-	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+	omap_nr_irqs = 96;
+	omap_init_irq(OMAP34XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
 
 void __init ti81xx_init_irq(void)
 {
-	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+	omap_nr_irqs = 96;
+	omap_init_irq(OMAP34XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
 
@@ -290,7 +290,8 @@ static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
 	struct resource res;
-	u32 nr_irq = 96;
+
+	omap_nr_irqs = 96;
 
 	if (WARN_ON(!node))
 		return -ENODEV;
@@ -301,9 +302,9 @@ static int __init intc_of_init(struct device_node *node,
 	}
 
 	if (of_device_is_compatible(node, "ti,am33xx-intc"))
-		nr_irq = 128;
+		omap_nr_irqs = 128;
 
-	omap_init_irq(res.start, nr_irq, of_node_get(node));
+	omap_init_irq(res.start, of_node_get(node));
 
 	set_handle_irq(omap_intc_handle_irq);
 
-- 
1.8.4.GIT


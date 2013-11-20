From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 30/31] arm: omap: irq: introduce omap_nr_pending
Date: Wed, 20 Nov 2013 12:09:17 -0600
Message-ID: <1384970958-4118-31-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39970 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab3KTSK5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:57 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

that variable will tell us how many INTC_PENDING_IRQn
registers we have. It'll be used on a following patch
to cleanup omap_intc_handle_irq() a bit.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index a411ed4..1b2266a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -70,6 +70,7 @@ static struct omap_intc_regs intc_context;
 
 static struct irq_domain *domain;
 static void __iomem *omap_irq_base;
+static int omap_nr_pending = 3;
 static int omap_nr_irqs = 96;
 
 /* INTC bank register get/set */
@@ -268,6 +269,7 @@ out:
 void __init omap2_init_irq(void)
 {
 	omap_nr_irqs = 96;
+	omap_nr_pending = 3;
 	omap_init_irq(OMAP24XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
@@ -275,6 +277,7 @@ void __init omap2_init_irq(void)
 void __init omap3_init_irq(void)
 {
 	omap_nr_irqs = 96;
+	omap_nr_pending = 3;
 	omap_init_irq(OMAP34XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
@@ -282,6 +285,7 @@ void __init omap3_init_irq(void)
 void __init ti81xx_init_irq(void)
 {
 	omap_nr_irqs = 96;
+	omap_nr_pending = 4;
 	omap_init_irq(OMAP34XX_IC_BASE, NULL);
 	set_handle_irq(omap_intc_handle_irq);
 }
@@ -291,6 +295,7 @@ static int __init intc_of_init(struct device_node *node,
 {
 	struct resource res;
 
+	omap_nr_pending = 3;
 	omap_nr_irqs = 96;
 
 	if (WARN_ON(!node))
@@ -301,8 +306,10 @@ static int __init intc_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
-	if (of_device_is_compatible(node, "ti,am33xx-intc"))
+	if (of_device_is_compatible(node, "ti,am33xx-intc")) {
 		omap_nr_irqs = 128;
+		omap_nr_pending = 4;
+	}
 
 	omap_init_irq(res.start, of_node_get(node));
 
-- 
1.8.4.GIT


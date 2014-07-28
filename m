From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 28/35] arm: omap: irq: get rid of ifdef hack
Date: Mon, 28 Jul 2014 16:16:16 -0500
Message-ID: <1406582183-696-29-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59240 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbaG1VRm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jul 2014 17:17:42 -0400
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we don't need the ifdef if we have omap_nr_pending
telling us how many pending registers we have
on current platform. This solves a possible
problem where we could try to handle bogus
interrupts on OMAP2 and OMAP3 if using single
zImage kernel, because we would end up reading
the following pending FIQ register.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 583a1c7..43785ee 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -234,24 +234,16 @@ static void __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr;
+	u32 irqnr = 0;
 	int handled_irq = 0;
+	int i;
 
 	do {
-		irqnr = intc_readl(INTC_PENDING_IRQ0);
-		if (irqnr)
-			goto out;
-
-		irqnr = intc_readl(INTC_PENDING_IRQ1);
-		if (irqnr)
-			goto out;
-
-		irqnr = intc_readl(INTC_PENDING_IRQ2);
-#if IS_ENABLED(CONFIG_SOC_TI81XX) || IS_ENABLED(CONFIG_SOC_AM33XX)
-		if (irqnr)
-			goto out;
-		irqnr = intc_readl(INTC_PENDING_IRQ3);
-#endif
+		for (i = 0; i < omap_nr_pending; i++) {
+			irqnr = intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
+			if (irqnr)
+				goto out;
+		}
 
 out:
 		if (!irqnr)
-- 
2.0.1.563.g66f467c


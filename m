From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 31/31] arm: omap: irq: get rid of ifdef hack
Date: Wed, 20 Nov 2013 12:09:18 -0600
Message-ID: <1384970958-4118-32-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39971 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab3KTSK5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:57 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

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
index 1b2266a..35669c1 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -234,23 +234,15 @@ static void __init omap_init_irq(u32 base, struct device_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr;
+	u32 irqnr = 0;
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
1.8.4.GIT


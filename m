From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 07/31] arm: omap: irq: switch over to intc_readl on omap_intc_handle_irq
Date: Wed, 20 Nov 2013 12:08:54 -0600
Message-ID: <1384970958-4118-8-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab3KTSKS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:18 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

an almost blind conversion from readl_relaxed
to our newly introduced intc_readl().

While at that, also remove some hardcoded
register addresses.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 0772a3db..0fe790c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -41,11 +41,13 @@
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
+#define INTC_PENDING_IRQ1	0x00b8
+#define INTC_PENDING_IRQ2	0x00d8
+#define INTC_PENDING_IRQ3	0x00f8
 #define INTC_ILR0		0x0100
 
 #define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
@@ -191,26 +193,26 @@ static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs
 	u32 irqnr;
 
 	do {
-		irqnr = readl_relaxed(base_addr + 0x98);
+		irqnr = intc_readl(INTC_PENDING_IRQ0);
 		if (irqnr)
 			goto out;
 
-		irqnr = readl_relaxed(base_addr + 0xb8);
+		irqnr = intc_readl(INTC_PENDING_IRQ1);
 		if (irqnr)
 			goto out;
 
-		irqnr = readl_relaxed(base_addr + 0xd8);
+		irqnr = intc_readl(INTC_PENDING_IRQ2);
 #if IS_ENABLED(CONFIG_SOC_TI81XX) || IS_ENABLED(CONFIG_SOC_AM33XX)
 		if (irqnr)
 			goto out;
-		irqnr = readl_relaxed(base_addr + 0xf8);
+		irqnr = intc_readl(INTC_PENDING_IRQ3);
 #endif
 
 out:
 		if (!irqnr)
 			break;
 
-		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
+		irqnr = intc_readl(INTC_SIR);
 		irqnr &= ACTIVEIRQ_MASK;
 
 		if (irqnr) {
-- 
1.8.4.GIT


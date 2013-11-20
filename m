From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 08/31] arm: omap: irq: remove unnecessary base_addr argument
Date: Wed, 20 Nov 2013 12:08:55 -0600
Message-ID: <1384970958-4118-9-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48447 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193Ab3KTSKU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:20 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

omap_intc_handle_irq now had an unnecessary
base_addr argument. Let's remove it and fix
all callers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 0fe790c..ec97ade 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -46,8 +46,6 @@
 #define INTC_PENDING_IRQ3	0x00f8
 #define INTC_ILR0		0x0100
 
-#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
@@ -188,7 +186,7 @@ void __init ti81xx_init_irq(void)
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
 }
 
-static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs *regs)
+static inline void omap_intc_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
@@ -224,8 +222,7 @@ out:
 
 asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs)
 {
-	void __iomem *base_addr = OMAP2_IRQ_BASE;
-	omap_intc_handle_irq(base_addr, regs);
+	omap_intc_handle_irq(regs);
 }
 
 int __init intc_of_init(struct device_node *node,
@@ -326,7 +323,6 @@ void omap3_intc_resume_idle(void)
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
-	void __iomem *base_addr = OMAP3_IRQ_BASE;
-	omap_intc_handle_irq(base_addr, regs);
+	omap_intc_handle_irq(regs);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
-- 
1.8.4.GIT


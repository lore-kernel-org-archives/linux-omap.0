From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 23/31] arm: omap: irq: move some more code around
Date: Wed, 20 Nov 2013 12:09:10 -0600
Message-ID: <1384970958-4118-24-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52601 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab3KTSKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:40 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

We want .init_irq to call set_irq_handle() for
legacy platforms. Note that this code will also
be dropped once omap2/3 devices are completely
moved to DT.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e87e8be..6b9bf0b 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -245,21 +245,6 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 		omap_alloc_gc(omap_irq_base + j, j + irq_base, 32);
 }
 
-void __init omap2_init_irq(void)
-{
-	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
-}
-
-void __init omap3_init_irq(void)
-{
-	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
-}
-
-void __init ti81xx_init_irq(void)
-{
-	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
-}
-
 static inline void omap_intc_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -299,6 +284,21 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(regs);
 }
 
+void __init omap2_init_irq(void)
+{
+	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+}
+
+void __init omap3_init_irq(void)
+{
+	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+}
+
+void __init ti81xx_init_irq(void)
+{
+	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+}
+
 static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
-- 
1.8.4.GIT


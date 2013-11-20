From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 26/31] arm: omap: irq: drop omap2_intc_handle_irq()
Date: Wed, 20 Nov 2013 12:09:13 -0600
Message-ID: <1384970958-4118-27-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab3KTSKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:45 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

that was just a no-op wrapper around omap_intc_handle_irq
anyway.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h |  1 -
 arch/arm/mach-omap2/irq.c    | 16 ++++++----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index bfc5e5f..427160b 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -199,7 +199,6 @@ void omap2_init_irq(void);
 void omap3_init_irq(void);
 void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
-void omap2_intc_handle_irq(struct pt_regs *regs);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index f72af7a..5425258 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -245,7 +245,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 		omap_alloc_gc(omap_irq_base + j, j + irq_base, 32);
 }
 
-static inline void omap_intc_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry
+omap_intc_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
@@ -279,27 +280,22 @@ out:
 	} while (irqnr);
 }
 
-asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs)
-{
-	omap_intc_handle_irq(regs);
-}
-
 void __init omap2_init_irq(void)
 {
 	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
-	set_handle_irq(omap2_intc_handle_irq);
+	set_handle_irq(omap_intc_handle_irq);
 }
 
 void __init omap3_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
-	set_handle_irq(omap2_intc_handle_irq);
+	set_handle_irq(omap_intc_handle_irq);
 }
 
 void __init ti81xx_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
-	set_handle_irq(omap2_intc_handle_irq);
+	set_handle_irq(omap_intc_handle_irq);
 }
 
 static int __init intc_of_init(struct device_node *node,
@@ -321,7 +317,7 @@ static int __init intc_of_init(struct device_node *node,
 
 	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
-	set_handle_irq(omap2_intc_handle_irq);
+	set_handle_irq(omap_intc_handle_irq);
 
 	return 0;
 }
-- 
1.8.4.GIT


From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 25/31] arm: omap: irq: drop omap3_intc_handle_irq()
Date: Wed, 20 Nov 2013 12:09:12 -0600
Message-ID: <1384970958-4118-26-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab3KTSKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:50 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

there are no more users for that function, we
can safely drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h | 1 -
 arch/arm/mach-omap2/irq.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4df64c36..bfc5e5f 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -200,7 +200,6 @@ void omap3_init_irq(void);
 void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
-void omap3_intc_handle_irq(struct pt_regs *regs);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index d936955..f72af7a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -329,8 +329,3 @@ static int __init intc_of_init(struct device_node *node,
 IRQCHIP_DECLARE(omap2_intc, "ti,omap2-intc", intc_of_init);
 IRQCHIP_DECLARE(omap3_intc, "ti,omap3-intc", intc_of_init);
 IRQCHIP_DECLARE(am33xx_intc, "ti,am33xx-intc", intc_of_init);
-
-asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
-{
-	omap_intc_handle_irq(regs);
-}
-- 
1.8.4.GIT


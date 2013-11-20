From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 12/31] arm: omap: irq: add suspend/resume methods
Date: Wed, 20 Nov 2013 12:08:59 -0600
Message-ID: <1384970958-4118-13-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51650 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab3KTSK2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:28 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

there is a generic way to suspend/resume irqchips,
let's use that instead of our homebrew version.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 45c5acc..6dfa6cf 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -150,6 +150,18 @@ static void omap_mask_ack_irq(struct irq_data *d)
 	omap_ack_irq(d);
 }
 
+static void omap_suspend_irq(struct irq_data *d)
+{
+	omap3_intc_prepare_idle();
+	omap_intc_save_context();
+}
+
+static void omap_resume_irq(struct irq_data *d)
+{
+	omap_intc_restore_context();
+	omap3_intc_resume_idle();
+}
+
 static void __init omap_irq_soft_reset(void)
 {
 	unsigned long tmp;
@@ -199,6 +211,8 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 	ct->chip.irq_ack = omap_mask_ack_irq;
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_suspend = omap_suspend_irq;
+	ct->chip.irq_resume = omap_resume_irq;
 	ct->chip.flags |= IRQCHIP_SKIP_SET_WAKE;
 
 	ct->regs.enable = INTC_MIR_CLEAR0;
-- 
1.8.4.GIT


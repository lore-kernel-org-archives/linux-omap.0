From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 13/31] arm: omap: irq: remove last bits of our homebrew irqchip pm
Date: Wed, 20 Nov 2013 12:09:00 -0600
Message-ID: <1384970958-4118-14-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab3KTSKc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:32 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

completely move towards generic irqchip PM.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h |  5 -----
 arch/arm/mach-omap2/irq.c    | 21 +++++++++------------
 arch/arm/mach-omap2/pm34xx.c | 10 ----------
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f7644fe..4d90328 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -199,11 +199,6 @@ void omap2_init_irq(void);
 void omap3_init_irq(void);
 void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
-void omap_intc_save_context(void);
-void omap_intc_restore_context(void);
-void omap3_intc_suspend(void);
-void omap3_intc_prepare_idle(void);
-void omap3_intc_resume_idle(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
 void omap3_intc_handle_irq(struct pt_regs *regs);
 void omap_intc_of_init(void);
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 6dfa6cf..f290f16 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -83,7 +83,7 @@ static u32 intc_readl(u32 reg)
 	return readl_relaxed(omap_irq_base + reg);
 }
 
-void omap_intc_save_context(void)
+static void omap_intc_save_context(void)
 {
 	int i;
 
@@ -104,7 +104,7 @@ void omap_intc_save_context(void)
 			intc_readl(INTC_MIR0 + (0x20 * i));
 }
 
-void omap_intc_restore_context(void)
+static void omap_intc_restore_context(void)
 {
 	int i;
 
@@ -123,7 +123,7 @@ void omap_intc_restore_context(void)
 	/* MIRs are saved and restore with other PRCM registers */
 }
 
-void omap3_intc_prepare_idle(void)
+static void omap_intc_prepare_idle(void)
 {
 	/*
 	 * Disable autoidle as it can stall interrupt controller,
@@ -132,7 +132,7 @@ void omap3_intc_prepare_idle(void)
 	intc_writel(INTC_SYSCONFIG, 0);
 }
 
-void omap3_intc_resume_idle(void)
+static void omap_intc_resume_idle(void)
 {
 	/* Re-enable autoidle */
 	intc_writel(INTC_SYSCONFIG, 1);
@@ -152,14 +152,17 @@ static void omap_mask_ack_irq(struct irq_data *d)
 
 static void omap_suspend_irq(struct irq_data *d)
 {
-	omap3_intc_prepare_idle();
+	omap_intc_prepare_idle();
 	omap_intc_save_context();
+
+	/* A pending interrupt would prevent OMAP from entering suspend */
+	omap_ack_irq(NULL);
 }
 
 static void omap_resume_irq(struct irq_data *d)
 {
 	omap_intc_restore_context();
-	omap3_intc_resume_idle();
+	omap_intc_resume_idle();
 }
 
 static void __init omap_irq_soft_reset(void)
@@ -193,12 +196,6 @@ int omap_irq_pending(void)
 	return 0;
 }
 
-void omap3_intc_suspend(void)
-{
-	/* A pending interrupt would prevent OMAP from entering suspend */
-	omap_ack_irq(NULL);
-}
-
 static __init void
 omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 93b80e5..2764796 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -82,8 +82,6 @@ static void omap3_core_save_context(void)
 	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
 		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
 
-	/* Save the Interrupt controller context */
-	omap_intc_save_context();
 	/* Save the GPMC context */
 	omap3_gpmc_save_context();
 	/* Save the system control module context, padconf already save above*/
@@ -97,8 +95,6 @@ static void omap3_core_restore_context(void)
 	omap3_control_restore_context();
 	/* Restore the GPMC context */
 	omap3_gpmc_restore_context();
-	/* Restore the interrupt controller context */
-	omap_intc_restore_context();
 	omap_dma_global_context_restore();
 }
 
@@ -288,8 +284,6 @@ void omap_sram_idle(void)
 		}
 	}
 
-	omap3_intc_prepare_idle();
-
 	/*
 	 * On EMU/HS devices ROM code restores a SRDC value
 	 * from scratchpad which has automatic self refresh on timeout
@@ -335,8 +329,6 @@ void omap_sram_idle(void)
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
-	omap3_intc_resume_idle();
-
 	pwrdm_post_transition(NULL);
 
 	/* PER */
@@ -373,8 +365,6 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap3_intc_suspend();
-
 	omap_sram_idle();
 
 restore:
-- 
1.8.4.GIT


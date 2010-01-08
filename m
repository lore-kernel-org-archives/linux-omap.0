From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/13] OMAP3: PM: Disable interrupt controller AUTOIDLE before WFI
Date: Fri,  8 Jan 2010 09:59:22 -0800
Message-ID: <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47107 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab0AHR7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:42 -0500
Received: by pwj9 with SMTP id 9so160327pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:41 -0800 (PST)
In-Reply-To: <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

OMAP interrupt controller goes to unknown state when there is right
combination of l3,l4 sleep/wake-up transitions, l4 autoidle in
interrupt controller and some interrupt. When this happens, interrupts
are not delivered to ARM anymore and ARM will remain in WFI (wait for
interrupt) until interrupt controller is forced to wake-up
(i.e. lauterbach).

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c              |   12 ++++++++++++
 arch/arm/mach-omap2/pm34xx.c           |    2 ++
 arch/arm/plat-omap/include/plat/irqs.h |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 54c5f0d..2705402 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -280,4 +280,16 @@ void omap3_intc_suspend(void)
 	/* A pending interrupt would prevent OMAP from entering suspend */
 	omap_ack_irq(0);
 }
+
+void omap3_intc_prepare_idle(void)
+{
+	/* Disable autoidle as it can stall interrupt controller */
+	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
+}
+
+void omap3_intc_resume_idle(void)
+{
+	/* Re-enable autoidle */
+	intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8a148fb..af83555 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -392,6 +392,7 @@ void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
+	omap3_intc_prepare_idle();
 
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
@@ -438,6 +439,7 @@ void omap_sram_idle(void)
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
+	omap3_intc_resume_idle();
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 0082036..c0ab7c8 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -500,6 +500,8 @@ extern int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);
 void omap3_intc_suspend(void);
+void omap3_intc_prepare_idle(void);
+void omap3_intc_resume_idle(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.6.6.rc2.1.g42108


From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 06/11] OMAP3: PM: Disable interrupt controller AUTOIDLE before WFI
Date: Fri, 23 Oct 2009 19:03:50 +0300
Message-ID: <1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21480 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZJWQSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:33 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIZKs001682
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:36 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPiA022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:32 +0300
In-Reply-To: <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

OMAP interrupt controller goes to unknown state when there is right
combination of l3,l4 sleep/wake-up transitions, l4 autoidle in
interrupt controller and some interrupt. When this happens, interrupts
are not delivered to ARM anymore and ARM will remain in WFI (wait for
interrupt) until interrupt controller is forced to wake-up
(i.e. lauterbach).

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/irq.c              |   12 ++++++++++++
 arch/arm/mach-omap2/pm34xx.c           |    2 ++
 arch/arm/plat-omap/include/mach/irqs.h |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ee8c68a..9241b87 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -272,4 +272,16 @@ void omap3_intc_suspend(void)
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
index 492458e..fec9c38 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -431,6 +431,7 @@ void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
+	omap3_intc_prepare_idle();
 
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
@@ -487,6 +488,7 @@ void omap_sram_idle(void)
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
+	omap3_intc_resume_idle();
 
 	/*
 	 * Enable smartreflex after WFI. Only needed if we entered
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index ff1faa8..b736c5d 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -486,6 +486,8 @@ extern int omap_irq_pending(void);
 void omap3_intc_save_context(void);
 void omap3_intc_restore_context(void);
 void omap3_intc_suspend(void);
+void omap3_intc_prepare_idle(void);
+void omap3_intc_resume_idle(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.5.4.3


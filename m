From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: INTC: use idle notifier for autoidle management
Date: Wed, 20 Oct 2010 16:31:22 -0700
Message-ID: <1287617483-24170-2-git-send-email-khilman@deeprootsystems.com>
References: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56536 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0JTXb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 19:31:28 -0400
Received: by mail-px0-f174.google.com with SMTP id 16so1050453pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 16:31:28 -0700 (PDT)
In-Reply-To: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Move INTC autoidle management from custom hook to use the new idle
notifier.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c              |   36 +++++++++++++++++++++----------
 arch/arm/mach-omap2/pm34xx.c           |    3 --
 arch/arm/plat-omap/include/plat/irqs.h |    2 -
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..cb51f74 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -14,10 +14,12 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/notifier.h>
+
+#include <plat/common.h>
 #include <mach/hardware.h>
 #include <asm/mach/irq.h>
 
-
 /* selected INTC register offsets */
 
 #define INTC_REVISION		0x0000
@@ -186,6 +188,24 @@ int omap_irq_pending(void)
 	return 0;
 }
 
+static int omap3_intc_idle_notifier(struct notifier_block *n,
+				      unsigned long val,
+				      void *p)
+{
+	if (val == OMAP_IDLE_START)
+		/* Disable autoidle as it can stall interrupt controller */
+		intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
+	else
+		/* Re-enable autoidle */
+		intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
+
+	return 0;
+}
+
+static struct notifier_block omap3_intc_notifier = {
+	.notifier_call = omap3_intc_idle_notifier,
+};
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_of_irqs = 0;
@@ -224,6 +244,9 @@ void __init omap_init_irq(void)
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
+
+	if (cpu_is_omap34xx())
+		omap_idle_notifier_register(&omap3_intc_notifier);
 }
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -282,15 +305,4 @@ void omap3_intc_suspend(void)
 	omap_ack_irq(0);
 }
 
-void omap3_intc_prepare_idle(void)
-{
-	/* Disable autoidle as it can stall interrupt controller */
-	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
-}
-
-void omap3_intc_resume_idle(void)
-{
-	/* Re-enable autoidle */
-	intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
-}
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 713bd04..4674748 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -407,8 +407,6 @@ void omap_sram_idle(void)
 		}
 	}
 
-	omap3_intc_prepare_idle();
-
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
@@ -454,7 +452,6 @@ void omap_sram_idle(void)
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
-	omap3_intc_resume_idle();
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 65e20a6..b87c211 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -424,8 +424,6 @@ extern int omap_irq_pending(void);
 void omap_intc_save_context(void);
 void omap_intc_restore_context(void);
 void omap3_intc_suspend(void);
-void omap3_intc_prepare_idle(void);
-void omap3_intc_resume_idle(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.7.2.1


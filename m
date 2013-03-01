From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 10/15] ARM: OMAP5: PM: Add MPU Open Switch Retention support
Date: Fri, 1 Mar 2013 17:40:59 +0530
Message-ID: <1362139864-9233-11-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33034 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3CAMKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:10:21 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

In MPUSS OSWR(Open Switch Retention), entire CPU cluster is powered down
except L2 cache memory. For MPUSS OSWR state, both CPU's needs to be in
power off state.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    2 ++
 arch/arm/mach-omap2/omap-secure.h         |    5 +++++
 arch/arm/mach-omap2/omap-wakeupgen.c      |   11 ++++++-----
 arch/arm/mach-omap2/sleep_omap4plus.S     |   23 +++++++++++++++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 275f9a4..c1c6b9d 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -82,6 +82,7 @@ struct cpu_pm_ops {
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
 extern int omap5_finish_suspend(unsigned long cpu_state);
+extern void omap5_cpu_resume(void);
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
@@ -459,6 +460,7 @@ int __init omap4_mpuss_init(void)
 	} else if (soc_is_omap54xx()) {
 		omap_pm_ops.finish_suspend = omap5_finish_suspend;
 		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
+		omap_pm_ops.resume = omap5_cpu_resume;
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 		enable_mercury_retention_mode();
 	}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 6f4dbee..1739468 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -34,6 +34,10 @@
 #define OMAP4_HAL_SAVEHW_INDEX		0x1b
 #define OMAP4_HAL_SAVEALL_INDEX		0x1c
 #define OMAP4_HAL_SAVEGIC_INDEX		0x1d
+#define OMAP5_HAL_SAVESECURERAM_INDEX	0x1c
+#define OMAP5_HAL_SAVEHW_INDEX		0x1d
+#define OMAP5_HAL_SAVEALL_INDEX		0x1e
+#define OMAP5_HAL_SAVEGIC_INDEX		0x1f
 
 /* Secure Monitor mode APIs */
 #define OMAP4_MON_SCU_PWR_INDEX		0x108
@@ -42,6 +46,7 @@
 #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 #define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
+#define OMAP5_MON_AUX_CTRL_INDEX	0x107
 
 #define OMAP5_MON_AMBA_IF_INDEX		0x108
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index a7350dd..f57b0b8 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -50,7 +50,7 @@ static DEFINE_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
-static unsigned int omap_secure_apis;
+static unsigned int omap_secure_apis, secure_api_index;
 
 /*
  * Static helper functions.
@@ -315,7 +315,7 @@ static void irq_sar_clear(void)
 static void irq_save_secure_context(void)
 {
 	u32 ret;
-	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
+	ret = omap_secure_dispatcher(secure_api_index,
 				FLAG_START_CRITICAL,
 				0, 0, 0, 0, 0);
 	if (ret != API_HAL_RET_VALUE_OK)
@@ -377,9 +377,7 @@ static struct notifier_block irq_notifier_block = {
 
 static void __init irq_pm_init(void)
 {
-	/* FIXME: Remove this when MPU OSWR support is added */
-	if (!soc_is_omap54xx())
-		cpu_pm_register_notifier(&irq_notifier_block);
+	cpu_pm_register_notifier(&irq_notifier_block);
 }
 #else
 static void __init irq_pm_init(void)
@@ -420,6 +418,9 @@ int __init omap_wakeupgen_init(void)
 		irq_banks = OMAP4_NR_BANKS;
 		max_irqs = OMAP4_NR_IRQS;
 		omap_secure_apis = 1;
+		secure_api_index = OMAP4_HAL_SAVEGIC_INDEX;
+	} else if (soc_is_omap54xx()) {
+		secure_api_index = OMAP5_HAL_SAVEGIC_INDEX;
 	}
 
 	/* Clear all IRQ bitmasks at wakeupGen level */
diff --git a/arch/arm/mach-omap2/sleep_omap4plus.S b/arch/arm/mach-omap2/sleep_omap4plus.S
index 3322fc8..f4874e5 100644
--- a/arch/arm/mach-omap2/sleep_omap4plus.S
+++ b/arch/arm/mach-omap2/sleep_omap4plus.S
@@ -406,6 +406,29 @@ do_wfi:
 	dsb
 	ldmfd	sp!, {r4-r12, pc}
 ENDPROC(omap5_finish_suspend)
+
+ENTRY(omap5_cpu_resume)
+#ifdef CONFIG_ARM_ERRATA_761171
+	/*
+	 * Work around for errata for 761171. Streaming write that will not
+	 * allocate in L2 could lead to data corruption.
+	 */
+	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
+	and	r5, r0, #0x00f00000		@ variant
+	and	r6, r0, #0x0000000f		@ revision
+	orr	r6, r6, r5, lsr #20-4		@ combine variant and revision
+	cmp	r6, #0x03			@ Present before r0p3
+	bgt	1f
+	mrc	p15, 0, r0, c1, c0, 1		@ Read Auxctrl
+	orr	r0, r0, #0x3 << 27		@ bits[28:27]-L1_mode3_threshold
+	ldr	r12, =OMAP5_MON_AUX_CTRL_INDEX
+	dsb
+	smc	#0
+	dsb
+1:
+#endif
+	b	cpu_resume			@ Jump to generic resume
+ENDPROC(omap5_cpu_resume)
 #endif
 
 #ifndef CONFIG_OMAP4_ERRATA_I688
-- 
1.7.9.5


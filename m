From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP5: Add cpuidle assembly code
Date: Thu, 17 Aug 2017 16:01:21 -0700
Message-ID: <20170817230122.30655-3-tony@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170817230122.30655-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

In order to support CPU off modes during idle like omap4 already
does, we need to add the assembly code needed for restoring the
CPU state from off mode.

The code is a combination of the following earlier patches done
by Santosh Shilimkar <santosh.shilimkar@oracle.com> in TI Linux
kernel tree:

881603c3f97f ("ARM: OMAP5: PM: Add CPU power off mode support")
411533444365 ("ARM: OMAP5: PM: Add MPU Open Switch Retention support")
3f9ea63594c3 ("ARM: OMAP5: PM: Add L2 memory power down support")

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[tony@atomide.com: updated against mainline kernel]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h              |  11 +++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   8 +-
 arch/arm/mach-omap2/omap-secure.h         |   6 ++
 arch/arm/mach-omap2/omap-wakeupgen.c      |   5 +-
 arch/arm/mach-omap2/sleep44xx.S           | 137 ++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -318,6 +318,8 @@ static inline void omap4_cpu_resume(void)
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void omap5_secondary_startup(void);
 void omap5_secondary_hyp_startup(void);
+int omap5_finish_suspend(unsigned long cpu_state);
+void omap5_cpu_resume(void);
 #else
 static inline void omap5_secondary_startup(void)
 {
@@ -326,6 +328,15 @@ static inline void omap5_secondary_startup(void)
 static inline void omap5_secondary_hyp_startup(void)
 {
 }
+
+static inline int omap5_finish_suspend(unsigned long cpu_state)
+{
+	return 0;
+}
+
+static inline void omap5_cpu_resume(void)
+{
+}
 #endif
 
 void pdata_quirks_init(const struct of_device_id *);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -439,7 +439,13 @@ int __init omap4_mpuss_init(void)
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
 		omap_pm_ops.hotplug_restart = omap4_secondary_startup;
 		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
-	} else if (soc_is_omap54xx() || soc_is_dra7xx()) {
+	} else if (soc_is_omap54xx()) {
+		omap_pm_ops.finish_suspend = omap5_finish_suspend;
+		omap_pm_ops.resume = omap5_cpu_resume;
+		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
+		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
+		enable_mercury_retention_mode();
+	} else if (soc_is_dra7xx()) {
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 		enable_mercury_retention_mode();
 	}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -36,6 +36,10 @@
 #define OMAP4_HAL_SAVEHW_INDEX		0x1b
 #define OMAP4_HAL_SAVEALL_INDEX		0x1c
 #define OMAP4_HAL_SAVEGIC_INDEX		0x1d
+#define OMAP5_HAL_SAVESECURERAM_INDEX	0x1c
+#define OMAP5_HAL_SAVEHW_INDEX		0x1d
+#define OMAP5_HAL_SAVEALL_INDEX		0x1e
+#define OMAP5_HAL_SAVEGIC_INDEX		0x1f
 
 /* Secure Monitor mode APIs */
 #define OMAP4_MON_SCU_PWR_INDEX		0x108
@@ -44,6 +48,8 @@
 #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 
+#define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
+#define OMAP5_MON_L2AUX_CTRL_INDEX	0x104
 #define OMAP5_DRA7_MON_SET_CNTFRQ_INDEX	0x109
 #define OMAP5_MON_AMBA_IF_INDEX		0x108
 #define OMAP5_DRA7_MON_SET_ACR_INDEX	0x107
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -56,7 +56,7 @@ static DEFINE_RAW_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = DEFAULT_NR_REG_BANKS;
 static unsigned int max_irqs = DEFAULT_IRQS;
-static unsigned int omap_secure_apis;
+static unsigned int omap_secure_apis, secure_api_index;
 
 #ifdef CONFIG_CPU_PM
 static unsigned int wakeupgen_context[MAX_NR_REG_BANKS];
@@ -345,7 +345,7 @@ static void irq_restore_context(void)
 static void irq_save_secure_context(void)
 {
 	u32 ret;
-	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
+	ret = omap_secure_dispatcher(secure_api_index,
 				FLAG_START_CRITICAL,
 				0, 0, 0, 0, 0);
 	if (ret != API_HAL_RET_VALUE_OK)
@@ -549,6 +549,7 @@ static int __init wakeupgen_init(struct device_node *node,
 		wakeupgen_ops = &omap4_wakeupgen_ops;
 	} else if (soc_is_omap54xx()) {
 		wakeupgen_ops = &omap5_wakeupgen_ops;
+		secure_api_index = OMAP5_HAL_SAVEGIC_INDEX;
 	} else if (soc_is_am43xx()) {
 		irq_banks = AM43XX_NR_REG_BANKS;
 		max_irqs = AM43XX_IRQS;
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -20,6 +20,7 @@
 #include "common.h"
 #include "omap44xx.h"
 #include "omap4-sar-layout.h"
+#include "omap-secure.h"
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 
@@ -331,6 +332,142 @@ ppa_por_params_offset:
 ENDPROC(omap4_cpu_resume)
 #endif	/* CONFIG_ARCH_OMAP4 */
 
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
+
+/*
+ * ================================
+ * == OMAP5 CPU suspend finisher ==
+ * ================================
+ *
+ * OMAP5 MPUSS states for the context save:
+ * save_state =
+ *	0 - Nothing lost and no need to save: MPUSS INA/CSWR
+ *	1 - CPUx L1 and logic lost: CPU OFF, MPUSS INA/CSWR
+ *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
+ *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
+ */
+ENTRY(omap5_finish_suspend)
+	stmfd	sp!, {r4-r12, lr}
+	cmp	r0, #0x0
+	beq	do_wfi				@ No lowpower state, jump to WFI
+
+	/*
+	 * Flush all data from the L1 data cache before disabling
+	 * SCTLR.C bit.
+	 */
+	bl	omap4_get_sar_ram_base
+	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	skip_secure_l1_clean_op
+	mov	r0, #0				@ Clean secure L1
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP5_MON_CACHES_CLEAN_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+skip_secure_l1_clean_op:
+	bl	v7_flush_dcache_louis
+
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)		@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	/* Clean and Invalidate L1 data cache. */
+	bl	v7_flush_dcache_louis
+
+	/*
+	 * Take CPU out of Symmetric Multiprocessing (SMP) mode and thus
+	 * preventing the CPU from receiving cache, TLB, or BTB
+	 * maintenance operations broadcast by other CPUs in the cluster.
+	 */
+	mrc	p15, 0, r0, c1, c1, 2		@ Read NSACR data
+	tst	r0, #(1 << 18)
+	mrcne	p15, 0, r0, c1, c0, 1
+	bicne	r0, r0, #(1 << 6)		@ Disable SMP bit
+	mcrne	p15, 0, r0, c1, c0, 1
+	isb
+	dsb
+
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
+	ands	r5, r5, #0x0f
+	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]	@ Retrieve L2 state
+	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
+	cmp	r0, #3
+	bne	do_wfi
+	bl	omap4_get_sar_ram_base
+	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	skip_secure_l2_clean_op
+	mov	r0, #1				@ Clean secure L2
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP5_MON_CACHES_CLEAN_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+skip_secure_l2_clean_op:
+	mov	r0, #2				@ Flush L2
+	bl	v7_flush_dcache_all
+
+do_wfi:
+	bl	omap_do_wfi
+
+	/*
+	 * CPU is here when it failed to enter OFF/DORMANT or
+	 * no low power state was attempted.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	tst	r0, #(1 << 2)			@ Check C bit enabled?
+	orreq	r0, r0, #(1 << 2)		@ Enable the C bit
+	mcreq	p15, 0, r0, c1, c0, 0
+	isb
+	mrc	p15, 0, r0, c1, c0, 1
+	tst	r0, #(1 << 6)			@ Check SMP bit enabled?
+	orreq	r0, r0, #(1 << 6)
+	mcreq	p15, 0, r0, c1, c0, 1
+	isb
+	dsb
+	ldmfd	sp!, {r4-r12, pc}
+ENDPROC(omap5_finish_suspend)
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
+	mrc	p15, 1, r0, c15, c0, 0		@ Read L2 ACTLR
+	cmp	r0, #0x118			@ Check if it is already set
+	beq	skip_sec_l2
+	ldr	r0, =0x118			@ Setup L2 ACTLR = 0x118
+	ldr	r12, =OMAP5_MON_L2AUX_CTRL_INDEX
+	dsb
+	smc     #0
+	dsb
+skip_sec_l2:
+	b	cpu_resume			@ Jump to generic resume
+ENDPROC(omap5_cpu_resume)
+#endif
+
 #endif	/* defined(CONFIG_SMP) && defined(CONFIG_PM) */
 
 ENTRY(omap_do_wfi)
-- 
2.14.1

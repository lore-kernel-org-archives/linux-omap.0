From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Sun, 4 Sep 2011 19:24:15 +0530
Message-ID: <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab1IDN4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 09:56:14 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
retention (CSWR) is not supported by hardware design.

The CPUx OFF mode isn't supported on OMAP4430 ES1.0

CPUx sleep code is common for hotplug, suspend and CPUilde.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Makefile                    |    3 +-
 arch/arm/mach-omap2/include/mach/omap-secure.h  |    8 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |   25 +++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |  249 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c                  |    6 +
 arch/arm/mach-omap2/omap4-sar-layout.h          |    9 +
 arch/arm/mach-omap2/pm44xx.c                    |    6 +
 arch/arm/mach-omap2/sleep44xx.S                 |  213 +++++++++++++++++++
 8 files changed, 518 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b032c21..b4f2eeb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -63,7 +63,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
 					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o sleep44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o sleep44xx.o \
+					   omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
index e2f95a0..0062d49 100644
--- a/arch/arm/mach-omap2/include/mach/omap-secure.h
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -35,10 +35,18 @@
 #define OMAP4_HAL_SAVEALL_INDEX		0x1c
 #define OMAP4_HAL_SAVEGIC_INDEX		0x1d
 
+/* Secure Monitor mode APIs */
+#define OMAP4_MON_SCU_PWR_INDEX		0x108
+
+/* Secure PPA(Primary Protected Application) APIs */
+#define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
+
+#ifndef __ASSEMBLER__
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
 
+#endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 040dcf6..662f37c 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -45,5 +45,30 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
 #endif
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PM)
+extern int omap4_mpuss_init(void);
+extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
+extern int omap4_finish_suspend(unsigned long cpu_state);
+extern void omap4_cpu_resume(void);
+#else
+static inline int omap4_enter_lowpower(unsigned int cpu,
+					unsigned int power_state)
+{
+	omap_do_wfi();
+	return 0;
+}
+
+static inline int omap4_mpuss_init(void)
+{
+	return 0;
+}
+
+static inline int omap4_finish_suspend(unsigned long cpu_state)
+{}
+static inline void omap4_cpu_resume(void)
+{}
+#endif
+
 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP4_COMMON_H */
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
new file mode 100644
index 0000000..1137537
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -0,0 +1,249 @@
+/*
+ * OMAP MPUSS low power code
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * OMAP4430 MPUSS mainly consists of dual Cortex-A9 with per-CPU
+ * Local timer and Watchdog, GIC, SCU, PL310 L2 cache controller,
+ * CPU0 and CPU1 LPRM modules.
+ * CPU0, CPU1 and MPUSS each have there own power domain and
+ * hence multiple low power combinations of MPUSS are possible.
+ *
+ * The CPU0 and CPU1 can't support Closed switch Retention (CSWR)
+ * because the mode is not supported by hw constraints of dormant
+ * mode. While waking up from the dormant mode, a reset  signal
+ * to the Cortex-A9 processor must be asserted by the external
+ * power controller.
+ *
+ * With architectural inputs and hardware recommendations, only
+ * below modes are supported from power gain vs latency point of view.
+ *
+ *	CPU0		CPU1		MPUSS
+ *	----------------------------------------------
+ *	ON		ON		ON
+ *	ON(Inactive)	OFF		ON(Inactive)
+ *	OFF		OFF		CSWR
+ *	OFF		OFF		OSWR (*TBD)
+ *	OFF		OFF		OFF* (*TBD)
+ *	----------------------------------------------
+ *
+ * Note: CPU0 is the master core and it is the last CPU to go down
+ * and first to wake-up when MPUSS low power states are excercised
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/smp_scu.h>
+#include <asm/system.h>
+#include <asm/pgalloc.h>
+#include <asm/suspend.h>
+
+#include <plat/omap44xx.h>
+#include <mach/omap4-common.h>
+
+#include "omap4-sar-layout.h"
+#include "pm.h"
+#include "powerdomain.h"
+
+#ifdef CONFIG_SMP
+
+struct omap4_cpu_pm_info {
+	struct powerdomain *pwrdm;
+	void __iomem *scu_sar_addr;
+	void __iomem *wkup_sar_addr;
+};
+
+static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
+
+/*
+ * Program the wakeup routine address for the CPU0 and CPU1
+ * used for OFF or DORMANT wakeup.
+ */
+static inline void set_cpu_wakeup_addr(unsigned int cpu_id, u32 addr)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+
+	__raw_writel(addr, pm_info->wkup_sar_addr);
+}
+
+/*
+ * Set the CPUx powerdomain's previous power state
+ */
+static inline void set_cpu_next_pwrst(unsigned int cpu_id,
+				unsigned int power_state)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+
+	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
+}
+
+/*
+ * Read CPU's previous power state
+ */
+static inline unsigned int read_cpu_prev_pwrst(unsigned int cpu_id)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+
+	return pwrdm_read_prev_pwrst(pm_info->pwrdm);
+}
+
+/*
+ * Clear the CPUx powerdomain's previous power state
+ */
+static inline void clear_cpu_prev_pwrst(unsigned int cpu_id)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+
+	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+}
+
+/*
+ * Store the SCU power status value to scratchpad memory
+ */
+static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+	u32 scu_pwr_st;
+
+	switch (cpu_state) {
+	case PWRDM_POWER_RET:
+		scu_pwr_st = SCU_PM_DORMANT;
+		break;
+	case PWRDM_POWER_OFF:
+		scu_pwr_st = SCU_PM_POWEROFF;
+		break;
+	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
+	default:
+		scu_pwr_st = SCU_PM_NORMAL;
+		break;
+	}
+
+	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
+}
+
+/**
+ * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
+ * The purpose of this function is to manage low power programming
+ * of OMAP4 MPUSS subsystem
+ * @cpu : CPU ID
+ * @power_state: Low power state.
+ */
+int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
+{
+	unsigned int save_state = 0;
+	unsigned int wakeup_cpu;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return -ENXIO;
+
+	switch (power_state) {
+	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
+		save_state = 0;
+		break;
+	case PWRDM_POWER_OFF:
+		save_state = 1;
+		break;
+	case PWRDM_POWER_RET:
+	default:
+		/*
+		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
+		 * doesn't make much scense, since logic is lost and $L1
+		 * needs to be cleaned because of coherency. This makes
+		 * CPUx OSWR equivalent to CPUX OFF and hence not supported
+		 */
+		WARN_ON(1);
+		return -ENXIO;
+	}
+
+	clear_cpu_prev_pwrst(cpu);
+	set_cpu_next_pwrst(cpu, power_state);
+	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
+	scu_pwrst_prepare(cpu, power_state);
+
+	/*
+	 * Call low level function  with targeted CPU id
+	 * and its low power state.
+	 */
+	cpu_suspend(save_state, omap4_finish_suspend);
+
+	/*
+	 * Restore the CPUx power state to ON otherwise CPUx
+	 * power domain can transitions to programmed low power
+	 * state while doing WFI outside the low powe code. On
+	 * secure devices, CPUx does WFI which can result in
+	 * domain transition
+	 */
+	wakeup_cpu = smp_processor_id();
+	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
+
+	return 0;
+}
+
+/*
+ * Initialise OMAP4 MPUSS
+ */
+int __init omap4_mpuss_init(void)
+{
+	struct omap4_cpu_pm_info *pm_info;
+	void __iomem *sar_base = omap4_get_sar_ram_base();
+
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
+	/* Initilaise per CPU PM information */
+	pm_info = &per_cpu(omap4_pm_info, 0x0);
+	pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
+	pm_info->wkup_sar_addr = sar_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
+	if (!pm_info->pwrdm) {
+		pr_err("Lookup failed for CPU0 pwrdm\n");
+		return -ENODEV;
+	}
+
+	/* Clear CPU previous power domain state */
+	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+
+	/* Initialise CPU0 power domain state to ON */
+	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
+
+	pm_info = &per_cpu(omap4_pm_info, 0x1);
+	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
+	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
+	if (!pm_info->pwrdm) {
+		pr_err("Lookup failed for CPU1 pwrdm\n");
+		return -ENODEV;
+	}
+
+	/* Clear CPU previous power domain state */
+	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+
+	/* Initialise CPU1 power domain state to ON */
+	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
+
+	/* Save device type on scratchpad for low level code to use */
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		__raw_writel(1, sar_base + OMAP_TYPE_OFFSET);
+	else
+		__raw_writel(0, sar_base + OMAP_TYPE_OFFSET);
+
+	return 0;
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 8e9b491..f920abe 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -25,6 +25,7 @@
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-secure.h>
 
 /* SCU base address */
 static void __iomem *scu_base;
@@ -38,6 +39,11 @@ void __iomem *omap4_get_scu_base(void)
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
+	/* Enable NS access to SMP bit for this CPU on EMU/HS devices */
+	if (cpu_is_omap443x() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
+							4, 0, 0, 0, 0, 0);
+
 	/*
 	 * If any interrupts are already enabled for the primary
 	 * core (e.g. timer irq), then they will not have been enabled
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 7781ea4..970a2ee 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -19,4 +19,13 @@
 #define SAR_BANK3_OFFSET		0x2000
 #define SAR_BANK4_OFFSET		0x3000
 
+/* Scratch pad memory offsets from SAR_BANK1 */
+#define SCU_OFFSET0				0xd00
+#define SCU_OFFSET1				0xd04
+#define OMAP_TYPE_OFFSET			0xd10
+
+/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
+#define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
+#define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
+
 #endif
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 44ce15c..4f39de5 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -178,6 +178,12 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	ret = omap4_mpuss_init();
+	if (ret) {
+		pr_err("Failed to initialise OMAP4 MPUSS\n");
+		goto err2;
+	}
+
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 049f426..230ab8c 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -11,8 +11,221 @@
 
 #include <linux/linkage.h>
 #include <asm/system.h>
+#include <asm/smp_scu.h>
+#include <asm/memory.h>
+#include <asm/hardware/cache-l2x0.h>
 
+#include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-secure.h>
+
+#include "omap4-sar-layout.h"
+
+#ifdef CONFIG_SMP
+
+.macro	DO_SMC
+	dsb
+	smc	#0
+	dsb
+.endm
+
+ppa_zero_params:
+	.word		0x0
+
+/*
+ * =============================
+ * == CPU suspend finisher ==
+ * =============================
+ *
+ * void omap4_finish_suspend(unsigned long cpu_state)
+ *
+ * This function code saves the CPU context and performs the CPU
+ * power down sequence. Calling WFI effectively changes the CPU
+ * power domains states to the desired target power state.
+ *
+ * @cpu_state : contains context save state (r0)
+ *	0 - No context lost
+ * 	1 - CPUx L1 and logic lost: MPUSS CSWR
+ * 	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
+ *	3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
+ * @return: This function never returns for CPU OFF and DORMANT power states.
+ * Post WFI, CPU transitions to DORMANT or OFF power state and on wake-up
+ * from this follows a full CPU reset path via ROM code to CPU restore code.
+ * It returns to the caller for CPU INACTIVE and ON power states or in case
+ * CPU failed to transition to targeted OFF/DORMANT state.
+ */
+ENTRY(omap4_finish_suspend)
+	stmfd	sp!, {lr}
+	cmp	r0, #0x0
+	beq	do_WFI				@ No lowpower state, jump to WFI
+
+	/*
+	 * Flush all data from the L1 data cache before disabling
+	 * SCTLR.C bit.
+	 */
+	bl	omap4_get_sar_ram_base
+	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	skip_secure_l1_clean
+	mov	r0, #SCU_PM_NORMAL
+	mov	r1, #0xFF			@ clean seucre L1
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+skip_secure_l1_clean:
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
+	/*
+	 * Invalidate L1 data cache. Even though only invalidate is
+	 * necessary exported flush API is used here. Doing clean
+	 * on already clean cache would be almost NOP.
+	 */
+	bl	v7_flush_dcache_all
+
+	/*
+	 * Switch the CPU from Symmetric Multiprocessing (SMP) mode
+	 * to AsymmetricMultiprocessing (AMP) mode by programming
+	 * the SCU power status to DORMANT or OFF mode.
+	 * This enables the CPU to be taken out of coherency by
+	 * preventing the CPU from receiving cache, TLB, or BTB
+	 * maintenance operations broadcast by other CPUs in the cluster.
+	 */
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	ldr	r9, [r8, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	scu_gp_set
+	mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
+	ands	r0, r0, #0x0f
+	ldreq	r0, [r8, #SCU_OFFSET0]
+	ldrne	r0, [r8, #SCU_OFFSET1]
+	mov	r1, #0x00
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+	b	skip_scu_gp_set
+scu_gp_set:
+	mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
+	ands	r0, r0, #0x0f
+	ldreq	r1, [r8, #SCU_OFFSET0]
+	ldrne	r1, [r8, #SCU_OFFSET1]
+	bl	omap4_get_scu_base
+	bl	scu_power_mode
+skip_scu_gp_set:
+	mrc	p15, 0, r0, c1, c1, 2		@ Read NSACR data
+	tst	r0, #(1 << 18)
+	mrcne	p15, 0, r0, c1, c0, 1
+	bicne	r0, r0, #(1 << 6)		@ Disable SMP bit
+	mcrne	p15, 0, r0, c1, c0, 1
+	isb
+	dsb
+
+do_WFI:
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
+
+	/*
+	 * Ensure the CPU power state is set to NORMAL in
+	 * SCU power state so that CPU is back in coherency.
+	 * In non-coherent mode CPU can lock-up and lead to
+	 * system deadlock.
+	 */
+	mrc	p15, 0, r0, c1, c0, 1
+	tst	r0, #(1 << 6)			@ Check SMP bit enabled?
+	orreq	r0, r0, #(1 << 6)
+	mcreq	p15, 0, r0, c1, c0, 1
+	isb
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	ldr	r9, [r8, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Check for HS device
+	bne	scu_gp_clear
+	mov	r0, #SCU_PM_NORMAL
+	mov	r1, #0x00
+	stmfd   r13!, {r4-r12, r14}
+	ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
+	DO_SMC
+	ldmfd   r13!, {r4-r12, r14}
+	b	skip_scu_gp_clear
+scu_gp_clear:
+	bl	omap4_get_scu_base
+	mov	r1, #SCU_PM_NORMAL
+	bl	scu_power_mode
+skip_scu_gp_clear:
+	isb
+	dsb
+	ldmfd	sp!, {pc}
+ENDPROC(omap4_finish_suspend)
+
+/*
+ * ============================
+ * == CPU resume entry point ==
+ * ============================
+ *
+ * void omap4_cpu_resume(void)
+ *
+ * ROM code jumps to this function while waking up from CPU
+ * OFF or DORMANT state. Physical address of the function is
+ * stored in the SAR RAM while entering to OFF or DORMANT mode.
+ */
+ENTRY(omap4_cpu_resume)
+	/*
+	 * Configure ACTRL and enable NS SMP bit access on CPU1 on HS device.
+	 * OMAP44XX EMU/HS devices - CPU0 SMP bit access is enabled in PPA
+	 * init and for CPU1, a secure PPA API provided. CPU0 must be ON
+	 * while executing NS_SMP API on CPU1 and PPA version must be 1.4.0+.
+	 * OMAP443X GP devices- SMP bit isn't accessible.
+	 * OMAP446X GP devices - SMP bit access is enabled on both CPUs.
+	 */
+	ldr	r8, =OMAP44XX_SAR_RAM_BASE
+	ldr	r9, [r8, #OMAP_TYPE_OFFSET]
+	cmp	r9, #0x1			@ Skip if GP device
+	bne	skip_ns_smp_enable
+	mrc     p15, 0, r0, c0, c0, 5
+	ands    r0, r0, #0x0f
+	beq	skip_ns_smp_enable
+ppa_actrl_retry:
+	mov     r0, #OMAP4_PPA_CPU_ACTRL_SMP_INDEX
+	adr	r3, ppa_zero_params		@ Pointer to parameters
+	mov	r1, #0x0			@ Process ID
+	mov	r2, #0x4			@ Flag
+	mov	r6, #0xff
+	mov	r12, #0x00			@ Secure Service ID
+	DO_SMC
+	cmp	r0, #0x0			@ API returns 0 on success.
+	beq	enable_smp_bit
+	b	ppa_actrl_retry
+enable_smp_bit:
+	mrc	p15, 0, r0, c1, c0, 1
+	tst	r0, #(1 << 6)			@ Check SMP bit enabled?
+	orreq	r0, r0, #(1 << 6)
+	mcreq	p15, 0, r0, c1, c0, 1
+	isb
+skip_ns_smp_enable:
+
+	b	cpu_resume			@ Jump to generic resume
+ENDPROC(omap4_cpu_resume)
+#endif
 
 ENTRY(omap_bus_sync)
 	stmfd	sp!, {lr}
-- 
1.7.4.1


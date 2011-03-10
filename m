From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 05/19] OMAP4: PM: Add CPUX OFF mode support
Date: Thu, 10 Mar 2011 19:38:01 +0530
Message-ID: <1299766095-23879-6-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab1CJOIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:34 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
retention (CSWR) is not supported by hardware design.

The CPUx OFF mode isn't supported on OMAP4430 ES1.0

CPUx sleep code is common for hotplug, suspend and CPUilde.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Makefile                    |    4 +-
 arch/arm/mach-omap2/include/mach/omap4-common.h |   46 +++
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c      |  240 ++++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h          |   11 +
 arch/arm/mach-omap2/pm44xx.c                    |    6 +
 arch/arm/mach-omap2/sleep44xx.S                 |  335 +++++++++++++++++++++++
 6 files changed, 641 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-mpuss-lowpower.c
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1bf9cd2..04b97bb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -63,13 +63,15 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
 					   cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o \
+					   omap4-mpuss-lowpower.o sleep44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
+AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 284180c..a6ce905 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -13,6 +13,9 @@
 #ifndef OMAP_ARCH_OMAP4_COMMON_H
 #define OMAP_ARCH_OMAP4_COMMON_H
 
+#include <asm/proc-fns.h>
+
+#ifndef __ASSEMBLER__
 /*
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
@@ -43,4 +46,47 @@ extern void __iomem *omap4_get_sar_ram_base(void);
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
+/*
+ * Read MPIDR: Multiprocessor affinity register
+ */
+static inline unsigned int hard_smp_processor_id(void)
+{
+	unsigned int cpunum;
+
+	asm volatile (
+	"mrc	 p15, 0, %0, c0, c0, 5\n"
+		: "=r" (cpunum));
+	return cpunum &= 0x0f;
+}
+
+#if defined(CONFIG_SMP)	&& defined(CONFIG_PM)
+extern int omap4_mpuss_init(void);
+extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
+extern void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state);
+extern void omap4_cpu_resume(void);
+
+#else
+
+static inline int omap4_enter_lowpower(unsigned int cpu,
+					unsigned int power_state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static inline int omap4_mpuss_init(void)
+{
+	return 0;
+}
+
+static inline void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state)
+{
+}
+
+static inline void omap4_cpu_resume(void)
+{
+}
+
 #endif
+#endif /* __ASSEMBLER__ */
+#endif /* OMAP_ARCH_OMAP4_COMMON_H */
diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
new file mode 100644
index 0000000..21c5ad3
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -0,0 +1,240 @@
+/*
+ * OMAP4 MPUSS low power code
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
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
+};
+
+static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
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
+/*
+ * OMAP4 MPUSS Low Power Entry Function
+ *
+ * The purpose of this function is to manage low power programming
+ * of OMAP4 MPUSS subsystem
+ * Paramenters:
+ *	cpu : CPU ID
+ *	power_state: Targetted Low power state.
+ */
+int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
+{
+	unsigned int save_state = 0;
+	unsigned int wakeup_cpu = hard_smp_processor_id();
+
+	if ((cpu >= NR_CPUS) || (omap_rev() == OMAP4430_REV_ES1_0))
+		goto ret;
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
+		goto ret;
+	}
+
+	clear_cpu_prev_pwrst(cpu);
+	set_cpu_next_pwrst(cpu, power_state);
+	scu_pwrst_prepare(cpu, power_state);
+
+	/*
+	 * Call low level function  with targeted CPU id
+	 * and its low power state.
+	 */
+	omap4_cpu_suspend(cpu, save_state);
+
+	/*
+	 * Restore the CPUx power state to ON otherwise CPUx
+	 * power domain can transitions to programmed low power
+	 * state while doing WFI outside the low powe code. On
+	 * secure devices, CPUx does WFI which can result in
+	 * domain transition
+	 */
+	wakeup_cpu = hard_smp_processor_id();
+	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
+
+ret:
+	return 0;
+}
+
+/*
+ * Initialise OMAP4 MPUSS
+ */
+int __init omap4_mpuss_init(void)
+{
+	struct omap4_cpu_pm_info *pm_info;
+	void __iomem *sar_ram_base = omap4_get_sar_ram_base();
+
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
+	/* Initilaise per CPU PM information */
+	pm_info = &per_cpu(omap4_pm_info, 0x0);
+	pm_info->scu_sar_addr = sar_ram_base + SCU_OFFSET0;
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
+	pm_info->scu_sar_addr = sar_ram_base + SCU_OFFSET1;
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
+	/*
+	 * Program the wakeup routine address for the CPU0 and CPU1
+	 * used for OFF or DORMANT wakeup. Wakeup routine address
+	 * is fixed so programit in init itself.
+	 */
+	__raw_writel(virt_to_phys(omap4_cpu_resume),
+			sar_ram_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+	__raw_writel(virt_to_phys(omap4_cpu_resume),
+			sar_ram_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET);
+
+	return 0;
+}
+
+#endif
+
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 1cfb4dd..8b71b1e 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -19,4 +19,15 @@
 #define SAR_BANK3_OFFSET		0x2000
 #define SAR_BANK4_OFFSET		0x3000
 
+/* Scratch pad memory offsets from SAR_BANK1 */
+#define CPU0_SAVE_OFFSET			0xb00
+#define CPU1_SAVE_OFFSET			0xc00
+#define MMU_OFFSET				0xd00
+#define SCU_OFFSET0				0xd20
+#define SCU_OFFSET1				0xd24
+
+/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
+#define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
+#define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
+
 #endif
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 76cfff2..7502723 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -111,6 +111,12 @@ static int __init omap4_pm_init(void)
 		pr_err("Failed to setup powerdomains\n");
 		goto err2;
 	}
+
+	ret = omap4_mpuss_init();
+	if (ret) {
+		pr_err("Failed to initialise OMAP4 MPUSS\n");
+		goto err2;
+	}
 #endif
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
new file mode 100644
index 0000000..1d166ef
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -0,0 +1,335 @@
+/*
+ * OMAP44xx CPU low power powerdown and powerup code.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/system.h>
+#include <asm/smp_scu.h>
+#include <asm/memory.h>
+
+#include <plat/omap44xx.h>
+#include <mach/omap4-common.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include "omap4-sar-layout.h"
+
+#ifdef CONFIG_SMP
+
+/* Masks used for MMU manipulation */
+#define TTRBIT_MASK				0xffffc000
+#define TABLE_INDEX_MASK			0xfff00000
+#define TABLE_ENTRY				0x00000c02
+#define CACHE_DISABLE_MASK			0xffffe7fb
+#define TABLE_ADDRESS_OFFSET			0x04
+#define CR_VALUE_OFFSET				0x08
+
+/*
+ * =============================
+ * == CPU suspend entry point ==
+ * =============================
+ *
+ * void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state)
+ *
+ * This function code saves the CPU context and performs the CPU
+ * power down sequence. Calling WFI effectively changes the CPU
+ * power domains states to the desired target power state.
+ *
+ * @cpu : contains cpu id (r0)
+ * @save_state : contains context save state (r1)
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
+
+ENTRY(omap4_cpu_suspend)
+	stmfd	sp!, {r0-r12, lr}		@ Save registers on stack
+	cmp	r1, #0x0
+	beq	do_WFI				@ Nothing to save, jump to WFI
+	mov	r5, r0
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	ands	r5, r5, #0x0f
+	orreq	r8, r8, #CPU0_SAVE_OFFSET
+	orrne	r8, r8, #CPU1_SAVE_OFFSET
+
+	/*
+	 * Save only needed CPU CP15 registers. VFP, breakpoint,
+	 * performance monitor registers are not saved. Generic
+	 * code suppose to take care of those.
+	 */
+	mov	r4, sp				@ Store sp
+	mrs	r5, spsr			@ Store spsr
+	mov	r6, lr				@ Store lr
+	stmia	r8!, {r4-r6}
+
+	/* c1 and c2 registers */
+	mrc	p15, 0, r4, c1, c0, 2		@ CPACR
+	mrc	p15, 0, r5, c2, c0, 0		@ TTBR0
+	mrc	p15, 0, r6, c2, c0, 1		@ TTBR1
+	mrc	p15, 0, r7, c2, c0, 2		@ TTBCR
+	stmia	r8!, {r4-r7}
+
+	/* c3 and c10 registers */
+	mrc	p15, 0, r4, c3, c0, 0		@ DACR
+	mrc	p15, 0, r5, c10, c2, 0		@ PRRR
+	mrc	p15, 0, r6, c10, c2, 1		@ NMRR
+	stmia	r8!,{r4-r6}
+
+	/* c12, c13 and CPSR registers */
+	mrc	p15, 0, r4, c13, c0, 1		@ Context ID
+	mrc	p15, 0, r5, c13, c0, 2		@ User r/w thread ID
+	mrc	p15, 0, r6, c12, c0, 0		@ Secure or NS VBAR
+	mrs	r7, cpsr			@ Store CPSR
+	stmia	r8!, {r4-r7}
+
+	/* c1 control register */
+	mrc	p15, 0, r4, c1, c0, 0		@ Save control register
+	stmia	r8!, {r4}
+
+	/*
+	 * Flush all data from the L1 data cache before disabling
+	 * SCTLR.C bit.
+	 */
+	bl	v7_flush_dcache_all
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
+	mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
+	ands	r0, r0, #0x0f
+	ldreq	r1, [r8, #SCU_OFFSET0]
+	ldrne	r1, [r8, #SCU_OFFSET1]
+	bl	omap4_get_scu_base
+	bl     scu_power_mode
+
+do_WFI:
+	/*
+	 * Execute an ISB instruction to ensure that all of the
+	 * CP15 register changes have been committed.
+	 */
+	isb
+
+	/*
+	 * Execute a barrier instruction to ensure that all cache,
+	 * TLB and branch predictor maintenance operations issued
+	 * by any CPU in the cluster have completed.
+	 */
+	dsb
+	dmb
+
+	/*
+	 * Execute a WFI instruction and wait until the
+	 * STANDBYWFI output is asserted to indicate that the
+	 * CPU is in idle and low power state.
+	 */
+	wfi					@ Wait For Interrupt
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
+	bl	omap4_get_scu_base
+	mov	r1, #SCU_PM_NORMAL
+	bl     scu_power_mode
+	isb
+	dsb
+
+	ldmfd	sp!, {r0-r12, pc}		@ Restore regs and return
+ENDPROC(omap4_cpu_suspend)
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
+
+ENTRY(omap4_cpu_resume)
+	/*
+	 * Check the wakeup cpuid and use appropriate
+	 * SAR BANK location for context restore.
+	 */
+	ldr	r3, =OMAP44XX_SAR_RAM_BASE
+	mov	r1, #0
+	mcr	p15, 0, r1, c7, c5, 0		@ Invalidate L1 I
+	mrc	p15, 0, r0, c0, c0, 5		@ MPIDR
+	ands	r0, r0, #0x0f
+	orreq	r3, r3, #CPU0_SAVE_OFFSET
+	orrne	r3, r3, #CPU1_SAVE_OFFSET
+
+	/* Restore cp15 registers */
+	ldmia	r3!, {r4-r6}
+	mov	sp, r4				@ Restore sp
+	msr	spsr_cxsf, r5			@ Restore spsr
+	mov	lr, r6				@ Restore lr
+
+	/* c1 and c2 registers */
+	ldmia	r3!, {r4-r7}
+	mcr	p15, 0, r4, c1, c0, 2		@ CPACR
+	mcr	p15, 0, r5, c2, c0, 0		@ TTBR0
+	mcr	p15, 0, r6, c2, c0, 1		@ TTBR1
+	mcr	p15, 0, r7, c2, c0, 2		@ TTBCR
+
+	/* c3 and c10 registers */
+	ldmia	r3!,{r4-r6}
+	mcr	p15, 0, r4, c3, c0, 0		@ DACR
+	mcr	p15, 0, r5, c10, c2, 0		@ PRRR
+	mcr	p15, 0, r6, c10, c2, 1		@ NMRR
+
+	/* c12, c13 and CPSR registers */
+	ldmia	r3!,{r4-r7}
+	mcr	p15, 0, r4, c13, c0, 1		@ Context ID
+	mcr	p15, 0, r5, c13, c0, 2		@ User r/w thread ID
+	mrc	p15, 0, r6, c12, c0, 0		@ Secure or NS VBAR
+	msr	cpsr, r7			@ store cpsr
+
+	/*
+	 * Enabling MMU here. Page entry needs to be altered
+	 * to create temporary 1:1 map and then resore the entry
+	 * ones MMU is enabled
+	 */
+	mrc	p15, 0, r7, c2, c0, 2		@ Read TTBRControl
+	and	r7, #0x7			@ Extract N (0:2) to decide
+	cmp	r7, #0x0			@ TTBR0/TTBR1
+	beq	use_ttbr0
+ttbr_error:
+	b	ttbr_error			@ Only N = 0 supported
+use_ttbr0:
+	mrc	p15, 0, r2, c2, c0, 0		@ Read TTBR0
+	ldr	r5, =TTRBIT_MASK
+	and	r2, r5
+	mov	r4, pc
+	ldr	r5, =TABLE_INDEX_MASK
+	and	r4, r5				@ r4 = 31 to 20 bits of pc
+	ldr	r1, =TABLE_ENTRY
+	add	r1, r1, r4			@ r1 has value of table entry
+	lsr	r4, #18				@ Address of table entry
+	add	r2, r4				@ r2 - location to be modified
+
+	/* Ensure the modified entry makes it to main memory */
+#ifdef CONFIG_CACHE_L2X0
+	ldr	r5, =OMAP44XX_L2CACHE_BASE
+	str	r2, [r5, #L2X0_CLEAN_INV_LINE_PA]
+wait_l2:
+	ldr	r0, [r5, #L2X0_CLEAN_INV_LINE_PA]
+	ands	r0, #1
+	bne	wait_l2
+#endif
+
+	/* Storing previous entry of location being modified */
+	ldr     r5, =OMAP44XX_SAR_RAM_BASE
+	ldr	r4, [r2]
+	str	r4, [r5, #MMU_OFFSET]		@ Modify the table entry
+	str	r1, [r2]
+
+	/*
+	 * Storing address of entry being modified
+	 * It will be restored after enabling MMU
+	 */
+	ldr     r5, =OMAP44XX_SAR_RAM_BASE
+	orr	r5, r5, #MMU_OFFSET
+	str	r2, [r5, #TABLE_ADDRESS_OFFSET]
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 4		@ Flush prefetch buffer
+	mcr	p15, 0, r0, c7, c5, 6		@ Invalidate BTB
+	mcr	p15, 0, r0, c8, c5, 0		@ Invalidate ITLB
+	mcr	p15, 0, r0, c8, c6, 0		@ Invalidate DTLB
+
+	/*
+	 * Restore control register  but don't enable Data caches here.
+	 * Caches will be enabled after restoring MMU table entry.
+	 */
+	ldmia	r3!, {r4}
+	str	r4, [r5, #CR_VALUE_OFFSET]	@ Store previous value of CR
+	ldr	r2, =CACHE_DISABLE_MASK
+	and	r4, r2
+	mcr	p15, 0, r4, c1, c0, 0
+	isb
+	dsb
+	ldr	r0, =mmu_on_label
+	bx	r0
+mmu_on_label:
+	/* Set up the per-CPU stacks */
+	bl	cpu_init
+
+	/*
+	 * Restore the MMU table entry that was modified for
+	 * enabling MMU.
+	 */
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	orr	r8, r8, #MMU_OFFSET		@ Get address of entry that..
+	ldr	r2, [r8, #TABLE_ADDRESS_OFFSET]	@ was modified
+	ldr	r3, =local_va2pa_offet
+	add	r2, r2, r3
+	ldr	r0, [r8]			@ Get the previous value..
+	str	r0, [r2]			@ which needs to be restored
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c1, 6		@ flush TLB and issue barriers
+	dsb
+	isb
+	ldr	r0, [r8, #CR_VALUE_OFFSET]	@ Restore the Control register
+	mcr     p15, 0, r0, c1, c0, 0		@ with caches enabled.
+	isb
+
+	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+
+	.equ	local_va2pa_offet, (PHYS_OFFSET + PAGE_OFFSET)
+
+ENDPROC(omap4_cpu_resume)
+
+#endif
-- 
1.6.0.4


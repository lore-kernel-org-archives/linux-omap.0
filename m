From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
Date: Sun, 4 Sep 2011 19:24:21 +0530
Message-ID: <1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab1IDN4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:16 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
necessary maintenance operations and context restoration in the
low power code.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-secure.h |    5 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c      |   38 +++++++++-
 arch/arm/mach-omap2/omap4-sar-layout.h         |    4 +
 arch/arm/mach-omap2/sleep44xx.S                |   96 ++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
index 0062d49..6e929c5 100644
--- a/arch/arm/mach-omap2/include/mach/omap-secure.h
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -37,8 +37,13 @@
 
 /* Secure Monitor mode APIs */
 #define OMAP4_MON_SCU_PWR_INDEX		0x108
+#define OMAP4_MON_L2X0_DBG_CTRL_INDEX	0x100
+#define OMAP4_MON_L2X0_CTRL_INDEX	0x102
+#define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
+#define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 
 /* Secure PPA(Primary Protected Application) APIs */
+#define OMAP4_PPA_L2_POR_INDEX		0x23
 #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 9f632fe..aea6deb 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -49,6 +49,7 @@
 #include <asm/system.h>
 #include <asm/pgalloc.h>
 #include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
@@ -63,10 +64,12 @@ struct omap4_cpu_pm_info {
 	struct powerdomain *pwrdm;
 	void __iomem *scu_sar_addr;
 	void __iomem *wkup_sar_addr;
+	void __iomem *l2x0_sar_addr;
 };
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
+static void __iomem *sar_base;
 
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
@@ -135,6 +138,33 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
 }
 
+/*
+ * Store the CPU cluster state for L2X0 low power operations.
+ */
+static void l2x0_pwrst_prepare(unsigned int cpu_id, unsigned int save_state)
+{
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
+
+	__raw_writel(save_state, pm_info->l2x0_sar_addr);
+}
+
+/*
+ * Save the L2X0 AUXCTRL and POR value to SAR memory. Its used to
+ * in every restore MPUSS OFF path.
+ */
+static void save_l2x0_context(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	u32 val;
+	void __iomem *l2x0_base = omap4_get_l2cache_base();
+
+	val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
+	__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
+	val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
+	__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
+#endif
+}
+
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -182,6 +212,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
 	scu_pwrst_prepare(cpu, power_state);
+	l2x0_pwrst_prepare(cpu, save_state);
 
 	/*
 	 * Call low level function  with targeted CPU id
@@ -241,17 +272,19 @@ int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 int __init omap4_mpuss_init(void)
 {
 	struct omap4_cpu_pm_info *pm_info;
-	void __iomem *sar_base = omap4_get_sar_ram_base();
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
 		return -ENODEV;
 	}
 
+	sar_base = omap4_get_sar_ram_base();
+
 	/* Initilaise per CPU PM information */
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
 	pm_info->wkup_sar_addr = sar_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET0;
 	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
 	if (!pm_info->pwrdm) {
 		pr_err("Lookup failed for CPU0 pwrdm\n");
@@ -267,6 +300,7 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
 	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
 	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
 	if (!pm_info->pwrdm) {
 		pr_err("Lookup failed for CPU1 pwrdm\n");
@@ -292,6 +326,8 @@ int __init omap4_mpuss_init(void)
 	else
 		__raw_writel(0, sar_base + OMAP_TYPE_OFFSET);
 
+	save_l2x0_context();
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index aa14a8d..fe5b545 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -23,6 +23,10 @@
 #define SCU_OFFSET0				0xd00
 #define SCU_OFFSET1				0xd04
 #define OMAP_TYPE_OFFSET			0xd10
+#define L2X0_SAVE_OFFSET0			0xd14
+#define L2X0_SAVE_OFFSET1			0xd18
+#define L2X0_AUXCTRL_OFFSET			0xd1c
+#define L2X0_PREFETCH_CTRL_OFFSET		0xd20
 
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 230ab8c..a7cce0b 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -32,6 +32,9 @@
 ppa_zero_params:
 	.word		0x0
 
+ppa_por_params:
+	.word		1, 0
+
 /*
  * =============================
  * == CPU suspend finisher ==
@@ -130,6 +133,55 @@ skip_scu_gp_set:
 	mcrne	p15, 0, r0, c1, c0, 1
 	isb
 	dsb
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * Clean and invalidate the L2 cache.
+	 * Common cache-l2x0.c functions can't be used here since it
+	 * uses spinlocks. We are out of coherency here with data cache
+	 * disabled. The spinlock implementation uses exclusive load/store
+	 * instruction which can fail without data cache being enabled.
+	 * OMAP4 hardware doesn't support exclusive monitor which can
+	 * overcome exclusive access issue. Because of this, CPU can
+	 * lead to deadlock.
+	 */
+l2x_clean_inv:
+	bl	omap4_get_sar_ram_base
+	mov	r8, r0
+	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
+	ands	r5, r5, #0x0f
+	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]
+	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
+	cmp	r0, #3
+	bne	do_WFI
+#ifdef CONFIG_PL310_ERRATA_727915
+	mov	r0, #0x03
+	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
+	DO_SMC
+#endif
+	bl	omap4_get_l2cache_base
+	mov	r2, r0
+	ldr	r0, =0xffff
+	str	r0, [r2, #L2X0_CLEAN_INV_WAY]
+wait:
+	ldr	r0, [r2, #L2X0_CLEAN_INV_WAY]
+	ldr	r1, =0xffff
+	ands	r0, r0, r1
+	bne	wait
+#ifdef CONFIG_PL310_ERRATA_727915
+	mov	r0, #0x00
+	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
+	DO_SMC
+#endif
+l2x_sync:
+	bl	omap4_get_l2cache_base
+	mov	r2, r0
+	mov	r0, #0x0
+	str	r0, [r2, #L2X0_CACHE_SYNC]
+sync:
+	ldr	r0, [r2, #L2X0_CACHE_SYNC]
+	ands	r0, r0, #0x1
+	bne	sync
+#endif
 
 do_WFI:
 	bl	omap_do_wfi
@@ -222,6 +274,50 @@ enable_smp_bit:
 	mcreq	p15, 0, r0, c1, c0, 1
 	isb
 skip_ns_smp_enable:
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * Restore the L2 AUXCTRL and enable the L2 cache.
+	 * OMAP4_MON_L2X0_AUXCTRL_INDEX =  Program the L2X0 AUXCTRL
+	 * OMAP4_MON_L2X0_CTRL_INDEX =  Enable the L2 using L2X0 CTRL
+	 * register r0 contains value to be programmed.
+	 * L2 cache is already invalidate by ROM code as part
+	 * of MPUSS OFF wakeup path.
+	 */
+	ldr	r2, =OMAP44XX_L2CACHE_BASE
+	ldr	r0, [r2, #L2X0_CTRL]
+	and	r0, #0x0f
+	cmp	r0, #1
+	beq	skip_l2en			@ Skip if already enabled
+	ldr	r3, =OMAP44XX_SAR_RAM_BASE
+	ldr	r1, [r3, #OMAP_TYPE_OFFSET]
+	cmp	r1, #0x1			@ Check for HS device
+	bne     set_gp_por
+	ldr     r0, =OMAP4_PPA_L2_POR_INDEX
+	ldr     r1, =OMAP44XX_SAR_RAM_BASE
+	ldr     r4, [r1, #L2X0_PREFETCH_CTRL_OFFSET]
+	adr     r3, ppa_por_params
+	str     r4, [r3, #0x04]
+	mov	r1, #0x0			@ Process ID
+	mov	r2, #0x4			@ Flag
+	mov	r6, #0xff
+	mov	r12, #0x00			@ Secure Service ID
+	DO_SMC
+	b	set_aux_ctrl
+set_gp_por:
+	ldr     r1, =OMAP44XX_SAR_RAM_BASE
+	ldr     r0, [r1, #L2X0_PREFETCH_CTRL_OFFSET]
+	ldr	r12, =OMAP4_MON_L2X0_PREFETCH_INDEX	@ Setup L2 PREFETCH
+	DO_SMC
+set_aux_ctrl:
+	ldr     r1, =OMAP44XX_SAR_RAM_BASE
+	ldr	r0, [r1, #L2X0_AUXCTRL_OFFSET]
+	ldr	r12, =OMAP4_MON_L2X0_AUXCTRL_INDEX	@ Setup L2 AUXCTRL
+	DO_SMC
+	mov	r0, #0x1
+	ldr	r12, =OMAP4_MON_L2X0_CTRL_INDEX		@ Enable L2 cache
+	DO_SMC
+skip_l2en:
+#endif
 
 	b	cpu_resume			@ Jump to generic resume
 ENDPROC(omap4_cpu_resume)
-- 
1.7.4.1


From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 3/8] ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic control register change
Date: Fri, 20 Apr 2012 12:19:46 +0300
Message-ID: <1334913591-26312-4-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50503 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab2DTJUO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:14 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

GIC distributor control register has changed between CortexA9 r1pX and
r2pX. The Control Register secure banked version is now composed of 2
bits:
     bit 0 == Secure Enable
     bit 1 == Non-Secure Enable
The Non-Secure banked register has not changed. Since the ROM Code is
based on the r1pX GIC, the CPU1 GIC restoration will cause a problem
to CPU0 Non-Secure SW.
The workaround must be:
     1) Before doing the CPU1 wakeup, CPU0 must disable
        the GIC distributor
     2) CPU1 must re-enable the GIC distributor on
        it's wakeup path.

With this procedure, the GIC configuration done between the
CPU0 wakeup and CPU1 wakeup will not be lost but during this
short windows, the CPU0 will not receive interrupts

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h              |    2 +
 arch/arm/mach-omap2/omap-headsmp.S        |   36 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    9 ++++++-
 arch/arm/mach-omap2/omap-smp.c            |   28 +++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-common.c        |    8 +++++-
 5 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..48d1ebe 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -199,6 +199,7 @@ static inline void __iomem *omap4_get_scu_base(void)
 #endif
 
 extern void __init gic_init_irq(void);
+extern void gic_dist_disable(void);
 extern void omap_smc1(u32 fn, u32 arg);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap_do_wfi(void);
@@ -206,6 +207,7 @@ extern void omap_do_wfi(void);
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
+extern void omap_secondary_startup_4460(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 503ac77..d602555 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -43,3 +43,39 @@ hold:	ldr	r12,=0x103
 	b	secondary_startup
 ENDPROC(omap_secondary_startup)
 
+ENTRY(omap_secondary_startup_4460)
+hold_2:	ldr	r12,=0x103
+	dsb
+	smc	#0			@ read from AuxCoreBoot0
+	mov	r0, r0, lsr #9
+	mrc	p15, 0, r4, c0, c0, 5
+	and	r4, r4, #0x0f
+	cmp	r0, r4
+	bne	hold_2
+
+	/*
+	 * GIC distributor control register has changed between
+	 * CortexA9 r1pX and r2pX. The Control Register secure
+	 * banked version is now composed of 2 bits:
+	 * bit 0 == Secure Enable
+	 * bit 1 == Non-Secure Enable
+	 * The Non-Secure banked register has not changed
+	 * Because the ROM Code is based on the r1pX GIC, the CPU1
+	 * GIC restoration will cause a problem to CPU0 Non-Secure SW.
+	 * The workaround must be:
+	 * 1) Before doing the CPU1 wakeup, CPU0 must disable
+	 * the GIC distributor
+	 * 2) CPU1 must re-enable the GIC distributor on
+	 * it's wakeup path.
+	 */
+	ldr	r1, =0x48241000
+	ldr	r0, [r1]
+	orr	r0, #1
+	str	r0, [r1]
+
+	/*
+	 * we've been released from the wait loop,secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+ENDPROC(omap_secondary_startup_4460)
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..e02c082 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -68,6 +68,7 @@ struct omap4_cpu_pm_info {
 	void __iomem *scu_sar_addr;
 	void __iomem *wkup_sar_addr;
 	void __iomem *l2x0_sar_addr;
+	void (*secondary_startup)(void);
 };
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
@@ -300,6 +301,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int cpu_state = 0;
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
@@ -309,7 +311,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 
 	clear_cpu_prev_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
-	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_secondary_startup));
+	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
 	scu_pwrst_prepare(cpu, power_state);
 
 	/*
@@ -360,6 +362,11 @@ int __init omap4_mpuss_init(void)
 	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
 	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
+	if (cpu_is_omap446x())
+		pm_info->secondary_startup = omap_secondary_startup_4460;
+	else
+		pm_info->secondary_startup = omap_secondary_startup;
+
 	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
 	if (!pm_info->pwrdm) {
 		pr_err("Lookup failed for CPU1 pwrdm\n");
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index deffbf1..c3eb9e8 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -33,6 +33,7 @@
 
 /* SCU base address */
 static void __iomem *scu_base;
+bool omap4_smp_romcode_errata;
 
 static DEFINE_SPINLOCK(boot_lock);
 
@@ -104,6 +105,24 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 *	4.3.4.2 Power States of CPU0 and CPU1
 	 */
 	if (booted) {
+		/*
+		 * GIC distributor control register has changed between
+		 * CortexA9 r1pX and r2pX. The Control Register secure
+		 * banked version is now composed of 2 bits:
+		 * bit 0 == Secure Enable
+		 * bit 1 == Non-Secure Enable
+		 * The Non-Secure banked register has not changed
+		 * Because the ROM Code is based on the r1pX GIC, the CPU1
+		 * GIC restoration will cause a problem to CPU0 Non-Secure SW.
+		 * The workaround must be:
+		 * 1) Before doing the CPU1 wakeup, CPU0 must disable
+		 * the GIC distributor
+		 * 2) CPU1 must re-enable the GIC distributor on
+		 * it's wakeup path.
+		 */
+		if (omap4_smp_romcode_errata)
+			gic_dist_disable();
+
 		clkdm_wakeup(cpu1_clkdm);
 		clkdm_allow_idle(cpu1_clkdm);
 	} else {
@@ -124,13 +143,20 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init wakeup_secondary(void)
 {
+	void *startup_addr = omap_secondary_startup;
+
 	/*
 	 * Write the address of secondary startup routine into the
 	 * AuxCoreBoot1 where ROM code will jump and start executing
 	 * on secondary core once out of WFE
 	 * A barrier is added to ensure that write buffer is drained
 	 */
-	omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
+	if (cpu_is_omap446x()) {
+		startup_addr = omap_secondary_startup_4460;
+		omap4_smp_romcode_errata = true;
+	}
+
+	omap_auxcoreboot_addr(virt_to_phys(startup_addr));
 	smp_wmb();
 
 	/*
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 70de277..cc6a915 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -38,6 +38,7 @@ static void __iomem *l2cache_base;
 #endif
 
 static void __iomem *sar_ram_base;
+static void __iomem *gic_dist_base_addr;
 
 #ifdef CONFIG_OMAP4_ERRATA_I688
 /* Used to implement memory barrier on DRAM path */
@@ -92,7 +93,6 @@ void __init omap_barriers_init(void)
 void __init gic_init_irq(void)
 {
 	void __iomem *omap_irq_base;
-	void __iomem *gic_dist_base_addr;
 
 	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
@@ -107,6 +107,12 @@ void __init gic_init_irq(void)
 	gic_init(0, 29, gic_dist_base_addr, omap_irq_base);
 }
 
+void gic_dist_disable(void)
+{
+	if (gic_dist_base_addr)
+		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
+}
+
 #ifdef CONFIG_CACHE_L2X0
 
 void __iomem *omap4_get_l2cache_base(void)
-- 
1.7.4.1


From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Fri, 17 Feb 2017 07:55:02 -0800
Message-ID: <20170217155502.GD21809@atomide.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com>
 <20170215183915.GU3897@atomide.com>
 <20170215191242.GP21809@atomide.com>
 <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
 <20170215222711.GQ21809@atomide.com>
 <20170216161010.GU21809@atomide.com>
 <fc1e75e8-87ef-59f1-3c8a-cb45f1749e50@ti.com>
 <20170216165409.GW21809@atomide.com>
 <20170216190701.GY21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170216190701.GY21809@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170216 11:08]:
> * Tony Lindgren <tony@atomide.com> [170216 08:55]:
> > For your use case, probably all we need is runtime checks for HS in
> > addition to parking cpu1 for kexec. If that's not enough, then maybe
> > a device specific DT property for never-reset-no-matter-what.
> 
> Below is a first take on the last resort cpu1 reset done based on
> configured CPU1_WAKEUP_NS_PA_ADDR_OFFSET for omap4 and 5. Note that
> we can't merge it yet as it will break kexec boot for dra7. To fix that,
> we need to first do what you're suggesting and properly park cpu1 for
> kexec.

Something like the patch below might be doable for the first fix
before we have something to park cpu1 for kexec. I've added more checks
to attemp to detect cpu1 being in WFI. At least things keep on working
for kexec on omap4/5 and GP dra7.

Andrew, care to give it a try and see if can add some HS dra7 checks
there too to have kexec work on it? Basically we want to attempt to
detect if there's a chance cpu1 is in WFI, and if I think the only
optino is to reset it before bringing it up as otherwise outcome will
be unpredictable.

Regards,

Tony

8< -----------------------
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -270,6 +270,7 @@ extern const struct smp_operations omap4_smp_ops;
 extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
+extern u32 omap4_get_cpu1_ns_pa_addr(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -64,6 +64,7 @@
 #include "prm-regbits-44xx.h"
 
 static void __iomem *sar_base;
+static u32 old_cpu1_ns_pa_addr;
 
 #if defined(CONFIG_PM) && defined(CONFIG_SMP)
 
@@ -212,6 +213,11 @@ static void __init save_l2x0_context(void)
 {}
 #endif
 
+u32 omap4_get_cpu1_ns_pa_addr(void)
+{
+	return old_cpu1_ns_pa_addr;
+}
+
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -371,7 +377,7 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
-		if (cpu_is_omap44xx())
+		if (soc_is_omap44xx())
 			pm_info->wkup_sar_addr = sar_base +
 				CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
 		else
@@ -395,7 +401,7 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
-		if (cpu_is_omap44xx())
+		if (soc_is_omap44xx())
 			pm_info->wkup_sar_addr = sar_base +
 				CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 		else
@@ -432,7 +438,7 @@ int __init omap4_mpuss_init(void)
 		save_l2x0_context();
 	}
 
-	if (cpu_is_omap44xx()) {
+	if (soc_is_omap44xx()) {
 		omap_pm_ops.finish_suspend = omap4_finish_suspend;
 		omap_pm_ops.resume = omap4_cpu_resume;
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
@@ -443,7 +449,7 @@ int __init omap4_mpuss_init(void)
 		enable_mercury_retention_mode();
 	}
 
-	if (cpu_is_omap446x())
+	if (soc_is_omap446x())
 		omap_pm_ops.hotplug_restart = omap4460_secondary_startup;
 
 	return 0;
@@ -460,22 +466,30 @@ int __init omap4_mpuss_init(void)
 void __init omap4_mpuss_early_init(void)
 {
 	unsigned long startup_pa;
+	void __iomem *ns_pa_addr;
 
-	if (!(cpu_is_omap44xx() || soc_is_omap54xx()))
+	if (!(soc_is_omap44xx() || soc_is_omap54xx()))
 		return;
 
 	sar_base = omap4_get_sar_ram_base();
 
-	if (cpu_is_omap443x())
+	/* Restore old NS_PA_ADDR for validity checks later on */
+	if (soc_is_omap44xx())
+		ns_pa_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+	else
+		ns_pa_addr = sar_base + OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+	old_cpu1_ns_pa_addr = readl_relaxed(ns_pa_addr);
+
+	if (soc_is_omap443x())
 		startup_pa = __pa_symbol(omap4_secondary_startup);
-	else if (cpu_is_omap446x())
+	else if (soc_is_omap446x())
 		startup_pa = __pa_symbol(omap4460_secondary_startup);
 	else if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
 		startup_pa = __pa_symbol(omap5_secondary_hyp_startup);
 	else
 		startup_pa = __pa_symbol(omap5_secondary_startup);
 
-	if (cpu_is_omap44xx())
+	if (soc_is_omap44xx())
 		writel_relaxed(startup_pa, sar_base +
 			       CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
 	else
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -44,6 +44,7 @@ struct omap_smp_config {
 	unsigned long cpu1_rstctrl_pa;
 	void __iomem *cpu1_rstctrl_va;
 	void __iomem *scu_base;
+	void __iomem *wakeupgen_base;
 	void *startup_addr;
 };
 
@@ -140,7 +141,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	static struct clockdomain *cpu1_clkdm;
 	static bool booted;
 	static struct powerdomain *cpu1_pwrdm;
-	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
 	 * Set synchronisation state between this boot processor
@@ -157,7 +157,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	if (omap_secure_apis_support())
 		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	else
-		writel_relaxed(0x20, base + OMAP_AUX_CORE_BOOT_0);
+		writel_relaxed(0x20, cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 
 	if (!cpu1_clkdm && !cpu1_pwrdm) {
 		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
@@ -261,9 +261,62 @@ static void __init omap4_smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
+/*
+ * For now, just make sure the start-up address is not within
+ * the first 1GB as that most likely means that CPU1 is configured
+ * by either the bootloader or previous kernel in kexec boot to
+ * something that will most likely fail without a reset.
+ */
+static bool __init omap4_smp_cpu1_startup_valid(unsigned long addr)
+{
+	if ((addr >> 24) == 0x80)
+		return false;
+
+	return true;
+}
+
+/*
+ * We may need to reset CPU1 before configuring, otherwise kexec can end up
+ * trying to use old kernel startup address or suspend-resume will occasionally
+ * fail to bring up CPU1 on 4430 if CPU1 fails to enter deeper idle states.
+ */
+static void __init omap4_smp_maybe_reset_cpu1(struct omap_smp_config *c)
+{
+	unsigned long cpu1_startup_pa, cpu1_ns_pa_addr;
+	bool needs_reset = false;
+
+	cpu1_startup_pa = readl_relaxed(cfg.wakeupgen_base +
+					OMAP_AUX_CORE_BOOT_1);
+	cpu1_ns_pa_addr = omap4_get_cpu1_ns_pa_addr();
+
+	/* REVISIT: Anything to check for HS dra7? */
+	if (soc_is_dra74x() && omap_secure_apis_support())
+		return;
+
+	/* If dra7 has AUX_CORE_BOOT_1 within first 1GB, CPU1 may be in WFI */
+	if (soc_is_dra74x() && !omap_secure_apis_support() &&
+	    !omap4_smp_cpu1_startup_valid(cpu1_startup_pa))
+		needs_reset = true;
+
+	/* If omap4 or 5 has NS_PA_ADDR within first 1GB, CPU1 may be in WFI */
+	if ((soc_is_omap44xx() || soc_is_omap54xx()) &&
+	    !omap4_smp_cpu1_startup_valid(cpu1_ns_pa_addr) &&
+	    c->cpu1_rstctrl_va)
+		needs_reset = true;
+
+	if (!needs_reset || !c->cpu1_rstctrl_va)
+		return;
+
+	pr_info("smp: Already configured omap cpu1, needs reset (0x%lx 0x%lx)\n",
+		cpu1_startup_pa, cpu1_ns_pa_addr);
+
+	writel_relaxed(1, c->cpu1_rstctrl_va);
+	readl_relaxed(c->cpu1_rstctrl_va);
+	writel_relaxed(0, c->cpu1_rstctrl_va);
+}
+
 static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
-	void __iomem *base = omap_get_wakeupgen_base();
 	const struct omap_smp_config *c = NULL;
 
 	if (soc_is_omap443x())
@@ -281,6 +334,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	/* Must preserve cfg.scu_base set earlier */
 	cfg.cpu1_rstctrl_pa = c->cpu1_rstctrl_pa;
 	cfg.startup_addr = c->startup_addr;
+	cfg.wakeupgen_base = omap_get_wakeupgen_base();
 
 	if (soc_is_dra74x() || soc_is_omap54xx()) {
 		if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
@@ -299,15 +353,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	if (cfg.scu_base)
 		scu_enable(cfg.scu_base);
 
-	/*
-	 * Reset CPU1 before configuring, otherwise kexec will
-	 * end up trying to use old kernel startup address.
-	 */
-	if (cfg.cpu1_rstctrl_va) {
-		writel_relaxed(1, cfg.cpu1_rstctrl_va);
-		readl_relaxed(cfg.cpu1_rstctrl_va);
-		writel_relaxed(0, cfg.cpu1_rstctrl_va);
-	}
+	omap4_smp_maybe_reset_cpu1(&cfg);
 
 	/*
 	 * Write the address of secondary startup routine into the
@@ -319,7 +365,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		omap_auxcoreboot_addr(__pa_symbol(cfg.startup_addr));
 	else
 		writel_relaxed(__pa_symbol(cfg.startup_addr),
-			       base + OMAP_AUX_CORE_BOOT_1);
+			       cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 }
 
 const struct smp_operations omap4_smp_ops __initconst = {
-- 
2.11.1

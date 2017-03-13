From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during
 boot
Date: Mon, 13 Mar 2017 13:52:31 -0700
Message-ID: <20170313205231.1593-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
unconditionally resetting CPU1 because of a kexec boot issue I was seeing
earlier on omap4 when doing kexec boot between two different kernel
versions.

This caused issues on some systems. We should only reset CPU1 as a last
resort option, and try to avoid it where possible. Doing an unconditional
CPU1 reset causes issues for example when booting a bootloader configured
secure OS running on CPU1 as reported by Andrew F. Davis <afd@ti.com>.

We can't completely remove the reset of CPU1 as it would break
kexec booting from older kernels. Also it looks like omap4 suspend/resume
cycle occasionally fails to bring up CPU1 without the reset of CPU1.

The ideal fix is to park CPU1 to the bootrom loop during CPU hot-unplug.
This way we can be assured that the CPU1 is properly configured by
bootloader or the previous kernel. However, we can't do that for the
earlier kernels out there capable of kexec booting new kernels.

So let's fix the issue reported by Andrew by making CPU1 reset conditional
and only do it if CPU1 is configured to boot at an address that is within
the booting kernel. In these cases we know for sure that we just overwrote
the configured boot_secondary() during booting and that it's invalid.

And while at it, let's replace legacy cpu_is usage with soc_is to avoid
confusion with mixed use of both checks.

Additionally we also need to fix the hot-unplug code to properly park CPU1
to the bootrom loop so it's not affected by SDRAM changes done by kexec
booting kernel.

Fixes: 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec")
Reported-by: Andrew F. Davis <afd@ti.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h              |  1 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 30 +++++++++----
 arch/arm/mach-omap2/omap-smp.c            | 70 +++++++++++++++++++++++++------
 3 files changed, 80 insertions(+), 21 deletions(-)

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
+	/* Save old NS_PA_ADDR for validity checks later on */
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
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
 
+#include <asm/sections.h>
 #include <asm/smp_scu.h>
 #include <asm/virt.h>
 
@@ -44,6 +45,7 @@ struct omap_smp_config {
 	unsigned long cpu1_rstctrl_pa;
 	void __iomem *cpu1_rstctrl_va;
 	void __iomem *scu_base;
+	void __iomem *wakeupgen_base;
 	void *startup_addr;
 };
 
@@ -140,7 +142,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	static struct clockdomain *cpu1_clkdm;
 	static bool booted;
 	static struct powerdomain *cpu1_pwrdm;
-	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
 	 * Set synchronisation state between this boot processor
@@ -157,7 +158,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	if (omap_secure_apis_support())
 		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	else
-		writel_relaxed(0x20, base + OMAP_AUX_CORE_BOOT_0);
+		writel_relaxed(0x20, cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 
 	if (!cpu1_clkdm && !cpu1_pwrdm) {
 		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
@@ -261,9 +262,59 @@ static void __init omap4_smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
+/*
+ * For now, just make sure the start-up address is not within the booting
+ * kernel space as that means we just overwrote whatever secondary_startup()
+ * code there was.
+ */
+static bool __init omap4_smp_cpu1_startup_valid(unsigned long addr)
+{
+	if ((addr >= __pa(PAGE_OFFSET)) && (addr <= __pa(__bss_start)))
+		return false;
+
+	return true;
+}
+
+/*
+ * We may need to reset CPU1 before configuring, otherwise kexec boot can end
+ * up trying to use old kernel startup address or suspend-resume will
+ * occasionally fail to bring up CPU1 on 4430 if CPU1 fails to enter deeper
+ * idle states.
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
+	/* Did the configured secondary_startup() get overwritten? */
+	if (!omap4_smp_cpu1_startup_valid(cpu1_startup_pa))
+		needs_reset = true;
+
+	/*
+	 * If omap4 or 5 has NS_PA_ADDR configured, CPU1 may be in a
+	 * deeper idle state in WFI and wake to an invalid address.
+	 */
+	if ((soc_is_omap44xx() || soc_is_omap54xx()) &&
+	    !omap4_smp_cpu1_startup_valid(cpu1_ns_pa_addr))
+		needs_reset = true;
+
+	if (!needs_reset || !c->cpu1_rstctrl_va)
+		return;
+
+	pr_info("smp: Already configured CPU1, needs reset (0x%lx 0x%lx)\n",
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
@@ -281,6 +332,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	/* Must preserve cfg.scu_base set earlier */
 	cfg.cpu1_rstctrl_pa = c->cpu1_rstctrl_pa;
 	cfg.startup_addr = c->startup_addr;
+	cfg.wakeupgen_base = omap_get_wakeupgen_base();
 
 	if (soc_is_dra74x() || soc_is_omap54xx()) {
 		if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
@@ -299,15 +351,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -319,7 +363,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		omap_auxcoreboot_addr(__pa_symbol(cfg.startup_addr));
 	else
 		writel_relaxed(__pa_symbol(cfg.startup_addr),
-			       base + OMAP_AUX_CORE_BOOT_1);
+			       cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
 }
 
 const struct smp_operations omap4_smp_ops __initconst = {
-- 
2.11.1

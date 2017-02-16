From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Thu, 16 Feb 2017 11:07:01 -0800
Message-ID: <20170216190701.GY21809@atomide.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com>
 <20170215183915.GU3897@atomide.com>
 <20170215191242.GP21809@atomide.com>
 <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
 <20170215222711.GQ21809@atomide.com>
 <20170216161010.GU21809@atomide.com>
 <fc1e75e8-87ef-59f1-3c8a-cb45f1749e50@ti.com>
 <20170216165409.GW21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170216165409.GW21809@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [170216 08:55]:
> * Andrew F. Davis <afd@ti.com> [170216 08:30]:
> > On 02/16/2017 10:10 AM, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [170215 14:28]:
> > >> * Andrew F. Davis <afd@ti.com> [170215 14:14]:
> > >>> On 02/15/2017 01:12 PM, Tony Lindgren wrote:
> > >>>> And also the same issue happens doing kexec on beagle-x15 naturally if
> > >>>> the cpu1 reset is removed.
> > >>>>
> > >>>
> > >>> When a core actually powers up it idles in ROM code waiting for
> > >>> OMAP_AUX_CORE_BOOT_0 to be set. When we shutdown a core it is not really
> > >>> powered off, we just let it spin in omap4_cpu_die() or
> > >>> omap4_secondary_startup() waiting on OMAP_AUX_CORE_BOOT_0, just like if
> > >>> it were still trapped in ROM after a reset.
> > > 
> > > OK so I debugged this a bit more. We have CPU1 in omap_do_wfi()
> > > as we don't currently have omap5_secondary_startup() or any deeper
> > > idle mode support beyond retention for omap5 or dra7 in the mainline
> > > kernel.
> > > 
> > >>> The issue with this fake startup idle loop is that, unlike the ROM based
> > >>> startup idle loop, these do *not* jump to the address we stored in
> > >>> OMAP_AUX_CORE_BOOT_1, they just make the assumption that they can safely
> > >>> jump to the kernel startup function.
> > > 
> > > This does not seem to be the case here.
> > > 
> > 
> > Well this is what I am seeing every time, this code only works when it
> > is the same kernel we kexec, any changed addresses here will not work.
> 
> Hmm let's talk the mainline kernel here. Currently things do work in
> the mainline kernel because of the cpu1 reset. And without cpu1 reset
> things will currently go wrong in the mainline kernel both for kexec
> and suspend/resume.
> 
> > >>> So when we tell this core to boot, and it is not in the real ROM startup
> > >>> loop, it breaks stuff as it jumps to the old kernel's
> > >>> secondary_startup() even though we gave it the correct address in
> > >>> OMAP_AUX_CORE_BOOT_1.
> > > 
> > > And this is not happening. I think this is what I was seeing earlier,
> > > but it's not the omap5/dra7 issue.
> > > 
> > > What we have is cpu1 returning from previous kernel's omap_do_wfi()
> > > in the kexec booted kernel's code and that's when things go wrong.
> > > 
> > 
> > We are the ones sending it to omap_do_wfi(), in omap4_cpu_die() it gets
> > idled in a loop, it shouldn't be idled after it is shut off, it should
> > get parked, we should do this like we do in omap5_secondary_startup().
> 
> Yup agreed. We need to figure out if it's just normal cpuidle hot-unplug
> event vs shut down and park for kexec. Probably cpu_kill() is the place
> to park it, need to check.
> 
> > > So if cpu1 was configured for idle for any reason, it will never gets
> > > to omap5_secondary_startup without the reset currently.
> > > 
> > > The reason kexec and suspend/resume mostly works for omap4 without
> > > cpu1 reset is that we usually enter off mode for cpu1 and the context
> > > is lost and then we properly go through omap4_secondary_startup. Or
> > > that's my theory so far for the occasional flakeyness I've been seeing :)
> > > 
> > > Any ideas what we should try to check to see if cpu1 is in idle
> > > mode so we can do the reset if needed?
> > > 
> > 
> > You can never reset the core, resetting the core is not allowed on HS
> > devices and so it really doesn't matter what the core is doing. In no
> > case is reseting the core a valid work-around for not correctly parking
> > it. We need to fix the omap4_cpu_die() to not let the core go idle if
> > the return from idle path is the problem.
> 
> Yeah well from Linux point of view, what we're interested in is that
> cpu1 comes up reliably in all cases no matter what it takes. I agree
> doing a reset on it should be only done if nothing else helps. And I
> can see some HS implementations not allowing cpu1 reset. And I can see
> some product specific bootloaders idle cpu1 and that's where things
> break again.
> 
> For your use case, probably all we need is runtime checks for HS in
> addition to parking cpu1 for kexec. If that's not enough, then maybe
> a device specific DT property for never-reset-no-matter-what.

Below is a first take on the last resort cpu1 reset done based on
configured CPU1_WAKEUP_NS_PA_ADDR_OFFSET for omap4 and 5. Note that
we can't merge it yet as it will break kexec boot for dra7. To fix that,
we need to first do what you're suggesting and properly park cpu1 for
kexec.

Regards,

Tony

8< -----------------------------
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -270,6 +270,7 @@ extern const struct smp_operations omap4_smp_ops;
 extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
+extern bool omap4_cpu1_may_need_reset(void);
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
 
@@ -213,6 +214,35 @@ static void __init save_l2x0_context(void)
 #endif
 
 /**
+ * omap4_cpu1_may_need_reset: Check if cpu1 needs to be reset on boot
+ *
+ * If cpu1 is configured for idle in the bootloader or in the previous
+ * kernel after kexec, it will wake-up from idle state to the configured
+ * restore address which is unsafe for booting kernel. In that case all
+ * we can do is reset cpu1 to get it to start_secondary. In at least
+ * omap5 case, the ROM code properly parks the bootloader at a higher
+ * kernel address, so for those cases no reset is needed. For anything
+ * configured for the first 1GiB at 0x80000000 let's assume we need a
+ * reset.
+ */
+bool omap4_cpu1_may_need_reset(void)
+{
+	bool unsafe_cpu1_ns_pa_addr;
+
+	if (!old_cpu1_ns_pa_addr)
+		return false;
+
+	unsafe_cpu1_ns_pa_addr = ((old_cpu1_ns_pa_addr >> 24) == 0x80);
+	if (!unsafe_cpu1_ns_pa_addr)
+		return false;
+
+	pr_info("smp: omap has configured ns_pa_addr: 0x%08x\n",
+		old_cpu1_ns_pa_addr);
+
+	return true;
+}
+
+/**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
  * of OMAP4 MPUSS subsystem
@@ -371,7 +401,7 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
-		if (cpu_is_omap44xx())
+		if (soc_is_omap44xx())
 			pm_info->wkup_sar_addr = sar_base +
 				CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
 		else
@@ -395,7 +425,7 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
-		if (cpu_is_omap44xx())
+		if (soc_is_omap44xx())
 			pm_info->wkup_sar_addr = sar_base +
 				CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 		else
@@ -432,7 +462,7 @@ int __init omap4_mpuss_init(void)
 		save_l2x0_context();
 	}
 
-	if (cpu_is_omap44xx()) {
+	if (soc_is_omap44xx()) {
 		omap_pm_ops.finish_suspend = omap4_finish_suspend;
 		omap_pm_ops.resume = omap4_cpu_resume;
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
@@ -443,7 +473,7 @@ int __init omap4_mpuss_init(void)
 		enable_mercury_retention_mode();
 	}
 
-	if (cpu_is_omap446x())
+	if (soc_is_omap446x())
 		omap_pm_ops.hotplug_restart = omap4460_secondary_startup;
 
 	return 0;
@@ -460,22 +490,30 @@ int __init omap4_mpuss_init(void)
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
@@ -300,10 +300,13 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		scu_enable(cfg.scu_base);
 
 	/*
-	 * Reset CPU1 before configuring, otherwise kexec will
-	 * end up trying to use old kernel startup address.
+	 * Reset CPU1 before configuring, otherwise kexec can
+	 * end up trying to use old kernel startup address or
+	 * suspen/resume will fail bring up CPU1. Seen only on
+	 * 4430..
 	 */
-	if (cfg.cpu1_rstctrl_va) {
+	if (omap4_cpu1_may_need_reset() && cfg.cpu1_rstctrl_va) {
+		pr_info("smp: omap cpu1 idle configured, needs reset\n");
 		writel_relaxed(1, cfg.cpu1_rstctrl_va);
 		readl_relaxed(cfg.cpu1_rstctrl_va);
 		writel_relaxed(0, cfg.cpu1_rstctrl_va);
-- 
2.11.1

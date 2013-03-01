From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 01/15] ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
Date: Fri, 1 Mar 2013 17:40:50 +0530
Message-ID: <1362139864-9233-2-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab3CAMKE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:10:04 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP5 and future OMAP based SOCs has backward compatible MPUSS
IP block with OMAP4. It's programming model is mostly similar.
Hence consolidate the OMAP MPUSS code so that it can be re-used
on OMAP5 and future SOCs.

No functional change.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   56 +++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index abdd0f6..ee8a1e4 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -71,10 +71,37 @@ struct omap4_cpu_pm_info {
 	void (*secondary_startup)(void);
 };
 
+struct cpu_pm_ops {
+	int (*finish_suspend)(unsigned long cpu_state);
+	void (*resume)(void);
+	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
+};
+
+extern int omap4_finish_suspend(unsigned long cpu_state);
+extern void omap4_cpu_resume(void);
+
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
 static void __iomem *sar_base;
 
+static int default_finish_suspend(unsigned long cpu_state)
+{
+	omap_do_wfi();
+	return 0;
+}
+
+static void dummy_cpu_resume(void)
+{}
+
+void dummy_scu_prepare(unsigned int cpu_id, unsigned int cpu_state)
+{}
+
+struct cpu_pm_ops omap_pm_ops = {
+	.finish_suspend		= default_finish_suspend,
+	.resume			= dummy_cpu_resume,
+	.scu_prepare		= dummy_scu_prepare,
+};
+
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
  * used for OFF or DORMANT wakeup.
@@ -203,11 +230,12 @@ static void save_l2x0_context(void)
 {
 	u32 val;
 	void __iomem *l2x0_base = omap4_get_l2cache_base();
-
-	val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
-	__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
-	val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
-	__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
+	if (l2x0_base) {
+		val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
+		__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
+		val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
+		__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
+	}
 }
 #else
 static void save_l2x0_context(void)
@@ -269,17 +297,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
-	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
-	scu_pwrst_prepare(cpu, power_state);
+	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.resume));
+	omap_pm_ops.scu_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
 
 	/*
 	 * Call low level function  with targeted low power state.
 	 */
 	if (save_state)
-		cpu_suspend(save_state, omap4_finish_suspend);
+		cpu_suspend(save_state, omap_pm_ops.finish_suspend);
 	else
-		omap4_finish_suspend(save_state);
+		omap_pm_ops.finish_suspend(save_state);
 
 	/*
 	 * Restore the CPUx power state to ON otherwise CPUx
@@ -315,14 +343,14 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	clear_cpu_prev_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
-	scu_pwrst_prepare(cpu, power_state);
+	omap_pm_ops.scu_prepare(cpu, power_state);
 
 	/*
 	 * CPU never retuns back if targeted power state is OFF mode.
 	 * CPU ONLINE follows normal CPU ONLINE ptah via
 	 * omap_secondary_startup().
 	 */
-	omap4_finish_suspend(cpu_state);
+	omap_pm_ops.finish_suspend(cpu_state);
 
 	set_cpu_next_pwrst(cpu, PWRDM_POWER_ON);
 	return 0;
@@ -399,6 +427,12 @@ int __init omap4_mpuss_init(void)
 
 	save_l2x0_context();
 
+	if (cpu_is_omap44xx()) {
+		omap_pm_ops.finish_suspend = omap4_finish_suspend;
+		omap_pm_ops.resume = omap4_cpu_resume;
+		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5


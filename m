From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/10] ARM: OMAP5 / DRA7: PM: Provide a dummy startup function
 for CPU hotplug
Date: Fri, 22 Aug 2014 09:02:30 -0500
Message-ID: <1408716154-26101-7-git-send-email-nm@ti.com>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408716154-26101-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Dont assume that all OMAP4+ code will be able to use OMAP4 hotplug
logic. On OMAP5, DRA7, we do not need this in place yet, also,
currently the CPU startup pointer is located in omap4_cpu_pm_info
instead of cpu_pm_ops.

So, isolate the function to hotplug_restart pointer in cpu_pm_ops
where it should have belonged, initalize them as per valid startup
pointers for OMAP4430/60 as in current logic, however provide
dummy_cpu_resume to be the startup location as well.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[nm@ti.com: split this out of original code and isolate it]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 53d8de5..207fce2 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -69,7 +69,6 @@ struct omap4_cpu_pm_info {
 	void __iomem *scu_sar_addr;
 	void __iomem *wkup_sar_addr;
 	void __iomem *l2x0_sar_addr;
-	void (*secondary_startup)(void);
 };
 
 /**
@@ -77,6 +76,7 @@ struct omap4_cpu_pm_info {
  * @finish_suspend:	CPU suspend finisher function pointer
  * @resume:		CPU resume function pointer
  * @scu_prepare:	CPU Snoop Control program function pointer
+ * @hotplug_restart:	CPU restart function pointer
  *
  * Structure holds functions pointer for CPU low power operations like
  * suspend, resume and scu programming.
@@ -85,6 +85,7 @@ struct cpu_pm_ops {
 	int (*finish_suspend)(unsigned long cpu_state);
 	void (*resume)(void);
 	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
+	void (*hotplug_restart)(void);
 };
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
@@ -108,6 +109,7 @@ struct cpu_pm_ops omap_pm_ops = {
 	.finish_suspend		= default_finish_suspend,
 	.resume			= dummy_cpu_resume,
 	.scu_prepare		= dummy_scu_prepare,
+	.hotplug_restart	= dummy_cpu_resume,
 };
 
 /*
@@ -312,7 +314,7 @@ int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 
 	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
 	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
-	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
+	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.hotplug_restart));
 	omap_pm_ops.scu_prepare(cpu, power_state);
 
 	/*
@@ -385,10 +387,6 @@ int __init omap4_mpuss_init(void)
 					CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 		pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
 	}
-	if (cpu_is_omap446x())
-		pm_info->secondary_startup = omap4460_secondary_startup;
-	else
-		pm_info->secondary_startup = omap4_secondary_startup;
 
 	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
 	if (!pm_info->pwrdm) {
@@ -422,12 +420,16 @@ int __init omap4_mpuss_init(void)
 		omap_pm_ops.finish_suspend = omap4_finish_suspend;
 		omap_pm_ops.resume = omap4_cpu_resume;
 		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
+		omap_pm_ops.hotplug_restart = omap4_secondary_startup;
 		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
 	} else if (soc_is_omap54xx() || soc_is_dra7xx()) {
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 		enable_mercury_retention_mode();
 	}
 
+	if (cpu_is_omap446x())
+		omap_pm_ops.hotplug_restart = omap4460_secondary_startup;
+
 	return 0;
 }
 
-- 
1.7.9.5

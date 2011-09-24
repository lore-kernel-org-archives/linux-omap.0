From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 12/24] OMAP4: PM: Program CPU1 to hit OFF when off-lined
Date: Sat, 24 Sep 2011 11:44:32 +0530
Message-ID: <1316844884-21700-13-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab1IXGPL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:11 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Program non-boot CPUs to hit lowest supported power state
when it is off-lined using cpu hotplug framework.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 +++++
 arch/arm/mach-omap2/omap-hotplug.c              |   14 ++++++---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |   32 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap-wakeupgen.c            |   32 +++++++++++++++++++++++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 1f6c9ac..ed3797c 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -58,6 +58,7 @@ extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
+extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
@@ -66,6 +67,12 @@ static inline int omap4_enter_lowpower(unsigned int cpu,
 	return 0;
 }
 
+static inline int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
 static inline int omap4_mpuss_init(void)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..51ade8d 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -21,6 +21,8 @@
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
 
+#include "powerdomain.h"
+
 int platform_cpu_kill(unsigned int cpu)
 {
 	return 1;
@@ -32,6 +34,8 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
+	unsigned int this_cpu;
+
 	flush_cache_all();
 	dsb();
 
@@ -39,15 +43,15 @@ void platform_cpu_die(unsigned int cpu)
 	 * we're ready for shutdown now, so do it
 	 */
 	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
-		printk(KERN_CRIT "Secure clear status failed\n");
+		pr_err("Secure clear status failed\n");
 
 	for (;;) {
 		/*
-		 * Execute WFI
+		 * Enter into low power state
 		 */
-		do_wfi();
-
-		if (omap_read_auxcoreboot0() == cpu) {
+		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
+		this_cpu = smp_processor_id();
+		if (omap_read_auxcoreboot0() == this_cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index e4f11be..c0b6472 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -192,6 +192,38 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	return 0;
 }
 
+/**
+ * omap4_hotplug_cpu: OMAP4 CPU hotplug entry
+ * @cpu : CPU ID
+ * @power_state: CPU low power state.
+ */
+int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+{
+	unsigned int cpu_state = 0;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return -ENXIO;
+
+	if (power_state == PWRDM_POWER_OFF)
+		cpu_state = 1;
+
+	clear_cpu_prev_pwrst(cpu);
+	set_cpu_next_pwrst(cpu, power_state);
+	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_secondary_startup));
+	scu_pwrst_prepare(cpu, power_state);
+
+	/*
+	 * CPU never retuns back if targetted power state is OFF mode.
+	 * CPU ONLINE follows normal CPU ONLINE ptah via
+	 * omap_secondary_startup().
+	 */
+	omap4_finish_suspend(cpu_state);
+
+	set_cpu_next_pwrst(cpu, PWRDM_POWER_ON);
+	return 0;
+}
+
+
 /*
  * Initialise OMAP4 MPUSS
  */
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 22b0269..12b00e0 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -180,6 +180,36 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
 	spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int __cpuinit irq_cpu_hotplug_notify(struct notifier_block *self,
+					 unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+		wakeupgen_irqmask_all(cpu, 0);
+		break;
+	case CPU_DEAD:
+		wakeupgen_irqmask_all(cpu, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __refdata irq_hotplug_notifier = {
+	.notifier_call = irq_cpu_hotplug_notify,
+};
+
+static void __init irq_hotplug_init(void)
+{
+	register_hotcpu_notifier(&irq_hotplug_notifier);
+}
+#else
+static void __init irq_hotplug_init(void)
+{}
+#endif
+
 /*
  * Initialise the wakeupgen module.
  */
@@ -222,5 +252,7 @@ int __init omap_wakeupgen_init(void)
 	for (i = 0; i < NR_IRQS; i++)
 		irq_target_cpu[i] = boot_cpu;
 
+	irq_hotplug_init();
+
 	return 0;
 }
-- 
1.7.4.1


From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 16/25] OMAP4: PM: Program CPU1 to hit OFF when off-lined
Date: Sun, 4 Sep 2011 19:24:17 +0530
Message-ID: <1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab1IDN4L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:11 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Program non-boot CPUs to hit lowest supported power state
when it is off-lined using cpu hotplug framework.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 +++++
 arch/arm/mach-omap2/omap-hotplug.c              |   14 ++++++---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |   33 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap-wakeupgen.c            |   32 ++++++++++++++++++++++
 4 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 662f37c..14803c3 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -51,6 +51,7 @@ extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
+extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
@@ -59,6 +60,12 @@ static inline int omap4_enter_lowpower(unsigned int cpu,
 	return 0;
 }
 
+static inline int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+{
+	omap_do_wfi();
+	return 0;
+}
+
 static inline int omap4_mpuss_init(void)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 80167ec..51ade8d 100644
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
-		omap_do_wfi();
-
-		if (omap_read_auxcoreboot0() == cpu) {
+		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
+		this_cpu = smp_processor_id();
+		if (omap_read_auxcoreboot0() == this_cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 1137537..9d68abf 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -193,6 +193,39 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
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
+	cpu_clear_prev_logic_pwrst(cpu);
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
index a0882e6..6461f22 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -194,6 +194,36 @@ void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
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
@@ -237,5 +267,7 @@ int __init omap_wakeupgen_init(void)
 	for (i = 0; i < NR_IRQS; i++)
 		irq_target_cpu[i] = boot_cpu;
 
+	irq_hotplug_init();
+
 	return 0;
 }
-- 
1.7.4.1


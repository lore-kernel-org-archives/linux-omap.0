From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 07/17] omap4: pm: CPU1 wakeup workaround form Low power modes
Date: Sat, 19 Feb 2011 16:12:28 +0530
Message-ID: <1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48715 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab1BSKmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 05:42:53 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The SGI(Software Generated Interrupts) are not wakeup capable from
low power states. This is known limitation on OMAP4 and needs to be
worked around by using software forced clockdomain wake-up. CPU0 forces
the CPU1 clockdomain to software force wakeup. After the wakeup, CPU1
restores its clockdomain hardware supervised mode.

More details can be found in OMAP4430 TRM - Version J
Section :
	4.3.4.2 Power States of CPU0 and CPU1

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    9 +++++++++
 arch/arm/mach-omap2/omap-smp.c     |   27 ++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 9f8f097..cf4ab15 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -23,6 +23,7 @@
 #include <mach/omap-wakeupgen.h>
 
 #include "powerdomain.h"
+#include "clockdomain.h"
 
 int platform_cpu_kill(unsigned int cpu)
 {
@@ -36,6 +37,11 @@ int platform_cpu_kill(unsigned int cpu)
 void platform_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;
+	static struct clockdomain *cpu1_clkdm;
+
+	/* To avoid cpu1 clockdomain lookup every time */
+	if (!cpu1_clkdm)
+		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
 
 	flush_cache_all();
 	dsb();
@@ -59,6 +65,9 @@ void platform_cpu_die(unsigned int cpu)
 			 * OK, proper wakeup, we're done
 			 */
 			omap_wakeupgen_irqmask_all(this_cpu, 0);
+
+			/* Restore clockdomain to hardware supervised */
+			clkdm_allow_idle(cpu1_clkdm);
 			break;
 		}
 		pr_debug("CPU%u: spurious wakeup call\n", cpu);
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b105a29..31c9b79 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -25,6 +25,8 @@
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
 
+#include "clockdomain.h"
+
 /* SCU base address */
 void __iomem *scu_base;
 
@@ -48,6 +50,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	static struct clockdomain *cpu1_clkdm;
+	static bool booted;
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -63,7 +67,28 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	flush_cache_all();
 	smp_wmb();
-	smp_cross_call(cpumask_of(cpu), 1);
+
+	/* To avoid cpu1 clockdomain lookup every time */
+	if (!cpu1_clkdm)
+		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
+
+	/*
+	 * The SGI(Software Generated Interrupts) are not wakeup capable
+	 * from low power states. This is known limitation on OMAP4 and
+	 * needs to be worked around by using software forced clockdomain
+	 * wake-up. To wakeup CPU1, CPU0 forces the CPU1 clockdomain to
+	 * software force wakeup. After the wakeup, CPU1 restores its
+	 * clockdomain hardware supervised mode.
+	 * More details can be found in OMAP4430 TRM - Version J
+	 * Section :
+	 *	4.3.4.2 Power States of CPU0 and CPU1
+	 */
+	if (booted) {
+		clkdm_wakeup(cpu1_clkdm);
+	} else {
+		dsb_sev();
+		booted = true;
+	}
 
 	/*
 	 * Now the secondary core is starting up let it run its
-- 
1.6.0.4


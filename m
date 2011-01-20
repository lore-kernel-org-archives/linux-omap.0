From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to speed-up boot
Date: Thu, 20 Jan 2011 15:12:59 +0530
Message-ID: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44818 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab1ATJn2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 04:43:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>

On some architectures, secondary cores shares clock with primiary
core and hence scale together. Hence secondary core lpj calibration
is not necessary and can be skipped to save considerable time.

This can speed up the secondary cpu boot and hotplug cpu online
paths.

Discussion thread:
	http://www.spinics.net/lists/arm-kernel/msg111124.html

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/Kconfig            |    5 +++++
 arch/arm/kernel/smp.c       |   36 ++++++++++++++++++++++++++++--------
 arch/arm/mach-omap2/Kconfig |    1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..8944639 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -823,6 +823,7 @@ config ARCH_U300
 config ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
 	select CPU_V7
+	select ARCH_HAS_COMMON_CORES_CLOCK
 	select ARM_AMBA
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
@@ -1418,6 +1419,10 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_HAS_COMMON_CORES_CLOCK
+      bool
+      depends on SMP
+
 config HIGHMEM
 	bool "High Memory Support (EXPERIMENTAL)"
 	depends on MMU && EXPERIMENTAL
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..8e72b11 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -270,6 +270,20 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 }
 
 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Archs can select ARCH_HAS_COMMON_CORES_CLOCK
+ * for this.
+ */
+static inline int skip_secondary_calibrate(void)
+{
+#ifdef CONFIG_ARCH_HAS_COMMON_CORES_CLOCK
+	return true;
+#else
+	return false;
+#endif
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -312,7 +326,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();
 
-	calibrate_delay();
+	if (!skip_secondary_calibrate())
+		calibrate_delay();
 
 	smp_store_cpu_info(cpu);
 
@@ -332,14 +347,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	int cpu;
 	unsigned long bogosum = 0;
 
-	for_each_online_cpu(cpu)
-		bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+	if (!skip_secondary_calibrate()) {
+		for_each_online_cpu(cpu)
+			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
 
-	printk(KERN_INFO "SMP: Total of %d processors activated "
-	       "(%lu.%02lu BogoMIPS).\n",
-	       num_online_cpus(),
-	       bogosum / (500000/HZ),
-	       (bogosum / (5000/HZ)) % 100);
+		printk(KERN_INFO "SMP: Total of %d processors activated "
+		       "(%lu.%02lu BogoMIPS).\n",
+			num_online_cpus(),
+			bogosum / (500000/HZ),
+			(bogosum / (5000/HZ)) % 100);
+	} else {
+		printk(KERN_INFO "SMP: Total of %d processors activated.\n",
+			num_online_cpus());
+	}
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..e6ad15d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -43,6 +43,7 @@ config ARCH_OMAP4
 	default y
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
+	select ARCH_HAS_COMMON_CORES_CLOCK
 	select ARM_GIC
 	select PL310_ERRATA_588369
 	select ARM_ERRATA_720789
-- 
1.6.0.4


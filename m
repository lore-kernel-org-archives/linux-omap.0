From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot
Date: Mon, 24 Jan 2011 14:21:19 +0530
Message-ID: <1295859080-15259-6-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35299 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab1AXIvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:52 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On some architectures, secondary cores shares clock with primiary
core and hence scale together. Hence secondary core lpj calibration
is not necessary and can be skipped to save considerable time.

This can speed up the secondary cpu boot and hotplug cpu online
paths.

The patch is still under discussion and relevant thread is
here.
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42902.html

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp.h     |    8 ++++++++
 arch/arm/kernel/smp.c          |   35 ++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/omap-smp.c |    3 +++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..150d202 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -69,6 +69,14 @@ asmlinkage void secondary_start_kernel(void);
 extern void platform_secondary_init(unsigned int cpu);
 
 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs inside
+ * platform_secondary_init()
+ */
+extern void secondary_skip_calibrate(void);
+
+
+/*
  * Initialize cpu_possible map, and enable coherency
  */
 extern void platform_smp_prepare_cpus(unsigned int);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..6aa99bc 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -55,6 +55,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };
 
+static unsigned int skip_secondary_calibrate;
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
@@ -270,6 +272,16 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 }
 
 /*
+ * Skip the secondary calibration on architectures sharing clock
+ * with primary cpu. Needs to be called for archs from
+ * platform_secondary_init()
+ */
+void secondary_skip_calibrate(void)
+{
+	skip_secondary_calibrate = 1;
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -312,7 +324,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 */
 	percpu_timer_setup();
 
-	calibrate_delay();
+	if (!skip_secondary_calibrate)
+		calibrate_delay();
 
 	smp_store_cpu_info(cpu);
 
@@ -330,16 +343,20 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	int cpu;
-	unsigned long bogosum = 0;
+	char bogosum[32];
+	unsigned long bogosums = 0;
+
+	if (!skip_secondary_calibrate) {
+		for_each_online_cpu(cpu)
+			bogosums += per_cpu(cpu_data, cpu).loops_per_jiffy;
 
-	for_each_online_cpu(cpu)
-		bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+		snprintf(bogosum, sizeof(bogosums), " (%lu.%02lu BogoMIPS).\n",
+			bogosums / (500000/HZ), (bogosums / (5000/HZ)) % 100);
+	} else
+		bogosum[0] = '\0';
 
-	printk(KERN_INFO "SMP: Total of %d processors activated "
-	       "(%lu.%02lu BogoMIPS).\n",
-	       num_online_cpus(),
-	       bogosum / (500000/HZ),
-	       (bogosum / (5000/HZ)) % 100);
+	pr_info("SMP: Total of %d processors activated%s.\n",
+		num_online_cpus(), bogosum);
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..7342cd5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -39,6 +39,9 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 */
 	gic_secondary_init(0);
 
+	/* Allow to skip secondary CPU calibration */
+	secondary_skip_calibrate();
+
 	/*
 	 * Synchronise with the boot thread.
 	 */
-- 
1.6.0.4


From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 09/13] ARM: OMAP5: Add SMP support.
Date: Thu, 3 May 2012 12:56:18 +0530
Message-ID: <1336029982-31898-10-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719Ab2ECH0r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:47 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Add OMAP5 SMP boot support using OMAP4 SMP code. The relevant code paths
are runtime checked using cpu id

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/omap-headsmp.S |   21 ++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c     |   41 +++++++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 88fb577..0771d22 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -222,6 +222,7 @@ extern void omap_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
+extern void omap5_secondary_startup(void);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 503ac77..502e313 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -19,6 +19,27 @@
 #include <linux/init.h>
 
 	__CPUINIT
+
+/* Physical address needed since MMU not enabled yet on secondary core */
+#define AUX_CORE_BOOT0_PA			0x48281800
+
+/*
+ * OMAP5 specific entry point for secondary CPU to jump from ROM
+ * code.  This routine also provides a holding flag into which
+ * secondary core is held until we're ready for it to initialise.
+ * The primary core will update this flag using a hardware
++ * register AuxCoreBoot0.
+ */
+ENTRY(omap5_secondary_startup)
+wait:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
+	ldr	r0, [r2]
+	mov	r0, r0, lsr #5
+	mrc	p15, 0, r4, c0, c0, 5
+	and	r4, r4, #0x0f
+	cmp	r0, r4
+	bne	wait
+	b	secondary_startup
+END(omap5_secondary_startup)
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 151fd5b..9424bb6 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -33,6 +33,10 @@
 #include "common.h"
 #include "clockdomain.h"
 
+#define CPU_MASK		0xff0ffff0
+#define CPU_CORTEX_A9		0x410FC090
+#define CPU_CORTEX_A15		0x410FC0F0
+
 /* SCU base address */
 static void __iomem *scu_base;
 
@@ -43,6 +47,14 @@ void __iomem *omap4_get_scu_base(void)
 	return scu_base;
 }
 
+static inline unsigned int get_a15_core_count(void)
+{
+	unsigned int ncores;
+
+	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (ncores));
+	return ((ncores >> 24) & 3) + 1;
+}
+
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/*
@@ -133,7 +145,6 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 static void __init wakeup_secondary(void)
 {
 	void __iomem *base = omap_get_wakeupgen_base();
-
 	/*
 	 * Write the address of secondary startup routine into the
 	 * AuxCoreBoot1 where ROM code will jump and start executing
@@ -162,16 +173,21 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores;
-
-	/*
-	 * Currently we can't call ioremap here because
-	 * SoC detection won't work until after init_early.
-	 */
-	scu_base =  OMAP2_L4_IO_ADDRESS(OMAP44XX_SCU_BASE);
-	BUG_ON(!scu_base);
-
-	ncores = scu_get_core_count(scu_base);
+	unsigned int i = 0, ncores = 1, cpu_id;
+
+	/* Use ARM cpuid check here, as SoC detection will not work so early */
+	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
+	if (cpu_id == CPU_CORTEX_A9) {
+		/*
+		 * Currently we can't call ioremap here because
+		 * SoC detection won't work until after init_early.
+		 */
+		scu_base =  OMAP2_L4_IO_ADDRESS(OMAP44XX_SCU_BASE);
+		BUG_ON(!scu_base);
+		ncores = scu_get_core_count(scu_base);
+	} else if (cpu_id == CPU_CORTEX_A15) {
+		ncores = get_a15_core_count();
+	}
 
 	/* sanity check */
 	if (ncores > nr_cpu_ids) {
@@ -193,6 +209,7 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * Initialise the SCU and wake up the secondary core using
 	 * wakeup_secondary().
 	 */
-	scu_enable(scu_base);
+	if (scu_base)
+		scu_enable(scu_base);
 	wakeup_secondary();
 }
-- 
1.7.1


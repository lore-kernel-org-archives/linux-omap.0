From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 09/14] ARM: OMAP5: Add SMP support.
Date: Thu, 5 Jul 2012 17:38:51 +0530
Message-ID: <1341490136-25901-14-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41014 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab2GEMKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 08:10:38 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, R Sricharan <r.sricharan@ti.com>

Add OMAP5 SMP boot support using OMAP4 SMP code. The relevant code paths
are runtime checked using cpu id

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/omap-headsmp.S |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c     |   35 +++++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 53c87ab..367e1fe 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -271,6 +271,7 @@ extern void omap_secondary_startup(void);
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
index badfe39..7d118b9 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -33,6 +33,12 @@
 #include "common.h"
 #include "clockdomain.h"
 
+#define CPU_MASK		0xff0ffff0
+#define CPU_CORTEX_A9		0x410FC090
+#define CPU_CORTEX_A15		0x410FC0F0
+
+#define OMAP5_CORE_COUNT	0x2
+
 /* SCU base address */
 static void __iomem *scu_base;
 
@@ -133,7 +139,6 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 static void __init wakeup_secondary(void)
 {
 	void __iomem *base = omap_get_wakeupgen_base();
-
 	/*
 	 * Write the address of secondary startup routine into the
 	 * AuxCoreBoot1 where ROM code will jump and start executing
@@ -162,16 +167,21 @@ static void __init wakeup_secondary(void)
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
+		ncores = OMAP5_CORE_COUNT;
+	}
 
 	/* sanity check */
 	if (ncores > nr_cpu_ids) {
@@ -193,6 +203,7 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * Initialise the SCU and wake up the secondary core using
 	 * wakeup_secondary().
 	 */
-	scu_enable(scu_base);
+	if (scu_base)
+		scu_enable(scu_base);
 	wakeup_secondary();
 }
-- 
1.7.9.5


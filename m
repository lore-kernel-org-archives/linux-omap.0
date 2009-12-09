From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/6] OMAP4: AuxCoreBoot registers only accessible in secure mode.
Date: Wed,  9 Dec 2009 23:59:08 +0530
Message-ID: <1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49302 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523AbZLIS32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:29:28 -0500
In-Reply-To: <1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

The AuxCoreBoot0 and AuxCoreBoot1 can be only accessed in secure
mode. Replace the current code with secure monitor API's to access/modify
these registers.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S    |   35 +++++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap-smp.c        |   24 +++++++---------------
 arch/arm/plat-omap/include/plat/smp.h |    2 +
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 4afadba..aa3f65c 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -27,20 +27,39 @@
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
  * secondary core is held until we're ready for it to initialise.
- * The primary core will update the this flag using a hardware
- * register AuxCoreBoot1.
+ * The primary core will update this flag using a hardware
+ * register AuxCoreBoot0.
  */
 ENTRY(omap_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #0x0f
-hold:	ldr	r1, =OMAP4_AUX_CORE_BOOT1_PA	@ read from AuxCoreBoot1
-	ldr	r2, [r1]
-	cmp	r2, r0
+hold:	ldr	r12,=0x103
+	dsb
+	smc				@ read from AuxCoreBoot0
+	mov	r0, r0, lsr #9
+	mrc	p15, 0, r4, c0, c0, 5
+	and	r4, r4, #0x0f
+	cmp	r0, r4
 	bne	hold
 
 	/*
-	 * we've been released from the cpu_release,secondary_stack
+	 * we've been released from the wait loop,secondary_stack
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
+END(omap_secondary_startup)
 
+
+ENTRY(omap_modify_auxcoreboot0)
+	stmfd   sp!, {r1-r12, lr}
+	ldr	r12, =0x104
+	dsb
+	smc
+	ldmfd   sp!, {r1-r12, pc}
+END(omap_modify_auxcoreboot0)
+
+ENTRY(omap_auxcoreboot_addr)
+	stmfd   sp!, {r2-r12, lr}
+	ldr	r12, =0x105
+	dsb
+	smc
+	ldmfd   sp!, {r2-r12, pc}
+END(omap_auxcoreboot_addr)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 4890bcf..59e8478 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -21,15 +21,12 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
+#include <asm/cacheflush.h>
 #include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <plat/common.h>
 
-/* Registers used for communicating startup information */
-static void __iomem *omap4_auxcoreboot_reg0;
-static void __iomem *omap4_auxcoreboot_reg1;
-
 /* SCU base address */
 static void __iomem *scu_base;
 
@@ -74,12 +71,13 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	spin_lock(&boot_lock);
 
 	/*
-	 * Update the AuxCoreBoot1 with boot state for secondary core.
+	 * Update the AuxCoreBoot0 with boot state for secondary core.
 	 * omap_secondary_startup() routine will hold the secondary core till
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
-	__raw_writel(cpu, omap4_auxcoreboot_reg1);
+	omap_modify_auxcoreboot0(0x200, 0x0);
+	flush_cache_all();
 	smp_wmb();
 
 	timeout = jiffies + (1 * HZ);
@@ -99,17 +97,18 @@ static void __init wakeup_secondary(void)
 {
 	/*
 	 * Write the address of secondary startup routine into the
-	 * AuxCoreBoot0 where ROM code will jump and start executing
+	 * AuxCoreBoot1 where ROM code will jump and start executing
 	 * on secondary core once out of WFE
 	 * A barrier is added to ensure that write buffer is drained
 	 */
-	__raw_writel(virt_to_phys(omap_secondary_startup),	   \
-					omap4_auxcoreboot_reg0);
+	omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
 	smp_wmb();
 
 	/*
 	 * Send a 'sev' to wake the secondary core from WFE.
+	 * Drain the outstanding writes to memory
 	 */
+	dsb();
 	set_event();
 	mb();
 }
@@ -136,7 +135,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int ncores = get_core_count();
 	unsigned int cpu = smp_processor_id();
-	void __iomem *omap4_wkupgen_base;
 	int i;
 
 	/* sanity check */
@@ -168,12 +166,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	/* Never released */
-	omap4_wkupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
-	BUG_ON(!omap4_wkupgen_base);
-	omap4_auxcoreboot_reg0 = omap4_wkupgen_base + 0x800;
-	omap4_auxcoreboot_reg1 = omap4_wkupgen_base + 0x804;
-
 	if (max_cpus > 1) {
 		/*
 		 * Enable the local timer or broadcast device for the
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index dcaa8fd..8983d54 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -28,6 +28,8 @@
 
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
+extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
+extern void omap_auxcoreboot_addr(u32 cpu_addr);
 
 /*
  * We use Soft IRQ1 as the IPI
-- 
1.6.0.4


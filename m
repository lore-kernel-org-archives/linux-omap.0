From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under smp_prepare_cpus()
Date: Wed, 20 Feb 2013 20:48:45 +0530
Message-ID: <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43759 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935502Ab3BTPRz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:55 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). While at
it drop the un-necessary sev() and barrier which was under prepare code.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |   51 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 7d29a74..9711ecd 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -164,36 +164,6 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 	return 0;
 }
 
-static void __init wakeup_secondary(void)
-{
-	void *startup_addr = omap_secondary_startup;
-	void __iomem *base = omap_get_wakeupgen_base();
-
-	if (cpu_is_omap446x()) {
-		startup_addr = omap_secondary_startup_4460;
-		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
-	}
-
-	/*
-	 * Write the address of secondary startup routine into the
-	 * AuxCoreBoot1 where ROM code will jump and start executing
-	 * on secondary core once out of WFE
-	 * A barrier is added to ensure that write buffer is drained
-	 */
-	if (omap_secure_apis_support())
-		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
-	else
-		__raw_writel(virt_to_phys(omap5_secondary_startup),
-						base + OMAP_AUX_CORE_BOOT_1);
-
-	/*
-	 * Send a 'sev' to wake the secondary core from WFE.
-	 * Drain the outstanding writes to memory
-	 */
-	dsb_sev();
-	mb();
-}
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -231,6 +201,8 @@ static void __init omap4_smp_init_cpus(void)
 
 static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
+	void *startup_addr = omap_secondary_startup;
+	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
 	 * Initialise the SCU and wake up the secondary core using
@@ -238,7 +210,24 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	if (scu_base)
 		scu_enable(scu_base);
-	wakeup_secondary();
+
+	if (cpu_is_omap446x()) {
+		startup_addr = omap_secondary_startup_4460;
+		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
+	}
+
+	/*
+	 * Write the address of secondary startup routine into the
+	 * AuxCoreBoot1 where ROM code will jump and start executing
+	 * on secondary core once out of WFE
+	 * A barrier is added to ensure that write buffer is drained
+	 */
+	if (omap_secure_apis_support())
+		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
+	else
+		__raw_writel(virt_to_phys(omap5_secondary_startup),
+						base + OMAP_AUX_CORE_BOOT_1);
+
 }
 
 struct smp_operations omap4_smp_ops __initdata = {
-- 
1.7.9.5


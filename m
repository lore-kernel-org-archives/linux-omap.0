From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 03/25] OMAP4: PM: Use custom omap_do_wfi() for suspend and default idle.
Date: Sun, 4 Sep 2011 19:24:04 +0530
Message-ID: <1315144466-9395-4-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab1IDNzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:55:35 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The omap_do_wfi() incorporates interconnect barriers to meet
OMAP44XX interconnect ordering requirements. Make use of this
hook in default idle, suspend and CPU hot-plug paths.

Without the interconnect barriers, many issues have been observed
leading to system freeze, CPU deadlocks, random crashes with
register accesses, synchronization loss on initiators operating
on both interconnect port simultaneously.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    1 +
 arch/arm/mach-omap2/omap-hotplug.c              |    2 +-
 arch/arm/mach-omap2/pm44xx.c                    |   22 ++++++++++-
 arch/arm/mach-omap2/sleep44xx.S                 |   47 +++++++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 26653f6..62d8d07 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -38,6 +38,7 @@ extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 extern void omap_bus_sync(void);
 extern unsigned long omap_get_dram_barrier_base(void);
+extern void omap_do_wfi(void);
 
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..80167ec 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -45,7 +45,7 @@ void platform_cpu_die(unsigned int cpu)
 		/*
 		 * Execute WFI
 		 */
-		do_wfi();
+		omap_do_wfi();
 
 		if (omap_read_auxcoreboot0() == cpu) {
 			/*
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..4bbc6fe 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -33,7 +33,7 @@ static LIST_HEAD(pwrst_list);
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-	do_wfi();
+	omap_do_wfi();
 	return 0;
 }
 
@@ -91,6 +91,23 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 }
 
 /**
+ * omap_default_idle -
+ * Implements OMAP4 memory, IO ordering requirements which can't be addressed
+ * with default arch_idle() hook. Used by all CPUs with !CONFIG_CPUIDLE and
+ * by secondary CPU with CONFIG_CPUIDLE.
+ */
+static void omap_default_idle(void)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	omap_do_wfi();
+
+	local_fiq_enable();
+	local_irq_enable();
+}
+
+/**
  * omap4_pm_init - Init routine for OMAP4 PM
  *
  * Initializes all powerdomain and clockdomain target states
@@ -115,6 +132,9 @@ static int __init omap4_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
+	/* Overwrite the default arch_idle() */
+	pm_idle = omap_default_idle;
+
 err2:
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 5406713..049f426 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -27,3 +27,50 @@ ENTRY(omap_bus_sync)
 	isb
 	ldmfd	sp!, {pc}
 ENDPROC(omap_bus_sync)
+
+ENTRY(omap_do_wfi)
+	stmfd	sp!, {lr}
+	/* Drain interconnect write buffers. */
+	bl omap_bus_sync
+
+	/*
+	 * Execute an ISB instruction to ensure that all of the
+	 * CP15 register changes have been committed.
+	 */
+	isb
+
+	/*
+	 * Execute a barrier instruction to ensure that all cache,
+	 * TLB and branch predictor maintenance operations issued
+	 * by any CPU in the cluster have completed.
+	 */
+	dsb
+	dmb
+
+	/*
+	 * Execute a WFI instruction and wait until the
+	 * STANDBYWFI output is asserted to indicate that the
+	 * CPU is in idle and low power state. CPU can specualatively
+	 * prefetch the instructions so add NOPs after WFI. Sixteen
+	 * NOPs as per Cortex-A9 pipeline.
+	 */
+	wfi					@ Wait For Interrupt
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+
+	ldmfd	sp!, {pc}
+ENDPROC(omap_do_wfi)
-- 
1.7.4.1


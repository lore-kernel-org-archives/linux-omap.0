From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/9] ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable] tuple
Date: Wed, 20 Feb 2013 20:48:41 +0530
Message-ID: <1361373527-21695-4-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935480Ab3BTPRy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:54 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP platform, FIQ is reserved for secure environment only. If at all
the FIQ needs to be disabled, it involves going through security
API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.

So just get rid of it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    4 ----
 arch/arm/mach-omap2/cpuidle44xx.c |    7 -------
 arch/arm/mach-omap2/pm24xx.c      |   11 +++--------
 arch/arm/mach-omap2/pm34xx.c      |    9 +--------
 arch/arm/mach-omap2/pm44xx.c      |    4 ----
 5 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 22590db..f61b28c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -82,8 +82,6 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
 
-	local_fiq_disable();
-
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
@@ -121,8 +119,6 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
 return_sleep_time:
 
-	local_fiq_enable();
-
 	return index;
 }
 
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index d639aef..944e64a 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -70,10 +70,7 @@ static int omap4_enter_idle_simple(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	local_fiq_disable();
 	omap_do_wfi();
-	local_fiq_enable();
-
 	return index;
 }
 
@@ -84,8 +81,6 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	int cpu_id = smp_processor_id();
 
-	local_fiq_disable();
-
 	/*
 	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
 	 * This is necessary to honour hardware recommondation
@@ -158,8 +153,6 @@ fail:
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 	cpu_done[dev->cpu] = false;
 
-	local_fiq_enable();
-
 	return index;
 }
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c333fa6..af29c31 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -213,22 +213,17 @@ static int omap2_can_sleep(void)
 
 static void omap2_pm_idle(void)
 {
-	local_fiq_disable();
-
 	if (!omap2_can_sleep()) {
 		if (omap_irq_pending())
-			goto out;
+			return;
 		omap2_enter_mpu_retention();
-		goto out;
+		return;
 	}
 
 	if (omap_irq_pending())
-		goto out;
+		return;
 
 	omap2_enter_full_retention();
-
-out:
-	local_fiq_enable();
 }
 
 static void __init prcm_setup_regs(void)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7be3622..2f7e58e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,10 +346,8 @@ void omap_sram_idle(void)
 
 static void omap3_pm_idle(void)
 {
-	local_fiq_disable();
-
 	if (omap_irq_pending())
-		goto out;
+		return;
 
 	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
 	trace_cpu_idle(1, smp_processor_id());
@@ -358,9 +356,6 @@ static void omap3_pm_idle(void)
 
 	trace_power_end(smp_processor_id());
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
-
-out:
-	local_fiq_enable();
 }
 
 #ifdef CONFIG_SUSPEND
@@ -759,14 +754,12 @@ int __init omap3_pm_init(void)
 			pr_err("Memory allocation failed when allocating for secure sram context\n");
 
 		local_irq_disable();
-		local_fiq_disable();
 
 		omap_dma_global_context_save();
 		omap3_save_secure_ram_context();
 		omap_dma_global_context_restore();
 
 		local_irq_enable();
-		local_fiq_enable();
 	}
 
 	omap3_save_scratchpad_contents();
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index aa6fd98..a96ae57 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -121,11 +121,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
  */
 static void omap_default_idle(void)
 {
-	local_fiq_disable();
-
 	omap_do_wfi();
-
-	local_fiq_enable();
 }
 
 /**
-- 
1.7.9.5


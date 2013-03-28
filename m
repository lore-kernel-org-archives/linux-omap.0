From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/9] ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable]
 tuple
Date: Thu, 28 Mar 2013 13:07:13 +0530
Message-ID: <5153F329.8010602@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-4-git-send-email-santosh.shilimkar@ti.com> <874nfw8zb7.fsf@linaro.org> <51534235.6030506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab3C1HfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 03:35:20 -0400
In-Reply-To: <51534235.6030506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 12:32 AM, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 12:06 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> On OMAP platform, FIQ is reserved for secure environment only. If at all
>>> the FIQ needs to be disabled, it involves going through security
>>> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
>>>
>>> So just get rid of it.
>>
>> What about GP devices?
>>
> On GP devices as well FIQ isn't available for non-secure software since
> its marked secure only in ROM initialization. There has been heavy
> debate on this since some customers wanted to have it available
> for debug purpose but some other work-around was done rather
> than opening it for public.
> 

For record, patch with updated changelog for GP device is end of
the email.

Regards,
Santosh

>From 6b85638b83caac7bae9ffa202391882a9ad4388f Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 11 Feb 2013 19:29:45 +0530
Subject: [PATCH v2 3/9] ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable]
 tuple

On OMAP platform, FIQ is reserved for secure environment only. If at all
the FIQ needs to be disabled, it involves going through security
API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
On GP devices too, the fiq is disabled for non-secure software.

So just get rid of it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 ---
 arch/arm/mach-omap2/cpuidle44xx.c |    7 -------
 arch/arm/mach-omap2/pm24xx.c      |   11 +++--------
 arch/arm/mach-omap2/pm34xx.c      |    9 +--------
 arch/arm/mach-omap2/pm44xx.c      |    4 ----
 5 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 80392fc..06f567f 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -107,8 +107,6 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 
-	local_fiq_disable();
-
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
 
@@ -143,7 +141,6 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
 
 return_sleep_time:
-	local_fiq_enable();
 
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
index b59d939..ce956b0 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -200,22 +200,17 @@ static int omap2_can_sleep(void)
 
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
index 2d93d8b..c018593 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,19 +346,14 @@ void omap_sram_idle(void)
 
 static void omap3_pm_idle(void)
 {
-	local_fiq_disable();
-
 	if (omap_irq_pending())
-		goto out;
+		return;
 
 	trace_cpu_idle(1, smp_processor_id());
 
 	omap_sram_idle();
 
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
-
-out:
-	local_fiq_enable();
 }
 
 #ifdef CONFIG_SUSPEND
@@ -757,14 +752,12 @@ int __init omap3_pm_init(void)
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
index ea62e75..9e9095c 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -131,11 +131,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
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


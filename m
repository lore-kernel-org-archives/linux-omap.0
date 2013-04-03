From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 16/18] ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
Date: Wed, 03 Apr 2013 14:37:18 -0700
Message-ID: <876203qos1.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-17-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41196 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760497Ab3DCVhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 17:37:22 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so1114350pab.7
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 14:37:21 -0700 (PDT)
In-Reply-To: <1364205910-32392-17-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
> function to check whether the MPU cluster lost context or not. Thanks to
> couple CPUIdle, cluster low power entry is almost guaranteed and hence
> the programmed cluster check is enough in idle exit path. The API was
> more of an optimization for corner cases, where if the cluster low power
> entry fails for some reason, the cluster context restore gets skipped.
>
> Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
> once the PRM/CM code gets moved to drivers. This patch also reduces one
> dependency with platform code for idle driver movement.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Looks good, but I find the changelog a bit confusing.

Below is a slightly modified patch (I only modified the changelog).  If
those changes are OK with you, I'll add it to my cpuidle branch as well.

Kevin

>From c01794dc249f826f0714578f26ff9efd35ea6296 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 25 Mar 2013 15:35:08 +0530
Subject: [PATCH] ARM: OMAP4+: CPUidle: Deprecate use of
 omap4_mpuss_read_prev_context_state()

Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
to check whether the MPU cluster lost context or not before calling
cpu_cluster_pm_exit().  This was initially done an optimization for
corner cases, where if the cluster low power entry fails for some
reason, the cluster context restore gets skipped.  However, since
reading the previous context is expensive (involving slow accesses to
the PRCM), it's better to avoid it and simply check the target cluster
state instead.

Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
once the PRM/CM code gets moved to drivers. This patch also reduces one
dependency with platform code for idle driver movement.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[khilman@linaro.org: minor changelog edits]
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-omap2/common.h              |  5 -----
 arch/arm/mach-omap2/cpuidle44xx.c         |  3 ++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 --------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 40f4a03..f5c9983 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -249,7 +249,6 @@ extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
-extern u32 omap4_mpuss_read_prev_context_state(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
@@ -277,10 +276,6 @@ static inline int omap4_finish_suspend(unsigned long cpu_state)
 static inline void omap4_cpu_resume(void)
 {}
 
-static inline u32 omap4_mpuss_read_prev_context_state(void)
-{
-	return 0;
-}
 #endif
 
 struct omap_sdrc_params;
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 354517a..3cad103 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -149,7 +149,8 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	 * Call idle CPU cluster PM exit notifier chain
 	 * to restore GIC and wakeupgen context.
 	 */
-	if (omap4_mpuss_read_prev_context_state())
+	if ((cx->mpu_state == PWRDM_POWER_RET) &&
+		(cx->mpu_logic_state == PWRDM_POWER_OFF))
 		cpu_cluster_pm_exit();
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 8bcb64b..e80327b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -139,20 +139,6 @@ static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
 	}
 }
 
-/**
- * omap4_mpuss_read_prev_context_state:
- * Function returns the MPUSS previous context state
- */
-u32 omap4_mpuss_read_prev_context_state(void)
-{
-	u32 reg;
-
-	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
-	reg &= OMAP4430_LOSTCONTEXT_DFF_MASK;
-	return reg;
-}
-
 /*
  * Store the CPU cluster state for L2X0 low power operations.
  */
-- 
1.8.2


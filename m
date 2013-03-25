From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 16/18] ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
Date: Mon, 25 Mar 2013 15:35:08 +0530
Message-ID: <1364205910-32392-17-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50683 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab3CYKEM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:12 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
function to check whether the MPU cluster lost context or not. Thanks to
couple CPUIdle, cluster low power entry is almost guaranteed and hence
the programmed cluster check is enough in idle exit path. The API was
more of an optimization for corner cases, where if the cluster low power
entry fails for some reason, the cluster context restore gets skipped.

Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
once the PRM/CM code gets moved to drivers. This patch also reduces one
dependency with platform code for idle driver movement.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.h              |    5 -----
 arch/arm/mach-omap2/cpuidle44xx.c         |    3 ++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 --------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f75d972..6b97d42 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -250,7 +250,6 @@ extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
-extern u32 omap4_mpuss_read_prev_context_state(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
@@ -278,10 +277,6 @@ static inline int omap4_finish_suspend(unsigned long cpu_state)
 static inline void omap4_cpu_resume(void)
 {}
 
-static inline u32 omap4_mpuss_read_prev_context_state(void)
-{
-	return 0;
-}
 #endif
 
 struct omap_sdrc_params;
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index ac6d526..e6218d3 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -146,7 +146,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	 * Call idle CPU cluster PM exit notifier chain
 	 * to restore GIC and wakeupgen context.
 	 */
-	if (omap4_mpuss_read_prev_context_state())
+	if ((cx->mpu_state == PWRDM_POWER_RET) &&
+		(cx->mpu_logic_state == PWRDM_POWER_OFF))
 		cpu_cluster_pm_exit();
 
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 995443a..6e917d7 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -185,20 +185,6 @@ static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
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
1.7.9.5


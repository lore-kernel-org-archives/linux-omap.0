From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 6/7] OMAP3: PM: make omap3_cpuidle_update_states independent of enable_off_mode
Date: Mon, 20 Dec 2010 14:05:08 -0600
Message-ID: <1292875509-9896-7-git-send-email-nm@ti.com>
References: <1292875509-9896-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933135Ab0LTUF0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 15:05:26 -0500
In-Reply-To: <1292875509-9896-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Santosh <santosh.shilimkar@ti.com>

Currently omap3_cpuidle_update_states makes whole sale decision
on which C states to update based on enable_off_mode variable
Instead, achieve the same functionality by independently providing
mpu and core deepest states the system is allowed to achieve and
update the idle states accordingly.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
v2: proto is used as (u32, u32) + added the acks collected
v1: original version
 arch/arm/mach-omap2/cpuidle34xx.c |   19 ++++++++++---------
 arch/arm/mach-omap2/pm.h          |    2 +-
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d50b45..f80d3f6 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -293,25 +293,26 @@ select_state:
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
 /**
- * omap3_cpuidle_update_states - Update the cpuidle states.
+ * omap3_cpuidle_update_states() - Update the cpuidle states
+ * @mpu_deepest_state:	Enable states upto and including this for mpu domain
+ * @core_deepest_state:	Enable states upto and including this for core domain
  *
- * Currently, this function toggles the validity of idle states based upon
- * the flag 'enable_off_mode'. When the flag is set all states are valid.
- * Else, states leading to OFF state set to be invalid.
+ * This goes through the list of states available and enables and disables the
+ * validity of C states based on deepest state that can be achieved for the
+ * variable domain
  */
-void omap3_cpuidle_update_states(void)
+void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
 {
 	int i;
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		struct omap3_processor_cx *cx = &omap3_power_states[i];
 
-		if (enable_off_mode) {
+		if ((cx->mpu_state >= mpu_deepest_state) &&
+		    (cx->core_state >= core_deepest_state)) {
 			cx->valid = 1;
 		} else {
-			if ((cx->mpu_state == PWRDM_POWER_OFF) ||
-				(cx->core_state	== PWRDM_POWER_OFF))
-				cx->valid = 0;
+			cx->valid = 0;
 		}
 	}
 }
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 5e0bee9..29663cc 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -58,7 +58,7 @@ extern u32 sleep_while_idle;
 #endif
 
 #if defined(CONFIG_CPU_IDLE)
-extern void omap3_cpuidle_update_states(void);
+extern void omap3_cpuidle_update_states(u32, u32);
 #endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index feb1bd9..ca3b134 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -928,7 +928,7 @@ void omap3_pm_off_mode_enable(int enable)
 		state = PWRDM_POWER_RET;
 
 #ifdef CONFIG_CPU_IDLE
-	omap3_cpuidle_update_states();
+	omap3_cpuidle_update_states(state, state);
 #endif
 
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-- 
1.6.3.3


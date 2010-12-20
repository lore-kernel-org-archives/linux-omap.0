From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 7/7] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Mon, 20 Dec 2010 14:05:09 -0600
Message-ID: <1292875509-9896-8-git-send-email-nm@ti.com>
References: <1292875509-9896-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36428 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933135Ab0LTUFX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 15:05:23 -0500
In-Reply-To: <1292875509-9896-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Santosh <santosh.shilimkar@ti.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Limitation i583: Self_Refresh Exit issue after OFF mode

Issue:
When device is waking up from OFF mode, then SDRC state machine sends
inappropriate sequence violating JEDEC standards.

Impact:
OMAP3630 < ES1.2 is impacted as follows depending on the platform:
CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable, while
	for all other sysclk frequencies, varied levels of instability
	seen based on varied parameters.
CS1: impacted

This patch takes option #3 as recommended by the Silicon erratum:
Avoid core power domain transitioning to OFF mode. Power consumption
impact is expected in this case.
To do this, we route core OFF requests to RET request on the impacted
revisions of silicon.

Acked-by: Jean Pihet <j-pihet@ti.com>

[nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a bit]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
v5: used WARN_ONCE to warn user for the required paths
v4: idle state control changed a bit -we wont register or enable
    the states which cannot be enabled.
v3: http://marc.info/?t=129140247800027&r=1&w=2
    no functional change in erratum wa implementation, just registration of
 	erratum is collated to a single cpu detection and version check
v2: https://patchwork.kernel.org/patch/365262/
    rebased to this patch series instead of depending on hs changes
    fix typo for macro definition
v1: http://marc.info/?l=linux-omap&m=129013173425266&w=2
 arch/arm/mach-omap2/cpuidle34xx.c |   12 ++++++++++++
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |   25 ++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f80d3f6..ab4c862 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -453,6 +453,18 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+
+	/*
+	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
+	 * enable OFF mode in a stable form for previous revisions.
+	 * we disable C7 state as a result.
+	 */
+	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
+		omap3_power_states[OMAP3_STATE_C7].valid = 0;
+		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
+		WARN_ONCE(1, "%s: core off state C7 disabled due to i583\n",
+				__func__);
+	}
 }
 
 struct cpuidle_driver omap3_idle_driver = {
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 2c1cbbd..ed2357a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
+#define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 extern u16 pm34xx_errata;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ca3b134..652d6f5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -928,12 +928,29 @@ void omap3_pm_off_mode_enable(int enable)
 		state = PWRDM_POWER_RET;
 
 #ifdef CONFIG_CPU_IDLE
-	omap3_cpuidle_update_states(state, state);
+	/*
+	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
+	 * enable OFF mode in a stable form for previous revisions, restrict
+	 * instead to RET
+	 */
+	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
+		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
+	else
+		omap3_cpuidle_update_states(state, state);
 #endif
 
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		pwrst->next_state = state;
-		omap_set_pwrdm_state(pwrst->pwrdm, state);
+		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
+				pwrst->pwrdm == core_pwrdm &&
+				state == PWRDM_POWER_OFF) {
+			pwrst->next_state = PWRDM_POWER_RET;
+			WARN_ONCE(1,
+				"%s: Core OFF disabled due to errata i583\n",
+				__func__);
+		} else {
+			pwrst->next_state = state;
+		}
+		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 	}
 }
 
@@ -1011,6 +1028,8 @@ static void __init pm_errata_configure(void)
 		pm34xx_errata |= PM_RTA_ERRATUM_i608;
 		/* Enable the l2 cache toggling in sleep logic */
 		enable_omap3630_toggle_l2_on_restore();
+		if (omap_rev() < OMAP3630_REV_ES1_2)
+			pm34xx_errata |= PM_SDRC_WAKEUP_ERRATUM_i583;
 	}
 }
 
-- 
1.6.3.3


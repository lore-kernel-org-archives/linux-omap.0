From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH v2] OMAP3630: PM: don't warn the user with a trace in case of PM34XX_ERRATUM
Date: Mon, 31 Jan 2011 11:35:25 -0200
Message-ID: <1296480925-25463-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53779 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab1AaNg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 08:36:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

In case in user has a OMAP3630 < ES1.2 the kernel should warn the user
about the ERRATUM, but using pr_warn instead of WARN_ON is already
enough, as there is nothing else the user can do besides changing the
board.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
---
v1->v2:
* Use pr_warn instead of printk (Kevin Hilman)

 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c      |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f7b22a1..876eeca 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -464,7 +464,7 @@ void omap_init_power_states(void)
 	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
 		omap3_power_states[OMAP3_STATE_C7].valid = 0;
 		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
-		WARN_ONCE(1, "%s: core off state C7 disabled due to i583\n",
+		pr_warn("%s: core off state C7 disabled due to i583\n",
 				__func__);
 	}
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a4aa192..88f09da 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -927,8 +927,7 @@ void omap3_pm_off_mode_enable(int enable)
 				pwrst->pwrdm == core_pwrdm &&
 				state == PWRDM_POWER_OFF) {
 			pwrst->next_state = PWRDM_POWER_RET;
-			WARN_ONCE(1,
-				"%s: Core OFF disabled due to errata i583\n",
+			pr_warn("%s: Core OFF disabled due to errata i583\n",
 				__func__);
 		} else {
 			pwrst->next_state = state;
-- 
1.7.2.3


From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 01/17][V2] ARM: OMAP4: cpuidle - Remove unused valid field
Date: Wed,  4 Apr 2012 22:12:35 +0200
Message-ID: <1333570371-1389-2-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59126 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2DDUM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 16:12:56 -0400
Received: by wejx9 with SMTP id x9so417996wej.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 13:12:55 -0700 (PDT)
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

The 'valid' field is never used in the code, let's remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f386cbe..ee0bc50 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -29,16 +29,15 @@ struct omap4_idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
 	u32 mpu_state;
-	u8 valid;
 };
 
 static struct cpuidle_params cpuidle_params_table[] = {
 	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	{.exit_latency = 2 + 2 , .target_residency = 5, .valid = 1},
+	{.exit_latency = 2 + 2 , .target_residency = 5 },
 	/* C2- CPU0 OFF + CPU1 OFF + MPU CSWR */
-	{.exit_latency = 328 + 440 , .target_residency = 960, .valid = 1},
+	{.exit_latency = 328 + 440 , .target_residency = 960 },
 	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	{.exit_latency = 460 + 518 , .target_residency = 1100, .valid = 1},
+	{.exit_latency = 460 + 518 , .target_residency = 1100 },
 };
 
 #define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
@@ -155,7 +154,6 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
 	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
 	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
 
-	cx->valid		= cpuidle_params_table[idx].valid;
 	cpuidle_set_statedata(state_usage, cx);
 
 	return cx;
@@ -191,7 +189,6 @@ int __init omap4_idle_init(void)
 	_fill_cstate(drv, 0, "MPUSS ON");
 	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
-	cx->valid = 1;	/* C1 is always valid */
 	cx->cpu_state = PWRDM_POWER_ON;
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->mpu_logic_state = PWRDM_POWER_RET;
-- 
1.7.5.4


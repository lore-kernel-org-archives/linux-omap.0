From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/18][V3] ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
Date: Tue, 24 Apr 2012 16:05:24 +0200
Message-ID: <1335276339-11135-4-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46390 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2DXOFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:05:49 -0400
Received: by wibhj6 with SMTP id hj6so3964512wib.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:05:48 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

We do not longer need this table as we defined the values
in the driver states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 7072c9e..522ec23 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -31,16 +31,7 @@ struct omap4_idle_statedata {
 	u32 mpu_state;
 };
 
-static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	{.exit_latency = 2 + 2 , .target_residency = 5 },
-	/* C2- CPU0 OFF + CPU1 OFF + MPU CSWR */
-	{.exit_latency = 328 + 440 , .target_residency = 960 },
-	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	{.exit_latency = 460 + 518 , .target_residency = 1100 },
-};
-
-#define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
+#define OMAP4_NUM_STATES 3
 
 struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
-- 
1.7.5.4


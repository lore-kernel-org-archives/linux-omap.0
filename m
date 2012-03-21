From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 3/7] ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
Date: Wed, 21 Mar 2012 10:27:46 +0100
Message-ID: <1332322070-24577-4-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52117 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab2CUJ15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 05:27:57 -0400
Received: by wejx9 with SMTP id x9so755262wej.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:27:56 -0700 (PDT)
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

We do not longer need this table as we defined the values
in the driver states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index cd6bee7..0455858 100644
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


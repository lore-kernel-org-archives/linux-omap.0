From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/18][V3] ARM: OMAP3: define statically the omap3_idle_data
Date: Tue, 24 Apr 2012 16:05:34 +0200
Message-ID: <1335276339-11135-14-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43905 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2DXOGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:06:07 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so434644wej.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:06:06 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Initialize the omap3_idle_data array at compile time, that will allow
to remove the initialization at boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a82a887..93e2450 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -44,9 +44,36 @@ struct omap3_idle_statedata {
 	u32 core_state;
 };
 
-#define OMAP3_NUM_STATES 7
-
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
+struct omap3_idle_statedata omap3_idle_data[] = {
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_ON,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_OFF,
+	},
+};
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
@@ -172,7 +199,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	    (cx->core_state >= core_deepest_state)) {
 		return index;
 	} else {
-		int idx = OMAP3_NUM_STATES - 1;
+		int idx = ARRAY_SIZE(omap3_idle_data) - 1;
 
 		/* Reach the current state starting at highest C-state */
 		for (; idx >= 0; idx--) {
@@ -334,7 +361,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.desc		  = "MPU OFF + CORE OFF",
 		},
 	},
-	.state_count = OMAP3_NUM_STATES,
+	.state_count = ARRAY_SIZE(omap3_idle_data),
 	.safe_state_index = 0,
 };
 
-- 
1.7.5.4


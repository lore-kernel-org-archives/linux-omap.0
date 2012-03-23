From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 7/9] ARM: OMAP3: define statically the omap3_idle_data
Date: Fri, 23 Mar 2012 10:26:32 +0100
Message-ID: <1332494794-7810-7-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43866 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab2CWJ0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1979620wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:44 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 877a7e1..34e1e34 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -46,7 +46,36 @@ struct omap3_idle_statedata {
 
 #define OMAP3_NUM_STATES 7
 
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
+struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
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
 
-- 
1.7.5.4


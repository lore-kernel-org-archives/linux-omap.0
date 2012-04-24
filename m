From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 07/18][V3] ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot time
Date: Tue, 24 Apr 2012 16:05:28 +0200
Message-ID: <1335276339-11135-8-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:65201 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2DXOF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:05:56 -0400
Received: by mail-wg0-f42.google.com with SMTP id ds11so3516464wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:05:56 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

We initialized it at compile time, no need to do that at boot
time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f1410f1..be1617c 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -170,14 +170,6 @@ struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
 };
 
-static inline struct omap4_idle_statedata *_fill_cstate_usage(
-					struct cpuidle_device *dev,
-					int idx)
-{
-	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
-	return cx;
-}
-
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
@@ -186,7 +178,6 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
  */
 int __init omap4_idle_init(void)
 {
-	struct omap4_idle_statedata *cx;
 	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
 
@@ -199,21 +190,6 @@ int __init omap4_idle_init(void)
 	dev = &per_cpu(omap4_idle_dev, cpu_id);
 	dev->cpu = cpu_id;
 
-	cx = _fill_cstate_usage(dev, 0);
-	cx->cpu_state = PWRDM_POWER_ON;
-	cx->mpu_state = PWRDM_POWER_ON;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	cx = _fill_cstate_usage(dev, 1);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	cx = _fill_cstate_usage(dev, 2);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_OFF;
-
 	cpuidle_register_driver(&omap4_idle_driver);
 
 	if (cpuidle_register_device(dev)) {
-- 
1.7.5.4


From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 06/18][V3] ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
Date: Tue, 24 Apr 2012 16:05:27 +0200
Message-ID: <1335276339-11135-7-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43905 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2DXOFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:05:53 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so434644wej.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:05:52 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

We are storing the 'omap4_idle_data' in the private data field
of the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 9e3effa..f1410f1 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -24,7 +24,7 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-/* Machine specific information to be recorded in the C-state driver_data */
+/* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
@@ -65,8 +65,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	struct omap4_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
+	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	u32 cpu1_state;
 	int cpu_id = smp_processor_id();
 
@@ -83,7 +82,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
 		index = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[index]);
+		cx = &omap4_idle_data[index];
 	}
 
 	if (index > 0)
@@ -176,15 +175,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
 					int idx)
 {
 	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
-
-	cpuidle_set_statedata(state_usage, cx);
-
 	return cx;
 }
 
-
-
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
-- 
1.7.5.4


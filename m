From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 6/7] ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
Date: Wed, 21 Mar 2012 10:27:49 +0100
Message-ID: <1332322070-24577-7-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45372 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab2CUJ2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 05:28:01 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so755242wej.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:28:00 -0700 (PDT)
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

We are storing the 'omap4_idle_data' in the private data field
if the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly
instead dereferencing pointers in an idle critical loop.

Also, that simplfies the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index e14cd56..cb91d1f 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -24,7 +24,7 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-/* Machine specific information to be recorded in the C-state driver_data */
+/* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
@@ -67,8 +67,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	struct omap4_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
+	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
 	int idle_time;
@@ -92,7 +91,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
 		new_state_idx = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
+		cx = &omap4_idle_data[new_state_idx]
 	}
 
 	if (index > 0)
@@ -193,15 +192,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
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
@@ -210,9 +203,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
  */
 int __init omap4_idle_init(void)
 {
-	struct omap4_idle_statedata *cx;
-	struct cpuidle_device *dev;
+	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
 	struct cpuidle_driver *drv = &omap4_idle_driver;
+	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-- 
1.7.5.4


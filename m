From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/17][V2] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Wed,  4 Apr 2012 22:12:44 +0200
Message-ID: <1333570371-1389-11-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: santosh.shilimkar-l0cyMroinI0@public.gmane.org, jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With the previous changes all the states are valid, except
the last state which can be handled by decreasing the number
of states.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 11a2c23..3f46e45 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -67,7 +67,6 @@ static struct cpuidle_params cpuidle_params_table[] = {
 struct omap3_idle_statedata {
 	u32 mpu_state;
 	u32 core_state;
-	u8 valid;
 };
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
@@ -191,8 +190,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	}
 
 	/* Check if current state is valid */
-	if ((cx->valid) &&
-	    (cx->mpu_state >= mpu_deepest_state) &&
+	if ((cx->mpu_state >= mpu_deepest_state) &&
 	    (cx->core_state >= core_deepest_state)) {
 		return index;
 	} else {
@@ -216,8 +214,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 		idx--;
 		for (; idx >= 0; idx--) {
 			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
-			if ((cx->valid) &&
-			    (cx->mpu_state >= mpu_deepest_state) &&
+			if ((cx->mpu_state >= mpu_deepest_state) &&
 			    (cx->core_state >= core_deepest_state)) {
 				next_index = idx;
 				break;
@@ -371,7 +368,6 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
 	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
 
-	cx->valid		= cpuidle_params_table[idx].valid;
 	cpuidle_set_statedata(state_usage, cx);
 
 	return cx;
@@ -399,7 +395,6 @@ int __init omap3_idle_init(void)
 
 	/* C1 . MPU WFI + Core active */
 	cx = _fill_cstate_usage(dev, 0);
-	cx->valid = 1;	/* C1 is always valid */
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->core_state = PWRDM_POWER_ON;
 
@@ -436,14 +431,13 @@ int __init omap3_idle_init(void)
 	 * We disable C7 state as a result.
 	 */
 	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
-		cx->valid = 0;
+		drv->state_count = OMAP3_NUM_STATES - 1;
 		pr_warn("%s: core off state C7 disabled due to i583\n",
 			__func__);
 	}
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_OFF;
 
-	drv->state_count = OMAP3_NUM_STATES;
 	cpuidle_register_driver(&omap3_idle_driver);
 
 	if (cpuidle_register_device(dev)) {
-- 
1.7.5.4

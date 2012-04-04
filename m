From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/17][V2] ARM: OMAP3 : cpuidle - simplify next_valid_state
Date: Wed,  4 Apr 2012 22:12:48 +0200
Message-ID: <1333570371-1389-15-git-send-email-daniel.lezcano@linaro.org>
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

Simplify the indentation by removing the useless 'else' statement.
Remove the first loop for the 'idx' search as we have it already
with the 'index' passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   53 +++++++++++++-----------------------
 1 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e4738eb..35a1471 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -174,13 +174,12 @@ static inline int omap3_enter_idle(struct cpuidle_device *dev,
  * if it satisfies the enable_off_mode condition.
  */
 static int next_valid_state(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-				int index)
+			    struct cpuidle_driver *drv, int index)
 {
-	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
+	int idx;
 	int next_index = -1;
 
 	if (enable_off_mode) {
@@ -196,42 +195,28 @@ static int next_valid_state(struct cpuidle_device *dev,
 
 	/* Check if current state is valid */
 	if ((cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
+	    (cx->core_state >= core_deepest_state))
 		return index;
-	} else {
-		int idx = OMAP3_NUM_STATES - 1;
-
-		/* Reach the current state starting at highest C-state */
-		for (; idx >= 0; idx--) {
-			if (&drv->states[idx] == curr) {
-				next_index = idx;
-				break;
-			}
-		}
-
-		/* Should never hit this condition */
-		WARN_ON(next_index == -1);
 
-		/*
-		 * Drop to next valid state.
-		 * Start search from the next (lower) state.
-		 */
-		idx--;
-		for (; idx >= 0; idx--) {
-			cx =  &omap3_idle_data[idx];
-			if ((cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
-				next_index = idx;
-				break;
-			}
+	/*
+	 * Drop to next valid state.
+	 * Start search from the next (lower) state.
+	 */
+	for (idx = index - 1; idx >= 0; idx--) {
+		cx =  &omap3_idle_data[idx];
+		if ((cx->mpu_state >= mpu_deepest_state) &&
+		    (cx->core_state >= core_deepest_state)) {
+			next_index = idx;
+			break;
 		}
-		/*
-		 * C1 is always valid.
-		 * So, no need to check for 'next_index == -1' outside
-		 * this loop.
-		 */
 	}
 
+	/*
+	 * C1 is always valid.
+	 * So, no need to check for 'next_index == -1' outside
+	 * this loop.
+	 */
+
 	return next_index;
 }
 
-- 
1.7.5.4

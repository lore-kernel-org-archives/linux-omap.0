From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/17][V2] ARM: OMAP3: cpuidle - remove cpuidle_params_table
Date: Wed,  4 Apr 2012 22:12:45 +0200
Message-ID: <1333570371-1389-12-git-send-email-daniel.lezcano@linaro.org>
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

We do not longer need the ''cpuidle_params_table' array as
we defined the states in the driver and we checked they are
all valid.

We also remove the structure definition as it is no longer used.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   28 +++-------------------------
 arch/arm/mach-omap2/pm.h          |   12 ------------
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 3f46e45..cdf1b8f 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -38,36 +38,14 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-/*
- * The latencies/thresholds for various C states have
- * to be configured from the respective board files.
- * These are some default values (which might not provide
- * the best power savings) used on boards which do not
- * pass these details from the board file.
- */
-static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 */
-	{2 + 2, 5, 1},
-	/* C2 */
-	{10 + 10, 30, 1},
-	/* C3 */
-	{50 + 50, 300, 1},
-	/* C4 */
-	{1500 + 1800, 4000, 1},
-	/* C5 */
-	{2500 + 7500, 12000, 1},
-	/* C6 */
-	{3000 + 8500, 15000, 1},
-	/* C7 */
-	{10000 + 30000, 300000, 1},
-};
-#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
-
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
 	u32 mpu_state;
 	u32 core_state;
 };
+
+#define OMAP3_NUM_STATES 7
+
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 5646b80..7856489 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -38,18 +38,6 @@ static inline int omap4_opp_init(void)
 }
 #endif
 
-/*
- * cpuidle mach specific parameters
- *
- * The board code can override the default C-states definition using
- * omap3_pm_init_cpuidle
- */
-struct cpuidle_params {
-	u32 exit_latency;	/* exit_latency = sleep + wake-up latencies */
-	u32 target_residency;
-	u8 valid;		/* validates the C-state */
-};
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-- 
1.7.5.4

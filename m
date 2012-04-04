From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/17][V2] ARM: OMAP3: cpuidle - remove rx51 cpuidle
	parameters table
Date: Wed,  4 Apr 2012 22:12:42 +0200
Message-ID: <1333570371-1389-9-git-send-email-daniel.lezcano@linaro.org>
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

As suggested, this table is an optimized version for rx51 and we
remove it in order to consolidate the cpuidle code between omap3
and omap4, we remove this specific data definition which is used
to override the default omap3 latencies but at the cost of extra
code and complexity.

In order to not lose the values which probably took time to be
measured, the table is converted into a comment with an array
description.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-rx51.c  |   38 +++++++++++++++++-------------------
 arch/arm/mach-omap2/cpuidle34xx.c |   17 ----------------
 arch/arm/mach-omap2/pm.h          |    9 --------
 3 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 27f01f0..2da92a6 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -59,25 +59,24 @@ static struct platform_device leds_gpio = {
 };
 
 /*
- * cpuidle C-states definition override from the default values.
- * The 'exit_latency' field is the sum of sleep and wake-up latencies.
- */
-static struct cpuidle_params rx51_cpuidle_params[] = {
-	/* C1 */
-	{110 + 162, 5 , 1},
-	/* C2 */
-	{106 + 180, 309, 1},
-	/* C3 */
-	{107 + 410, 46057, 0},
-	/* C4 */
-	{121 + 3374, 46057, 0},
-	/* C5 */
-	{855 + 1146, 46057, 1},
-	/* C6 */
-	{7580 + 4134, 484329, 0},
-	/* C7 */
-	{7505 + 15274, 484329, 1},
-};
+ * cpuidle C-states definition for rx51.
+ *
+ * The 'exit_latency' field is the sum of sleep
+ * and wake-up latencies.
+
+    ---------------------------------------------
+   | state |  exit_latency  |  target_residency  |
+    ---------------------------------------------
+   |  C1   |    110 + 162   |            5       |
+   |  C2   |    106 + 180   |          309       |
+   |  C3   |    107 + 410   |        46057       |
+   |  C4   |    121 + 3374  |        46057       |
+   |  C5   |    855 + 1146  |        46057       |
+   |  C6   |   7580 + 4134  |       484329       |
+   |  C7   |   7505 + 15274 |       484329       |
+    ---------------------------------------------
+
+*/
 
 extern void __init rx51_peripherals_init(void);
 
@@ -98,7 +97,6 @@ static void __init rx51_init(void)
 	struct omap_sdrc_params *sdrc_params;
 
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	omap_serial_init();
 
 	sdrc_params = nokia_get_sdram_timings();
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5358664..3519a8b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -298,23 +298,6 @@ select_state:
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
-void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
-{
-	int i;
-
-	if (!cpuidle_board_params)
-		return;
-
-	for (i = 0; i < OMAP3_NUM_STATES; i++) {
-		cpuidle_params_table[i].valid =	cpuidle_board_params[i].valid;
-		cpuidle_params_table[i].exit_latency =
-			cpuidle_board_params[i].exit_latency;
-		cpuidle_params_table[i].target_residency =
-			cpuidle_board_params[i].target_residency;
-	}
-	return;
-}
-
 struct cpuidle_driver omap3_idle_driver = {
 	.name = 	"omap3_idle",
 	.owner = 	THIS_MODULE,
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 36fa90b..5646b80 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -50,15 +50,6 @@ struct cpuidle_params {
 	u8 valid;		/* validates the C-state */
 };
 
-#if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
-extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
-#else
-static
-inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
-{
-}
-#endif
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-- 
1.7.5.4

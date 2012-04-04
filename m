From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/17][V2] ARM: OMAP4: cpuidle - use the omap4_idle_data
	variable directly
Date: Wed,  4 Apr 2012 22:12:40 +0200
Message-ID: <1333570371-1389-7-git-send-email-daniel.lezcano@linaro.org>
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

We are storing the 'omap4_idle_data' in the private data field
of the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly
instead dereferencing pointers in an idle critical loop.

Also, that simplfies the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 5b20115..b82f9fe 100644
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
 	u32 cpu1_state;
 	int cpu_id = smp_processor_id();
 
@@ -85,7 +84,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
 	if (cpu1_state != PWRDM_POWER_OFF) {
 		index = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[index]);
+		cx = &omap4_idle_data[index];
 	}
 
 	if (index > 0)
@@ -178,15 +177,9 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
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
@@ -196,8 +189,8 @@ static inline struct omap4_idle_statedata *_fill_cstate_usage(
 int __init omap4_idle_init(void)
 {
 	struct omap4_idle_statedata *cx;
-	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &omap4_idle_driver;
+	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-- 
1.7.5.4

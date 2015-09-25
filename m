From: Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 2/2] arm: omap2+: PM: change trace_power_domain_target event format.
Date: Fri, 25 Sep 2015 15:22:25 +0200
Message-ID: <1443187345-14834-3-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
To: khilman@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

power_domain_target arg3 is now a string (event name) with generic power
domains. In the case of Omap, it is a hint to the prev/next switch op.
Incidentally this trace is now conditioned by CONFIG_PM_ADVANCED_DEBUG.

Compiled for Omap2+ but not tested.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm/mach-omap2/powerdomain.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 78af6d8..cd77696 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -160,7 +160,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
-	int prev, next, state, trace_state = 0;
+	int prev, state;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -177,18 +177,25 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 			pwrdm->state_counter[prev]++;
 		if (prev == PWRDM_POWER_RET)
 			_update_logic_membank_counters(pwrdm);
-		/*
-		 * If the power domain did not hit the desired state,
-		 * generate a trace event with both the desired and hit states
-		 */
-		next = pwrdm_read_next_pwrst(pwrdm);
-		if (next != prev) {
-			trace_state = (PWRDM_TRACE_STATES_FLAG |
+
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+		{
+			/*
+			 * If the power domain did not hit the desired state,
+			 * generate a trace event with both the desired and hit
+			 * states */
+			int next = pwrdm_read_next_pwrst(pwrdm);
+
+			if (next != prev) {
+				int trace_state = (PWRDM_TRACE_STATES_FLAG |
 				       ((next & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
-			trace_power_domain_target(pwrdm->name, trace_state,
-						  smp_processor_id());
+				trace_power_domain_target(pwrdm->name,
+					trace_state, "PWRDM_STATE_PREV");
+			}
 		}
+#endif
+
 		break;
 	default:
 		return -EINVAL;
@@ -522,9 +529,10 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 		 pwrdm->name, pwrst);
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
+#ifdef CONFIG_PM_ADVANCED_DEBUG
 		/* Trace the pwrdm desired target state */
-		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
+		trace_power_domain_target(pwrdm->name, pwrst, "set_next_pwrst");
+#endif
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
-- 
1.9.1


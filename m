From: Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v2 2/2] arm: omap2+: PM: change trace_power_domain_target event format.
Date: Mon, 28 Sep 2015 10:44:24 +0200
Message-ID: <1443429864-4177-2-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443429864-4177-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1443429864-4177-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-omap@vger.kernel.org

power_domain_target arg3 is now a string (event name) with generic power
domains. In the case of Omap, it is a hint to the prev/next switch op.

Compiled for Omap2+ but not tested.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm/mach-omap2/powerdomain.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 78af6d8..02167c2 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -160,7 +160,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
-	int prev, next, state, trace_state = 0;
+	int prev, state;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -177,17 +177,21 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
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
+		if (trace_power_domain_target_enabled()) {
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
 		break;
 	default:
@@ -523,8 +527,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
-		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
+		trace_power_domain_target(pwrdm->name, pwrst, "set_next_pwrst");
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
-- 
1.9.1


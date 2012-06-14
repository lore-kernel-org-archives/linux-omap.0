From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 8/8] ARM: OMAP2+: PM debug: trace the functional power domains states
Date: Thu, 14 Jun 2012 16:53:11 +0200
Message-ID: <1339685591-11177-9-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54987 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab2FNOxm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:42 -0400
Received: by wibhn6 with SMTP id hn6so2037708wib.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:41 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Trace the power domain transitions using the functional power states,
which include the power and logic states.

While at it, fix the trace in the case a power domain did not hit
the desired state, as reported by Paul Walmsley.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 875c6c4..f6885f9 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -144,7 +144,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
-	int prev, state, trace_state = 0;
+	int prev, next, state, trace_state;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -165,10 +165,10 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		 * If the power domain did not hit the desired state,
 		 * generate a trace event with both the desired and hit states
 		 */
-		if (state != prev) {
+		next = pwrdm_read_next_func_pwrst(pwrdm);
+		if (next != prev) {
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
-				       ((state & OMAP_POWERSTATE_MASK) << 8) |
-				       ((prev & OMAP_POWERSTATE_MASK) << 0));
+				       (next << 8) | (prev << 0));
 			trace_power_domain_target(pwrdm->name, trace_state,
 						  smp_processor_id());
 		}
@@ -768,13 +768,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
-		/* Trace the pwrdm desired target state */
-		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
-		/* Program the pwrdm desired target state */
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
-	}
 
 	return ret;
 }
-- 
1.7.7.6


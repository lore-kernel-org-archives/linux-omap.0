From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 6/8] ARM: OMAP2+: PM debug: trace the functional power domains states
Date: Wed, 15 Aug 2012 12:02:46 +0200
Message-ID: <1345024968-28951-7-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37506 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab2HOKDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:17 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so884296wey.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:16 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
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
index 6b8580b..06a566b 100644
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
+		next = pwrdm_read_next_fpwrst(pwrdm);
+		if (next != prev) {
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
-				       ((state & OMAP_POWERSTATE_MASK) << 8) |
-				       ((prev & OMAP_POWERSTATE_MASK) << 0));
+				       (next << 8) | (prev << 0));
 			trace_power_domain_target(pwrdm->name, trace_state,
 						  smp_processor_id());
 		}
@@ -781,13 +781,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
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


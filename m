From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/6] ARM: OMAP2+: powerdomain: fix powerdomain trace
 integration
Date: Fri, 23 Nov 2012 20:42:39 -0700
Message-ID: <20121124034238.24638.66515.stgit@dusk.lan>
References: <20121124033809.24638.11090.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57032 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624Ab2KXDoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 22:44:17 -0500
In-Reply-To: <20121124033809.24638.11090.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <jean.pihet@newoldbits.com>

Fix the trace in the case a power domain did not hit the desired
state, as reported by Paul Walmsley.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
[paul@pwsan.com: split this fix off from the patch
 "ARM: OMAP2+: PM debug: trace the functional power domains states"]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index dea62a9..92388c0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -143,7 +143,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
-	int prev, state, trace_state = 0;
+	int prev, next, state, trace_state = 0;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -164,9 +164,10 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		 * If the power domain did not hit the desired state,
 		 * generate a trace event with both the desired and hit states
 		 */
-		if (state != prev) {
+		next = pwrdm_read_next_pwrst(pwrdm);
+		if (next != prev) {
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
-				       ((state & OMAP_POWERSTATE_MASK) << 8) |
+				       ((next & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
 			trace_power_domain_target(pwrdm->name, trace_state,
 						  smp_processor_id());



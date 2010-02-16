From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 2/2] OMAP3: PM: Consistently report cpuidle C-state's names
Date: Tue, 16 Feb 2010 13:58:19 +0200
Message-ID: <1266321499-11858-3-git-send-email-eduardo.valentin@nokia.com>
References: <1266321499-11858-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31062 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab0BPL6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 06:58:54 -0500
In-Reply-To: <1266321499-11858-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "\\\"Kristo Tero (Nokia-D/Tampere)\\\"" <Tero.Kristo@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch changes the naming convention for OMAP3 cpuidle
C-states. Currently, depending on which Cstates are enabled/disabled,
there is a inconsistency between C-state name and what power domain
states it is supposed to reach when that C-state is selected.

For instance, if all cstates are enabled, "C1" means mpu on and
core on. But if this exact cstate is disabled, then "C1" doesn't mean
same power domains state configuration anymore.

So, this patch tries changing the cstates naming convention in order
to proper and consistently report the cstates names.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 50fe9ab..7ab9992 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -367,7 +367,7 @@ int __init omap3_idle_init(void)
 			omap3_enter_idle_bm : omap3_enter_idle;
 		if (cx->type == OMAP3_STATE_C1)
 			dev->safe_state = state;
-		sprintf(state->name, "C%d", count+1);
+		sprintf(state->name, "C%d", cx->type + 1);
 		sprintf(state->desc, "MPU=%s NEON=%s CORE=%s",
 			pd_states[cx->mpu_state], pd_states[cx->mpu_state],
 			pd_states[cx->core_state]);
-- 
1.6.5.7.g9ecb2


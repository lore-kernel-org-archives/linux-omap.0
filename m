From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [RFC] [PATCH 1/1] OMAP3: PM: Add cpuidle C-state description information
Date: Tue, 16 Feb 2010 09:16:04 +0200
Message-ID: <1266304564-22778-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29140 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab0BPHQr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 02:16:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "\\\"Kristo Tero (Nokia-D/Tampere)\\\"" <Tero.Kristo@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Add a basic description information for each cpuidle C-state.
The info contains only which state the MPU, NEON and CORE
power domains should reach when the C-state is selected.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cfa5a6..50fe9ab 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -339,6 +339,7 @@ struct cpuidle_driver omap3_idle_driver = {
  */
 int __init omap3_idle_init(void)
 {
+	const char *pd_states[4] = {"OFF", "RET", "INA", "ON "};
 	int i, count = 0;
 	struct omap3_processor_cx *cx;
 	struct cpuidle_state *state;
@@ -367,6 +368,9 @@ int __init omap3_idle_init(void)
 		if (cx->type == OMAP3_STATE_C1)
 			dev->safe_state = state;
 		sprintf(state->name, "C%d", count+1);
+		sprintf(state->desc, "MPU=%s NEON=%s CORE=%s",
+			pd_states[cx->mpu_state], pd_states[cx->mpu_state],
+			pd_states[cx->core_state]);
 		count++;
 	}
 
-- 
1.6.5.7.g9ecb2


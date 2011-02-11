From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap3: cpuidle: Add description field to each C-state.
Date: Fri, 11 Feb 2011 20:42:12 +0530
Message-ID: <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590Ab1BKPMW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 10:12:22 -0500
In-Reply-To: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add a description field to each idle C-state. This helps to give
better data with PowerTop and one don't have to refer to the code
to link what Cx means from system point of view while analysing
PowerTop data.

No functional change.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f7b22a1..3e4ec31 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -58,6 +58,7 @@ struct omap3_processor_cx {
 	u32 core_state;
 	u32 threshold;
 	u32 flags;
+	const char *desc;
 };
 
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
@@ -365,6 +366,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C1].desc = "MPU ON + CORE ON";
 
 	/* C2 . MPU WFI + Core inactive */
 	omap3_power_states[OMAP3_STATE_C2].valid =
@@ -380,6 +382,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C2].desc = "MPU ON + CORE ON";
 
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid =
@@ -395,6 +398,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C3].desc = "MPU RET + CORE ON";
 
 	/* C4 . MPU OFF + Core inactive */
 	omap3_power_states[OMAP3_STATE_C4].valid =
@@ -410,6 +414,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C4].desc = "MPU OFF + CORE ON";
 
 	/* C5 . MPU CSWR + Core CSWR*/
 	omap3_power_states[OMAP3_STATE_C5].valid =
@@ -425,6 +430,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C5].desc = "MPU RET + CORE RET";
 
 	/* C6 . MPU OFF + Core CSWR */
 	omap3_power_states[OMAP3_STATE_C6].valid =
@@ -440,6 +446,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C6].desc = "MPU OFF + CORE RET";
 
 	/* C7 . MPU OFF + Core OFF */
 	omap3_power_states[OMAP3_STATE_C7].valid =
@@ -455,6 +462,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+	omap3_power_states[OMAP3_STATE_C7].desc = "MPU OFF + CORE OFF";
 
 	/*
 	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
@@ -512,6 +520,7 @@ int __init omap3_idle_init(void)
 		if (cx->type == OMAP3_STATE_C1)
 			dev->safe_state = state;
 		sprintf(state->name, "C%d", count+1);
+		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		count++;
 	}
 
-- 
1.6.0.4


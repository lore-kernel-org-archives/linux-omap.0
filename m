From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/12] Adds support for CPUIdle safe state
Date: Mon, 1 Sep 2008 19:12:09 +0530 (IST)
Message-ID: <62933.192.168.10.89.1220276529.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47087 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbYIANmQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 09:42:16 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DgAfe000475
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:15 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m81Dg8Ql019712
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:09 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the support to move to a safe-state on bm activity

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |  152 +++++++++++++++++++-------------------
 1 files changed, 79 insertions(+), 73 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:25:25.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:27:10.000000000 +0530
@@ -139,25 +139,28 @@ static int omap3_enter_idle_bm(struct cp
 	int i, j;

 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
-
-		/* Find current state in list */
-		for (i = 0; i < OMAP3_MAX_STATES; i++)
-			if (state == &dev->states[i])
-				break;
-		BUG_ON(i == OMAP3_MAX_STATES);
-
-		/* Back up to non 'CHECK_BM' state */
-		for (j = i - 1;  j > 0; j--) {
-			struct cpuidle_state *s = &dev->states[j];
-
-			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
-				new_state = s;
-				break;
+		if (dev->safe_state) {
+			return dev->safe_state->enter(dev, dev->safe_state);
+		} else {
+			/* Find current state in list */
+			for (i = 0; i < OMAP3_MAX_STATES; i++)
+				if (state == &dev->states[i])
+					break;
+			BUG_ON(i == OMAP3_MAX_STATES);
+
+			/* Back up to non 'CHECK_BM' state */
+			for (j = i - 1;  j >= 0; j--) {
+				struct cpuidle_state *s = &dev->states[j];
+
+				if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
+					new_state = s;
+					break;
+				}
 			}
+			pr_debug("%s: Bus activity: Entering %s\
+				(instead of %s)\n", __func__,
+				 new_state->name, state->name);
 		}
-
-		pr_debug("%s: Bus activity: Entering %s (instead of %s)\n",
-			__func__, new_state->name, state->name);
 	}

 	return omap3_enter_idle(dev, new_state ? : state);
@@ -179,79 +182,79 @@ DEFINE_PER_CPU(struct cpuidle_device, om
 void omap_init_power_states(void)
 {
 	/* C0 . System executing code */
-	omap3_power_states[0].valid = 1;
-	omap3_power_states[0].type = OMAP3_STATE_C0;
-	omap3_power_states[0].sleep_latency = 0;
-	omap3_power_states[0].wakeup_latency = 0;
-	omap3_power_states[0].threshold = 0;
-	omap3_power_states[0].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[0].core_state = PWRDM_POWER_ON;
-	omap3_power_states[0].flags = CPUIDLE_FLAG_SHALLOW;
+	omap3_power_states[OMAP3_STATE_C0].valid = 1;
+	omap3_power_states[OMAP3_STATE_C0].type = OMAP3_STATE_C0;
+	omap3_power_states[OMAP3_STATE_C0].sleep_latency = 0;
+	omap3_power_states[OMAP3_STATE_C0].wakeup_latency = 0;
+	omap3_power_states[OMAP3_STATE_C0].threshold = 0;
+	omap3_power_states[OMAP3_STATE_C0].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].flags = CPUIDLE_FLAG_SHALLOW;

 	/* C1 . MPU WFI + Core active */
-	omap3_power_states[1].valid = 1;
-	omap3_power_states[1].type = OMAP3_STATE_C1;
-	omap3_power_states[1].sleep_latency = 10;
-	omap3_power_states[1].wakeup_latency = 10;
-	omap3_power_states[1].threshold = 30;
-	omap3_power_states[1].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[1].core_state = PWRDM_POWER_ON;
-	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C1].valid = 1;
+	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
+	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 10;
+	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 10;
+	omap3_power_states[OMAP3_STATE_C1].threshold = 30;
+	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID |
 						CPUIDLE_FLAG_SHALLOW;

 	/* C2 . MPU CSWR + Core active */
-	omap3_power_states[2].valid = 1;
-	omap3_power_states[2].type = OMAP3_STATE_C2;
-	omap3_power_states[2].sleep_latency = 50;
-	omap3_power_states[2].wakeup_latency = 50;
-	omap3_power_states[2].threshold = 300;
-	omap3_power_states[2].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C2].valid = 1;
+	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
+	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 50;
+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 50;
+	omap3_power_states[OMAP3_STATE_C2].threshold = 300;
+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
 						CPUIDLE_FLAG_BALANCED;

 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[3].valid = 1;
-	omap3_power_states[3].type = OMAP3_STATE_C3;
-	omap3_power_states[3].sleep_latency = 1500;
-	omap3_power_states[3].wakeup_latency = 1800;
-	omap3_power_states[3].threshold = 4000;
-	omap3_power_states[3].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[3].core_state = PWRDM_POWER_ON;
-	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C3].valid = 1;
+	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
+	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
+	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
+	omap3_power_states[OMAP3_STATE_C3].threshold = 4000;
+	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_BALANCED;

 	/* C4 . MPU CSWR + Core CSWR*/
-	omap3_power_states[4].valid = 1;
-	omap3_power_states[4].type = OMAP3_STATE_C4;
-	omap3_power_states[4].sleep_latency = 2500;
-	omap3_power_states[4].wakeup_latency = 7500;
-	omap3_power_states[4].threshold = 12000;
-	omap3_power_states[4].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[4].core_state = PWRDM_POWER_RET;
-	omap3_power_states[4].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C4].valid = 1;
+	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
+	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
+	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
+	omap3_power_states[OMAP3_STATE_C4].threshold = 12000;
+	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[5].valid = 1;
-	omap3_power_states[5].type = OMAP3_STATE_C5;
-	omap3_power_states[5].sleep_latency = 3000;
-	omap3_power_states[5].wakeup_latency = 8500;
-	omap3_power_states[5].threshold = 15000;
-	omap3_power_states[5].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[5].core_state = PWRDM_POWER_RET;
-	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C5].valid = 1;
+	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
+	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
+	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
+	omap3_power_states[OMAP3_STATE_C5].threshold = 15000;
+	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C6 . MPU OFF + Core OFF */
-	omap3_power_states[6].valid = 0;
-	omap3_power_states[6].type = OMAP3_STATE_C6;
-	omap3_power_states[6].sleep_latency = 10000;
-	omap3_power_states[6].wakeup_latency = 30000;
-	omap3_power_states[6].threshold = 300000;
-	omap3_power_states[6].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].core_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID |
+	omap3_power_states[OMAP3_STATE_C6].valid = 0;
+	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
+	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
+	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
+	omap3_power_states[OMAP3_STATE_C6].threshold = 300000;
+	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
 			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
 }

@@ -269,6 +272,7 @@ int omap3_idle_init(void)
 	struct omap3_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;
+	char clk_name[11];

 	omap3_clear_scratchpad_contents();
 	omap3_save_scratchpad_contents();
@@ -290,6 +294,8 @@ int omap3_idle_init(void)
 		state->flags = cx->flags;
 		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
 			omap3_enter_idle_bm : omap3_enter_idle;
+		if (cx->type == OMAP3_STATE_C1)
+			dev->safe_state = state;
 		sprintf(state->name, "C%d", count+1);
 		count++;
 	}



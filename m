From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/05] OMAP3: Safe-state on bm-activity
Date: Wed, 8 Oct 2008 17:31:37 +0530
Message-ID: <001a01c9293d$9e274f50$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbYJHMBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 08:01:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the support to move to a safe-state on bm activity

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   29 +++++------------------------
 1 files changed, 5 insertions(+), 24 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:52:43.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:53:11.000000000 +0530
@@ -116,32 +116,11 @@ return_sleep_time :
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
-	struct cpuidle_state *new_state = NULL;
-	int i, j;
-
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
-			}
-		}
-
-		pr_debug("%s: Bus activity: Entering %s (instead of %s)\n",
-			__func__, new_state->name, state->name);
+		if (dev->safe_state)
+			return dev->safe_state->enter(dev, dev->safe_state);
 	}
-
-	return omap3_enter_idle(dev, new_state ? : state);
+	return omap3_enter_idle(dev, state);
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
@@ -260,6 +239,8 @@ int omap3_idle_init(void)
 		state->flags = cx->flags;
 		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
 			omap3_enter_idle_bm : omap3_enter_idle;
+		if (cx->type == OMAP3_STATE_C1)
+			dev->safe_state = state;
 		sprintf(state->name, "C%d", count+1);
 		count++;
 	}


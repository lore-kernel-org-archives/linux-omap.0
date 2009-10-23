From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/10] OMAP3: PM: CPUidle: check activity for C2, C3, correct accounting
Date: Fri, 23 Oct 2009 09:59:02 -0700
Message-ID: <1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbZJWQ7W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:59:22 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1391355qwb.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 09:59:27 -0700 (PDT)
In-Reply-To: <1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Use the activity check for states C2 and C3 as well.  This is
primarily to prevent deeper states during UART activity.

Also, if a different state is chosen than the target state, update the
'last_state' accordingly so that CPUidle state accounting is coorect.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1120494..b0bee34 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,6 +28,7 @@
 #include <plat/powerdomain.h>
 #include <plat/irqs.h>
 #include <plat/control.h>
+#include <plat/serial.h>
 
 #include "pm.h"
 
@@ -124,11 +125,15 @@ return_sleep_time:
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
+	struct cpuidle_state *new_state = state;
+
 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
-		if (dev->safe_state)
-			return dev->safe_state->enter(dev, dev->safe_state);
+		BUG_ON(!dev->safe_state);
+		new_state = dev->safe_state;
 	}
-	return omap3_enter_idle(dev, state);
+
+	dev->last_state = new_state;
+	return omap3_enter_idle(dev, new_state);
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
@@ -163,7 +168,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].threshold = 300;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C3 . MPU OFF + Core active */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
@@ -173,7 +179,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].threshold = 4000;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C4 . MPU CSWR + Core CSWR*/
 	omap3_power_states[OMAP3_STATE_C4].valid = 1;
@@ -198,7 +205,7 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core OFF */
-	omap3_power_states[OMAP3_STATE_C6].valid = 0;
+	omap3_power_states[OMAP3_STATE_C6].valid = 1;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
 	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
-- 
1.6.4.3


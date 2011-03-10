From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 17/19] OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
Date: Thu, 10 Mar 2011 19:38:13 +0530
Message-ID: <1299766095-23879-18-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40522 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab1CJOIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:37 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

CPU local timer(TWD) stops when the CPU is transitioning into
deeper C-States. Since these timers are not wakeup capable, we
need the wakeup capable global timer to program the wakeup time
depending on the next timer expiry.

It can be handled by registering a global wakeup capable timer along
with local timers marked with (mis)feature flag CLOCK_EVT_FEAT_C3STOP.
Then notify the clock events layer from idle code using
CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT).

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 19a405c..daf41e1 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -12,6 +12,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/clockchips.h>
 
 #include <asm/proc-fns.h>
 
@@ -85,6 +86,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	struct omap4_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
+	int cpu_id = smp_processor_id();
 
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
@@ -111,8 +113,14 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	pwrdm_set_logic_retst(core_pd, cx->core_logic_state);
 	omap_set_pwrdm_state(core_pd, cx->core_state);
 
+	if (cx->type > OMAP4_STATE_C1)
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+
 	omap4_enter_lowpower(dev->cpu, cx->cpu0_state);
 
+	if (cx->type > OMAP4_STATE_C1)
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-- 
1.6.0.4


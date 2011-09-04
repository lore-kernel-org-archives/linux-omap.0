From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 24/25] OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
Date: Sun, 4 Sep 2011 19:24:25 +0530
Message-ID: <1315144466-9395-25-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36818 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab1IDN4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:17 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

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
index c9c6f43..e0140d6 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
 
 #include <asm/proc-fns.h>
 
@@ -60,6 +61,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	struct omap4_idle_statedata *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
+	int cpu_id = smp_processor_id();
 
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
@@ -81,6 +83,9 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 		cx = cpuidle_get_statedata(dev->safe_state);
 	}
 
+	if (state > &dev->states[0])
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+
 	/* Call idle CPU PM enter notifier chain */
 	if (cx->cpu_state == PWRDM_POWER_OFF)
 		cpu_pm_enter();
@@ -103,6 +108,9 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
+	if (state > &dev->states[0])
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-- 
1.7.4.1


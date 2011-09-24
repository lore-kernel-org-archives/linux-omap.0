From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 22/24] OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
Date: Sat, 24 Sep 2011 11:44:42 +0530
Message-ID: <1316844884-21700-23-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab1IXGPV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:21 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

CPU local timer(TWD) stops when the CPU is transitioning into
deeper C-States. Since these timers are not wakeup capable, we
need the wakeup capable global timer to program the wakeup time
depending on the next timer expiry.

It can be handled by registering a global wakeup capable timer along
with local timers marked with (mis)feature flag CLOCK_EVT_FEAT_C3STOP.
Then notify the clock events layer from idle code using
CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT).

ARM local timers are already marked with C3STOP feature. Add the
notifiers to OMAP4 CPU idle code for the broadcast entry and exit.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index ac8f4c0..f0cd214 100644
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
 	/*
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
@@ -116,6 +121,9 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
+	if (state > &dev->states[0])
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-- 
1.7.4.1


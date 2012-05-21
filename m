From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 1/4] ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
Date: Mon, 21 May 2012 13:02:36 +0530
Message-ID: <1337585559-20250-2-git-send-email-santosh.shilimkar@ti.com>
References: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2EUHcv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 03:32:51 -0400
In-Reply-To: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ccross@android.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

For coupled cpuidle to work when both cpus are active, it needs a global timer
that can handle events for both cpus.  This timer is used as the broadcast
clock-event when the per-cpu timer hardware stop in low power states.
Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
set the irq to allow the clockevent core to determine the affinity of the
timer.

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c512bac..4212f2f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -135,6 +135,7 @@ static struct clock_event_device clockevent_gpt = {
 	.name		= "gp timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
+	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
 	.set_mode	= omap2_gp_timer_set_mode,
 };
@@ -226,7 +227,8 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 		clockevent_delta2ns(3, &clockevent_gpt);
 		/* Timer internal resynch latency. */
 
-	clockevent_gpt.cpumask = cpumask_of(0);
+	clockevent_gpt.cpumask = cpu_possible_mask;
+	clockevent_gpt.irq = omap_dm_timer_get_irq(&clkev);
 	clockevents_register_device(&clockevent_gpt);
 
 	pr_info("OMAP clockevent source: GPTIMER%d at %lu Hz\n",
-- 
1.7.5.4


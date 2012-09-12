From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH] ARM: OMAP: counter: add locking to read_persistent_clock
Date: Wed, 12 Sep 2012 11:23:02 +0530
Message-ID: <1347429182-10956-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41139 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2ILFxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 01:53:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, Colin Cross <ccross@android.com>

From: Colin Cross <ccross@android.com>

read_persistent_clock uses a global variable, use a spinlock to
ensure non-atomic updates to the variable don't overlap and cause
time to move backwards.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/plat-omap/counter_32k.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index dbf1e03..2bc51fb 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -55,22 +55,29 @@ static u32 notrace omap_32k_read_sched_clock(void)
  * nsecs and adds to a monotonically increasing timespec.
  */
 static struct timespec persistent_ts;
-static cycles_t cycles, last_cycles;
+static cycles_t cycles;
 static unsigned int persistent_mult, persistent_shift;
+static DEFINE_SPINLOCK(read_persistent_clock_lock);
+
 static void omap_read_persistent_clock(struct timespec *ts)
 {
 	unsigned long long nsecs;
-	cycles_t delta;
-	struct timespec *tsp = &persistent_ts;
+	cycles_t last_cycles;
+	unsigned long flags;
+
+	spin_lock_irqsave(&read_persistent_clock_lock, flags);
 
 	last_cycles = cycles;
 	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
-	delta = cycles - last_cycles;
 
-	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
+	nsecs = clocksource_cyc2ns(cycles - last_cycles,
+					persistent_mult, persistent_shift);
+
+	timespec_add_ns(&persistent_ts, nsecs);
+
+	*ts = persistent_ts;
 
-	timespec_add_ns(tsp, nsecs);
-	*ts = *tsp;
+	spin_unlock_irqrestore(&read_persistent_clock_lock, flags);
 }
 
 /**
-- 
1.7.9.5


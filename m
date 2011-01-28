From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH] nohz/sched: delay going tickless when CPU is loaded
Date: Fri, 28 Jan 2011 13:03:16 -0800
Message-ID: <1296248596-22478-1-git-send-email-khilman@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Nicole Chalhoub <n-chalhoub@ti.com>, Vincent Bour <v-bour@ti.com>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Nicole Chalhoub <n-chalhoub@ti.com>

One criterion of C-states selection is based on the load factor.  High
load prevents deep C-states.  The load is evaluated and updated at
each scheduler tick, and thus not updated when in tickless mode.  As a
result, the CPU load calculated on the tick just before entering
tickless is used for idle decisions.

When a high load is evaluated on a tick happening on a burst of
activity, this load value is kept until the next tick, which could
take few ms to happen if going tickless.

This patch ensures that the load is taken into consideration before
going tickless.  Rather than going tickless and entering a shallow
sleep state, the decison to go tickless is slightly delayed so that
the idle governor will tend to favor deeper sleep states.

Delaying NOHZ decisions until the load is zero improved the load
estimation on our ARM/OMAP4 platform where HZ =128 and increased the
time spent in deep C-states (~50% of idle time in C-states deeper than
C1).  A power saving of ~20mA at battery level is observed during MP3
playback on OMAP4/Blaze board.

Signed-off-by: Nicole Chalhoub <n-chalhoub@ti.com>
Signed-off-by: Vincent Bour <v-bour@ti.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
[khilman@ti.com: minor edits/changes to changelog]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v2.6.38-rc2

 kernel/time/tick-sched.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e216e0..96cb512 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -325,7 +325,7 @@ void tick_nohz_stop_sched_tick(int inidle)
 	} while (read_seqretry(&xtime_lock, seq));
 
 	if (rcu_needs_cpu(cpu) || printk_needs_cpu(cpu) ||
-	    arch_needs_cpu(cpu)) {
+	    arch_needs_cpu(cpu) || this_cpu_load()) {
 		next_jiffies = last_jiffies + 1;
 		delta_jiffies = 1;
 	} else {
-- 
1.7.3.5

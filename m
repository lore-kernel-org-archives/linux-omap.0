From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RFC PATCH V6 2/4] cpuidle: Remove CPUIDLE_FLAG_IGNORE and
 dev->prepare()
Date: Thu, 22 Sep 2011 14:01:20 +0530
Message-ID: <20110922083110.10520.37389.stgit@localhost6.localdomain6>
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Sender: linux-sh-owner@vger.kernel.org
To: khilman@ti.com, venki@google.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, santosh.shilimkar@ti.com, arjan@linux.intel.com, lenb@kernel.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The cpuidle_device->prepare() mechanism causes updates to the
cpuidle_state[].flags, setting and clearing CPUIDLE_FLAG_IGNORE
to tell the governor not to chose a state on a per-cpu basis at
run-time. State demotion is now handled by the driver and it returns
the actual state entered. Hence, this mechanism is not required.
Also this removes per-cpu flags from cpuidle_state enabling
it to be made global.

Ref: https://lkml.org/lkml/2011/3/25/52

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
---
 drivers/cpuidle/cpuidle.c        |   10 ----------
 drivers/cpuidle/governors/menu.c |    2 --
 include/linux/cpuidle.h          |    3 ---
 3 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 88bd121..f66bcf9 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -83,16 +83,6 @@ int cpuidle_idle_call(void)
 	hrtimer_peek_ahead_timers();
 #endif
 
-	/*
-	 * Call the device's prepare function before calling the
-	 * governor's select function.  ->prepare gives the device's
-	 * cpuidle driver a chance to update any dynamic information
-	 * of its cpuidle states for the current idle period, e.g.
-	 * state availability, latencies, residencies, etc.
-	 */
-	if (dev->prepare)
-		dev->prepare(dev);
-
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(dev);
 	if (need_resched()) {
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e4b200c..af724e8 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -288,8 +288,6 @@ static int menu_select(struct cpuidle_device *dev)
 	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
 		struct cpuidle_state *s = &dev->states[i];
 
-		if (s->flags & CPUIDLE_FLAG_IGNORE)
-			continue;
 		if (s->target_residency > data->predicted_us)
 			continue;
 		if (s->exit_latency > latency_req)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8da811b..c6d85cf 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -47,7 +47,6 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
-#define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
@@ -93,8 +92,6 @@ struct cpuidle_device {
 	struct completion	kobj_unregister;
 	void			*governor_data;
 	int			safe_state_index;
-
-	int (*prepare)		(struct cpuidle_device *dev);
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);


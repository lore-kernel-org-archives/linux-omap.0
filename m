From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4: CPUidle: add synchronization for coupled idle states
Date: Fri, 30 Mar 2012 18:57:28 +0530
Message-ID: <1333114048-26136-4-git-send-email-santosh.shilimkar@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760804Ab2C3N1m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 09:27:42 -0400
In-Reply-To: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, ccross@android.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Kevin Hilman <khilman@ti.com>

With coupled idle states, a failure for any CPU to hit a low power
state must be coordinated such that all CPUs abort.

On OMAP4, when entering a coupled state, CPU0 has to wait for CPU1 to
enter its low power state before it can enter its low power state.

This is implemented by letting CPU0 wait for the CPU1 powerdomain to
hit off.  However, there are conditions where CPU1 might abort/fail
and not hit off while CPU0 is waiting for it.  For example, a CPU1
wakeup or a failed attempt to hit off due to hardware conditions.

To avoid the deadlock where CPU0 would continually wait for CPU1 to
hit off-mode, this patch adds a flag to signal when each CPU has come
out of its low-power state.  CPU0 then checks whether CPU1 has hit off
*or* has already completed its attempt to hit off.  If the latter,
CPU0 must abort its attempt to hit a low-power state so the coupled
state enter method can return.

In addition, cpuidle_coupled_parallel_barrier() is used to ensure the
clearing of the 'done' flag is synchronized on all CPUs.

Cc: Colin Cross <ccross@android.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 5724393..fcf6653 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -48,6 +48,9 @@ struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
 static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
 static struct clockdomain *cpu_clkdm[NR_CPUS];
 
+static atomic_t abort_barrier;
+static bool cpu_done[NR_CPUS];
+
 /**
  * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
  * @dev: cpuidle device
@@ -88,8 +91,20 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	 * out of coherency and in OFF mode.
 	 */
 	if (dev->cpu == 0) {
-		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF)
+		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF) {
 			cpu_relax();
+
+			/*
+			 * CPU1 could have already entered & exited idle
+			 * without hitting off because of a wakeup
+			 * or a failed attempt to hit off mode.  Check for
+			 * that here, otherwise we could spin forever
+			 * waiting for CPU1 off.
+			 */
+			if (cpu_done[1])
+			    goto fail;
+
+		}
 	}
 
 	/*
@@ -113,6 +128,7 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	}
 
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+	cpu_done[dev->cpu] = true;
 
 	if (dev->cpu == 0) {
 		/* Wakeup CPU1 only if it is not offlined */
@@ -137,6 +153,10 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
+fail:
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+	cpu_done[dev->cpu] = false;
+
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
 
 	local_fiq_enable();
-- 
1.7.5.4


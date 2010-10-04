From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/4] perf: add OMAP support for the new power events
Date: Mon,  4 Oct 2010 17:20:59 +0200
Message-ID: <1286205661-24448-3-git-send-email-jean.pihet@newoldbits.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Jean Pihet <jean.pihet@newoldbits.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch adds the new power management trace points for
the OMAP architecture.

The trace points are for cpuidle, cpufreq (DVFS), the clocks
changes (enable, disable, set_rate) and the power domains
transitions.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 +++
 arch/arm/mach-omap2/pm34xx.c      |    5 +++++
 arch/arm/mach-omap2/powerdomain.c |    3 +++
 arch/arm/plat-omap/clock.c        |   13 ++++++++++---
 arch/arm/plat-omap/cpu-omap.c     |    2 ++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 3d3d035..96a6f38 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <trace/events/power.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
@@ -130,6 +131,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
+	trace_processor_idle(cx->type, smp_processor_id());
+
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b03426..4b5383f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>
 
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -557,6 +558,8 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending() || need_resched())
 		goto out;
 
+	trace_processor_idle(1, smp_processor_id());
+
 	omap_sram_idle();
 
 out:
@@ -623,6 +626,8 @@ restore:
 			printk(KERN_INFO "Powerdomain (%s) didn't enter "
 			       "target state %d\n",
 			       pwrst->pwrdm->name, pwrst->next_state);
+			trace_power_domain_missed(pwrst->pwrdm->name,
+						  state, smp_processor_id());
 			ret = -1;
 		}
 		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6527ec3..73cbe9a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <trace/events/power.h>
 
 #include <asm/atomic.h>
 
@@ -440,6 +441,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
+	trace_power_domain_target(pwrdm->name, pwrst, smp_processor_id());
+
 	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 			     (pwrst << OMAP_POWERSTATE_SHIFT),
 			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 7190cbd..d6518f5 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -21,6 +21,7 @@
 #include <linux/cpufreq.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
+#include <trace/events/power.h>
 
 #include <plat/clock.h>
 
@@ -43,8 +44,10 @@ int clk_enable(struct clk *clk)
 		return -EINVAL;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_enable)
+	if (arch_clock->clk_enable) {
+		trace_clock_enable(clk->name, 1, smp_processor_id());
 		ret = arch_clock->clk_enable(clk);
+	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -66,8 +69,10 @@ void clk_disable(struct clk *clk)
 		goto out;
 	}
 
-	if (arch_clock->clk_disable)
+	if (arch_clock->clk_disable) {
+		trace_clock_disable(clk->name, 0, smp_processor_id());
 		arch_clock->clk_disable(clk);
+	}
 
 out:
 	spin_unlock_irqrestore(&clockfw_lock, flags);
@@ -120,8 +125,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		return ret;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_set_rate)
+	if (arch_clock->clk_set_rate) {
+		trace_clock_set_rate(clk->name, rate, smp_processor_id());
 		ret = arch_clock->clk_set_rate(clk, rate);
+	}
 	if (ret == 0) {
 		if (clk->recalc)
 			clk->rate = clk->recalc(clk);
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 6d3d333..19d5a6c 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <trace/events/power.h>
 
 #include <mach/hardware.h>
 #include <plat/clock.h>
@@ -95,6 +96,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
 	       freqs.old, freqs.new);
 #endif
+	trace_processor_frequency(freqs.new, freqs.cpu);
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
-- 
1.7.1


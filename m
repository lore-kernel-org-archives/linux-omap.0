From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 5/6] smp_twd: Reconfigure clockevents after cpufreq change
Date: Tue, 13 Dec 2011 20:31:27 -0800
Message-ID: <1323837088-2469-6-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45491 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832Ab1LNEet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:34:49 -0500
Received: by mail-yw0-f41.google.com with SMTP id o21so991479yho.28
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:34:48 -0800 (PST)
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

From: Linus Walleij <(address hidden)>

The localtimer's clock changes with the cpu clock. After a
cpufreq transition, update the clockevent's frequency and
reprogram the next clock event.

Adds a clock called "smp_twd" that is used to determine the
twd frequency, which can also be used at init time to
avoid calibrating the twd frequency.

Clock changes are based on Rob Herring's work. The
necessary changes in the clockevents framework was done by
Thomas Gleixner in kernel v3.0.

Signed-off-by: Colin Cross <(address hidden)>
Cc: Russell King <(address hidden)>
Acked-by: Thomas Gleixner <(address hidden)>
Acked-by: Rob Herring <(address hidden)>
Acked-by: Santosh Shilimkar <(address hidden)>
[ifdef:ed CPUfreq stuff for non-cpufreq configs]
Signed-off-by: Linus Walleij <(address hidden)>
---
 arch/arm/kernel/smp_twd.c |   89 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a8a6682..92dbd80 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -10,13 +10,17 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/smp.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/percpu.h>
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
@@ -25,7 +29,9 @@
 /* set up by the platform code */
 void __iomem *twd_base;
 
+static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
+static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
 
 static struct clock_event_device __percpu **twd_evt;
 
@@ -89,6 +95,52 @@ void twd_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(clk->irq);
 }
 
+#ifdef CONFIG_CPU_FREQ
+
+/*
+ * Updates clockevent frequency when the cpu frequency changes.
+ * Called on the cpu that is changing frequency with interrupts disabled.
+ */
+static void twd_update_frequency(void *data)
+{
+	twd_timer_rate = clk_get_rate(twd_clk);
+
+	clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
+}
+
+static int twd_cpufreq_transition(struct notifier_block *nb,
+	unsigned long state, void *data)
+{
+	struct cpufreq_freqs *freqs = data;
+
+	/*
+	 * The twd clock events must be reprogrammed to account for the new
+	 * frequency.  The timer is local to a cpu, so cross-call to the
+	 * changing cpu.
+	 */
+	if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
+		smp_call_function_single(freqs->cpu, twd_update_frequency,
+			NULL, 1);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block twd_cpufreq_nb = {
+	.notifier_call = twd_cpufreq_transition,
+};
+
+static int twd_cpufreq_init(void)
+{
+	if (!IS_ERR_OR_NULL(twd_clk))
+		return cpufreq_register_notifier(&twd_cpufreq_nb,
+			CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+core_initcall(twd_cpufreq_init);
+
+#endif
+
 static void __cpuinit twd_calibrate_rate(void)
 {
 	unsigned long count;
@@ -140,6 +192,27 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static struct clk *twd_get_clock(void)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_get_sys("smp_twd", NULL);
+	if (IS_ERR(clk)) {
+		pr_err("smp_twd: clock not found: %d\n", (int)PTR_ERR(clk));
+		return clk;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("smp_twd: clock failed to enable: %d\n", err);
+		clk_put(clk);
+		return ERR_PTR(err);
+	}
+
+	return clk;
+}
+
 /*
  * Setup the local clock events for a CPU.
  */
@@ -165,7 +238,13 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		}
 	}
 
-	twd_calibrate_rate();
+	if (!twd_clk)
+		twd_clk = twd_get_clock();
+
+	if (!IS_ERR_OR_NULL(twd_clk))
+		twd_timer_rate = clk_get_rate(twd_clk);
+	else
+		twd_calibrate_rate();
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
@@ -173,15 +252,13 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
-	clk->shift = 20;
-	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
-	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
-	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
 	*this_cpu_clk = clk;
 
-	clockevents_register_device(clk);
+	__get_cpu_var(twd_ce) = clk;
 
+	clockevents_config_and_register(clk, twd_timer_rate,
+					0xf, 0xffffffff);
 	enable_percpu_irq(clk->irq, 0);
 }
-- 
1.7.5.4


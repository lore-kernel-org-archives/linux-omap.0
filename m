From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 6/6] HACK: arm: reprogram twd based on clk notifier
Date: Tue, 13 Dec 2011 20:31:28 -0800
Message-ID: <1323837088-2469-7-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43318 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755720Ab1LNEex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:34:53 -0500
Received: by ghrr14 with SMTP id r14so361464ghr.40
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:34:52 -0800 (PST)
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

From: Mike Turquette <mturquette@linaro.org>

As a proof-of-concept, convert the existing smp_twd code to use clk
notifiers in place of CPUfreq notifiers.  This works out nicely for
Cortex-A9 MPcore designs that scale all CPUs at the same frequency.  For
chips which can scale frequency independently this change makes less
sense. (but I don't know how they were doing it in the first place...)

The primary purpose behind this change is to test the new clk notifier
code.  If you find it useful beyond that, please let me know!

Not-signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/kernel/smp_twd.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 92dbd80..8bdbaad 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -95,51 +94,45 @@ void twd_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(clk->irq);
 }
 
-#ifdef CONFIG_CPU_FREQ
-
 /*
  * Updates clockevent frequency when the cpu frequency changes.
  * Called on the cpu that is changing frequency with interrupts disabled.
  */
-static void twd_update_frequency(void *data)
+static void twd_update_frequency(void *new_rate)
 {
-	twd_timer_rate = clk_get_rate(twd_clk);
+	unsigned long *rate = new_rate;
 
-	clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
+	clockevents_update_freq(__get_cpu_var(twd_ce), *rate/1000);
 }
 
-static int twd_cpufreq_transition(struct notifier_block *nb,
-	unsigned long state, void *data)
+static int twd_rate_change(struct notifier_block *nb,
+	unsigned long flags, void *data)
 {
-	struct cpufreq_freqs *freqs = data;
+	struct clk_notifier_data *cnd = data;
 
 	/*
 	 * The twd clock events must be reprogrammed to account for the new
 	 * frequency.  The timer is local to a cpu, so cross-call to the
 	 * changing cpu.
 	 */
-	if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
-		smp_call_function_single(freqs->cpu, twd_update_frequency,
-			NULL, 1);
+	if (flags == POST_RATE_CHANGE)
+		smp_call_function(twd_update_frequency, (void *)&cnd->new_rate, 1);
 
 	return NOTIFY_OK;
 }
 
-static struct notifier_block twd_cpufreq_nb = {
-	.notifier_call = twd_cpufreq_transition,
+static struct notifier_block twd_clk_nb = {
+	.notifier_call = twd_rate_change,
 };
 
-static int twd_cpufreq_init(void)
+static int twd_clk_init(void)
 {
 	if (!IS_ERR_OR_NULL(twd_clk))
-		return cpufreq_register_notifier(&twd_cpufreq_nb,
-			CPUFREQ_TRANSITION_NOTIFIER);
+		return clk_notifier_register(twd_clk, &twd_clk_nb);
 
 	return 0;
 }
-core_initcall(twd_cpufreq_init);
-
-#endif
+core_initcall(twd_clk_init);
 
 static void __cpuinit twd_calibrate_rate(void)
 {
@@ -203,6 +196,13 @@ static struct clk *twd_get_clock(void)
 		return clk;
 	}
 
+	err = clk_prepare(clk);
+	if (err) {
+		pr_err("smp_twd: clock failed to prepare: %d\n", err);
+		clk_put(clk);
+		return ERR_PTR(err);
+	}
+
 	err = clk_enable(clk);
 	if (err) {
 		pr_err("smp_twd: clock failed to enable: %d\n", err);
-- 
1.7.5.4


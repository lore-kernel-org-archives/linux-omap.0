From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 18:25:51 +0200
Message-ID: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Now the System stall is observed on TI AM437x based board
(am437x-gp-evm) during resuming from System suspend when ARM Global
timer is selected as clocksource device - SysRq are working, but
nothing else. The reason of stall is that ARM Global timer loses its
contexts.

The reason of stall is that ARM Global timer loses its contexts during
System suspend:
   GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
   GT_COUNTERx = 0

Hence, update ARM Global timer driver to reflect above behaviour
- save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
- ensure clocksource and clockevent devices have coresponding flags
  (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
  depending on presence of "always-on" DT property.

CC: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fa..1bbaf64 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -51,6 +51,8 @@ static void __iomem *gt_base;
 static unsigned long gt_clk_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
+static bool gt_always_on;
+static u32 gt_control;
 
 /*
  * To get the value from the Global Timer Counter register proceed as follows:
@@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
 {
 	int cpu = smp_processor_id();
 
+	if (!gt_always_on)
+		clk->features |= CLOCK_EVT_FEAT_C3STOP;
+
 	clk->name = "arm_global_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 		CLOCK_EVT_FEAT_PERCPU;
@@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
 	return gt_counter_read();
 }
 
+static void gt_suspend(struct clocksource *cs)
+{
+	gt_control = readl(gt_base + GT_CONTROL);
+}
+
+static void gt_resume(struct clocksource *cs)
+{
+	/* enables timer on all the cores */
+	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+}
+
 static struct clocksource gt_clocksource = {
 	.name	= "arm_global_timer",
 	.rating	= 300,
 	.read	= gt_clocksource_read,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend = gt_suspend,
+	.resume = gt_resume,
 };
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
@@ -218,6 +236,9 @@ static void __init gt_clocksource_init(void)
 	/* enables timer on all the cores */
 	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
+	if (gt_always_on)
+		gt_clocksource.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
 #endif
@@ -289,6 +310,8 @@ static void __init global_timer_of_register(struct device_node *np)
 		goto out_clk;
 	}
 
+	gt_always_on = of_property_read_bool(np, "always-on");
+
 	err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
 				 "gt", gt_evt);
 	if (err) {
-- 
2.6.3

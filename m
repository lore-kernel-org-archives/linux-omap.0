From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4] clocksource: arm_global_timer: fix suspend resume
Date: Mon, 30 Nov 2015 20:25:12 +0200
Message-ID: <1448907912-15512-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

Now the System stall is observed on TI AM437x based board
(am437x-gp-evm) during resuming from System suspend when ARM Global
timer is selected as clocksource device (CPUIdle not enabled) - SysRq are working,
but nothing else.

The reason of stall is that ARM Global timer loses its contexts during
System suspend:
   GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
   GT_COUNTERx = 0

Hence, update ARM Global timer driver to reflect above behaviour
- re-enable ARM Global timer on resume (GT_CONTROL.TIMER_ENABLE = 1)
  if not enabled.

CC: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v4:
 - check current timer's state before enabling.
Changes in v3:
 - dropped all DT specific code
Changes in v2:
 - suspend/resume simplified: nothing is stored any more and
   ARM GT just re-enabled
Links on prev versions:
v3: https://lkml.org/lkml/2015/11/27/402
v2: https://lkml.org/lkml/2015/11/20/355
v1: https://lkml.org/lkml/2015/11/13/456

 drivers/clocksource/arm_global_timer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fa..817a787 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,12 +195,23 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
 	return gt_counter_read();
 }
 
+static void gt_resume(struct clocksource *cs)
+{
+	unsigned long ctrl;
+
+	ctrl = readl(gt_base + GT_CONTROL);
+	if (!(ctrl & GT_CONTROL_TIMER_ENABLE))
+		/* re-enable timer on resume */
+		writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+}
+
 static struct clocksource gt_clocksource = {
 	.name	= "arm_global_timer",
 	.rating	= 300,
 	.read	= gt_clocksource_read,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.resume = gt_resume,
 };
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.6.3

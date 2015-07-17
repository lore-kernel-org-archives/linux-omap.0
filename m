From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/18] ARM/omap2/timer: Migrate to new 'set-state' interface
Date: Fri, 17 Jul 2015 10:41:08 +0530
Message-ID: <74364615a643f65b6de9faa4112365e4880c7047.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, olof@lixom.net
Cc: linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Migrate omap2 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-omap2/timer.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cac46d852da1..16b37e7196f5 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -102,38 +102,38 @@ static int omap2_gp_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+static int omap2_gp_timer_shutdown(struct clock_event_device *evt)
+{
+	__omap_dm_timer_stop(&clkev, OMAP_TIMER_POSTED, clkev.rate);
+	return 0;
+}
+
+static int omap2_gp_timer_set_periodic(struct clock_event_device *evt)
 {
 	u32 period;
 
 	__omap_dm_timer_stop(&clkev, OMAP_TIMER_POSTED, clkev.rate);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		period = clkev.rate / HZ;
-		period -= 1;
-		/* Looks like we need to first set the load value separately */
-		__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG,
-				      0xffffffff - period, OMAP_TIMER_POSTED);
-		__omap_dm_timer_load_start(&clkev,
-					OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
-					0xffffffff - period, OMAP_TIMER_POSTED);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	period = clkev.rate / HZ;
+	period -= 1;
+	/* Looks like we need to first set the load value separately */
+	__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG, 0xffffffff - period,
+			      OMAP_TIMER_POSTED);
+	__omap_dm_timer_load_start(&clkev,
+				   OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
+				   0xffffffff - period, OMAP_TIMER_POSTED);
+	return 0;
 }
 
 static struct clock_event_device clockevent_gpt = {
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 300,
-	.set_next_event	= omap2_gp_timer_set_next_event,
-	.set_mode	= omap2_gp_timer_set_mode,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 300,
+	.set_next_event		= omap2_gp_timer_set_next_event,
+	.set_state_shutdown	= omap2_gp_timer_shutdown,
+	.set_state_periodic	= omap2_gp_timer_set_periodic,
+	.set_state_oneshot	= omap2_gp_timer_shutdown,
+	.tick_resume		= omap2_gp_timer_shutdown,
 };
 
 static struct property device_disabled = {
-- 
2.4.0

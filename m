From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/8] ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
Date: Tue, 28 Mar 2017 20:57:55 -0500
Message-ID: <20170329015801.22240-3-d-gerlach@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329015801.22240-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP timer code registers two timers - one as clocksource
and one as clockevent. Since AM33XX has only one usable timer
in the WKUP domain one of the timers needs suspend-resume
support to restore the configuration to pre-suspend state.

commit adc78e6b9946 ("timekeeping: Add suspend and resume
of clock event devices") introduced .suspend and .resume
callbacks for clock event devices. Leverage these
callbacks to have AM33XX clockevent timer behave properly
across system suspend. Extend the use of the .suspend and
.resume callbacks used by am335x clockevent to am437x as well.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692c4737..70670dfd7135 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -68,6 +68,9 @@
 static struct omap_dm_timer clkev;
 static struct clock_event_device clockevent_gpt;
 
+/* Clockevent hwmod for am335x and am437x suspend */
+static struct omap_hwmod *clockevent_gpt_hwmod;
+
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 static unsigned long arch_timer_freq;
 
@@ -125,6 +128,23 @@ static int omap2_gp_timer_set_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
+static void omap_clkevt_idle(struct clock_event_device *unused)
+{
+	if (!clockevent_gpt_hwmod)
+		return;
+
+	omap_hwmod_idle(clockevent_gpt_hwmod);
+}
+
+static void omap_clkevt_unidle(struct clock_event_device *unused)
+{
+	if (!clockevent_gpt_hwmod)
+		return;
+
+	omap_hwmod_enable(clockevent_gpt_hwmod);
+	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
+}
+
 static struct clock_event_device clockevent_gpt = {
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT,
@@ -358,6 +378,14 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 					3, /* Timer internal resynch latency */
 					0xffffffff);
 
+	if (soc_is_am33xx() || soc_is_am43xx()) {
+		clockevent_gpt.suspend = omap_clkevt_idle;
+		clockevent_gpt.resume = omap_clkevt_unidle;
+
+		clockevent_gpt_hwmod =
+			omap_hwmod_lookup(clockevent_gpt.name);
+	}
+
 	pr_info("OMAP clockevent source: %s at %lu Hz\n", clockevent_gpt.name,
 		clkev.rate);
 }
-- 
2.11.0

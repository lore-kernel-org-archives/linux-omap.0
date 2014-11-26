From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH v5 1/4] ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
Date: Wed, 26 Nov 2014 15:52:30 -0600
Message-ID: <c8a9e025ce9672ce5f4c3abb2b00f626adf01f57.1417038624.git.d-gerlach@ti.com>
References: <cover.1417038624.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbaKZVxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 16:53:15 -0500
In-Reply-To: <cover.1417038624.git.d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

OMAP timer code registers two timers - one as clocksource
and one as clockevent. Since AM33XX has only one usable timer
in the WKUP domain one of the timers needs suspend-resume
support to restore the configuration to pre-suspend state.

commit adc78e6b9946 ("timekeeping: Add suspend and resume
of clock event devices") introduced .suspend and .resume
callbacks for clock event devices. Leverage these
callbacks to have AM33XX clockevent timer behave properly
across system suspend.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4f61148..5c7ecde 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -67,6 +67,9 @@
 static struct omap_dm_timer clkev;
 static struct clock_event_device clockevent_gpt;
 
+/* Clockevent hwmod for am335x and am437x suspend */
+struct omap_hwmod *clockevent_gpt_hwmod;
+
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 static unsigned long arch_timer_freq;
 
@@ -128,6 +131,23 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	}
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
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 300,
@@ -355,6 +375,14 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 					3, /* Timer internal resynch latency */
 					0xffffffff);
 
+	if (soc_is_am33xx()) {
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
2.1.0


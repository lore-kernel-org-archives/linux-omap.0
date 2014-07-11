From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
Date: Thu, 10 Jul 2014 21:55:41 -0500
Message-ID: <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaGKC5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 22:57:31 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

OMAP timer code registers two timers - one as clocksource
and one as clockevent. Since AM33XX has only one usable timer
in the WKUP domain one of the timers needs suspend-resume
support to restore the configuration to pre-suspend state.

commit adc78e6 (timekeeping: Add suspend and resume
of clock event devices) introduced .suspend and .resume
callbacks for clock event devices. Leverages these
callbacks to have AM33XX clockevent timer which is
in not in WKUP domain to behave properly across system
suspend.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4:
	Only use for am33xx soc now.

 arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 43d03fb..6fc1748 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -128,6 +128,29 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void omap_clkevt_suspend(struct clock_event_device *unused)
+{
+	struct omap_hwmod *oh;
+
+	oh = omap_hwmod_lookup(clockevent_gpt.name);
+	if (!oh)
+		return;
+
+	omap_hwmod_idle(oh);
+}
+
+static void omap_clkevt_resume(struct clock_event_device *unused)
+{
+	struct omap_hwmod *oh;
+
+	oh = omap_hwmod_lookup(clockevent_gpt.name);
+	if (!oh)
+		return;
+
+	omap_hwmod_enable(oh);
+	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
+}
+
 static struct clock_event_device clockevent_gpt = {
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 300,
@@ -333,6 +356,11 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	clkev.id = gptimer_id;
 	clkev.errata = omap_dm_timer_get_errata();
 
+	if (soc_is_am33xx()) {
+		clockevent_gpt.suspend = omap_clkevt_suspend;
+		clockevent_gpt.resume = omap_clkevt_resume;
+	}
+
 	/*
 	 * For clock-event timers we never read the timer counter and
 	 * so we are not impacted by errata i103 and i767. Therefore,
-- 
1.9.0


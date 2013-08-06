From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCHv3 6/9] ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
Date: Tue, 6 Aug 2013 12:49:33 -0500
Message-ID: <1375811376-49985-7-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130Ab3HFRub (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 13:50:31 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>

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
 arch/arm/mach-omap2/timer.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b37e1fc..cce5d39 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -118,11 +118,43 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void omap_clkevt_suspend(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", clkev.id);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return;
+
+	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
+	omap_hwmod_idle(oh);
+}
+
+static void omap_clkevt_resume(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", clkev.id);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return;
+
+	omap_hwmod_enable(oh);
+	__omap_dm_timer_load_start(&clkev,
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
+}
+
 static struct clock_event_device clockevent_gpt = {
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
 	.set_mode	= omap2_gp_timer_set_mode,
+	.suspend	= omap_clkevt_suspend,
+	.resume		= omap_clkevt_resume,
 };
 
 static struct property device_disabled = {
-- 
1.7.9.5


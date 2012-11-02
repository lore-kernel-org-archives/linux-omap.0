From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks for clockevent device
Date: Fri, 2 Nov 2012 18:02:43 +0530
Message-ID: <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760919Ab2KBMec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:32 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

The current OMAP timer code registers two timers -
one as clocksource and one as clockevent.
AM33XX has only one usable timer in the WKUP domain
so one of the timers needs suspend-resume support
to restore the configuration to pre-suspend state.

commit adc78e6 (timekeeping: Add suspend and resume
of clock event devices) introduced .suspend and .resume
callbacks for clock event devices. Leverages these
callbacks to have AM33XX clockevent timer which is
in not in WKUP domain to behave properly across system
suspend.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/timer.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 6584ee0..e8781fd 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -135,6 +135,35 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void omap_clkevt_suspend(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", 2);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return;
+
+	omap_hwmod_idle(oh);
+}
+
+static void omap_clkevt_resume(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", 2);
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
 	.name		= "gp_timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -142,6 +171,8 @@ static struct clock_event_device clockevent_gpt = {
 	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
 	.set_mode	= omap2_gp_timer_set_mode,
+	.suspend	= omap_clkevt_suspend,
+	.resume		= omap_clkevt_resume,
 };
 
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
-- 
1.7.0.4


From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V7 2/3] ARM: OMAP2+: Replace space=>underscore in the name field of system timers
Date: Thu, 3 May 2012 13:29:00 +0530
Message-ID: <1336031941-23651-3-git-send-email-hvaibhav@ti.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41019 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2ECH7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:59:18 -0400
In-Reply-To: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Depending on the bootloader, passing command-line arguments
with spaces may have issues. Some bootloaders doesn't seem
to pass along the quotes, passing only 'gp' part of the string,
which leads to wrong override configuration.

The only affected kernel parameter configuration for OMAP family
is "clocksource=", used to override kernel clocksource.

So this patch changes "gp timer" => "gp_timer", for clockevent,
clocksource and timer irq_handler.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
No code change compared to V6 patch series, only
commit description has been updated as per Kevin's comment.

 arch/arm/mach-omap2/timer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ecec873..777f84b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -90,7 +90,7 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 }

 static struct irqaction omap2_gp_timer_irq = {
-	.name		= "gp timer",
+	.name		= "gp_timer",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= omap2_gp_timer_interrupt,
 };
@@ -132,7 +132,7 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 }

 static struct clock_event_device clockevent_gpt = {
-	.name		= "gp timer",
+	.name		= "gp_timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
 	.set_next_event	= omap2_gp_timer_set_next_event,
@@ -269,7 +269,7 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
 }

 static struct clocksource clocksource_gpt = {
-	.name		= "gp timer",
+	.name		= "gp_timer",
 	.rating		= 300,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
--
1.7.0.4


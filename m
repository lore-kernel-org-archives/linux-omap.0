From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V6 2/3] ARM: OMAP2+: Replace space=>underscore in the name field of system timers
Date: Wed, 2 May 2012 19:26:53 +0530
Message-ID: <1335967014-11937-3-git-send-email-hvaibhav@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46672 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab2EBODm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 10:03:42 -0400
In-Reply-To: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Depending on the bootloader, passing command-line arguments
with spaces may have issues. Some bootloaders doesn't seem
to pass along the quotes, passing only 'gp' part of the string,
which leads to wrong clocksource override configuration.

So this patch changes "gp timer" => "gp_timer", for clockevent,
clocksource and timer irq_handler.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
This is new patch addition compared to original series (<=V5).

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


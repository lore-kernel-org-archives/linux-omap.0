From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/9] ARM: OMAP: gptimer min_delta_ns corrected
Date: Wed, 28 Jan 2009 10:30:52 -0800
Message-ID: <20090128183052.21007.60486.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61374 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbZA1Saz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:30:55 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

When 32 kHz timer is used the min_delta_ns should be initialized so
that it reflects the timer programming cost. A write to the timer
device will be usually posted, but it takes roughly 3 cycles before
it is effective. If the timer is reprogrammed before that, the CPU
will stall until the previous write completes. This was pointed out by
Richard Woodruff.

Since the lower bound for min_delta_ns is 1000, the change is visible
only with tick rates less than 3 MHz.

Also note that the old value is incorrect for 32 kHz also due to
a rounding error, and it can cause the timer queue to hang (due to
clockevent code trying to program the timer with zero ticks).

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Reviewed-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer-gp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index ae60363..9fc13a2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -118,7 +118,8 @@ static void __init omap2_gp_clockevent_init(void)
 	clockevent_gpt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
 	clockevent_gpt.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_gpt);
+		clockevent_delta2ns(3, &clockevent_gpt);
+		/* Timer internal resynch latency. */
 
 	clockevent_gpt.cpumask = cpumask_of(0);
 	clockevents_register_device(&clockevent_gpt);


From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH] OMAP2: gptimer min_delta_ns corrected
Date: Fri,  2 Jan 2009 17:07:16 +0200
Message-ID: <1230908836-24231-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55504 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZABPHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2009 10:07:25 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n02F7Ctg008908
	for <linux-omap@vger.kernel.org>; Fri, 2 Jan 2009 09:07:22 -0600
Received: from localhost.localdomain (esdhcp042201.research.nokia.com [172.21.42.201])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n02F7HPs031933
	for <linux-omap@vger.kernel.org>; Fri, 2 Jan 2009 17:07:17 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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
---
 arch/arm/mach-omap2/timer-gp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 787cfef..3e66a9a 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -121,7 +121,8 @@ static void __init omap2_gp_clockevent_init(void)
 	clockevent_gpt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
 	clockevent_gpt.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_gpt);
+		clockevent_delta2ns(3, &clockevent_gpt);
+		/* Timer internal resynch latency. */
 
 	clockevent_gpt.cpumask = cpumask_of_cpu(0);
 	clockevents_register_device(&clockevent_gpt);
-- 
1.5.4.3


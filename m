From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Mon, 29 Dec 2008 19:14:28 +0200
Message-ID: <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33688 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbYL2RP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Dec 2008 12:15:29 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBTHF5Ae010206
	for <linux-omap@vger.kernel.org>; Mon, 29 Dec 2008 19:15:26 +0200
Received: from localhost.localdomain (esdhcp042201.research.nokia.com [172.21.42.201])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBTHESZt027013
	for <linux-omap@vger.kernel.org>; Mon, 29 Dec 2008 19:14:28 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

clockevent_delta2ns() used to initialize min_delta_ns rounds the value
down, so the result can be too small. When clockevents_program_event()
is using too small value it will try to program the timer with zero
ticks stalling the timer queue.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 arch/arm/mach-omap2/timer-gp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 787cfef..375c18e 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -121,7 +121,7 @@ static void __init omap2_gp_clockevent_init(void)
 	clockevent_gpt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
 	clockevent_gpt.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_gpt);
+		clockevent_delta2ns(1, &clockevent_gpt) + 1;
 
 	clockevent_gpt.cpumask = cpumask_of_cpu(0);
 	clockevents_register_device(&clockevent_gpt);
-- 
1.5.4.3


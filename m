From: Kim Kyuwon <q1.kim@samsung.com>
Subject: Suggestion and patch about the alarm of TWL4030-RTC
Date: Wed, 22 Apr 2009 13:52:09 +0900
Message-ID: <49EEA279.2010202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52467 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZDVExS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 00:53:18 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KIH00K6XK6YH5@mailout4.samsung.com> for
 linux-omap@vger.kernel.org; Wed, 22 Apr 2009 13:52:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KIH00MNHK6Y0E@mmp1.samsung.com> for
 linux-omap@vger.kernel.org; Wed, 22 Apr 2009 13:52:10 +0900 (KST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexandre Rusev <source@mvista.com>, OMAP <linux-omap@vger.kernel.org>
Cc: =?windows-1252?Q?=22=3F=3F=3F=22?= <kyungmin.park@samsung.com>, =?windows-1252?Q?=22=3F=3F=3F=22?= <bhmin@samsung.com>, David Brownell <david-b@pacbell.net>, Kevin Hilman <khilman@deeprootsystems.com>, rtc-linux@googlegroups.com, chammoru@gmail.com

Hi All,

>From the twl4030_rtc_suspend() in rtc-twl4030.c, the alarm signal of TWL4030 RTC can't wake up the system form suspend.
However, I think it is more reasonable to alarm wake up the system and this is just we do.
(Mobile phone is mostly in suspend state, especially in the morning, thus alarm signal can wake up the phone!)
So I'm sending following patch.

Please give your comments.
I really want to apply this patch.

Thanks & Regards,
Kyuwon

--
>From 9d70ffc38653b1fb0dc7ae0950502e4adfe06c50 Mon Sep 17 00:00:00 2001
From: Kim Kyuwon <q1.kim@samsung.com>
Date: Wed, 22 Apr 2009 13:29:50 +0900
Subject: [PATCH] rtc: rtc-twl4030 don't mask alarm interrupts on suspend

This patch enables the alarm interrupt of TWL4030 RTC to wake up the system from suspend

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 drivers/rtc/rtc-twl4030.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index ad35f76..c185939 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -495,9 +495,7 @@ static int twl4030_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	irqstat = rtc_irq_bits;
 
-	/* REVISIT alarm may need to wake us from sleep */
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
-			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 	return 0;
 }
 
-- 
1.5.2.5

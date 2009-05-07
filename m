From: Kim Kyuwon <q1.kim@samsung.com>
Subject: [PATCH] rtc: rtc-twl4030 don't mask alarm interrupts on suspend
Date: Thu, 07 May 2009 10:12:40 +0900
Message-ID: <4A023588.8080308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759536AbZEGBNF@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: rtc-linux@googlegroups.com, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Kyungmin Park <kyungmin.park@samsung.com>, p_gortmaker@yahoo.com, a.zummo@towertech.it
List-Id: linux-omap@vger.kernel.org

Hi All,

This patch was originally sent to linux-omap mailing list.
(Please refer to http://markmail.org/thread/o643d7w224zo3i7n)

David Brownell said, if I've tested this:

 Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Of course, I've tested.

Regards,
Kyuwon
--
From: Kim Kyuwon <q1.kim@samsung.com>
Subject: [PATCH] rtc: rtc-twl4030 don't mask alarm interrupts on suspend

This patch enables the alarm interrupt of TWL4030 RTC to wake up the
system from suspend. You can test this patch with following command.

# echo +10 > /sys/class/rtc/rtc0/wakealarm; echo mem > /sys/power/state;

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

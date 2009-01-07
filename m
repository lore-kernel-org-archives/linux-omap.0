From: "matti.halme@nokia.com" <matti.halme@nokia.com>
Subject: [PATCH] Don't mask rtc-twl4030 alarm interrupts on shutdown
Date: Wed, 7 Jan 2009 09:10:07 +0200
Message-ID: <043E6D9F43E2D14682729D3AE18163F30293E71E@vaebe107.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56272 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZAGHKp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 02:10:45 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: linux-omap@vger.kernel.org

A triggering RTC alarm should be able to power on a device that has been
powered off. This patch enables that on twl4030 by not masking the alarm
interrupt at shutdown.

Signed-off-by: Matti Halme <matti.halme@nokia.com>
---
 drivers/rtc/rtc-twl4030.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index abe87a4..f5f6a97 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -505,8 +505,9 @@ static int __devexit twl4030_rtc_remove(struct
platform_device *pdev)
 
 static void twl4030_rtc_shutdown(struct platform_device *pdev)
 {
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
-			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	/* mask timer interrupts, but leave alarm interrupts on to
enable
+	   power-on when alarm is triggered */
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 }
 
 #ifdef CONFIG_PM
-- 
1.4.4.4

Regards,
Matti Halme

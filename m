From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH] rtc-twl4030: Fix periodic interrupt
Date: Fri, 5 Sep 2008 14:54:46 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB027DF89CEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbYIEJY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 05:24:56 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m859Onrp010304
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 04:24:54 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m859Olwq015666
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 14:54:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

RTC generates an extra spurious interrupt for every actual periodic
interrupt. This is due to a problem with the RTC_IT bit of
REG_PWR_ISR1. It requires two writes or two reads (when COR is 
enabled) to clear it. Since COR is enabled and one read of the same
register is done already (inside twl4030-pwrirq.c do_twl4030_pwrirq()
function), we can do away with a need to add one more write into the 
same register inside the interrupt handler, by replacing the write
currently present with just one extra read.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
---
David Brownell reported this issue earlier. This patch fixes it.
Index: linux-omap-2.6/drivers/rtc/rtc-twl4030.c
===================================================================
--- linux-omap-2.6.orig/drivers/rtc/rtc-twl4030.c	2008-09-05 12:22:23.089855991 +0530
+++ linux-omap-2.6/drivers/rtc/rtc-twl4030.c	2008-09-05 12:49:55.634939761 +0530
@@ -446,8 +446,13 @@ static irqreturn_t twl4030_rtc_interrupt
 				   REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
-			PWR_RTC_INT_CLR, REG_PWR_ISR1);
+
+	/* Clear on Read enabled. RTC_IT bit of REG_PWR_ISR1 needs
+	 * 2 reads to clear the interrupt. One read is done in
+	 * do_twl4030_pwrirq(). Doing the second read, to clear
+	 * the bit.
+	 */
+	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
 	if (res)
 		goto out;


--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------


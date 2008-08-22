From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH resend] TWL4030-RTC: Fix the broken functionality
Date: Fri, 22 Aug 2008 19:47:24 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB027DC93776@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYHVOYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 10:24:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7MEHQBs031219
	for <linux-omap@vger.kernel.org>; Fri, 22 Aug 2008 09:17:32 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7MEHQYO003602
	for <linux-omap@vger.kernel.org>; Fri, 22 Aug 2008 19:47:26 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

rtc_irq_set_freq() function takes only powers of 2 as a valid
argument. This stipulates that an ioctl call on /dev/rtc0
can accept values of 1,2,4 and 8 only. But the function 
twl4030_rtc_irq_set_freq() takes only values 0-3. RTC_INTERRUPTS_REG
of TWL4030 also requires value in the range 0-3 for the interrupt
period. Hence it is required to map the argument from the powers of 2,
to the corresponding numbers 0-3, via a call to ilog2.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
---
Index: my-local-git-dir/drivers/rtc/rtc-twl4030.c
===================================================================
--- my-local-git-dir.orig/drivers/rtc/rtc-twl4030.c	2008-08-22 17:37:33.000000000 +0530
+++ my-local-git-dir/drivers/rtc/rtc-twl4030.c	2008-08-22 19:25:41.616786397 +0530
@@ -38,6 +38,7 @@
 #include <linux/i2c/twl4030-rtc.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/log2.h>
 
 #include <asm/mach/time.h>
 #include <asm/system.h>
@@ -363,14 +364,26 @@ out:
 static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
 {
 	struct rtc_device *rtc = dev_get_drvdata(dev);
+	u8 value;
 
-	if (freq < 0 || freq > 3)
+	/* RTC_INTERRUPTS_REG takes the value of 0 for interrupts every
+	 * second, 1 for every minute, 2 every hour and 3 every day.
+	 * But freq is in 2^N format, which needs to be converted back.
+	 */
+	value = ilog2(freq);
+	if (value < 0 || value > 3)
 		return -EINVAL;
 
-	rtc->irq_freq = freq;
+	rtc->irq_freq = value;
+
+	/* Clear the current periodicity of irq*/
+	mask_rtc_irq_bit(0x3);
 
-	/* set rtc irq freq to user defined value */
-	set_rtc_irq_bit(freq);
+	/* If the new value is non-zero, set the new periodicity */
+	if (value) {
+		/* set rtc irq freq to user defined value */
+		set_rtc_irq_bit(freq);
+	}
 
 	return 0;
 }

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

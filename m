From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [patch 2.6.27-rc5-omap1] rtc-twl4030 cleanup
Date: Fri, 5 Sep 2008 12:54:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB027DF89BDB@dbde02.ent.ti.com>
References: <200809041024.18572.david-b@pacbell.net>
 <200809041048.46177.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbYIEHYd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 03:24:33 -0400
In-Reply-To: <200809041048.46177.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David
> Brownell
> Sent: Thursday, September 04, 2008 11:19 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: [patch 2.6.27-rc5-omap1] rtc-twl4030 cleanup
> 
> On Thursday 04 September 2008, David Brownell wrote:
> > Update IRQs still misbehave (two per > second, not one!),
> 
> Someone with docs will need to sort this one out.  The
> appended test program will illustrate the problem; it
> was sitting around to help sort out bugs in way x86
> "HPET Emulation" reports update IRQs.
> 
> Output on twl4030 is like:
> 
> Read using select(2) on /dev/rtc0:
>     1    0.562852  (+0.358789) 0190
>    -3 *  0.563770  (+0.359707) 0190
>    -2    1.562741  (+0.358678) 0190
>    -6 *  1.563712  (+0.359649) 0190
>    -5    2.562825  (+0.358762) 0190
>    -9 *  2.563737  (+0.359674) 0190
>    -8    3.562817  (+0.358754) 0190
>   -12 *  3.563722  (+0.359659) 0190
>   -11    4.562975  (+0.358912) 0190
>   -15 *  4.563923  (+0.359860) 0190
>   -14    5.563039  (+0.358976) 0190
>   -18 *  5.564048  (+0.359985) 0190
> ^C
> 
> The "*" indicates bogus IRQ reports ... in this case it
> looks like each update IRQ is reported TWICE, with the
> second one being about one millisec after the first one.
> Since this test waits for five consecutive non-bogus
> interrupts, it never stops ...
> 

David,
  Could you please try with this patch?

<CUT HERE>
RTC generates an extra spurious interrupt for every actual periodic
interrupt. This is due to a problem with the RTC_IT bit of
REG_PWR_ISR1. It requires two writes or two reads (when COR is 
enabled) to clear it. Since COR is enabled and one read of the same
register is done already (inside twl4030-pwrirq.c do_twl4030_pwrirq()
function), all we need is one more read.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
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


From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH] TWL4030-RTC: Remove obsolete comment
Date: Tue, 19 Aug 2008 20:29:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB020F89F02A@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB020F89F003@dbde02.ent.ti.com>
 <20080819144218.GE23346@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45970 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYHSO72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 10:59:28 -0400
In-Reply-To: <20080819144218.GE23346@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Tuesday, August 19, 2008 8:12 PM
> To: Pakaravoor, Jagadeesh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] TWL4030-RTC: Remove obsolete comment
> 
> On Tue, Aug 19, 2008 at 07:50:26PM +0530, ext Pakaravoor, Jagadeesh wrote:
> > From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> >
> > TWL4030-RTC: Remove obsolete comment.
> >
> > Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> > Index: my-local-git-dir/drivers/rtc/rtc-twl4030.c
> > ===================================================================
> > --- my-local-git-dir.orig/drivers/rtc/rtc-twl4030.c	2008-08-19 19:20:24.000000000 +0530
> > +++ my-local-git-dir/drivers/rtc/rtc-twl4030.c	2008-08-19 19:28:43.037746119 +0530
> > @@ -446,12 +446,6 @@ static irqreturn_t twl4030_rtc_interrupt
> >  				   REG_RTC_STATUS_REG);
> >  	if (res)
> >  		goto out;
> > -	/*
> > -	 * Workaround for strange behaviour with T2. Need to write into ISR
> > -	 * register one more time to clear the interrupt. Otherwise, the same
> > -	 * RTC event generates 2 interrupts in a row.
> > -	 * (no errata document available)
> > -	 */
> >  	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> >  			PWR_RTC_INT_CLR, REG_PWR_ISR1);
> >  	if (res)
> 
> Why is this obsolete? Seems quite a good comment to me. Removing it
> might turn into someone removing that line and make t2's rtc misbehave.
> 
> Maybe you wanna remove only the "no errata" line if there is any errata
> available but the comment itself is quite valuable.
> 

Currently there is only one write to the ISR (REG_PWR_ISR1), where as previously there used to be two writes. So the comment is no more valid.

--
Jagadeesh

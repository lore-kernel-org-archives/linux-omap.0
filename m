From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] TWL4030-RTC: Remove obsolete comment
Date: Tue, 19 Aug 2008 17:42:18 +0300
Message-ID: <20080819144218.GE23346@gandalf.research.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB020F89F003@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46584 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYHSOle (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 10:41:34 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB020F89F003@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 19, 2008 at 07:50:26PM +0530, ext Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> TWL4030-RTC: Remove obsolete comment.
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> Index: my-local-git-dir/drivers/rtc/rtc-twl4030.c
> ===================================================================
> --- my-local-git-dir.orig/drivers/rtc/rtc-twl4030.c	2008-08-19 19:20:24.000000000 +0530
> +++ my-local-git-dir/drivers/rtc/rtc-twl4030.c	2008-08-19 19:28:43.037746119 +0530
> @@ -446,12 +446,6 @@ static irqreturn_t twl4030_rtc_interrupt
>  				   REG_RTC_STATUS_REG);
>  	if (res)
>  		goto out;
> -	/*
> -	 * Workaround for strange behaviour with T2. Need to write into ISR
> -	 * register one more time to clear the interrupt. Otherwise, the same
> -	 * RTC event generates 2 interrupts in a row.
> -	 * (no errata document available)
> -	 */
>  	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
>  			PWR_RTC_INT_CLR, REG_PWR_ISR1);
>  	if (res)

Why is this obsolete? Seems quite a good comment to me. Removing it
might turn into someone removing that line and make t2's rtc misbehave.

Maybe you wanna remove only the "no errata" line if there is any errata
available but the comment itself is quite valuable.

-- 
balbi

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] rtc-twl4030: Fix periodic interrupt
Date: Tue, 9 Sep 2008 10:43:10 -0700
Message-ID: <20080909174310.GR29054@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB027DF89CEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61707 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbYIIRnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 13:43:14 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB027DF89CEA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pakaravoor, Jagadeesh <j-pakaravoor@ti.com> [080905 02:34]:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> RTC generates an extra spurious interrupt for every actual periodic
> interrupt. This is due to a problem with the RTC_IT bit of
> REG_PWR_ISR1. It requires two writes or two reads (when COR is 
> enabled) to clear it. Since COR is enabled and one read of the same
> register is done already (inside twl4030-pwrirq.c do_twl4030_pwrirq()
> function), we can do away with a need to add one more write into the 
> same register inside the interrupt handler, by replacing the write
> currently present with just one extra read.

Pushing today.

Tony

> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> ---
> David Brownell reported this issue earlier. This patch fixes it.
> Index: linux-omap-2.6/drivers/rtc/rtc-twl4030.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/rtc/rtc-twl4030.c	2008-09-05 12:22:23.089855991 +0530
> +++ linux-omap-2.6/drivers/rtc/rtc-twl4030.c	2008-09-05 12:49:55.634939761 +0530
> @@ -446,8 +446,13 @@ static irqreturn_t twl4030_rtc_interrupt
>  				   REG_RTC_STATUS_REG);
>  	if (res)
>  		goto out;
> -	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> -			PWR_RTC_INT_CLR, REG_PWR_ISR1);
> +
> +	/* Clear on Read enabled. RTC_IT bit of REG_PWR_ISR1 needs
> +	 * 2 reads to clear the interrupt. One read is done in
> +	 * do_twl4030_pwrirq(). Doing the second read, to clear
> +	 * the bit.
> +	 */
> +	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
>  	if (res)
>  		goto out;
> 
> 
> --
> With Regards,
> Jagadeesh Bhaskar P
>  
> ----------------------------
> Some men see things as they are and say why - I dream things that never were and say why not.
> - George Bernard Shaw
> -------------------
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

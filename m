From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Don't mask rtc-twl4030 alarm interrupts on shutdown
Date: Thu, 8 Jan 2009 14:24:08 +0200
Message-ID: <20090108122407.GD27566@atomide.com>
References: <043E6D9F43E2D14682729D3AE18163F30293E71E@vaebe107.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58451 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZAHMYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 07:24:15 -0500
Content-Disposition: inline
In-Reply-To: <043E6D9F43E2D14682729D3AE18163F30293E71E@vaebe107.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "matti.halme@nokia.com" <matti.halme@nokia.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org

* matti.halme@nokia.com <matti.halme@nokia.com> [090107 09:10]:
> A triggering RTC alarm should be able to power on a device that has been
> powered off. This patch enables that on twl4030 by not masking the alarm
> interrupt at shutdown.

Looks like this is already queued up for mainline by Alessandro,
so pushing to linux-omap tree while waiting for it to fall down
from mainline.

Tony


> Signed-off-by: Matti Halme <matti.halme@nokia.com>
> ---
>  drivers/rtc/rtc-twl4030.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
> index abe87a4..f5f6a97 100644
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -505,8 +505,9 @@ static int __devexit twl4030_rtc_remove(struct
> platform_device *pdev)
>  
>  static void twl4030_rtc_shutdown(struct platform_device *pdev)
>  {
> -	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
> -			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> +	/* mask timer interrupts, but leave alarm interrupts on to
> enable
> +	   power-on when alarm is triggered */
> +	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 1.4.4.4
> 
> Regards,
> Matti Halme
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

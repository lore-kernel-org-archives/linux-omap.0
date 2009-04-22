From: David Brownell <david-b@pacbell.net>
Subject: Re: Suggestion and patch about the alarm of TWL4030-RTC
Date: Tue, 21 Apr 2009 21:57:42 -0700
Message-ID: <200904212157.43022.david-b@pacbell.net>
References: <49EEA279.2010202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:37284 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751402AbZDVE5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2009 00:57:45 -0400
In-Reply-To: <49EEA279.2010202@samsung.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <q1.kim@samsung.com>
Cc: Alexandre Rusev <source@mvista.com>, OMAP <linux-omap@vger.kernel.org>, ??? <kyungmin.park@samsung.com>, ??? <bhmin@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, rtc-linux@googlegroups.com, chammoru@gmail.com

On Tuesday 21 April 2009, Kim Kyuwon wrote:
> Hi All,
> 
> >From the twl4030_rtc_suspend() in rtc-twl4030.c, the alarm signal of TWL4030 RTC can't wake up the system form suspend.
> However, I think it is more reasonable to alarm wake up the system and this is just we do.
> (Mobile phone is mostly in suspend state, especially in the morning, thus alarm signal can wake up the phone!)
> So I'm sending following patch.
> 
> Please give your comments.
> I really want to apply this patch.
> 
> Thanks & Regards,
> Kyuwon
> 
> --
> >From 9d70ffc38653b1fb0dc7ae0950502e4adfe06c50 Mon Sep 17 00:00:00 2001
> From: Kim Kyuwon <q1.kim@samsung.com>
> Date: Wed, 22 Apr 2009 13:29:50 +0900
> Subject: [PATCH] rtc: rtc-twl4030 don't mask alarm interrupts on suspend
> 
> This patch enables the alarm interrupt of TWL4030 RTC to wake up the system from suspend
> 
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>

Looks right to me.  If you've tested thhis:

  Acked-by: David Brownell <dbrownell@users.sourceforge.net>

The reason I left that original clearly-wrong code in place
was that I had yet to see an OMAP3-based system which could
use the system suspend state, so it was unclear that change
would suffice...


> ---
>  drivers/rtc/rtc-twl4030.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
> index ad35f76..c185939 100644
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -495,9 +495,7 @@ static int twl4030_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	irqstat = rtc_irq_bits;
>  
> -	/* REVISIT alarm may need to wake us from sleep */
> -	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
> -			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> +	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
>  	return 0;
>  }
>  
> -- 
> 1.5.2.5
> 
> 



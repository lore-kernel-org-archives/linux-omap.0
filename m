From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] Don't mask rtc-twl4030 alarm interrupts on shutdown
Date: Mon, 29 Dec 2008 17:54:49 +0200
Message-ID: <31e679430812290754w6585166ao804ef5fbe4bde536@mail.gmail.com>
References: <043E6D9F43E2D14682729D3AE18163F3FD9B6C@vaebe107.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:32649 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYL2Pyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Dec 2008 10:54:51 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1519242yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Dec 2008 07:54:49 -0800 (PST)
In-Reply-To: <043E6D9F43E2D14682729D3AE18163F3FD9B6C@vaebe107.NOE.Nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: matti.halme@nokia.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

This list has moved to linux-omap@vger.kernel.org

On Mon, Dec 29, 2008 at 4:55 PM,  <matti.halme@nokia.com> wrote:
> A triggering RTC alarm should be able to power on a device that has been
> powered off. This patch enables that on twl4030 by not masking the alarm
> interrupt at shutdown.
>
> Signed-off-by: Matti Halme <matti.halme at nokia.com>
> ---
>  drivers/rtc/rtc-twl4030.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
> index abe87a4..f5f6a97 100644
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -505,8 +505,9 @@ static int __devexit twl4030_rtc_remove(struct platform_device *pdev)
>
>  static void twl4030_rtc_shutdown(struct platform_device *pdev)
>  {
> -       mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
> -                        BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
> +       /* mask timer interrupts, but leave alarm interrupts on to enable
> +          power-on when alarm is triggered */
> +       mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
>  }
>
>  #ifdef CONFIG_PM
> --
> 1.4.4.4
>
> Regards,
> Matti Halme
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net

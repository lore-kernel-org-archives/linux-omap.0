From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:OMAP2: follow new twl4030 RTC init convention in
	Overo board file
Date: Tue, 23 Sep 2008 13:52:58 +0300
Message-ID: <20080923105256.GG5102@atomide.com>
References: <5e088bd90809132219j63bbec48hdd36ddb1357741e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63475 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbYIWKxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 06:53:02 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809132219j63bbec48hdd36ddb1357741e0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080914 08:20]:
> Overo was omitted from the changes in 74fcfe9c589f1060b5e5a791e9c0c54212d7c1b8
> 
> This patch brings Overo RTC setup into line with the other omap boards

Pushing.

Tony

> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  arch/arm/mach-omap2/board-overo.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index 5c23b4d..85ef43f 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -158,11 +158,6 @@ static void __init overo_init_irq(void)
>  	omap_gpio_init();
>  }
> 
> -static struct platform_device overo_twl4030rtc_device = {
> -	.name           = "twl4030_rtc",
> -	.id             = -1,
> -};
> -
>  static struct platform_device overo_lcd_device = {
>  	.name		= "overo_lcd",
>  	.id		= -1,
> @@ -179,9 +174,6 @@ static struct omap_board_config_kernel
> overo_config[] __initdata = {
> 
>  static struct platform_device *overo_devices[] __initdata = {
>  	&overo_lcd_device,
> -#ifdef CONFIG_RTC_DRV_TWL4030
> -	&overo_twl4030rtc_device,
> -#endif
>  };
> 
>  static void __init overo_init(void)
> -- 
> 1.5.4.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

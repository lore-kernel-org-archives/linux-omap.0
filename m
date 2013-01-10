From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH for 3.8] ARM: OMAP: zoom-display: Remove the use of
 TWL4030_MODULE_PWM1
Date: Thu, 10 Jan 2013 12:00:37 -0800
Message-ID: <20130110200036.GC14149@atomide.com>
References: <1357725628-25120-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45414 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754617Ab3AJUAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 15:00:40 -0500
Content-Disposition: inline
In-Reply-To: <1357725628-25120-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130109 02:03]:
> Use the future proof TWL_MODULE_PWM module id instead to aim the twl-core
> cleanup planed for 3.9 kernel cycle.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Tony,
> 
> can you queue this patch for 3.8 cycle?
> With the second part of my twl-core cleanup series I have overlooked this file
> since in my working tree I ahve already removed this part of the code and
> switched zoom to use the bl-pwm driver for the backlight.

Looks like we're now in the oopses and regressions phase, so it's probably
best that you just apply this to your series:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> I will resend the series which is doing that on top of this patch:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82724.html
> 
> Thank you,
> Peter
> 
>  arch/arm/mach-omap2/board-zoom-display.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
> index 1c7c834..8cef477 100644
> --- a/arch/arm/mach-omap2/board-zoom-display.c
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -49,13 +49,13 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
>  {
>  }
>  
> -/*
> - * PWMA/B register offsets (TWL4030_MODULE_PWMA)
> - */
> +/* Register offsets in TWL4030_MODULE_INTBR */
>  #define TWL_INTBR_PMBR1	0xD
>  #define TWL_INTBR_GPBR1	0xC
> -#define TWL_LED_PWMON	0x0
> -#define TWL_LED_PWMOFF	0x1
> +
> +/* Register offsets in TWL_MODULE_PWM */
> +#define TWL_LED_PWMON	0x3
> +#define TWL_LED_PWMOFF	0x4
>  
>  static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
>  {
> @@ -93,8 +93,8 @@ static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
>  	}
>  
>  	c = ((50 * (100 - level)) / 100) + 1;
> -	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
> -	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
> +	twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, TWL_LED_PWMOFF);
> +	twl_i2c_write_u8(TWL_MODULE_PWM, c, TWL_LED_PWMON);
>  #else
>  	pr_warn("Backlight not enabled\n");
>  #endif
> -- 
> 1.8.1
> 

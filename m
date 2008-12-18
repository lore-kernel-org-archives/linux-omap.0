From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/1] LCD backlight support for OMAP3 EVM using TPS6235x
 based power module
Date: Thu, 18 Dec 2008 15:04:43 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECE3B1C1@dbde02.ent.ti.com>
References: <1229573163-24006-1-git-send-email-mani.pillai@ti.com>
 <CAAB461B-E7BF-4743-B254-271E22BE3015@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54593 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbYLRJfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 04:35:09 -0500
In-Reply-To: <CAAB461B-E7BF-4743-B254-271E22BE3015@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@sirena.org.uk" <broonie@sirena.org.uk>

Hi,

For OMAP we do not have the backlight class support. 
That's the reason I am hooking the LCD control to the existing framework
which is available in lcd_omap3evm.c.

The sys fs interface is also provided and can be controlled by writing to

/sys/devices/platform/omapfb/panel/backlight_level.

Regards
Mani

-----Original Message-----
From: Koen Kooi [mailto:k.kooi@student.utwente.nl] 
Sent: Thursday, December 18, 2008 2:47 PM
To: Pillai, Manikandan
Cc: linux-omap@vger.kernel.org; broonie@sirena.org.uk
Subject: Re: [PATCH 1/1] LCD backlight support for OMAP3 EVM using TPS6235x based power module


Op 18 dec 2008, om 05:06 heeft Manikandan Pillai het volgende  
geschreven:

> This patch provides support for LCD backlight enable and disable
> for OMAP3 EVM using TPS6235x based PR785 boards.


Could you hook into the backlight class for this please?

regards,

Koen


>
>
> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
> drivers/video/omap/lcd_omap3evm.c |   22 +++++++++++++++++++++-
> 1 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/ 
> lcd_omap3evm.c
> index 4f373b2..0ea35ba 100644
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ b/drivers/video/omap/lcd_omap3evm.c
> @@ -49,6 +49,9 @@
> #define TWL_PWMA_PWMAON		0x00
> #define TWL_PWMA_PWMAOFF	0x01
>
> +/* GPIO on which Backlight can be switched ON/OFF */
> +#define	LCD_OMAP3_BKLIGHT_GPIO	141
> +
> static unsigned int bklight_level;
>
> static int omap3evm_panel_init(struct lcd_panel *panel,
> @@ -71,6 +74,10 @@ static int omap3evm_panel_init(struct lcd_panel  
> *panel,
> 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> #endif
> +#if defined(CONFIG_PR785)
> +	gpio_request(LCD_OMAP3_BKLIGHT_GPIO, "AE6_34XX_GPIO141");
> +#endif
> +
> 	bklight_level = 100;
>
> 	return 0;
> @@ -108,7 +115,20 @@ static int omap3evm_bklight_setlevel(struct  
> lcd_panel *panel,
> 	}
> 	return 0;
> #endif
> -	/* Fix this once patch fix is sent out for TPS-boards */
> +
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +	bklight_level = level;
> +	/* if it is PR785 card the backlight can only be enabled or disable
> +	we will use values <=15 for disable and rest as enabled */
> +	if (level <= 15)
> +		/* Switch of the backlight for level values <=10 */
> +		gpio_direction_output(LCD_OMAP3_BKLIGHT_GPIO, 0);
> +	else
> +		gpio_direction_output(LCD_OMAP3_BKLIGHT_GPIO, 1);
> +
> +	return 0;
> +#endif
> +	/* if neither of them is defined, it's an error */
> 	return -1;
> }
>
> -- 
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


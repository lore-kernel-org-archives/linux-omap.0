From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] LCD backlight support for OMAP3 EVM using TPS6235x based power module
Date: Thu, 18 Dec 2008 10:17:14 +0100
Message-ID: <CAAB461B-E7BF-4743-B254-271E22BE3015@student.utwente.nl>
References: <1229573163-24006-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13-29048006"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:57625 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbYLRJSC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Dec 2008 04:18:02 -0500
In-Reply-To: <1229573163-24006-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13-29048006
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


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


--Apple-Mail-13-29048006
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJShUcMkyGM64RGpERAirxAJ9RY2N77Q2xvnho6jf4z65yyvQX6wCggmNN
JDzEGjmO0/rwaqnMSZpGr6I=
=f6M3
-----END PGP SIGNATURE-----

--Apple-Mail-13-29048006--

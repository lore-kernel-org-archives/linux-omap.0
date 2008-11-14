From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 12:38:54 +0100
Message-ID: <FEB3AB03-0384-4323-B4AE-D321BE3EFC2A@student.utwente.nl>
References: <hvaibhav@ti.com> <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13--752568382"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:57657 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbYKNLnG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 06:43:06 -0500
In-Reply-To: <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13--752568382
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende geschreven:

>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach- 
> omap2/board-omap3evm.c
>
> +	if (system_rev > OMAP3430_REV_ES1_0) {
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +			ENABLE_VPLL2_DEDICATED, TWL4030_VPLL2_DEDICATED);
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +			ENABLE_VPLL2_DEV_GRP, TWL4030_VPLL2_DEV_GRP);
> +	}
> +	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
> +	lcd_enabled = 1;
> +	return 0;
> +}
> +
> +static void panel_disable_lcd(struct omap_display *display)
> +{
> +	if (system_rev > OMAP3430_REV_ES1_0) {
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
> +				TWL4030_VPLL2_DEDICATED);
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
> +				TWL4030_VPLL2_DEV_GRP);
> +	}
> +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
> +	lcd_enabled = 0;
> +}

system_rev() is now omap_rev(), you'll get a really green picture  
without that change :)

I can confirm that the panel-sdp3430 works on the evm.

regards,

Koen

--Apple-Mail-13--752568382
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJHWNQMkyGM64RGpERApL/AKCYyD6u+zNFwKxsjTcMuIAG2UP7lwCeLa12
wRGGznMWbdkRl5jHxI0Gsyc=
=hvlC
-----END PGP SIGNATURE-----

--Apple-Mail-13--752568382--

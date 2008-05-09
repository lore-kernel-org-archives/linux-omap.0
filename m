From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 6/7] OMAP3 EVM: add lcd support (resubmit to respond to feedback)
Date: Fri, 9 May 2008 18:35:20 +0200
Message-ID: <5D9B6FC3-222B-4315-9DA9-62C8FFFB4537@student.utwente.nl>
References: <5e088bd90804292353t9e05fcatf1505a086770cb63@mail.gmail.com> <2a4801c741aef4f504dbaf153b85afab@felipebalbi.com> <5e088bd90804300714p5349a257rf1b89ddd347bb72@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:26986 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbYEIQg5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2008 12:36:57 -0400
Received: from [172.20.1.5] (vpn006167.vpn.utwente.nl [130.89.6.167])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m49GZMGI030448
          for <linux-omap@vger.kernel.org>; Fri, 9 May 2008 18:35:22 +0200
In-Reply-To: <5e088bd90804300714p5349a257rf1b89ddd347bb72@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 30 apr 2008, om 16:14 heeft Steve Sakoman het volgende geschreven:
> From: Steve Sakoman <steve@sakoman.com>
>
> Add LCD support for OMAP3 EVM
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>
> +#define LCD_PIXCLOCK_MAX	41700 /* in pico seconds  */
> +#define LCD_PIXCLOCK_MIN	38000 /* in pico seconds */

I strongly suspect the above comments needs to be "/* in kHz */ ...

>
> +struct lcd_panel omap3evm_panel = {
> +	.name		= "omap3evm",
> +	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> +			  OMAP_LCDC_INV_HSYNC,
> +
> +	.bpp		= 16,
> +	.data_lines	= 18,
> +	.x_res		= LCD_XRES,
> +	.y_res		= LCD_YRES,
> +	.hsw		= 3,		/* hsync_len (4) - 1 */
> +	.hfp		= 3,		/* right_margin (4) - 1 */
> +	.hbp		= 39,		/* left_margin (40) - 1 */
> +	.vsw		= 1,		/* vsync_len (2) - 1 */
> +	.vfp		= 2,		/* lower_margin */
> +	.vbp		= 7,		/* upper_margin (8) - 1 */
> +
> +	.pixel_clock	= LCD_PIXCLOCK_MAX,

... since pixel_clock seems to be in kHz. Could someone confirm this?

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIJH1KMkyGM64RGpERAifEAJwLITHNkhjJ/zhKKiTFdVEq+6AuMgCfVoXd
oFX58FQibqqSyaIk4sTVCNE=
=yJ/0
-----END PGP SIGNATURE-----

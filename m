From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 10:01:26 +0100
Message-ID: <581B2B1E-B999-4DEB-93A2-1F58B3DDA61D@student.utwente.nl>
References: <hvaibhav@ti.com> <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10--762016465"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:53628 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbYKNJBh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 04:01:37 -0500
In-Reply-To: <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10--762016465
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende geschreven:

>
> +++ b/drivers/video/omap2/panel-dvi.c
> @@ -52,54 +52,20 @@ static struct omap_panel dvi_panel = {
> 	.disable	= dvi_panel_disable,
> 	/*.set_mode	= dvi_set_mode, */
>
> -#if defined(CONFIG_PANEL_DVI_LOWRES)
> 	.timings = {
> -		/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R */
> -		.pixel_clock	= 35500,
> -		.hfp		= 48,
> -		.hsw		= 32,
> -		.hbp		= 80,
> -		.vfp		= 3,
> -		.vsw		= 4,
> -		.vbp		= 11,
> +		/* 480P */
> +		.pixel_clock	= 30000,
> +		.hfp		= 24,
> +		.hsw		= 40,
> +		.hbp		= 96,
> +		.vfp		= 10,
> +		.vsw		= 3,
> +		.vbp		= 32,
> 	},
>
> -	.x_res		= 800,
> -	.y_res		= 600,
> +	.x_res		= 480,
> +	.y_res		= 720,
> 	.bpp		= 24,
> -#elif defined(CONFIG_PANEL_DVI_HIGHRES)
> -	.timings = {
> -		/* 1024 x 768 @ 60 Hz Reduced blanking */
> -		.pixel_clock	= 56000,
> -		.hfp		= 48,
> -		.hsw		= 32,
> -		.hbp		= 80,
> -		.vfp		= 3,
> -		.vsw		= 4,
> -		.vbp		= 15,
> -	},
> -
> -	.x_res		= 1024,
> -	.y_res		= 768,
> -	.bpp		= 24,
> -#elif defined(CONFIG_PANEL_DVI_VERYHIGHRES)
> -	.timings = {
> -		/* 1280 x 1024 @ 57 Hz Reduced blanking */
> -		.pixel_clock	= 86500,
> -		.hfp		= 48,
> -		.hsw		= 32,
> -		.hbp		= 80,
> -		.vfp		= 3,
> -		.vsw		= 4,
> -		.vbp		= 15,
> -	},
> -
> -	.x_res		= 1280,
> -	.y_res		= 1024,
> -	.bpp		= 16,
> -#else
> -#error Undefined default mode
> -#endif

Can't the 480p mode the _added_ to the dvi file instead of removing  
all non-480p modes?

regards,

Koen

--Apple-Mail-10--762016465
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJHT5pMkyGM64RGpERApuqAJ9ecdo2gzvqSATXLtGEWfso++qgfQCgm2Y6
Hq4vfibDEEAFqs9b+AQY0jc=
=Av3w
-----END PGP SIGNATURE-----

--Apple-Mail-10--762016465--

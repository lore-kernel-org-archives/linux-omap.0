From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 14:42:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B5DF@dbde02.ent.ti.com>
References: <581B2B1E-B999-4DEB-93A2-1F58B3DDA61D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57514 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYKNJMe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 04:12:34 -0500
In-Reply-To: <581B2B1E-B999-4DEB-93A2-1F58B3DDA61D@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Friday, November 14, 2008 2:31 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org List
> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> FBDEV/DSS Patches
> 
> 
> Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende
> geschreven:
> 
> >
> > +++ b/drivers/video/omap2/panel-dvi.c
> > @@ -52,54 +52,20 @@ static struct omap_panel dvi_panel = {
> > 	.disable	= dvi_panel_disable,
> > 	/*.set_mode	= dvi_set_mode, */
> >
> > -#if defined(CONFIG_PANEL_DVI_LOWRES)
> > 	.timings = {
> > -		/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R
> */
> > -		.pixel_clock	= 35500,
> > -		.hfp		= 48,
> > -		.hsw		= 32,
> > -		.hbp		= 80,
> > -		.vfp		= 3,
> > -		.vsw		= 4,
> > -		.vbp		= 11,
> > +		/* 480P */
> > +		.pixel_clock	= 30000,
> > +		.hfp		= 24,
> > +		.hsw		= 40,
> > +		.hbp		= 96,
> > +		.vfp		= 10,
> > +		.vsw		= 3,
> > +		.vbp		= 32,
> > 	},
> >
> > -	.x_res		= 800,
> > -	.y_res		= 600,
> > +	.x_res		= 480,
> > +	.y_res		= 720,
> > 	.bpp		= 24,
> > -#elif defined(CONFIG_PANEL_DVI_HIGHRES)
> > -	.timings = {
> > -		/* 1024 x 768 @ 60 Hz Reduced blanking */
> > -		.pixel_clock	= 56000,
> > -		.hfp		= 48,
> > -		.hsw		= 32,
> > -		.hbp		= 80,
> > -		.vfp		= 3,
> > -		.vsw		= 4,
> > -		.vbp		= 15,
> > -	},
> > -
> > -	.x_res		= 1024,
> > -	.y_res		= 768,
> > -	.bpp		= 24,
> > -#elif defined(CONFIG_PANEL_DVI_VERYHIGHRES)
> > -	.timings = {
> > -		/* 1280 x 1024 @ 57 Hz Reduced blanking */
> > -		.pixel_clock	= 86500,
> > -		.hfp		= 48,
> > -		.hsw		= 32,
> > -		.hbp		= 80,
> > -		.vfp		= 3,
> > -		.vsw		= 4,
> > -		.vbp		= 15,
> > -	},
> > -
> > -	.x_res		= 1280,
> > -	.y_res		= 1024,
> > -	.bpp		= 16,
> > -#else
> > -#error Undefined default mode
> > -#endif
> 
> Can't the 480p mode the _added_ to the dvi file instead of removing
> all non-480p modes?
> 
[Hiremath, Vaibhav] Since LOWERS/HIGHERS/VERYHIGHERS doesn't convey meaningful information, I thought of changing this. So started with 480P, after addition of more modes say 720P, etc... we will have config option depending on the modes.

> regards,
> 
> Koen

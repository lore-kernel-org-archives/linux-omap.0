From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch to enable omapfb scaling
Date: Wed, 26 Nov 2008 09:29:11 -0800
Message-ID: <20081126172911.GN11997@atomide.com>
References: <490AE1A0.70609@movial.fi> <490F12A5.1000900@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61044 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYKZR3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:29:11 -0500
Content-Disposition: inline
In-Reply-To: <490F12A5.1000900@movial.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tuomas Kulve <tuomas.kulve@movial.fi>
Cc: linux-omap@vger.kernel.org

* Tuomas Kulve <tuomas.kulve@movial.fi> [081103 07:04]:
> Tuomas Kulve wrote:
> > Hi
> > 
> > The attached patch enables omapfb scaling. Tested on omap3 based
> > beagleboard with 2.6.27-omap1 kernel from linux-omap kernel tree.
> 
> The 0002 patch implements downscaling in omapfb. It seems to work on
> ES3.0 beagleboard and ES2.1 EVM but not on my rev B5 beagleboard.
> 
> The patch still needs cleanup but it should work with e.g. X.Org's XV
> extension:
> 
> http://gitweb.pingu.fi/?p=xf86-video-omapfb.git;a=summary

All, I'm not going to push any more omap video patches, those need to
be discussed on fbdev mailing list. So please send the patches against
the mainline kernel there and cc linux-omap mailing list.

Regards,

Tony


> 
> 
> -- 
> Tuomas Kulve, Movial Creative Technologies Inc.
> Porkkalankatu 13J, FI-00180 Helsinki
> Fax +358 9 8567 6401, Tel +358 9 8567 6400
> www.movial.com

> From 069ce763b1a7e936b7b2bdc288d94dd98e477d7e Mon Sep 17 00:00:00 2001
> From: Tuomas Kulve <tuomas.kulve@movial.com>
> Date: Mon, 3 Nov 2008 11:22:56 +0200
> Subject: [PATCH] Implemented video downsampling in omapfb.
> 
> ---
>  drivers/video/omap/dispc.c |   58 ++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 68bc887..83f37bf 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -545,6 +545,17 @@ static void write_firhv_reg(int plane, int reg, u32 value)
>  	dispc_write_reg(base + reg * 8,	value);
>  }
>  
> +static void write_firv_reg(int plane, int reg, u32 value)
> +{
> +	u32 base;
> +
> +	if (plane == 1)
> +		base = 0x1E0;
> +	else
> +		base = 0x1E0 + 0x20;
> +	dispc_write_reg(base + reg * 4,	value);
> +}
> +
>  static void set_upsampling_coef_table(int plane)
>  {
>  	const u32 coef[][2] = {
> @@ -565,6 +576,27 @@ static void set_upsampling_coef_table(int plane)
>  	}
>  }
>  
> +static void set_downsampling_coef_table(int plane)
> +{
> +	const u32 coef[][3] = {
> +		{ 0x24382400, 0x24382400, 0x00000000 },
> +		{ 0x28371FFE, 0x28391F04, 0x000004FE },
> +		{ 0x2C361BFB, 0x2D381B08, 0x000008FB },
> +		{ 0x303516F9, 0x3237170C, 0x00000CF9 },
> +		{ 0x11343311, 0x123737F7, 0x0000F711 },
> +		{ 0x1635300C, 0x173732F9, 0x0000F90C },
> +		{ 0x1B362C08, 0x1B382DFB, 0x0000FB08 },
> +		{ 0x1F372804, 0x1F3928FE, 0x0000FE04 },
> +	};
> +	int i;
> +
> +	for (i = 0; i < 8; i++) {
> +		write_firh_reg(plane, i, coef[i][0]);
> +		write_firhv_reg(plane, i, coef[i][1]);
> +		write_firv_reg(plane, i, coef[i][2]);
> +	}
> +}
> +
>  static int omap_dispc_set_scale(int plane,
>  				int orig_width, int orig_height,
>  				int out_width, int out_height)
> @@ -592,16 +624,32 @@ static int omap_dispc_set_scale(int plane,
>  		if (orig_height > out_height ||
>  		    orig_width * 8 < out_width ||
>  		    orig_height * 8 < out_height) {
> +			dev_dbg(dispc.fbdev->dev,
> +				"Max upsampling is 8x, "
> +				"tried: %dx%d -> %dx%d\n",
> +				orig_width, orig_height,
> +				out_width, out_height);
>  			enable_lcd_clocks(0);
>  			return -EINVAL;
>  		}
>  		set_upsampling_coef_table(plane);
>  	} else if (orig_width > out_width) {
> -		/* Downsampling not yet supported
> -		*/
> -
> -		enable_lcd_clocks(0);
> -		return -EINVAL;
> +		/*
> +		 * Downsampling.
> +		 * Currently you can only scale both dimensions in one way.
> +		 */
> +		if (orig_height < out_height ||
> +		    orig_width > out_width * 4 ||
> +		    orig_height > out_height * 4) {
> +			dev_dbg(dispc.fbdev->dev,
> +				"Max downsampling is 4x, "
> +				"tried: %dx%d -> %dx%d\n",
> +				orig_width, orig_height,
> +				out_width, out_height);
> +			enable_lcd_clocks(0);
> +			return -EINVAL;
> +		}
> +		set_downsampling_coef_table(plane);
>  	}
>  	if (!orig_width || orig_width == out_width)
>  		fir_hinc = 0;
> -- 
> 1.5.6.5
> 

> From fd41a240a99de4c1408097bb39fa89cec4b7868d Mon Sep 17 00:00:00 2001
> From: Tuomas Kulve <tuomas.kulve@movial.com>
> Date: Fri, 31 Oct 2008 20:05:26 +0200
> Subject: [PATCH] Calculate fir_*inc using resolution minus one in omapfb scaling.
> 
> ---
>  drivers/video/omap/dispc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 83f37bf..7ac4a86 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -654,11 +654,11 @@ static int omap_dispc_set_scale(int plane,
>  	if (!orig_width || orig_width == out_width)
>  		fir_hinc = 0;
>  	else
> -		fir_hinc = 1024 * orig_width / out_width;
> +		fir_hinc = 1024 * (orig_width - 1) / (out_width - 1);
>  	if (!orig_height || orig_height == out_height)
>  		fir_vinc = 0;
>  	else
> -		fir_vinc = 1024 * orig_height / out_height;
> +		fir_vinc = 1024 * (orig_height - 1) / (out_height - 1);
>  	dispc.fir_hinc[plane] = fir_hinc;
>  	dispc.fir_vinc[plane] = fir_vinc;
>  
> -- 
> 1.5.6.5
> 




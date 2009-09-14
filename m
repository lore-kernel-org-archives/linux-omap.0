From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] omapfb: Reorder Register_framebuffer call
Date: Mon, 14 Sep 2009 09:43:20 -0500
Message-ID: <A24693684029E5489D1D202277BE89444C327E31@dlee02.ent.ti.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48413 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755607AbZINOnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 10:43:33 -0400
In-Reply-To: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Imre Deak <imre.deak@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This patch has been lying around for some weeks now, with just responses about successful testing (detailed in the description).

Is there anything holding it for merge? Or should I try sending it to other ML?

BTW, It applies cleanly on mainline aswell.

Regards,
Sergio

> -----Original Message-----
> From: Sergio Aguirre [mailto:sergio.a.aguirre@gmail.com] On Behalf Of
> Sergio Aguirre
> Sent: Saturday, September 12, 2009 11:34 AM
> To: Imre Deak
> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-omap@vger.kernel.org;
> Aguirre Rodriguez, Sergio Alberto
> Subject: [PATCH] omapfb: Reorder Register_framebuffer call
> 
> This fixes the issue in which mm_lock mutex was attempted to be
> used without initializing previously.
> 
> Thanks to the testers!
>  - OMAP3430 SDP (Anand Gadiyar)
>  - OMAP3530 EVM (Vaibhav Hiremath)
>  - LogicPD's OMAP boards (Peter Brada)
>  - Beagleboard Rev. C2 (Eric Witcher)
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Anand Gadiyar <gadiyar@ti.com>
> Tested-by: Peter Barada <peterb@logicpd.com>
> Tested-by: Eric Witcher <ewitcher@mindspring.com>
> ---
>  drivers/video/omap/omapfb_main.c |   20 +++++++++++---------
>  1 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/omap/omapfb_main.c
> b/drivers/video/omap/omapfb_main.c
> index 125e605..60f9482 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -1503,12 +1503,21 @@ static int fbinfo_init(struct omapfb_device
> *fbdev, struct fb_info *info)
>  	var->rotate	  = def_rotate;
>  	var->bits_per_pixel = fbdev->panel->bpp;
> 
> +	r = register_framebuffer(info);
> +	if (r != 0) {
> +		dev_err(fbdev->dev,
> +			"registering framebuffer failed\n");
> +		return r;
> +	}
> +
>  	set_fb_var(info, var);
>  	set_fb_fix(info);
> 
>  	r = fb_alloc_cmap(&info->cmap, 16, 0);
> -	if (r != 0)
> +	if (r != 0) {
>  		dev_err(fbdev->dev, "unable to allocate color map memory\n");
> +		unregister_framebuffer(info);
> +	}
> 
>  	return r;
>  }
> @@ -1773,15 +1782,8 @@ static int omapfb_do_probe(struct platform_device
> *pdev,
>  	init_state++;
> 
>  	vram = 0;
> -	for (i = 0; i < fbdev->mem_desc.region_cnt; i++) {
> -		r = register_framebuffer(fbdev->fb_info[i]);
> -		if (r != 0) {
> -			dev_err(fbdev->dev,
> -				"registering framebuffer %d failed\n", i);
> -			goto cleanup;
> -		}
> +	for (i = 0; i < fbdev->mem_desc.region_cnt; i++)
>  		vram += fbdev->mem_desc.region[i].size;
> -	}
> 
>  	fbdev->state = OMAPFB_ACTIVE;
> 
> --
> 1.6.3.2
> 


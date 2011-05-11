From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
Date: Wed, 11 May 2011 09:20:07 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0BA4@dbde02.ent.ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
 <1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1EKDuR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 23:50:17 -0400
In-Reply-To: <1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> Sent: Tuesday, May 10, 2011 9:54 PM
> To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> Cc: Valkeinen, Tomi
> Subject: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
> 
> omapfb_mode_to_timings() had struct fb_info, struct fb_var and struct
> fb_ops allocated from stack. This caused the stack usage grow quite
> high.
> 
> Use kzalloc to allocate the structs instead.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |   49 +++++++++++++++++--------
> -----
>  1 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 30c958b..ae3e2be 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -1996,9 +1996,9 @@ static int omapfb_create_framebuffers(struct
> omapfb2_device *fbdev)
>  static int omapfb_mode_to_timings(const char *mode_str,
>  		struct omap_video_timings *timings, u8 *bpp)
>  {
> -	struct fb_info fbi;
> -	struct fb_var_screeninfo var;
> -	struct fb_ops fbops;
> +	struct fb_info *fbi;
> +	struct fb_var_screeninfo *var;
> +	struct fb_ops *fbops;
>  	int r;
> 
>  #ifdef CONFIG_OMAP2_DSS_VENC
> @@ -2016,25 +2016,25 @@ static int omapfb_mode_to_timings(const char
> *mode_str,
>  	/* this is quite a hack, but I wanted to use the modedb and for
>  	 * that we need fb_info and var, so we create dummy ones */
> 
> -	memset(&fbi, 0, sizeof(fbi));
> -	memset(&var, 0, sizeof(var));
> -	memset(&fbops, 0, sizeof(fbops));
> -	fbi.fbops = &fbops;
> +	fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);

If memory allocation fails, kzalloc would return NULL,
It is good to check for this condition

> +	var = kzalloc(sizeof(*var), GFP_KERNEL);
> +	fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);

Same at these two places

> +	fbi->fbops = fbops;
> 
> -	r = fb_find_mode(&var, &fbi, mode_str, NULL, 0, NULL, 24);
> +	r = fb_find_mode(var, fbi, mode_str, NULL, 0, NULL, 24);
> 
>  	if (r != 0) {
> -		timings->pixel_clock = PICOS2KHZ(var.pixclock);
> -		timings->hbp = var.left_margin;
> -		timings->hfp = var.right_margin;
> -		timings->vbp = var.upper_margin;
> -		timings->vfp = var.lower_margin;
> -		timings->hsw = var.hsync_len;
> -		timings->vsw = var.vsync_len;
> -		timings->x_res = var.xres;
> -		timings->y_res = var.yres;
> -
> -		switch (var.bits_per_pixel) {
> +		timings->pixel_clock = PICOS2KHZ(var->pixclock);
> +		timings->hbp = var->left_margin;
> +		timings->hfp = var->right_margin;
> +		timings->vbp = var->upper_margin;
> +		timings->vfp = var->lower_margin;
> +		timings->hsw = var->hsync_len;
> +		timings->vsw = var->vsync_len;
> +		timings->x_res = var->xres;
> +		timings->y_res = var->yres;
> +
> +		switch (var->bits_per_pixel) {
>  		case 16:
>  			*bpp = 16;
>  			break;
> @@ -2045,10 +2045,17 @@ static int omapfb_mode_to_timings(const char
> *mode_str,
>  			break;
>  		}
> 
> -		return 0;
> +		r = 0;
>  	} else {
> -		return -EINVAL;
> +		*bpp = 0;
> +		r = -EINVAL;
>  	}
> +
> +	kfree(fbi);
> +	kfree(var);
> +	kfree(fbops);
> +
> +	return r;
>  }
> 
>  static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

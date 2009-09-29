From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 17:22:40 +0300
Message-ID: <1254234160.23991.1.camel@tubuntu>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31441 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbZI2OWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 10:22:44 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-09-29 at 16:14 +0200, ext Aguirre Rodriguez, Sergio Alberto
wrote:
> From: Sergio Aguirre <saaguirre@ti.com>
> 
> Acquiring mutex before framebuffer registration doesn't make sense,
> As there's no danger of external access to the memory related fields.

What problem does this patch solve? It makes the code more complex.

 Tomi

> 
> NOTE: PLEASE REVIEW! I'M NOT AN EXPERT ON THIS.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/video/omap/omapfb_main.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 125e605..0d0c8c8 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -393,7 +393,7 @@ static void omapfb_sync(struct fb_info *fbi)
>   * Set fb_info.fix fields and also updates fbdev.
>   * When calling this fb_info.var must be set up already.
>   */
> -static void set_fb_fix(struct fb_info *fbi)
> +static void set_fb_fix(struct fb_info *fbi, int from_init)
>  {
>  	struct fb_fix_screeninfo *fix = &fbi->fix;
>  	struct fb_var_screeninfo *var = &fbi->var;
> @@ -403,10 +403,16 @@ static void set_fb_fix(struct fb_info *fbi)
>  
>  	rg = &plane->fbdev->mem_desc.region[plane->idx];
>  	fbi->screen_base	= rg->vaddr;
> -	mutex_lock(&fbi->mm_lock);
> -	fix->smem_start		= rg->paddr;
> -	fix->smem_len		= rg->size;
> -	mutex_unlock(&fbi->mm_lock);
> +
> +	if (!from_init) {
> +		mutex_lock(&fbi->mm_lock);
> +		fix->smem_start		= rg->paddr;
> +		fix->smem_len		= rg->size;
> +		mutex_unlock(&fbi->mm_lock);
> +	} else {
> +		fix->smem_start		= rg->paddr;
> +		fix->smem_len		= rg->size;
> +	}
>  
>  	fix->type = FB_TYPE_PACKED_PIXELS;
>  	bpp = var->bits_per_pixel;
> @@ -704,7 +710,7 @@ static int omapfb_set_par(struct fb_info *fbi)
>  	int r = 0;
>  
>  	omapfb_rqueue_lock(fbdev);
> -	set_fb_fix(fbi);
> +	set_fb_fix(fbi, 0);
>  	r = ctrl_change_mode(fbi);
>  	omapfb_rqueue_unlock(fbdev);
>  
> @@ -904,7 +910,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
>  		if (old_size != size) {
>  			if (size) {
>  				memcpy(&fbi->var, new_var, sizeof(fbi->var));
> -				set_fb_fix(fbi);
> +				set_fb_fix(fbi, 0);
>  			} else {
>  				/*
>  				 * Set these explicitly to indicate that the
> @@ -1504,7 +1510,7 @@ static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info)
>  	var->bits_per_pixel = fbdev->panel->bpp;
>  
>  	set_fb_var(info, var);
> -	set_fb_fix(info);
> +	set_fb_fix(info, 1);
>  
>  	r = fb_alloc_cmap(&info->cmap, 16, 0);
>  	if (r != 0)


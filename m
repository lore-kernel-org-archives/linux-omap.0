From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Tue, 30 Mar 2010 13:39:48 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBF3A3@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47643 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab0C3IJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 04:09:58 -0400
In-Reply-To: <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, March 22, 2010 6:40 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> In case of 720P with 90/270 degree rotation, the system reports
> GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able to
> fill
> the FIFO as per requirement.
> 
> In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> 
> "To improve the performance on 90 degree rotation, split the data access on
> write side and not read side."
> 
> That means, read should always happen on 0 degree and write should go to
> respective rotation view.


[Hiremath, Vaibhav] Tomi,

Any comment on this patch.

Thanks,
Vaibhav

> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |   85 +++++++++++++++++++--------
> --
>  1 files changed, 56 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 4a76917..fea6b08 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -184,6 +184,11 @@ static unsigned omapfb_get_vrfb_offset(const struct
> omapfb_info *ofbi, int rot)
>  static u32 omapfb_get_region_rot_paddr(const struct omapfb_info *ofbi, int
> rot)
>  {
>  	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
> +		if (rot == FB_ROTATE_CW)
> +			rot = FB_ROTATE_CCW;
> +		else if (rot == FB_ROTATE_CCW)
> +			rot = FB_ROTATE_CW;
> +
>  		return ofbi->region.vrfb.paddr[rot]
>  			+ omapfb_get_vrfb_offset(ofbi, rot);
>  	} else {
> @@ -191,20 +196,32 @@ static u32 omapfb_get_region_rot_paddr(const struct
> omapfb_info *ofbi, int rot)
>  	}
>  }
> 
> -static u32 omapfb_get_region_paddr(const struct omapfb_info *ofbi)
> +static u32 omapfb_get_region_paddr(struct omapfb_info *ofbi, int rot)
>  {
> -	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
> -		return ofbi->region.vrfb.paddr[0];
> -	else
> +	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
> +		if (rot == FB_ROTATE_CW)
> +			rot = FB_ROTATE_CCW;
> +		else if (rot == FB_ROTATE_CCW)
> +			rot = FB_ROTATE_CW;
> +
> +		return ofbi->region.vrfb.paddr[rot];
> +	} else {
>  		return ofbi->region.paddr;
> +	}
>  }
> 
> -static void __iomem *omapfb_get_region_vaddr(const struct omapfb_info
> *ofbi)
> +static void __iomem *omapfb_get_region_vaddr(struct omapfb_info *ofbi, int
> rot)
>  {
> -	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
> -		return ofbi->region.vrfb.vaddr[0];
> -	else
> +	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
> +		if (rot == FB_ROTATE_CW)
> +			rot = FB_ROTATE_CCW;
> +		else if (rot == FB_ROTATE_CCW)
> +			rot = FB_ROTATE_CW;
> +
> +		return ofbi->region.vrfb.vaddr[rot];
> +	} else {
>  		return ofbi->region.vaddr;
> +	}
>  }
> 
>  static struct omapfb_colormode omapfb_colormodes[] = {
> @@ -503,7 +520,7 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
>  	unsigned bytespp;
>  	bool yuv_mode;
>  	enum omap_color_mode mode;
> -	int r;
> +	int r, rotation = var->rotate;
>  	bool reconf;
> 
>  	if (!rg->size || ofbi->rotation_type != OMAP_DSS_ROT_VRFB)
> @@ -511,6 +528,11 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
> 
>  	DBG("setup_vrfb_rotation\n");
> 
> +	if (rotation == FB_ROTATE_CW)
> +		rotation = FB_ROTATE_CCW;
> +	else if (rotation == FB_ROTATE_CCW)
> +		rotation = FB_ROTATE_CW;
> +
>  	r = fb_mode_to_dss_mode(var, &mode);
>  	if (r)
>  		return r;
> @@ -534,32 +556,35 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
>  			vrfb->yres != var->yres_virtual)
>  		reconf = true;
> 
> -	if (vrfb->vaddr[0] && reconf) {
> +	if (vrfb->vaddr[rotation] && reconf) {
>  		fbi->screen_base = NULL;
>  		fix->smem_start = 0;
>  		fix->smem_len = 0;
> -		iounmap(vrfb->vaddr[0]);
> -		vrfb->vaddr[0] = NULL;
> +		iounmap(vrfb->vaddr[rotation]);
> +		vrfb->vaddr[rotation] = NULL;
>  		DBG("setup_vrfb_rotation: reset fb\n");
>  	}
> 
> -	if (vrfb->vaddr[0])
> +	if (vrfb->vaddr[rotation])
>  		return 0;
> 
> -	omap_vrfb_setup(&rg->vrfb, rg->paddr,
> -			var->xres_virtual,
> -			var->yres_virtual,
> -			bytespp, yuv_mode);
> +	if (rotation == FB_ROTATE_CW || rotation == FB_ROTATE_CCW)
> +		omap_vrfb_setup(&rg->vrfb, rg->paddr,
> +				var->yres_virtual, var->xres_virtual,
> +				bytespp, yuv_mode);
> +	else
> +		omap_vrfb_setup(&rg->vrfb, rg->paddr,
> +				var->xres_virtual, var->yres_virtual,
> +				bytespp, yuv_mode);
> 
> -	/* Now one can ioremap the 0 angle view */
> -	r = omap_vrfb_map_angle(vrfb, var->yres_virtual, 0);
> +	/* Now one can ioremap the rotation angle view */
> +	r = omap_vrfb_map_angle(vrfb, var->yres_virtual, rotation);
>  	if (r)
>  		return r;
> -
>  	/* used by open/write in fbmem.c */
> -	fbi->screen_base = ofbi->region.vrfb.vaddr[0];
> +	fbi->screen_base = ofbi->region.vrfb.vaddr[rotation];
> 
> -	fix->smem_start = ofbi->region.vrfb.paddr[0];
> +	fix->smem_start = ofbi->region.vrfb.paddr[rotation];
> 
>  	switch (var->nonstd) {
>  	case OMAPFB_COLOR_YUV422:
> @@ -603,7 +628,8 @@ void set_fb_fix(struct fb_info *fbi)
>  	DBG("set_fb_fix\n");
> 
>  	/* used by open/write in fbmem.c */
> -	fbi->screen_base = (char __iomem *)omapfb_get_region_vaddr(ofbi);
> +	fbi->screen_base = (char __iomem *)omapfb_get_region_vaddr(ofbi,
> +			var->rotate);
> 
>  	/* used by mmap in fbmem.c */
>  	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
> @@ -626,7 +652,7 @@ void set_fb_fix(struct fb_info *fbi)
>  		fix->smem_len = rg->size;
>  	}
> 
> -	fix->smem_start = omapfb_get_region_paddr(ofbi);
> +	fix->smem_start = omapfb_get_region_paddr(ofbi, var->rotate);
> 
>  	fix->type = FB_TYPE_PACKED_PIXELS;
> 
> @@ -862,15 +888,15 @@ static int omapfb_setup_overlay(struct fb_info *fbi,
> struct omap_overlay *ovl,
> 
> 
>  	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
> -		data_start_p = omapfb_get_region_rot_paddr(ofbi, rotation);
> +		data_start_p = omapfb_get_region_rot_paddr(ofbi, 0);
>  		data_start_v = NULL;
>  	} else {
> -		data_start_p = omapfb_get_region_paddr(ofbi);
> -		data_start_v = omapfb_get_region_vaddr(ofbi);
> +		data_start_p = omapfb_get_region_paddr(ofbi, 0);
> +		data_start_v = omapfb_get_region_vaddr(ofbi, 0);
>  	}
> 
>  	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
> -		offset = calc_rotation_offset_vrfb(var, fix, rotation);
> +		offset = calc_rotation_offset_vrfb(var, fix, 0);
>  	else
>  		offset = calc_rotation_offset_dma(var, fix, rotation);
> 
> @@ -1078,6 +1104,7 @@ static struct vm_operations_struct mmap_user_ops = {
>  static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
>  {
>  	struct omapfb_info *ofbi = FB2OFB(fbi);
> +	struct fb_var_screeninfo *var = &fbi->var;
>  	struct fb_fix_screeninfo *fix = &fbi->fix;
>  	unsigned long off;
>  	unsigned long start;
> @@ -1089,7 +1116,7 @@ static int omapfb_mmap(struct fb_info *fbi, struct
> vm_area_struct *vma)
>  		return -EINVAL;
>  	off = vma->vm_pgoff << PAGE_SHIFT;
> 
> -	start = omapfb_get_region_paddr(ofbi);
> +	start = omapfb_get_region_paddr(ofbi, var->rotate);
>  	len = fix->smem_len;
>  	if (off >= len)
>  		return -EINVAL;
> --
> 1.6.2.4


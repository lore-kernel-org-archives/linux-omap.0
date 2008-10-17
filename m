From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: Remove casting and change coding style
Date: Fri, 17 Oct 2008 14:34:52 -0700
Message-ID: <20081017213451.GA18573@atomide.com>
References: <c656a4d20809180549y7ad49f40tb235a52ac6d9de8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53849 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbYJQVey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:34:54 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20809180549y7ad49f40tb235a52ac6d9de8f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* arun c <arun.edarath@gmail.com> [080918 05:49]:
> As sugested by RMK

Pushing today.

Tony

> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  arch/arm/plat-omap/include/mach/omapfb.h |    4 ++--
>  drivers/video/omap/omapfb_main.c         |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/omapfb.h
> b/arch/arm/plat-omap/include/mach/omapfb.h
> index a4a84f3..a3c4408 100644
> --- a/arch/arm/plat-omap/include/mach/omapfb.h
> +++ b/arch/arm/plat-omap/include/mach/omapfb.h
> @@ -276,8 +276,8 @@ typedef int (*omapfb_notifier_callback_t)(struct
> notifier_block *,
>  					  void *fbi);
> 
>  struct omapfb_mem_region {
> -	dma_addr_t	paddr;
> -	void		*vaddr;
> +	u32		paddr;
> +	void __iomem	*vaddr;
>  	unsigned long	size;
>  	u8		type;		/* OMAPFB_PLANE_MEM_* */
>  	unsigned	alloc:1;	/* allocated by the driver */
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index d176a2c..3bb4247 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -402,7 +402,7 @@ static void set_fb_fix(struct fb_info *fbi)
>  	int bpp;
> 
>  	rg = &plane->fbdev->mem_desc.region[plane->idx];
> -	fbi->screen_base	= (char __iomem *)rg->vaddr;
> +	fbi->screen_base	= rg->vaddr;
>  	fix->smem_start		= rg->paddr;
>  	fix->smem_len		= rg->size;
> 
> @@ -1718,8 +1718,8 @@ static int omapfb_do_probe(struct platform_device *pdev,
> 
>  	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);
> 
> -	def_vxres = def_vxres ? : fbdev->panel->x_res;
> -	def_vyres = def_vyres ? : fbdev->panel->y_res;
> +	def_vxres = def_vxres ? def_vxres : fbdev->panel->x_res;
> +	def_vyres = def_vyres ? def_vyres : fbdev->panel->y_res;
> 
>  	init_state++;
> 
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

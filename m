From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Mon, 5 Mar 2012 16:10:14 -0800
Message-ID: <20120306001014.GR12083@atomide.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54029 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021Ab2CFAKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 19:10:19 -0500
Content-Disposition: inline
In-Reply-To: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

* Rob Clark <rob.clark@linaro.org> [120305 08:24]:
> From: Andy Gross <andy.gross@ti.com>
> 
> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> the device to use for buffer allocation.  DMM is split into a
> separate device using hwmod.
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -21,10 +21,10 @@
>  #include <plat/board.h>
>  #include <plat/vram.h>
>  #include <plat/dsp.h>
> +#include <plat/drm.h>
>  
>  #include <plat/omap-secure.h>
>  
> -
>  #define NO_LENGTH_CHECK 0xffffffff
>  
>  struct omap_board_config_kernel *omap_board_config __initdata;
> @@ -65,6 +65,7 @@ const void *__init omap_get_var_config(u16 tag, size_t *len)
>  
>  void __init omap_reserve(void)
>  {
> +	omapdrm_reserve_vram();
>  	omapfb_reserve_sdram_memblock();
>  	omap_vram_reserve_sdram_memblock();
>  	omap_dsp_reserve_sdram_memblock();

Tomi needs to look at the vram changes here.

> --- /dev/null
> +++ b/arch/arm/plat-omap/drm.c

This file would be better in mach-omap2/drm.c. I doubt that this will
ever be usable for omap1. But other than that, up to Tomi.

Tony

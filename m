From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix build break for omapdrm
Date: Mon, 21 Jan 2013 10:20:57 -0800
Message-ID: <20130121182057.GC22517@atomide.com>
References: <1358696243-3604-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:32910 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008Ab3AUSU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:20:59 -0500
Content-Disposition: inline
In-Reply-To: <1358696243-3604-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

* Rob Clark <robdclark@gmail.com> [130120 07:40]:
> Fixes compile break with 3.8-rc4.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Thanks applying into omap-for-v3.8-rc4/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/drm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
> index 4c7566c..2a2cfa8 100644
> --- a/arch/arm/mach-omap2/drm.c
> +++ b/arch/arm/mach-omap2/drm.c
> @@ -25,6 +25,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_data/omap_drm.h>
>  
> +#include "soc.h"
>  #include "omap_device.h"
>  #include "omap_hwmod.h"
>  
> @@ -56,7 +57,7 @@ static int __init omap_init_drm(void)
>  			oh->name);
>  	}
>  
> -	platform_data.omaprev = GET_OMAP_REVISION();
> +	platform_data.omaprev = GET_OMAP_TYPE;
>  
>  	return platform_device_register(&omap_drm_device);
>  
> -- 
> 1.8.1
> 

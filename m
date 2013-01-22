From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: Fix build break in drm.c
Date: Tue, 22 Jan 2013 10:25:50 -0800
Message-ID: <20130122182549.GL15361@atomide.com>
References: <1358843328-8178-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31907 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754023Ab3AVSZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 13:25:52 -0500
Content-Disposition: inline
In-Reply-To: <1358843328-8178-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Archit Taneja <archit@ti.com> [130122 00:32]:
> Building omapdrm leads to a build break because of a missing include needed
> for the macro GET_OMAP_REVISION(). Add the missing inlclude.

Thanks I already have a similar patch from Rob queued up.

Tony
 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/mach-omap2/drm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
> index 4c7566c..6b1a8df 100644
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
> -- 
> 1.7.9.5
> 

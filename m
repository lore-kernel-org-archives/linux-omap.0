From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: remove duplicated #include's
Date: Mon, 23 Mar 2009 12:35:34 -0700
Message-ID: <20090323193533.GH29546@atomide.com>
References: <1237614664-3120-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56521 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759592AbZCWTfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 15:35:30 -0400
Content-Disposition: inline
In-Reply-To: <1237614664-3120-1-git-send-email-weiyi.huang@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Huang Weiyi <weiyi.huang@gmail.com> [090320 22:58]:
> Remove duplicated #include's.
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Looks like this is not omap specific..

So please do the mach-s3c2412 change in a separate patch
and repost.

Or change the subject of the whole patch and upload it to
Russell's patch system.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/mcbsp.c       |    1 -
>  arch/arm/mach-s3c2412/mach-jive.c |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index a9e631f..f548bf4 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -19,7 +19,6 @@
>  
>  #include <mach/irqs.h>
>  #include <mach/dma.h>
> -#include <mach/irqs.h>
>  #include <mach/mux.h>
>  #include <mach/cpu.h>
>  #include <mach/mcbsp.h>
> diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
> index ecddbbb..6e85625 100644
> --- a/arch/arm/mach-s3c2412/mach-jive.c
> +++ b/arch/arm/mach-s3c2412/mach-jive.c
> @@ -52,7 +52,6 @@
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
>  #include <plat/udc.h>
> -#include <plat/iic.h>
>  
>  static struct map_desc jive_iodesc[] __initdata = {
>  };
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

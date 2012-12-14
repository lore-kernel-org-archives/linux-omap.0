From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: OMAP4: remove duplicated include from
 omap_hwmod_44xx_data.c
Date: Fri, 14 Dec 2012 10:19:03 -0800
Message-ID: <20121214181902.GA4989@atomide.com>
References: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54617 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756825Ab2LNSTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:19:12 -0500
Content-Disposition: inline
In-Reply-To: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: b-cousson@ti.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [121128 18:48]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e5eda55..f13fdbb 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -26,7 +26,6 @@
>  
>  #include <plat-omap/dma-omap.h>
>  
> -#include <linux/platform_data/omap_ocp2scp.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  #include <plat/dmtimer.h>
> 
> 

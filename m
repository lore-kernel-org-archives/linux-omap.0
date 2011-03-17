From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
Date: Thu, 17 Mar 2011 10:21:09 -0700
Message-ID: <874o718xyy.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-12-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43126 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab1CQRVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:21:16 -0400
Received: by mail-gy0-f181.google.com with SMTP id 13so1773101gyg.40
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:21:12 -0700 (PDT)
In-Reply-To: <1299338962-5602-12-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Error label case seems to have a 2 tab indentation when just 1 is
> necessary.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.40.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 2b6fdc7..1e52d61 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -276,16 +276,16 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	return ret;
>  
>  error:
> -		iounmap(sr_info->base);
> -		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
> -		release_mem_region(mem->start, resource_size(mem));
> -		list_del(&sr_info->node);
> -		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
> -			"interrupt handler. Smartreflex will"
> -			"not function as desired\n", __func__);
> -		kfree(name);
> -		kfree(sr_info);
> -		return ret;
> +	iounmap(sr_info->base);
> +	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mem->start, resource_size(mem));
> +	list_del(&sr_info->node);
> +	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
> +		"interrupt handler. Smartreflex will"
> +		"not function as desired\n", __func__);
> +	kfree(name);
> +	kfree(sr_info);
> +	return ret;
>  }
>  
>  static void sr_v1_disable(struct omap_sr *sr)

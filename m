From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: DMA: fix error handling in
 omap1_system_dma_init()
Date: Wed, 8 May 2013 16:10:34 -0700
Message-ID: <20130508231034.GP32546@atomide.com>
References: <CAPgLHd-5cRFtN-rF8c5Jvg9cqE3jvxuOa6KaDgcoYHPM4DhbMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34384 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774Ab3EHXKq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 19:10:46 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd-5cRFtN-rF8c5Jvg9cqE3jvxuOa6KaDgcoYHPM4DhbMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Wei Yongjun <weiyj.lk@gmail.com> [130426 01:36]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing iounmap() before return from omap1_system_dma_init()
> in the error handling case.
> Also removed platform_device_del() on add resources error case which
> cause dup device delete.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> no compile test.

Seems to work, applying into omap-for-v3.10/fixes thanks.

Tony

>  arch/arm/mach-omap1/dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 1a4e887..68ab858 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -301,7 +301,7 @@ static int __init omap1_system_dma_init(void)
>  	if (ret) {
>  		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
>  			__func__, pdev->name, pdev->id);
> -		goto exit_device_put;
> +		goto exit_iounmap;
>  	}
>  
>  	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
> @@ -309,7 +309,7 @@ static int __init omap1_system_dma_init(void)
>  		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
>  			__func__, pdev->name);
>  		ret = -ENOMEM;
> -		goto exit_device_del;
> +		goto exit_iounmap;
>  	}
>  
>  	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
> @@ -402,8 +402,8 @@ exit_release_d:
>  	kfree(d);
>  exit_release_p:
>  	kfree(p);
> -exit_device_del:
> -	platform_device_del(pdev);
> +exit_iounmap:
> +	iounmap(dma_base);
>  exit_device_put:
>  	platform_device_put(pdev);
>  
> 

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix error return code in
 omap1_system_dma_init()
Date: Thu, 16 May 2013 10:48:47 -0700
Message-ID: <20130516174847.GD5600@atomide.com>
References: <CAPgLHd8iPa4efHsYsCmGE-j-GzZw7DtWdSaQqpEuF60-BRtmbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11967 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751744Ab3EPRs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 13:48:56 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd8iPa4efHsYsCmGE-j-GzZw7DtWdSaQqpEuF60-BRtmbg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Wei Yongjun <weiyj.lk@gmail.com> [130512 21:30]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENOMEM in the d->chan alloc error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, applying into omap-for-v3.10/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap1/dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 68ab858..a94b3a7 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -345,6 +345,7 @@ static int __init omap1_system_dma_init(void)
>  		dev_err(&pdev->dev,
>  			"%s: Memory allocation failed for d->chan!\n",
>  			__func__);
> +		ret = -ENOMEM;
>  		goto exit_release_d;
>  	}
>  
> 

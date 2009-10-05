From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v2] SDMA: Fixing bug in omap_dma_set_global_params()
Date: Mon, 5 Oct 2009 09:41:02 -0700
Message-ID: <20091005094102.1385b418.rdunlap@xenotime.net>
References: <1254732163-3509-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:60664 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753082AbZJEQth (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 12:49:37 -0400
Received: from chimera.site ([96.253.169.185]) by xenotime.net for <linux-omap@vger.kernel.org>; Mon, 5 Oct 2009 09:48:59 -0700
In-Reply-To: <1254732163-3509-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, svenkatr@ti.com, tony@atomide.com

On Mon,  5 Oct 2009 14:12:43 +0530 Anuj Aggarwal wrote:

> Argument tparams was not being used to program
> global register GCR.HI_THREAD_RESERVED. This patch fixes the same.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)


Hi,
Someone please convert all of this source file to correct kernel-doc notation.

Thanks.

> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index fd3154a..0eb676d 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -829,10 +829,10 @@ EXPORT_SYMBOL(omap_free_dma);
>   *
>   * @param arb_rate
>   * @param max_fifo_depth
> - * @param tparams - Number of thereads to reserve : DMA_THREAD_RESERVE_NORM
> - * 						    DMA_THREAD_RESERVE_ONET
> - * 						    DMA_THREAD_RESERVE_TWOT
> - * 						    DMA_THREAD_RESERVE_THREET
> + * @param tparams - Number of threads to reserve : DMA_THREAD_RESERVE_NORM
> + * 						   DMA_THREAD_RESERVE_ONET
> + * 						   DMA_THREAD_RESERVE_TWOT
> + * 						   DMA_THREAD_RESERVE_THREET
>   */
>  void
>  omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
> @@ -844,11 +844,14 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
>  		return;
>  	}
>  
> +	if (max_fifo_depth == 0)
> +		max_fifo_depth = 1;
>  	if (arb_rate == 0)
>  		arb_rate = 1;
>  
> -	reg = (arb_rate & 0xff) << 16;
> -	reg |= (0xff & max_fifo_depth);
> +	reg = 0xff & max_fifo_depth;
> +	reg |= (0x3 & tparams) << 12;
> +	reg |= (arb_rate & 0xff) << 16;
>  
>  	dma_write(reg, GCR);
>  }
> -- 


---
~Randy

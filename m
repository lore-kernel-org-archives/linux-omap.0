From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DMA: OMAP: Remove extra looping from omap_request_dma
Date: Fri, 1 Jul 2011 00:19:42 -0700
Message-ID: <20110701071942.GC23145@atomide.com>
References: <1309356549.3995.13.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309356549.3995.13.camel@quad>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Scott Ellis <scott@jumpnowtek.com> [110629 20:58]:
> Break from dma channel search when a free one is found.

Care to describe how the current code is not finding a
free channel currently?

Tony

 
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
> ---
>  arch/arm/plat-omap/dma.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c22217c..3d36fcf 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -678,10 +678,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  
>  	spin_lock_irqsave(&dma_chan_lock, flags);
>  	for (ch = 0; ch < dma_chan_count; ch++) {
> -		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
> +		if (dma_chan[ch].dev_id == -1) {
>  			free_ch = ch;
> -			if (dev_id == 0)
> -				break;
> +			break;
>  		}
>  	}
>  	if (free_ch == -1) {
> 

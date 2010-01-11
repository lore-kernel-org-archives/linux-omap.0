From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: dma_chan[lch_head].flag & OMAP_DMA_ACTIVE tested
 twice in omap_dma_unlink_lch()
Date: Mon, 11 Jan 2010 15:14:15 -0800
Message-ID: <20100111231415.GE5055@atomide.com>
References: <4B488ABF.4070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752322Ab0AKXOM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B488ABF.4070403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roel Kluin <roel.kluin@gmail.com> [100109 05:49]:
> The same flag and bits were tested twice.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/arm/plat-omap/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Is this what was intended? please review.

Thanks, nice catch. Will queue into omap-fixes.

Regards,

Tony
 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 09d82b3..728c642 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1183,7 +1183,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
>  	}
>  
>  	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
> -	    (dma_chan[lch_head].flags & OMAP_DMA_ACTIVE)) {
> +	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
>  		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
>  		       "before unlinking\n");
>  		dump_stack();

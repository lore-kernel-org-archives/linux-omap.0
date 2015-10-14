From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/5] mtd: nand: omap2: Start dma request before enabling
 prefetch
Date: Wed, 14 Oct 2015 14:41:15 +0300
Message-ID: <561E3F5B.6040102@ti.com>
References: <1444700338-27582-1-git-send-email-fcooper@ti.com>
 <1444700338-27582-3-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444700338-27582-3-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 13/10/15 04:38, Franklin S Cooper Jr wrote:
> The prefetch engine sends a dma request once a FIFO threshold has
> been met. No other requests are received until the previous request
> is handled.
> 
> Starting an edma transfer (dma_async_issue_pending) results in any
> previous event for the dma channel to be cleared. Therefore, starting
> the prefetch engine before initiating the dma transfer may result in
> the prefetch triggering a dma request but instead of it being handled
> it can end up being cleared. This will result in a hang since the code
> will continue to wait for the dma request to complete.
> 
> By initiating the dma request before enabling the prefetch engine this
> race condition is avoided and no dma request are missed/cleared.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/mtd/nand/omap2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 957c32f..94d11de 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -509,6 +509,9 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>  	tx->callback_param = &info->comp;
>  	dmaengine_submit(tx);
>  
> +	init_completion(&info->comp);
> +	dma_async_issue_pending(info->dma);
> +
>  	/*  configure and start prefetch transfer */
>  	ret = omap_prefetch_enable(info->gpmc_cs,
>  		PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write, info);
> @@ -516,9 +519,6 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>  		/* PFPW engine is busy, use cpu copy method */
>  		goto out_copy_unmap;
>  
> -	init_completion(&info->comp);
> -	dma_async_issue_pending(info->dma);
> -
>  	/* setup and start DMA using dma_addr */

Is the above comment misplaced after this change?

>  	wait_for_completion(&info->comp);
>  	tim = 0;
> 

cheers,
-roger

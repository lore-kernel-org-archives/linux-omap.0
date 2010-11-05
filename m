From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: dma: Add read-back to DMA interrupt handler to
 avoid spurious interrupts
Date: Fri, 5 Nov 2010 09:51:02 -0700
Message-ID: <20101105165102.GN9264@atomide.com>
References: <1288017324-2181-1-git-send-email-mathias.nyman@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62749 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0KEQvS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:51:18 -0400
Content-Disposition: inline
In-Reply-To: <1288017324-2181-1-git-send-email-mathias.nyman@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathias Nyman <mathias.nyman@nokia.com>
Cc: linux-omap@vger.kernel.org

* Mathias Nyman <mathias.nyman@nokia.com> [101025 07:22]:
> Flush the writes to IRQSTATUS_L0 register in the DMA interrupt handler by reading the register
> directly after write. This prevents the spurious DMA interrupts noted when using VDD_OPP 1

Adding this to omap-fixes. For future arch/arm/*omap*/ patches,
please always Cc also linux-arm-kernel list. That way I can
apply the patch without a need to repost.

Regards,

Tony
 
> Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index f5c5b8d..2c28265 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1983,6 +1983,8 @@ static int omap2_dma_handle_ch(int ch)
>  
>  	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));
>  	dma_write(1 << ch, IRQSTATUS_L0);
> +	/* read back the register to flush the write */
> +	dma_read(IRQSTATUS_L0);
>  
>  	/* If the ch is not chained then chain_id will be -1 */
>  	if (dma_chan[ch].chain_id != -1) {
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

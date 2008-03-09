From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: DMA: fix CLINK mask, clear spurious interrupt
Date: Sun, 9 Mar 2008 12:54:58 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088057E388F@dbde01.ent.ti.com>
References: <1204926553-6228-1-git-send-email-khilman@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56770 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbYCIHad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Mar 2008 03:30:33 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1204926553-6228-1-git-send-email-khilman@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

Ack. Meant to send in this fix this weekend. 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, March 08, 2008 3:19 AM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman
> Subject: [PATCH] ARM: OMAP: DMA: fix CLINK mask, clear 
> spurious interrupt
> 
> Some bugfixes from the TI CDP kernel.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  arch/arm/plat-omap/dma.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 3e94683..008b5dd 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1020,12 +1020,12 @@ static void create_dma_lch_chain(int 
> lch_head, int lch_queue)
>  	}
>  
>  	w = OMAP_DMA_CLNK_CTRL_REG(lch_head);
> -	w &= ~(0x0f);
> +	w &= ~(0x1f);
>  	w |= lch_queue;
>  	OMAP_DMA_CLNK_CTRL_REG(lch_head) = w;
>  
>  	w = OMAP_DMA_CLNK_CTRL_REG(lch_queue);
> -	w &= ~(0x0f);
> +	w &= ~(0x1f);
>  	w |= (dma_chan[lch_queue].next_linked_ch);
>  	OMAP_DMA_CLNK_CTRL_REG(lch_queue) = w;
>  }
> @@ -1663,6 +1663,7 @@ static int omap2_dma_handle_ch(int ch)
>  	if (!status) {
>  		if (printk_ratelimit())
>  			printk(KERN_WARNING "Spurious DMA IRQ 
> for lch %d\n", ch);
> +		omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
>  		return 0;
>  	}
>  	if (unlikely(dma_chan[ch].dev_id == -1)) {
> -- 
> 1.5.4.1.99.gf1785
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

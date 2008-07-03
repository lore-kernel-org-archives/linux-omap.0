From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] driver: irda support 3430
Date: Thu, 3 Jul 2008 13:37:20 +0300
Message-ID: <20080703103717.GN14276@atomide.com>
References: <63319.192.168.10.89.1215067509.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54588 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbYGCMP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:15:58 -0400
Content-Disposition: inline
In-Reply-To: <63319.192.168.10.89.1215067509.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Girish. S. G." <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Girish. S. G. <girishsg@ti.com> [080703 11:10]:
> Irda driver changes to support on 3430
> 
> Signed-off-by: Girish S G <girishsg@ti.com>
> ---
>  drivers/net/irda/omap-ir.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> Index: linux-omap-2.6_today/drivers/net/irda/omap-ir.c
> ===================================================================
> --- linux-omap-2.6_today.orig/drivers/net/irda/omap-ir.c	2008-07-03
> 10:33:57.000000000 +0530
> +++ linux-omap-2.6_today/drivers/net/irda/omap-ir.c	2008-07-03
> 10:35:30.000000000 +0530
> @@ -217,7 +217,7 @@
>  	struct net_device *dev = data;
>  	struct omap_irda *omap_ir = netdev_priv(dev);
> 
> -	/*Stop DMA controller */
> +	/* Stop DMA controller */
>  	omap_stop_dma(omap_ir->tx_dma_channel);
>  }
> 
> @@ -378,8 +378,12 @@
> 
>  		skb_reserve(skb, 1);
> 
> -		w = omap_get_dma_dst_pos(omap_ir->rx_dma_channel) -
> -						omap_ir->rx_buf_dma_phys;
> +		w = OMAP_DMA4_CDAC(omap_ir->rx_dma_channel);
> +
> +		if (cpu_is_omap16xx())
> +			w -= OMAP1_DMA_CDSA_L(omap_ir->rx_dma_channel);
> +		if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +			w -= OMAP_DMA4_CDSA(omap_ir->rx_dma_channel);
> 
>  		if (!IS_FIR(omap_ir))
>  			/* Copy DMA buffer to skb */

Let's not tinker with the DMA registers again directly just as I
thought I got all that clean-up a bit! :)

Can you rather use the exported functions? If something is missing,
let's add it. But in the above case omap_set_dma_dest_params() and
omap_set_dma_src_params() should work I believe.

Regards,

Tony


> @@ -604,6 +608,8 @@
>  err_irlap:
>  	omap_ir->open = 0;
>  	omap_irda_shutdown(omap_ir);
> +	if (omap_ir->pdata->select_irda)
> +		omap_ir->pdata->select_irda(omap_ir->dev, ~IR_SEL);
>  err_startup:
>  	dma_free_coherent(NULL, IRDA_SIR_MAX_FRAME,
>  			omap_ir->tx_buf_dma_virt, omap_ir->tx_buf_dma_phys);
> @@ -636,6 +642,8 @@
>  				omap_ir->tx_buf_dma_phys);
> 
>  	omap_irda_shutdown(omap_ir);
> +	if (omap_ir->pdata->select_irda)
> +		omap_ir->pdata->select_irda(omap_ir->dev, ~IR_SEL);
> 
>  	/* Stop IrLAP */
>  	if (omap_ir->irlap) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

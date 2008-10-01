From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
Date: Wed, 1 Oct 2008 16:39:07 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E9AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45636 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbYJALJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 07:09:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m91B9AJO009538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 06:09:17 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m91B99jL024104
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 16:39:09 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Thursday, September 25, 2008 3:31 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
> 
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> SDMA channel is not disabled after transaction error. So 
> explicitly disable it.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked By : Nishant kamat <nskamat@ti.com>
> ---
> Index: linux-omap-2.6/arch/arm/plat-omap/dma.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/dma.c 2008-09-23 16:41:23.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/dma.c	2008-09-25 14:54:00.162059260 +0530
> @@ -1849,9 +1849,22 @@ static int omap2_dma_handle_ch(int ch)
>  		printk(KERN_INFO
>  		       "DMA synchronization event drop occurred 
> with device "
>  		       "%d\n", dma_chan[ch].dev_id);
> -	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ))
> +	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
>  		printk(KERN_INFO "DMA transaction error with 
> device %d\n",
>  		       dma_chan[ch].dev_id);
> +		if (cpu_class_is_omap2()) {
> +			/* Errata: sDMA Channel is not disabled
> +			 * after a transaction error. So we explicitely
> +			 * disable the channel
> +			 */
> +			u32 ccr;
> +
> +			ccr = dma_read(CCR(ch));
> +			ccr &= ~OMAP_DMA_CCR_EN;
> +			dma_write(ccr, CCR(ch));
> +			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
> +		}
> +	}
>  	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
>  		printk(KERN_INFO "DMA secure error with device %d\n",
>  		       dma_chan[ch].dev_id);

Tony,
What about this patch ?
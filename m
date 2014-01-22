From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH RFC 03/26] dmaengine: omap-dma: program hardware directly
Date: Wed, 22 Jan 2014 18:24:33 +0530
Message-ID: <52DFBF89.3020102@ti.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1Vyjtf-0005E5-Vw@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45402 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbaAVMzI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jan 2014 07:55:08 -0500
In-Reply-To: <E1Vyjtf-0005E5-Vw@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Thursday 02 January 2014 08:39 PM, Russell King wrote:
> Program the transfer parameters directly into the hardware, rather
> than using the functions in arch/arm/plat-omap/dma.c.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/omap-dma.c   |  144 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h |    6 +-
>  2 files changed, 132 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 3c1bb34aad0a..dd233ca2cf5a 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -99,16 +99,96 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
>  	unsigned idx)
>  {
>  	struct omap_sg *sg = d->sg + idx;
> +	uint32_t val;
> +
> +	if (d->dir == DMA_DEV_TO_MEM) {
> +		if (dma_omap1()) {
> +			val = c->plat->dma_read(CSDP, c->dma_ch);
> +			val &= ~(0x1f << 9);
> +			val |= OMAP_DMA_PORT_EMIFF << 9;
> +			c->plat->dma_write(val, CSDP, c->dma_ch);
> +		}
>  
> -	if (d->dir == DMA_DEV_TO_MEM)
> -		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
> -			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
> -	else
> -		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
> -			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
> +		val = c->plat->dma_read(CCR, c->dma_ch);
> +		val &= ~(0x03 << 14);
> +		val |= OMAP_DMA_AMODE_POST_INC << 14;
> +		c->plat->dma_write(val, CCR, c->dma_ch);
> +
> +		c->plat->dma_write(sg->addr, CDSA, c->dma_ch);
> +		c->plat->dma_write(0, CDEI, c->dma_ch);
> +		c->plat->dma_write(0, CDFI, c->dma_ch);
> +	} else {
> +		if (dma_omap1()) {
> +			val = c->plat->dma_read(CSDP, c->dma_ch);
> +			val &= ~(0x1f << 2);
> +			val |= OMAP_DMA_PORT_EMIFF << 2;
> +			c->plat->dma_write(val, CSDP, c->dma_ch);
> +		}
> +
> +		val = c->plat->dma_read(CCR, c->dma_ch);
> +		val &= ~(0x03 << 12);
> +		val |= OMAP_DMA_AMODE_POST_INC << 12;
> +		c->plat->dma_write(val, CCR, c->dma_ch);
> +
> +		c->plat->dma_write(sg->addr, CSSA, c->dma_ch);
> +		c->plat->dma_write(0, CSEI, c->dma_ch);
> +		c->plat->dma_write(0, CSFI, c->dma_ch);
> +	}
> +
EI and FI are always set to zero. So interleaved transfers support
have to enabled in omap-dma, as it was supported by the
legacy driver. It was not enabled because of no users of the feature,
 right  ?

Regards,
 Sricharan

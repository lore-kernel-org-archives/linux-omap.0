From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
Date: Wed, 22 Jan 2014 18:25:57 +0530
Message-ID: <52DFBFDD.8040506@ti.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39034 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbaAVM42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 07:56:28 -0500
In-Reply-To: <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Hi Russell,

On Thursday 02 January 2014 08:40 PM, Russell King wrote:
> Consolidate the setup of the channel control register.  Prepare the
> basic value in the preparation of the DMA descriptor, and write it into
> the register upon descriptor execution.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/omap-dma.c |  133 ++++++++++++++++-------------------------------
>  1 files changed, 45 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 98928f7209f6..796f882da03c 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -58,8 +58,7 @@ struct omap_desc {
>  
>  	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
>  	uint8_t es;		/* OMAP_DMA_DATA_TYPE_xxx */
> -	uint8_t sync_mode;	/* OMAP_DMA_SYNC_xxx */
> -	uint8_t sync_type;	/* OMAP_DMA_xxx_SYNC* */
> +	uint32_t ccr;		/* CCR value */
>  	uint16_t cicr;		/* CICR value */
>  	uint32_t csdp;		/* CSDP value */
>  
> @@ -228,7 +227,6 @@ static void omap_dma_start_desc(struct omap_chan *c)
>  {
>  	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
>  	struct omap_desc *d;
> -	uint32_t val;
>  
>  	if (!vd) {
>  		c->desc = NULL;
> @@ -240,23 +238,15 @@ static void omap_dma_start_desc(struct omap_chan *c)
>  	c->desc = d = to_omap_dma_desc(&vd->tx);
>  	c->sgidx = 0;
>  
> -	if (d->dir == DMA_DEV_TO_MEM) {
> -		val = c->plat->dma_read(CCR, c->dma_ch);
> -		val &= ~(0x03 << 14 | 0x03 << 12);
> -		val |= OMAP_DMA_AMODE_POST_INC << 14;
> -		val |= OMAP_DMA_AMODE_CONSTANT << 12;
> -		c->plat->dma_write(val, CCR, c->dma_ch);
> +	c->plat->dma_write(d->ccr, CCR, c->dma_ch);
> +	if (dma_omap1())
> +		c->plat->dma_write(d->ccr >> 16, CCR2, c->dma_ch);
>  
> +	if (d->dir == DMA_DEV_TO_MEM) {
>  		c->plat->dma_write(d->dev_addr, CSSA, c->dma_ch);
>  		c->plat->dma_write(0, CSEI, c->dma_ch);
>  		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
>  	} else {
> -		val = c->plat->dma_read(CCR, c->dma_ch);
> -		val &= ~(0x03 << 12 | 0x03 << 14);
> -		val |= OMAP_DMA_AMODE_CONSTANT << 14;
> -		val |= OMAP_DMA_AMODE_POST_INC << 12;
> -		c->plat->dma_write(val, CCR, c->dma_ch);
> -
>  		c->plat->dma_write(d->dev_addr, CDSA, c->dma_ch);
>  		c->plat->dma_write(0, CDEI, c->dma_ch);
>  		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
> @@ -264,47 +254,6 @@ static void omap_dma_start_desc(struct omap_chan *c)
>  
>  	c->plat->dma_write(d->csdp, CSDP, c->dma_ch);
>  
> -	if (dma_omap1()) {
> -		val = c->plat->dma_read(CCR, c->dma_ch);
> -		val &= ~(1 << 5);
> -		if (d->sync_mode == OMAP_DMA_SYNC_FRAME)
> -			val |= 1 << 5;
> -		c->plat->dma_write(val, CCR, c->dma_ch);
> -
> -		val = c->plat->dma_read(CCR2, c->dma_ch);
> -		val &= ~(1 << 2);
> -		if (d->sync_mode == OMAP_DMA_SYNC_BLOCK)
> -			val |= 1 << 2;
> -		c->plat->dma_write(val, CCR2, c->dma_ch);
> -	}
> -
> -	if (dma_omap2plus() && c->dma_sig) {
> -		val = c->plat->dma_read(CCR, c->dma_ch);
> -
> -		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
> -		val &= ~(1 << 24 | 1 << 23 | 3 << 19 | 1 << 18 | 1 << 5 | 0x1f);
> -		val |= (c->dma_sig & ~0x1f) << 14;
> -		val |= c->dma_sig & 0x1f;
> -
> -		if (d->sync_mode & OMAP_DMA_SYNC_FRAME)
> -			val |= 1 << 5;
> -
> -		if (d->sync_mode & OMAP_DMA_SYNC_BLOCK)
> -			val |= 1 << 18;
> -
> -		switch (d->sync_type) {
> -		case OMAP_DMA_DST_SYNC_PREFETCH:/* dest synch */
> -			val |= 1 << 23;		/* Prefetch */
> -			break;
> -		case 0:
> -			break;
> -		default:
> -			val |= 1 << 24; 	/* source synch */
> -			break;
> -		}
> -		c->plat->dma_write(val, CCR, c->dma_ch);
> -	}
> -
>  	omap_dma_start_sg(c, d, 0);
>  }
>  
> @@ -543,19 +492,17 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  	struct scatterlist *sgent;
>  	struct omap_desc *d;
>  	dma_addr_t dev_addr;
> -	unsigned i, j = 0, es, en, frame_bytes, sync_type;
> +	unsigned i, j = 0, es, en, frame_bytes;
>  	u32 burst;
>  
>  	if (dir == DMA_DEV_TO_MEM) {
>  		dev_addr = c->cfg.src_addr;
>  		dev_width = c->cfg.src_addr_width;
>  		burst = c->cfg.src_maxburst;
> -		sync_type = OMAP_DMA_SRC_SYNC;
>  	} else if (dir == DMA_MEM_TO_DEV) {
>  		dev_addr = c->cfg.dst_addr;
>  		dev_width = c->cfg.dst_addr_width;
>  		burst = c->cfg.dst_maxburst;
> -		sync_type = OMAP_DMA_DST_SYNC;
>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> @@ -584,12 +531,20 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  	d->dir = dir;
>  	d->dev_addr = dev_addr;
>  	d->es = es;
> -	d->sync_mode = OMAP_DMA_SYNC_FRAME;
> -	d->sync_type = sync_type;
> +
> +	d->ccr = 0;
> +	if (dir == DMA_DEV_TO_MEM)
> +		d->ccr |= OMAP_DMA_AMODE_POST_INC << 14 |
> +			  OMAP_DMA_AMODE_CONSTANT << 12;
> +	else
> +		d->ccr |= OMAP_DMA_AMODE_CONSTANT << 14 |
> +			  OMAP_DMA_AMODE_POST_INC << 12;
> +
>  	d->cicr = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
>  	d->csdp = es;
>  
>  	if (dma_omap1()) {
> +		d->ccr |= 1 << 5; /* frame sync */
>  		d->cicr |= OMAP1_DMA_TOUT_IRQ;
>  
>  		if (dir == DMA_DEV_TO_MEM)
> @@ -599,6 +554,13 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  			d->csdp |= OMAP_DMA_PORT_TIPB << 9 |
>  				   OMAP_DMA_PORT_EMIFF << 2;
>  	} else if (dma_omap2plus()) {
> +		d->ccr |= (c->dma_sig & ~0x1f) << 14;
> +		d->ccr |= c->dma_sig & 0x1f;
> +		d->ccr |= 1 << 5; /* frame sync */
> +
> +		if (dir == DMA_DEV_TO_MEM)
> +			d->ccr |= 1 << 24; /* source synch */
> +
>  		d->cicr |= OMAP2_DMA_MISALIGNED_ERR_IRQ | OMAP2_DMA_TRANS_ERR_IRQ;
>  	}
>  
> @@ -635,19 +597,17 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>  	enum dma_slave_buswidth dev_width;
>  	struct omap_desc *d;
>  	dma_addr_t dev_addr;
> -	unsigned es, sync_type;
> +	unsigned es;
>  	u32 burst;
>  
>  	if (dir == DMA_DEV_TO_MEM) {
>  		dev_addr = c->cfg.src_addr;
>  		dev_width = c->cfg.src_addr_width;
>  		burst = c->cfg.src_maxburst;
> -		sync_type = OMAP_DMA_SRC_SYNC;
>  	} else if (dir == DMA_MEM_TO_DEV) {
>  		dev_addr = c->cfg.dst_addr;
>  		dev_width = c->cfg.dst_addr_width;
>  		burst = c->cfg.dst_maxburst;
> -		sync_type = OMAP_DMA_DST_SYNC;
>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> @@ -677,15 +637,21 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>  	d->dev_addr = dev_addr;
>  	d->fi = burst;
>  	d->es = es;
> -	if (burst)
> -		d->sync_mode = OMAP_DMA_SYNC_PACKET;
> -	else
> -		d->sync_mode = OMAP_DMA_SYNC_ELEMENT;
> -	d->sync_type = sync_type;
>  	d->sg[0].addr = buf_addr;
>  	d->sg[0].en = period_len / es_bytes[es];
>  	d->sg[0].fn = buf_len / period_len;
>  	d->sglen = 1;
> +
> +	d->ccr = 0;
> +	if (__dma_omap15xx(od->plat->dma_attr))
> +		d->ccr = 3 << 8;
> +	if (dir == DMA_DEV_TO_MEM)
> +		d->ccr |= OMAP_DMA_AMODE_POST_INC << 14 |
> +			  OMAP_DMA_AMODE_CONSTANT << 12;
> +	else
> +		d->ccr |= OMAP_DMA_AMODE_CONSTANT << 14 |
> +			  OMAP_DMA_AMODE_POST_INC << 12;
> +
>  	d->cicr = OMAP_DMA_DROP_IRQ;
>  	if (flags & DMA_PREP_INTERRUPT)
>  		d->cicr |= OMAP_DMA_FRAME_IRQ;
> @@ -702,23 +668,22 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>  			d->csdp |= OMAP_DMA_PORT_MPUI << 9 |
>  				   OMAP_DMA_PORT_EMIFF << 2;
>  	} else if (dma_omap2plus()) {
> +		d->ccr |= (c->dma_sig & ~0x1f) << 14;
> +		d->ccr |= c->dma_sig & 0x1f;
> +
> +		if (burst)
> +			d->ccr |= 1 << 18 | 1 << 5; /* packet */
> +
> +		if (dir == DMA_DEV_TO_MEM)
> +			d->ccr |= 1 << 24; /* source synch */
> +
>  		d->cicr |= OMAP2_DMA_MISALIGNED_ERR_IRQ | OMAP2_DMA_TRANS_ERR_IRQ;
>  
>  		/* src and dst burst mode 16 */
>  		d->csdp |= 3 << 14 | 3 << 7;
>  	}
>  
> -	if (!c->cyclic) {
> -		c->cyclic = true;
> -
> -		if (__dma_omap15xx(od->plat->dma_attr)) {
> -			uint32_t val;
> -
> -			val = c->plat->dma_read(CCR, c->dma_ch);
> -			val |= 3 << 8;
> -			c->plat->dma_write(val, CCR, c->dma_ch);
> -		}
> -	}
> +	c->cyclic = true;
>  
>  	return vchan_tx_prep(&c->vc, &d->vd, flags);
>  }
> @@ -762,14 +727,6 @@ static int omap_dma_terminate_all(struct omap_chan *c)
>  	if (c->cyclic) {
>  		c->cyclic = false;
>  		c->paused = false;
> -
> -		if (__dma_omap15xx(od->plat->dma_attr)) {
> -			uint32_t val;
> -
> -			val = c->plat->dma_read(CCR, c->dma_ch);
> -			val &= ~(3 << 8);
> -			c->plat->dma_write(val, CCR, c->dma_ch);
> -		}
>  	}
>  
>  	vchan_get_all_descriptors(&c->vc, &head);


Setting up of DMA_DST_SYNC_PREFETCH is missing after this ?

Regards,
 Sricharan

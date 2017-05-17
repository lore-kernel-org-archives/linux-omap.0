From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v3 5/9] usb: musb: tusb6010_omap: Create new struct for
 DMA data/parameters
Date: Wed, 17 May 2017 15:17:13 -0500
Message-ID: <20170517201713.GF651@uda0271908>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
 <20170512135752.1800-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512135752.1800-6-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 12, 2017 at 04:57:48PM +0300, Peter Ujfalusi wrote:
> For the DMA we have ch (channel), dmareq and sync_dev parameters both
> within the tusb_omap_dma_ch and tusb_omap_dma_ch struct.
> By creating a common struct the code can be simplified when selecting
> between the shared or multichannel DMA parameters.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/usb/musb/tusb6010_omap.c | 163 ++++++++++++++++++++-------------------
>  1 file changed, 84 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index 025b52e0b34d..938ded0c407b 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -31,6 +31,12 @@
>  #define OMAP242X_DMA_EXT_DMAREQ4	16
>  #define OMAP242X_DMA_EXT_DMAREQ5	64
>  
> +struct tusb_dma_data {
> +	int			ch;
> +	s8			dmareq;
> +	s8			sync_dev;
> +};
> +
>  struct tusb_omap_dma_ch {
>  	struct musb		*musb;
>  	void __iomem		*tbase;
> @@ -39,9 +45,7 @@ struct tusb_omap_dma_ch {
>  	u8			tx;
>  	struct musb_hw_ep	*hw_ep;
>  
> -	int			ch;
> -	s8			dmareq;
> -	s8			sync_dev;
> +	struct tusb_dma_data	dma_data;
>  
>  	struct tusb_omap_dma	*tusb_dma;
>  
> @@ -58,9 +62,7 @@ struct tusb_omap_dma {
>  	struct dma_controller		controller;
>  	void __iomem			*tbase;
>  
> -	int				ch;
> -	s8				dmareq;
> -	s8				sync_dev;
> +	struct tusb_dma_data		dma_data;
>  	unsigned			multichannel:1;
>  };
>  
> @@ -119,9 +121,9 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
>  	spin_lock_irqsave(&musb->lock, flags);
>  
>  	if (tusb_dma->multichannel)
> -		ch = chdat->ch;
> +		ch = chdat->dma_data.ch;
>  	else
> -		ch = tusb_dma->ch;
> +		ch = tusb_dma->dma_data.ch;
>  
>  	if (ch_status != OMAP_DMA_BLOCK_IRQ)
>  		printk(KERN_ERR "TUSB DMA error status: %i\n", ch_status);
> @@ -140,8 +142,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
>  	/* HW issue #10: XFR_SIZE may get corrupt on DMA (both async & sync) */
>  	if (unlikely(remaining > chdat->transfer_len)) {
>  		dev_dbg(musb->controller, "Corrupt %s dma ch%i XFR_SIZE: 0x%08lx\n",
> -			chdat->tx ? "tx" : "rx", chdat->ch,
> -			remaining);
> +			chdat->tx ? "tx" : "rx", ch, remaining);
>  		remaining = 0;
>  	}
>  
> @@ -220,9 +221,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  	int				src_burst, dst_burst;
>  	u16				csr;
>  	u32				psize;
> -	int				ch;
> -	s8				dmareq;
> -	s8				sync_dev;
> +	struct tusb_dma_data		*dma_data;
>  
>  	if (unlikely(dma_addr & 0x1) || (len < 32) || (len > packet_sz))
>  		return false;
> @@ -249,7 +248,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  	dma_remaining = TUSB_EP_CONFIG_XFR_SIZE(dma_remaining);
>  	if (dma_remaining) {
>  		dev_dbg(musb->controller, "Busy %s dma ch%i, not using: %08x\n",
> -			chdat->tx ? "tx" : "rx", chdat->ch,
> +			chdat->tx ? "tx" : "rx", chdat->dma_data.ch,
>  			dma_remaining);
>  		return false;
>  	}
> @@ -262,15 +261,15 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  		chdat->transfer_packet_sz = packet_sz;
>  
>  	if (tusb_dma->multichannel) {
> -		ch = chdat->ch;
> -		dmareq = chdat->dmareq;
> -		sync_dev = chdat->sync_dev;
> +		dma_data = &chdat->dma_data;
>  	} else {
> +		dma_data = &tusb_dma->dma_data;
> +
>  		if (tusb_omap_use_shared_dmareq(chdat) != 0) {
>  			dev_dbg(musb->controller, "could not get dma for ep%i\n", chdat->epnum);
>  			return false;
>  		}
> -		if (tusb_dma->ch < 0) {
> +		if (dma_data->ch < 0) {
>  			/* REVISIT: This should get blocked earlier, happens
>  			 * with MSC ErrorRecoveryTest
>  			 */
> @@ -278,10 +277,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  			return false;
>  		}
>  
> -		ch = tusb_dma->ch;
> -		dmareq = tusb_dma->dmareq;
> -		sync_dev = tusb_dma->sync_dev;
> -		omap_set_dma_callback(ch, tusb_omap_dma_cb, channel);
> +		omap_set_dma_callback(dma_data->ch, tusb_omap_dma_cb, channel);
>  	}
>  
>  	chdat->packet_sz = packet_sz;
> @@ -312,7 +308,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  
>  	dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %pad len: %u(%u) packet_sz: %i(%i)\n",
>  		chdat->epnum, chdat->tx ? "tx" : "rx",
> -		ch, &dma_addr, chdat->transfer_len, len,
> +		dma_data->ch, &dma_addr, chdat->transfer_len, len,
>  		chdat->transfer_packet_sz, packet_sz);
>  
>  	/*
> @@ -329,7 +325,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  		dma_params.dst_ei	= 1;
>  		dma_params.dst_fi	= -31;	/* Loop 32 byte window */
>  
> -		dma_params.trigger	= sync_dev;
> +		dma_params.trigger	= dma_data->sync_dev;
>  		dma_params.sync_mode	= OMAP_DMA_SYNC_FRAME;
>  		dma_params.src_or_dst_synch	= 0;	/* Dest sync */
>  
> @@ -346,7 +342,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  		dma_params.dst_ei	= 0;
>  		dma_params.dst_fi	= 0;
>  
> -		dma_params.trigger	= sync_dev;
> +		dma_params.trigger	= dma_data->sync_dev;
>  		dma_params.sync_mode	= OMAP_DMA_SYNC_FRAME;
>  		dma_params.src_or_dst_synch	= 1;	/* Source sync */
>  
> @@ -360,10 +356,10 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  		((dma_addr & 0x3) == 0) ? "sync" : "async",
>  		dma_params.src_start, dma_params.dst_start);
>  
> -	omap_set_dma_params(ch, &dma_params);
> -	omap_set_dma_src_burst_mode(ch, src_burst);
> -	omap_set_dma_dest_burst_mode(ch, dst_burst);
> -	omap_set_dma_write_mode(ch, OMAP_DMA_WRITE_LAST_NON_POSTED);
> +	omap_set_dma_params(dma_data->ch, &dma_params);
> +	omap_set_dma_src_burst_mode(dma_data->ch, src_burst);
> +	omap_set_dma_dest_burst_mode(dma_data->ch, dst_burst);
> +	omap_set_dma_write_mode(dma_data->ch, OMAP_DMA_WRITE_LAST_NON_POSTED);
>  
>  	/*
>  	 * Prepare MUSB for DMA transfer
> @@ -386,7 +382,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  	/*
>  	 * Start DMA transfer
>  	 */
> -	omap_start_dma(ch);
> +	omap_start_dma(dma_data->ch);
>  
>  	if (chdat->tx) {
>  		/* Send transfer_packet_sz packets at a time */
> @@ -415,16 +411,17 @@ static int tusb_omap_dma_abort(struct dma_channel *channel)
>  {
>  	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
>  	struct tusb_omap_dma	*tusb_dma = chdat->tusb_dma;
> +	struct tusb_dma_data	*dma_data = &tusb_dma->dma_data;
>  
>  	if (!tusb_dma->multichannel) {
> -		if (tusb_dma->ch >= 0) {
> -			omap_stop_dma(tusb_dma->ch);
> -			omap_free_dma(tusb_dma->ch);
> -			tusb_dma->ch = -1;
> +		if (dma_data->ch >= 0) {
> +			omap_stop_dma(dma_data->ch);
> +			omap_free_dma(dma_data->ch);
> +			dma_data->ch = -1;
>  		}
>  
> -		tusb_dma->dmareq = -1;
> -		tusb_dma->sync_dev = -1;
> +		dma_data->dmareq = -1;
> +		dma_data->sync_dev = -1;
>  	}
>  
>  	channel->status = MUSB_DMA_STATUS_FREE;
> @@ -462,8 +459,8 @@ static inline int tusb_omap_dma_allocate_dmareq(struct tusb_omap_dma_ch *chdat)
>  		reg |= ((1 << 4) << (dmareq_nr * 5));
>  	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, reg);
>  
> -	chdat->dmareq = dmareq_nr;
> -	chdat->sync_dev = sync_dev[chdat->dmareq];
> +	chdat->dma_data.dmareq = dmareq_nr;
> +	chdat->dma_data.sync_dev = sync_dev[chdat->dma_data.dmareq];
>  
>  	return 0;
>  }
> @@ -472,15 +469,15 @@ static inline void tusb_omap_dma_free_dmareq(struct tusb_omap_dma_ch *chdat)
>  {
>  	u32 reg;
>  
> -	if (!chdat || chdat->dmareq < 0)
> +	if (!chdat || chdat->dma_data.dmareq < 0)
>  		return;
>  
>  	reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
> -	reg &= ~(0x1f << (chdat->dmareq * 5));
> +	reg &= ~(0x1f << (chdat->dma_data.dmareq * 5));
>  	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, reg);
>  
> -	chdat->dmareq = -1;
> -	chdat->sync_dev = -1;
> +	chdat->dma_data.dmareq = -1;
> +	chdat->dma_data.sync_dev = -1;
>  }
>  
>  static struct dma_channel *dma_channel_pool[MAX_DMAREQ];
> @@ -492,11 +489,13 @@ tusb_omap_dma_allocate(struct dma_controller *c,
>  {
>  	int ret, i;
>  	const char		*dev_name;
> +	void			*cb_data;
>  	struct tusb_omap_dma	*tusb_dma;
>  	struct musb		*musb;
>  	void __iomem		*tbase;
>  	struct dma_channel	*channel = NULL;
>  	struct tusb_omap_dma_ch	*chdat = NULL;
> +	struct tusb_dma_data	*dma_data = NULL;
>  	u32			reg;
>  
>  	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
> @@ -529,56 +528,61 @@ tusb_omap_dma_allocate(struct dma_controller *c,
>  	if (!channel)
>  		return NULL;
>  
> -	if (tx) {
> -		chdat->tx = 1;
> -		dev_name = "TUSB transmit";
> -	} else {
> -		chdat->tx = 0;
> -		dev_name = "TUSB receive";
> -	}
> -
>  	chdat->musb = tusb_dma->controller.musb;
>  	chdat->tbase = tusb_dma->tbase;
>  	chdat->hw_ep = hw_ep;
>  	chdat->epnum = hw_ep->epnum;
> -	chdat->dmareq = -1;
>  	chdat->completed_len = 0;
>  	chdat->tusb_dma = tusb_dma;
> +	if (tx)
> +		chdat->tx = 1;
> +	else
> +		chdat->tx = 0;
>  
>  	channel->max_len = 0x7fffffff;
>  	channel->desired_mode = 0;
>  	channel->actual_len = 0;
>  
>  	if (tusb_dma->multichannel) {
> +		dma_data = &chdat->dma_data;
>  		ret = tusb_omap_dma_allocate_dmareq(chdat);
>  		if (ret != 0)
>  			goto free_dmareq;
>  
> -		ret = omap_request_dma(chdat->sync_dev, dev_name,
> -				tusb_omap_dma_cb, channel, &chdat->ch);
> -		if (ret != 0)
> -			goto free_dmareq;
> -	} else if (tusb_dma->ch == -1) {
> -		tusb_dma->dmareq = 0;
> -		tusb_dma->sync_dev = OMAP24XX_DMA_EXT_DMAREQ0;
> -
> +		if (chdat->tx)
> +			dev_name = "TUSB transmit";
> +		else
> +			dev_name = "TUSB receive";
> +		cb_data = channel;
> +	} else if (tusb_dma->dma_data.ch == -1) {
> +		dma_data = &tusb_dma->dma_data;
> +		dma_data->dmareq = 0;
> +		dma_data->sync_dev = OMAP24XX_DMA_EXT_DMAREQ0;
> +
> +		dev_name = "TUSB shared";
>  		/* Callback data gets set later in the shared dmareq case */
> -		ret = omap_request_dma(tusb_dma->sync_dev, "TUSB shared",
> -				tusb_omap_dma_cb, NULL, &tusb_dma->ch);
> +		cb_data = NULL;
> +
> +		chdat->dma_data.dmareq = -1;
> +		chdat->dma_data.ch = -1;
> +		chdat->dma_data.sync_dev = -1;
> +	}
> +
> +	if (dma_data) {
> +		ret = omap_request_dma(dma_data->sync_dev, dev_name,
> +				       tusb_omap_dma_cb, cb_data, &dma_data->ch);

line over 80 characters.

Regards,
-Bin.

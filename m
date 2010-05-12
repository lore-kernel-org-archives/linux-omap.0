From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Wed, 12 May 2010 17:18:02 +0400
Message-ID: <4BEAAA8A.1000003@ru.mvista.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com> <1273664979-493-2-git-send-email-ajay.gupta@ti.com> <1273664979-493-3-git-send-email-ajay.gupta@ti.com> <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273664979-493-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> MUSB RTL version 1.8 onward (OMAP3630, AM/DM37x, OMAP4) DMA requires
> the buffers to be aligned on a four byte boundary. This affects USB
> CDC/RNDIS class application where buffers are always unaligned.
>
> Use system DMA for unaligned buffers as a workaround of this issue.
>
> Current patch supports device side CDC/RNDIS. Host side would require
> change in Tx programming path for mode-0 operation when transfer length
> is more than packet size.
>
> Also fixed an issue in device Tx completion path where 'is_dma' is getting
> set unconditionally. This would fail the io if Tx transfer is done in
> mode-0. Fixed it by updating it based on 'request->actual' length.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>   
[...]
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index 70342eb..6118d5f 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -54,12 +54,18 @@ static void musb_sysdma_completion(int lch, u16 ch_status, void *data)
>  					(struct musb_dma_channel *) data;
>  	struct musb_dma_controller *controller = musb_channel->controller;
>  	struct musb *musb = controller->private_data;
> +	void __iomem *mbase = controller->base;
> +
>  	channel = &musb_channel->channel;
>  
>  	DBG(2, "lch = 0x%d, ch_status = 0x%x\n", lch, ch_status);
>  	spin_lock_irqsave(&musb->lock, flags);
>  
> -	addr = (u32) omap_get_dma_dst_pos(musb_channel->sysdma_channel);
> +	if (musb_channel->transmit)
> +		addr = (u32) omap_get_dma_src_pos(musb_channel->sysdma_channel);
> +	else
> +		addr = (u32) omap_get_dma_dst_pos(musb_channel->sysdma_channel);
> +
>  	if (musb_channel->len == 0)
>  		channel->actual_len = 0;
>  	else
> @@ -72,6 +78,26 @@ static void musb_sysdma_completion(int lch, u16 ch_status, void *data)
>  		"=> reconfig 0 " : " => complete");
>  
>  	channel->status = MUSB_DMA_STATUS_FREE;
> +
> +	/* completed */
> +	if ((musb_channel->transmit) && (channel->desired_mode == 0)
> +		&& (channel->actual_len == musb_channel->max_packet_sz)) {
> +
> +		u8  epnum  = musb_channel->epnum;
> +		int offset = MUSB_EP_OFFSET(epnum,
> +				    MUSB_TXCSR);
> +		u16 txcsr;
> +
> +		/*
> +		 * The programming guide says that we
> +		 * must clear DMAENAB before DMAMODE.
> +		 */
> +		musb_ep_select(mbase, epnum);
> +		txcsr = musb_readw(mbase, offset);
> +		txcsr |=  MUSB_TXCSR_TXPKTRDY;
> +		musb_writew(mbase, offset, txcsr);
> +	}
> +
>  	musb_dma_completion(musb, musb_channel->epnum, musb_channel->transmit);
>  
>  	spin_unlock_irqrestore(&musb->lock, flags);
> @@ -138,8 +164,15 @@ static struct dma_channel *dma_channel_allocate(struct dma_controller *c,
>  			 * issue when TX and RX DMA channels are simultaneously
>  			 * enabled. To work around this issue, use system DMA
>  			 * for all RX channels.
> +			 * Also on MUSB RTL version 1.8 onward (OMAP3630, OMAP4
> +			 * and AM/DM37x) DMA requires buffers to be aligned on
> +			 * a four byte boundary. This affects USB CDC/RNDIS
> +			 * class application where buffers are always unaligned.
> +			 * Using system DMA for unaligned buffers as a
> +			 * workaround for this issue.
>  			 */
> -			if (((musb->hwvers == MUSB_HWVERS_1400) && !transmit)
> +			if ((((musb->hwvers == MUSB_HWVERS_1400) && !transmit)
> +				|| (musb->hwvers >= MUSB_HWVERS_1800))
>  				&& use_sdma_workaround()) {
>  				int ret;
>  				ret = omap_request_dma(OMAP24XX_DMA_NO_DEVICE,
> @@ -194,11 +227,18 @@ static void configure_channel(struct dma_channel *channel,
>  	struct musb *musb = controller->private_data;
>  	void __iomem *mbase = controller->base;
>  	u8 bchannel = musb_channel->idx;
> +	u8 buffer_is_aligned = (dma_addr & 0x3) ? 0 : 1;
> +	u8 use_sdma = (musb_channel->sysdma_channel == -1) ? 0 : 1;
>  	u16 csr = 0;
>  
>  	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
>  			channel, packet_sz, dma_addr, len, mode);
> -	if (musb_channel->sysdma_channel != -1) {
> +
> +	if (buffer_is_aligned && (packet_sz >= 512) &&
> +			(musb->hwvers >= MUSB_HWVERS_1800))
> +		use_sdma = 0;
> +
> +	if (use_sdma &&	!musb_channel->transmit) {
>  		/* System DMA */
>  		/* RX: set src = FIFO */
>  		omap_set_dma_transfer_params(musb_channel->sysdma_channel,
> @@ -224,6 +264,32 @@ static void configure_channel(struct dma_channel *channel,
>  
>  		omap_start_dma(musb_channel->sysdma_channel);
>  
> +	} else if (use_sdma && musb_channel->transmit) {
> +		/* System DMA */
> +		/* TX: set dst = FIFO */
> +		omap_set_dma_transfer_params(musb_channel->sysdma_channel,
> +					OMAP_DMA_DATA_TYPE_S8,
> +					len ? len : 1, 1, /* One frame */
> +					OMAP_DMA_SYNC_ELEMENT,
> +					OMAP24XX_DMA_NO_DEVICE,
> +					0); /* Src Sync */
> +
> +		omap_set_dma_src_params(musb_channel->sysdma_channel, 0,
> +					OMAP_DMA_AMODE_POST_INC, dma_addr,
> +					0, 0);
> +
> +		omap_set_dma_dest_params(musb_channel->sysdma_channel, 0,
> +					OMAP_DMA_AMODE_CONSTANT,
> +					MUSB_FIFO_ADDRESS(musb->ctrl_phys_base,
> +						musb_channel->epnum),
> +					0, 0);
> +
> +		omap_set_dma_dest_data_pack(musb_channel->sysdma_channel, 0);
> +		omap_set_dma_dest_burst_mode(musb_channel->sysdma_channel,
> +					OMAP_DMA_DATA_BURST_DIS);
> +
> +		omap_start_dma(musb_channel->sysdma_channel);
> +
>  	} else { /* Mentor DMA */
>  
>  	if (mode) {
> @@ -299,6 +365,9 @@ static int dma_channel_abort(struct dma_channel *channel)
>  
>  	if (channel->status == MUSB_DMA_STATUS_BUSY) {
>  		if (musb_channel->transmit) {
> +			if (musb_channel->sysdma_channel != -1)
> +				omap_stop_dma(musb_channel->sysdma_channel);
> +
>   

   Have you thought about e.g. Blackfin? How this is going to compile 
there, without omap_*() functions even existing? Or did you think that 
OMAP is the only user of this driver?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

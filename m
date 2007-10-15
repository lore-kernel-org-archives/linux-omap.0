From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] ARM: OMAP: OMAP2 USB DMA support
Date: Mon, 15 Oct 2007 11:29:50 +0900
Message-ID: <003401c80ed3$4647fb70$e1ac580a@swcenter.sec.samsung.co.kr>
References: <20071010033410.GA25402@party>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20071010033410.GA25402@party>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'David Brownell' <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi David Brownell,

Are there any comments?

Thank you,
Kyungmin Park

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
> bounces@linux.omap.com] On Behalf Of Kyungmin Park
> Sent: Wednesday, October 10, 2007 12:34 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH] ARM: OMAP: OMAP2 USB DMA support
> 
> In the previous time, USB DMA has some problem at setup time on OMAP2.
> I found that the code assumes bulk out required the big data transfer.
> But MODE SELECT(6) sent the only 24 bytes. it makes a problem.
> So I implement the small packets handling for it.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 74cdce1..3ac4b91 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -60,11 +60,6 @@
>  /* bulk DMA seems to be behaving for both IN and OUT */
>  #define	USE_DMA
> 
> -/* FIXME: OMAP2 currently has some problem in DMA mode */
> -#ifdef CONFIG_ARCH_OMAP2
> -#undef USE_DMA
> -#endif
> -
>  /* ISO too */
>  #define	USE_ISO
> 
> @@ -73,6 +68,8 @@
> 
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
> 
> +#define OMAP2_DMA_CH(ch)	(((ch) - 1) << 1)
> +#define OMAP24XX_DMA(name, ch)	(OMAP24XX_DMA_##name + OMAP2_DMA_CH(ch))
> 
>  /*
>   * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
> @@ -571,20 +568,25 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
>  	const int	sync_mode = cpu_is_omap15xx()
>  				? OMAP_DMA_SYNC_FRAME
>  				: OMAP_DMA_SYNC_ELEMENT;
> +	int		dma_trigger = 0;
> +
> +	if (cpu_is_omap24xx())
> +		dma_trigger = OMAP24XX_DMA(USB_W2FC_TX0, ep->dma_channel);
> 
>  	/* measure length in either bytes or packets */
>  	if ((cpu_is_omap16xx() && length <= UDC_TXN_TSC)
> +			|| (cpu_is_omap24xx() && length < ep->maxpacket)
>  			|| (cpu_is_omap15xx() && length < ep->maxpacket)) {
>  		txdma_ctrl = UDC_TXN_EOT | length;
>  		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
> -				length, 1, sync_mode, 0, 0);
> +				length, 1, sync_mode, dma_trigger, 0);
>  	} else {
>  		length = min(length / ep->maxpacket,
>  				(unsigned) UDC_TXN_TSC + 1);
>  		txdma_ctrl = length;
>  		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
>  				ep->ep.maxpacket >> 1, length, sync_mode,
> -				0, 0);
> +				dma_trigger, 0);
>  		length *= ep->maxpacket;
>  	}
>  	omap_set_dma_src_params(ep->lch, OMAP_DMA_PORT_EMIFF,
> @@ -622,20 +624,31 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int
> status)
> 
>  static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
>  {
> -	unsigned packets;
> +	unsigned packets = req->req.length - req->req.actual;
> +	int dma_trigger = 0;
> +
> +	if (cpu_is_omap24xx())
> +		dma_trigger = OMAP24XX_DMA(USB_W2FC_RX0, ep->dma_channel);
> 
>  	/* NOTE:  we filtered out "short reads" before, so we know
>  	 * the buffer has only whole numbers of packets.
> +	 * except MODE SELECT(6) sent the 24 bytes data in OMAP24XX DMA mode
>  	 */
> -
> -	/* set up this DMA transfer, enable the fifo, start */
> -	packets = (req->req.length - req->req.actual) / ep->ep.maxpacket;
> -	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
> -	req->dma_bytes = packets * ep->ep.maxpacket;
> -	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
> -			ep->ep.maxpacket >> 1, packets,
> -			OMAP_DMA_SYNC_ELEMENT,
> -			0, 0);
> +	if (cpu_is_omap24xx() && packets < ep->maxpacket) {
> +		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
> +				packets, 1, OMAP_DMA_SYNC_ELEMENT,
> +				dma_trigger, 0);
> +		req->dma_bytes = packets;
> +	} else {
> +		/* set up this DMA transfer, enable the fifo, start */
> +		packets /= ep->ep.maxpacket;
> +		packets = min(packets, (unsigned)UDC_RXN_TC + 1);
> +		req->dma_bytes = packets * ep->ep.maxpacket;
> +		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
> +				ep->ep.maxpacket >> 1, packets,
> +				OMAP_DMA_SYNC_ELEMENT,
> +				dma_trigger, 0);
> +	}
>  	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
>  		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
>  		0, 0);
> @@ -743,6 +756,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  {
>  	u16	reg;
>  	int	status, restart, is_in;
> +	int	dma_channel;
> 
>  	is_in = ep->bEndpointAddress & USB_DIR_IN;
>  	if (is_in)
> @@ -769,11 +783,15 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  	ep->dma_channel = channel;
> 
>  	if (is_in) {
> -		status = omap_request_dma(OMAP_DMA_USB_W2FC_TX0 - 1 + channel,
> +		if (cpu_is_omap24xx())
> +			dma_channel = OMAP24XX_DMA(USB_W2FC_TX0, channel);
> +		else
> +			dma_channel = OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
> +		status = omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status == 0) {
>  			UDC_TXDMA_CFG_REG = reg;
> -			/* EMIFF */
> +			/* EMIFF or SDRC */
>  			omap_set_dma_src_burst_mode(ep->lch,
>  						OMAP_DMA_DATA_BURST_4);
>  			omap_set_dma_src_data_pack(ep->lch, 1);
> @@ -785,7 +803,12 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  				0, 0);
>  		}
>  	} else {
> -		status = omap_request_dma(OMAP_DMA_USB_W2FC_RX0 - 1 + channel,
> +		if (cpu_is_omap24xx())
> +			dma_channel = OMAP24XX_DMA(USB_W2FC_RX0, channel);
> +		else
> +			dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
> +
> +		status = omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status == 0) {
>  			UDC_RXDMA_CFG_REG = reg;
> @@ -795,7 +818,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  				OMAP_DMA_AMODE_CONSTANT,
>  				(unsigned long) io_v2p((u32)&UDC_DATA_DMA_REG),
>  				0, 0);
> -			/* EMIFF */
> +			/* EMIFF or SDRC */
>  			omap_set_dma_dest_burst_mode(ep->lch,
>  						OMAP_DMA_DATA_BURST_4);
>  			omap_set_dma_dest_data_pack(ep->lch, 1);
> @@ -808,7 +831,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
> 
>  		/* channel type P: hw synch (fifo) */
> -		if (!cpu_is_omap15xx())
> +		if (cpu_class_is_omap1() && !cpu_is_omap15xx())
>  			OMAP1_DMA_LCH_CTRL_REG(ep->lch) = 2;
>  	}
> 
> @@ -926,11 +949,13 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
> 
>  	/* this isn't bogus, but OMAP DMA isn't the only hardware to
>  	 * have a hard time with partial packet reads...  reject it.
> +	 * Except OMAP2 can handle the small packets.
>  	 */
>  	if (use_dma
>  			&& ep->has_dma
>  			&& ep->bEndpointAddress != 0
>  			&& (ep->bEndpointAddress & USB_DIR_IN) == 0
> +			&& !cpu_class_is_omap2()
>  			&& (req->req.length % ep->ep.maxpacket) != 0) {
>  		DBG("%s, no partial packet OUT reads\n", __FUNCTION__);
>  		return -EMSGSIZE;
> @@ -2555,7 +2580,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
>  		 * (for more reliable behavior)
>  		 */
>  		if ((!use_dma && (addr & USB_DIR_IN))
> -				|| machine_is_omap_apollon()
> +				|| (!use_dma && machine_is_omap_apollon())
>  				|| cpu_is_omap15xx())
>  			dbuf = 0;
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

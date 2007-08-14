From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/52] musb_hdrc: Search and replace pEnd with musb_ep
	when struct musb_hw_ep
Date: Tue, 14 Aug 2007 02:23:51 -0700
Message-ID: <20070814092350.GB8413@atomide.com>
References: <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11870129782148-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [070813 06:49]:
> Search and replace pEnd with musb_ep when struct musb_hw_ep

This should actually say search and replace pEnd with hw_ep when
struct musb_hw_ep. The patch does the right thing though.

Tony

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/usb/musb/cppi_dma.c    |    8 +-
>  drivers/usb/musb/musb_host.c   |  140 ++++++++++++++++++++--------------------
>  drivers/usb/musb/musb_procfs.c |   28 ++++----
>  drivers/usb/musb/plat_uds.c    |   24 ++++----
>  4 files changed, 100 insertions(+), 100 deletions(-)
> 
> --- a/drivers/usb/musb/cppi_dma.c
> +++ b/drivers/usb/musb/cppi_dma.c
> @@ -1141,7 +1141,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  	u8			bReqComplete;
>  	struct cppi		*cppi;
>  	struct cppi_descriptor	*bdPtr;
> -	struct musb_hw_ep	*pEnd = NULL;
> +	struct musb_hw_ep	*hw_ep = NULL;
>  
>  	cppi = container_of(musb->pDmaController, struct cppi, Controller);
>  
> @@ -1227,7 +1227,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  					txChannel->Channel.bStatus =
>  							MGC_DMA_STATUS_FREE;
>  
> -					pEnd = txChannel->hw_ep;
> +					hw_ep = txChannel->hw_ep;
>  
>  					txChannel->Channel.dwActualLength =
>  						txChannel->actualLen;
> @@ -1245,7 +1245,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  						 */
>  						int	csr;
>  
> -						csr = musb_readw(pEnd->regs,
> +						csr = musb_readw(hw_ep->regs,
>  							MGC_O_HDRC_TXCSR);
>  						if (csr & MGC_M_TXCSR_TXPKTRDY)
>  #endif
> @@ -1290,7 +1290,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  			/* all segments completed! */
>  			rxChannel->Channel.bStatus = MGC_DMA_STATUS_FREE;
>  
> -			pEnd = rxChannel->hw_ep;
> +			hw_ep = rxChannel->hw_ep;
>  
>  			rxChannel->Channel.dwActualLength =
>  					rxChannel->actualLen;
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -174,10 +174,10 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
>  	void			*pBuffer;
>  	void __iomem		*pBase =  musb->pRegs;
>  	struct urb		*urb = next_urb(qh);
> -	struct musb_hw_ep	*pEnd = qh->hw_ep;
> +	struct musb_hw_ep	*hw_ep = qh->hw_ep;
>  	unsigned		nPipe = urb->pipe;
>  	u8			bAddress = usb_pipedevice(nPipe);
> -	int			bEnd = pEnd->bLocalEnd;
> +	int			bEnd = hw_ep->bLocalEnd;
>  
>  	/* initialize software qh state */
>  	qh->offset = 0;
> @@ -188,7 +188,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
>  	case USB_ENDPOINT_XFER_CONTROL:
>  		/* control transfers always start with SETUP */
>  		is_in = 0;
> -		pEnd->out_qh = qh;
> +		hw_ep->out_qh = qh;
>  		musb->bEnd0Stage = MGC_END0_START;
>  		pBuffer = urb->setup_packet;
>  		dwLength = 8;
> @@ -216,10 +216,10 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
>  			bEnd, pBuffer, dwLength);
>  
>  	/* Configure endpoint */
> -	if (is_in || pEnd->bIsSharedFifo)
> -		pEnd->in_qh = qh;
> +	if (is_in || hw_ep->bIsSharedFifo)
> +		hw_ep->in_qh = qh;
>  	else
> -		pEnd->out_qh = qh;
> +		hw_ep->out_qh = qh;
>  	musb_ep_program(musb, bEnd, urb, !is_in, pBuffer, dwLength);
>  
>  	/* transmit may have more work: start it when it is time */
> @@ -255,12 +255,12 @@ DBG(1,"SOF for %d\n", bEnd);
>  	default:
>  start:
>  		DBG(4, "Start TX%d %s\n", bEnd,
> -			pEnd->tx_channel ? "dma" : "pio");
> +			hw_ep->tx_channel ? "dma" : "pio");
>  
> -		if (!pEnd->tx_channel)
> -			musb_h_tx_start(pEnd);
> +		if (!hw_ep->tx_channel)
> +			musb_h_tx_start(hw_ep);
>  		else if (is_cppi_enabled() || tusb_dma_omap())
> -			cppi_host_txdma_start(pEnd);
> +			cppi_host_txdma_start(hw_ep);
>  	}
>  }
>  
> @@ -425,19 +425,19 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
>   */
>  static void
>  musb_advance_schedule(struct musb *musb, struct urb *urb,
> -		struct musb_hw_ep *pEnd, int is_in)
> +		struct musb_hw_ep *hw_ep, int is_in)
>  {
>  	struct musb_qh	*qh;
>  
> -	if (is_in || pEnd->bIsSharedFifo)
> -		qh = pEnd->in_qh;
> +	if (is_in || hw_ep->bIsSharedFifo)
> +		qh = hw_ep->in_qh;
>  	else
> -		qh = pEnd->out_qh;
> +		qh = hw_ep->out_qh;
>  	qh = musb_giveback(qh, urb, 0);
>  
>  	if (qh && qh->is_ready && !list_empty(&qh->hep->urb_list)) {
>  		DBG(4, "... next ep%d %cX urb %p\n",
> -				pEnd->bLocalEnd, is_in ? 'R' : 'T',
> +				hw_ep->bLocalEnd, is_in ? 'R' : 'T',
>  				next_urb(qh));
>  		musb_start_urb(musb, is_in, qh);
>  	}
> @@ -475,9 +475,9 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
>  	u8 bDone = FALSE;
>  	u32			length;
>  	int			do_flush = 0;
> -	struct musb_hw_ep	*pEnd = musb->aLocalEnd + bEnd;
> -	void __iomem		*epio = pEnd->regs;
> -	struct musb_qh		*qh = pEnd->in_qh;
> +	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
> +	void __iomem		*epio = hw_ep->regs;
> +	struct musb_qh		*qh = hw_ep->in_qh;
>  	int			nPipe = pUrb->pipe;
>  	void			*buffer = pUrb->transfer_buffer;
>  
> @@ -542,12 +542,12 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
>  			pUrb->status = -EREMOTEIO;
>  	}
>  
> -	musb_read_fifo(pEnd, length, pBuffer);
> +	musb_read_fifo(hw_ep, length, pBuffer);
>  
>  	wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
>  	wCsr |= MGC_M_RXCSR_H_WZC_BITS;
>  	if (unlikely(do_flush))
> -		musb_h_flush_rxfifo(pEnd, wCsr);
> +		musb_h_flush_rxfifo(hw_ep, wCsr);
>  	else {
>  		/* REVISIT this assumes AUTOCLEAR is never set */
>  		wCsr &= ~(MGC_M_RXCSR_RXPKTRDY | MGC_M_RXCSR_H_REQPKT);
> @@ -631,15 +631,15 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  	struct dma_channel	*pDmaChannel;
>  	u8			bDmaOk;
>  	void __iomem		*pBase = musb->pRegs;
> -	struct musb_hw_ep	*pEnd = musb->aLocalEnd + bEnd;
> -	void __iomem		*epio = pEnd->regs;
> +	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
> +	void __iomem		*epio = hw_ep->regs;
>  	struct musb_qh		*qh;
>  	u16			wPacketSize;
>  
> -	if (!is_out || pEnd->bIsSharedFifo)
> -		qh = pEnd->in_qh;
> +	if (!is_out || hw_ep->bIsSharedFifo)
> +		qh = hw_ep->in_qh;
>  	else
> -		qh = pEnd->out_qh;
> +		qh = hw_ep->out_qh;
>  
>  	wPacketSize = qh->maxpacket;
>  
> @@ -656,14 +656,14 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  	/* candidate for DMA? */
>  	pDmaController = musb->pDmaController;
>  	if (is_dma_capable() && bEnd && pDmaController) {
> -		pDmaChannel = is_out ? pEnd->tx_channel : pEnd->rx_channel;
> +		pDmaChannel = is_out ? hw_ep->tx_channel : hw_ep->rx_channel;
>  		if (!pDmaChannel) {
>  			pDmaChannel = pDmaController->channel_alloc(
> -					pDmaController, pEnd, is_out);
> +					pDmaController, hw_ep, is_out);
>  			if (is_out)
> -				pEnd->tx_channel = pDmaChannel;
> +				hw_ep->tx_channel = pDmaChannel;
>  			else
> -				pEnd->rx_channel = pDmaChannel;
> +				hw_ep->rx_channel = pDmaChannel;
>  		}
>  	} else
>  		pDmaChannel = NULL;
> @@ -689,7 +689,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  			/* ASSERT:  TXCSR_DMAENAB was already cleared */
>  
>  			/* flush all old state, set default */
> -			musb_h_tx_flush_fifo(pEnd);
> +			musb_h_tx_flush_fifo(hw_ep);
>  			csr &= ~(MGC_M_TXCSR_H_NAKTIMEOUT
>  					| MGC_M_TXCSR_DMAMODE
>  					| MGC_M_TXCSR_FRCDATATOG
> @@ -740,7 +740,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  			if (can_bulk_split(musb, qh->type))
>  				musb_writew(epio, MGC_O_HDRC_TXMAXP,
>  					wPacketSize
> -					| ((pEnd->wMaxPacketSizeTx /
> +					| ((hw_ep->wMaxPacketSizeTx /
>  						wPacketSize) - 1) << 11);
>  			else
>  				musb_writew(epio, MGC_O_HDRC_TXMAXP,
> @@ -754,7 +754,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  		}
>  
>  		if (can_bulk_split(musb, qh->type))
> -			wLoadCount = min((u32) pEnd->wMaxPacketSizeTx,
> +			wLoadCount = min((u32) hw_ep->wMaxPacketSizeTx,
>  						dwLength);
>  		else
>  			wLoadCount = min((u32) wPacketSize, dwLength);
> @@ -801,9 +801,9 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  			} else {
>  				pDmaController->channel_release(pDmaChannel);
>  				if (is_out)
> -					pEnd->tx_channel = NULL;
> +					hw_ep->tx_channel = NULL;
>  				else
> -					pEnd->rx_channel = NULL;
> +					hw_ep->rx_channel = NULL;
>  				pDmaChannel = NULL;
>  			}
>  		}
> @@ -841,7 +841,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  				wLoadCount = 0;
>  			} else {
>  				pDmaController->channel_release(pDmaChannel);
> -				pDmaChannel = pEnd->tx_channel = NULL;
> +				pDmaChannel = hw_ep->tx_channel = NULL;
>  
>  				/* REVISIT there's an error path here that
>  				 * needs handling:  can't do dma, but
> @@ -855,7 +855,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  
>  			/* PIO to load FIFO */
>  			qh->segsize = wLoadCount;
> -			musb_write_fifo(pEnd, wLoadCount, pBuffer);
> +			musb_write_fifo(hw_ep, wLoadCount, pBuffer);
>  			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
>  			wCsr &= ~(MGC_M_TXCSR_DMAENAB
>  				| MGC_M_TXCSR_DMAMODE
> @@ -874,8 +874,8 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  	} else {
>  		u16	csr;
>  
> -		if (pEnd->rx_reinit) {
> -			musb_rx_reinit(musb, qh, pEnd);
> +		if (hw_ep->rx_reinit) {
> +			musb_rx_reinit(musb, qh, hw_ep);
>  
>  			/* init new state: toggle and NYET, maybe DMA later */
>  			if (usb_gettoggle(pUrb->dev, qh->epnum, 0))
> @@ -887,13 +887,13 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  				csr |= MGC_M_RXCSR_DISNYET;
>  
>  		} else {
> -			csr = musb_readw(pEnd->regs, MGC_O_HDRC_RXCSR);
> +			csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
>  
>  			if (csr & (MGC_M_RXCSR_RXPKTRDY
>  					| MGC_M_RXCSR_DMAENAB
>  					| MGC_M_RXCSR_H_REQPKT))
>  				ERR("broken !rx_reinit, ep%d csr %04x\n",
> -						pEnd->bLocalEnd, csr);
> +						hw_ep->bLocalEnd, csr);
>  
>  			/* scrub any stale state, leaving toggle alone */
>  			csr &= MGC_M_RXCSR_DISNYET;
> @@ -908,8 +908,8 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  				qh->segsize = dwLength;
>  
>  				/* AUTOREQ is in a DMA register */
> -				musb_writew(pEnd->regs, MGC_O_HDRC_RXCSR, csr);
> -				csr = musb_readw(pEnd->regs,
> +				musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
> +				csr = musb_readw(hw_ep->regs,
>  						MGC_O_HDRC_RXCSR);
>  
>  				/* unless caller treats short rx transfers as
> @@ -924,7 +924,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  				if (!bDmaOk) {
>  					pDmaController->channel_release(
>  							pDmaChannel);
> -					pDmaChannel = pEnd->rx_channel = NULL;
> +					pDmaChannel = hw_ep->rx_channel = NULL;
>  				} else
>  					csr |= MGC_M_RXCSR_DMAENAB;
>  			}
> @@ -932,8 +932,8 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
>  
>  		csr |= MGC_M_RXCSR_H_REQPKT;
>  		DBG(7, "RXCSR%d := %04x\n", bEnd, csr);
> -		musb_writew(pEnd->regs, MGC_O_HDRC_RXCSR, csr);
> -		csr = musb_readw(pEnd->regs, MGC_O_HDRC_RXCSR);
> +		musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
> +		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
>  	}
>  }
>  
> @@ -948,8 +948,8 @@ static int musb_h_ep0_continue(struct musb *musb,
>  	int			 bMore = FALSE;
>  	u8 *pFifoDest = NULL;
>  	u16 wFifoCount = 0;
> -	struct musb_hw_ep	*pEnd = musb->control_ep;
> -	struct musb_qh		*qh = pEnd->in_qh;
> +	struct musb_hw_ep	*hw_ep = musb->control_ep;
> +	struct musb_qh		*qh = hw_ep->in_qh;
>  	struct usb_ctrlrequest	*pRequest;
>  
>  	switch (musb->bEnd0Stage) {
> @@ -960,7 +960,7 @@ static int musb_h_ep0_continue(struct musb *musb,
>  		if (wFifoCount < wCount)
>  			pUrb->status = -EOVERFLOW;
>  
> -		musb_read_fifo(pEnd, wFifoCount, pFifoDest);
> +		musb_read_fifo(hw_ep, wFifoCount, pFifoDest);
>  
>  		pUrb->actual_length += wFifoCount;
>  		if (wCount < qh->maxpacket) {
> @@ -998,7 +998,7 @@ static int musb_h_ep0_continue(struct musb *musb,
>  					+ pUrb->actual_length);
>  			DBG(3, "Sending %d bytes to %p\n",
>  					wFifoCount, pFifoDest);
> -			musb_write_fifo(pEnd, wFifoCount, pFifoDest);
> +			musb_write_fifo(hw_ep, wFifoCount, pFifoDest);
>  
>  			pUrb->actual_length += wFifoCount;
>  			bMore = TRUE;
> @@ -1024,9 +1024,9 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
>  	u16			wCsrVal, wCount;
>  	int			status = 0;
>  	void __iomem		*pBase = musb->pRegs;
> -	struct musb_hw_ep	*pEnd = musb->control_ep;
> -	void __iomem		*epio = pEnd->regs;
> -	struct musb_qh		*qh = pEnd->in_qh;
> +	struct musb_hw_ep	*hw_ep = musb->control_ep;
> +	void __iomem		*epio = hw_ep->regs;
> +	struct musb_qh		*qh = hw_ep->in_qh;
>  	u8			bComplete = FALSE;
>  	irqreturn_t		retval = IRQ_NONE;
>  
> @@ -1139,7 +1139,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
>  
>  	/* call completion handler if done */
>  	if (bComplete)
> -		musb_advance_schedule(musb, pUrb, pEnd, 1);
> +		musb_advance_schedule(musb, pUrb, hw_ep, 1);
>  done:
>  	return retval;
>  }
> @@ -1170,9 +1170,9 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
>  	size_t			wLength = 0;
>  	u8			*pBuffer = NULL;
>  	struct urb		*pUrb;
> -	struct musb_hw_ep	*pEnd = musb->aLocalEnd + bEnd;
> -	void __iomem		*epio = pEnd->regs;
> -	struct musb_qh		*qh = pEnd->out_qh;
> +	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
> +	void __iomem		*epio = hw_ep->regs;
> +	struct musb_qh		*qh = hw_ep->out_qh;
>  	u32			status = 0;
>  	void __iomem		*pBase = musb->pRegs;
>  	struct dma_channel	*dma;
> @@ -1189,7 +1189,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
>  	}
>  
>  	nPipe = pUrb->pipe;
> -	dma = is_dma_capable() ? pEnd->tx_channel : NULL;
> +	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
>  	DBG(4, "OUT/TX%d end, csr %04x%s\n", bEnd, wTxCsrVal,
>  			dma ? ", dma" : "");
>  
> @@ -1233,7 +1233,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
>  		/* do the proper sequence to abort the transfer in the
>  		 * usb core; the dma engine should already be stopped.
>  		 */
> -		musb_h_tx_flush_fifo(pEnd);
> +		musb_h_tx_flush_fifo(hw_ep);
>  		wTxCsrVal &= ~(MGC_M_TXCSR_AUTOSET
>  				| MGC_M_TXCSR_DMAENAB
>  				| MGC_M_TXCSR_H_ERROR
> @@ -1309,18 +1309,18 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
>  		/* set status */
>  		pUrb->status = status;
>  		pUrb->actual_length = qh->offset;
> -		musb_advance_schedule(musb, pUrb, pEnd, USB_DIR_OUT);
> +		musb_advance_schedule(musb, pUrb, hw_ep, USB_DIR_OUT);
>  
>  	} else if (!(wTxCsrVal & MGC_M_TXCSR_DMAENAB)) {
>  		// WARN_ON(!pBuffer);
>  
> -		/* REVISIT:  some docs say that when pEnd->tx_double_buffered,
> +		/* REVISIT:  some docs say that when hw_ep->tx_double_buffered,
>  		 * (and presumably, fifo is not half-full) we should write TWO
>  		 * packets before updating TXCSR ... other docs disagree ...
>  		 */
>  		/* PIO:  start next packet in this URB */
>  		wLength = min(qh->maxpacket, (u16) wLength);
> -		musb_write_fifo(pEnd, wLength, pBuffer);
> +		musb_write_fifo(hw_ep, wLength, pBuffer);
>  		qh->segsize = wLength;
>  
>  		MGC_SelectEnd(pBase, bEnd);
> @@ -1380,9 +1380,9 @@ finish:
>  void musb_host_rx(struct musb *musb, u8 bEnd)
>  {
>  	struct urb		*pUrb;
> -	struct musb_hw_ep	*pEnd = musb->aLocalEnd + bEnd;
> -	void __iomem		*epio = pEnd->regs;
> -	struct musb_qh		*qh = pEnd->in_qh;
> +	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
> +	void __iomem		*epio = hw_ep->regs;
> +	struct musb_qh		*qh = hw_ep->in_qh;
>  	size_t			xfer_len;
>  	void __iomem		*pBase = musb->pRegs;
>  	int			nPipe;
> @@ -1395,7 +1395,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
>  	MGC_SelectEnd(pBase, bEnd);
>  
>  	pUrb = next_urb(qh);
> -	dma = is_dma_capable() ? pEnd->rx_channel : NULL;
> +	dma = is_dma_capable() ? hw_ep->rx_channel : NULL;
>  	status = 0;
>  	xfer_len = 0;
>  
> @@ -1408,7 +1408,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
>  		 */
>  		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", bEnd, wVal,
>  			musb_readw(epio, MGC_O_HDRC_RXCOUNT));
> -		musb_h_flush_rxfifo(pEnd, MGC_M_RXCSR_CLRDATATOG);
> +		musb_h_flush_rxfifo(hw_ep, MGC_M_RXCSR_CLRDATATOG);
>  		return;
>  	}
>  
> @@ -1464,7 +1464,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
>  			(void) musb->pDmaController->channel_abort(dma);
>  			xfer_len = dma->dwActualLength;
>  		}
> -		musb_h_flush_rxfifo(pEnd, 0);
> +		musb_h_flush_rxfifo(hw_ep, 0);
>  		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
>  		bDone = TRUE;
>  		goto finish;
> @@ -1513,7 +1513,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
>  			| MGC_M_RXCSR_H_AUTOREQ
>  			| MGC_M_RXCSR_AUTOCLEAR
>  			| MGC_M_RXCSR_RXPKTRDY);
> -		musb_writew(pEnd->regs, MGC_O_HDRC_RXCSR, wVal);
> +		musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, wVal);
>  
>  #ifdef CONFIG_USB_INVENTRA_DMA
>  		/* bDone if pUrb buffer is full or short packet is recd */
> @@ -1626,7 +1626,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
>  
>  			if (!status) {
>  				c->channel_release(dma);
> -				dma = pEnd->rx_channel = NULL;
> +				dma = hw_ep->rx_channel = NULL;
>  				/* REVISIT reset CSR */
>  			}
>  		}
> @@ -1645,7 +1645,7 @@ finish:
>  	if (bDone) {
>  		if (pUrb->status == -EINPROGRESS)
>  			pUrb->status = status;
> -		musb_advance_schedule(musb, pUrb, pEnd, USB_DIR_IN);
> +		musb_advance_schedule(musb, pUrb, hw_ep, USB_DIR_IN);
>  	}
>  }
>  
> --- a/drivers/usb/musb/musb_procfs.c
> +++ b/drivers/usb/musb/musb_procfs.c
> @@ -237,14 +237,14 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  {
>  	int			code = 0;
>  	char			*buf = aBuffer;
> -	struct musb_hw_ep	*pEnd = &musb->aLocalEnd[bEnd];
> +	struct musb_hw_ep	*hw_ep = &musb->aLocalEnd[bEnd];
>  
>  	do {
>  		MGC_SelectEnd(musb->pRegs, bEnd);
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
>  		if (is_host_active(musb)) {
>  			int		dump_rx, dump_tx;
> -			void __iomem	*regs = pEnd->regs;
> +			void __iomem	*regs = hw_ep->regs;
>  
>  			/* TEMPORARY (!) until we have a real periodic
>  			 * schedule tree ...
> @@ -255,7 +255,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  				 */
>  				dump_tx = !list_empty(&musb->control);
>  				dump_rx = 0;
> -			} else if (pEnd == musb->bulk_ep) {
> +			} else if (hw_ep == musb->bulk_ep) {
>  				dump_tx = !list_empty(&musb->out_bulk);
>  				dump_rx = !list_empty(&musb->in_bulk);
>  			} else if (musb->periodic[bEnd]) {
> @@ -277,7 +277,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  					"dev %d hub %d port %d"
>  					"\n",
>  					bEnd,
> -					pEnd->rx_double_buffered
> +					hw_ep->rx_double_buffered
>  						? "2buf" : "1buf",
>  					musb_readw(regs, MGC_O_HDRC_RXCSR),
>  					musb_readb(regs, MGC_O_HDRC_RXINTERVAL),
> @@ -302,7 +302,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  
>  				if (is_cppi_enabled()
>  						&& bEnd
> -						&& pEnd->rx_channel) {
> +						&& hw_ep->rx_channel) {
>  					unsigned	cppi = bEnd - 1;
>  					unsigned	off1 = cppi << 2;
>  					void __iomem	*base;
> @@ -337,7 +337,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  					max -= code;
>  				}
>  
> -				if (pEnd == musb->bulk_ep
> +				if (hw_ep == musb->bulk_ep
>  						&& !list_empty(
>  							&musb->in_bulk)) {
>  					code = dump_queue(&musb->in_bulk,
> @@ -365,7 +365,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  					"dev %d hub %d port %d"
>  					"\n",
>  					bEnd,
> -					pEnd->tx_double_buffered
> +					hw_ep->tx_double_buffered
>  						? "2buf" : "1buf",
>  					musb_readw(regs, MGC_O_HDRC_TXCSR),
>  					musb_readb(regs, MGC_O_HDRC_TXINTERVAL),
> @@ -390,7 +390,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  
>  				if (is_cppi_enabled()
>  						&& bEnd
> -						&& pEnd->tx_channel) {
> +						&& hw_ep->tx_channel) {
>  					unsigned	cppi = bEnd - 1;
>  					void __iomem	*base;
>  					void __iomem	*ram;
> @@ -418,7 +418,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  					max -= code;
>  				}
>  
> -				if (pEnd == musb->control_ep
> +				if (hw_ep == musb->control_ep
>  						&& !list_empty(
>  							&musb->control)) {
>  					code = dump_queue(&musb->control,
> @@ -428,7 +428,7 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  					code = min(code, (int) max);
>  					buf += code;
>  					max -= code;
> -				} else if (pEnd == musb->bulk_ep
> +				} else if (hw_ep == musb->bulk_ep
>  						&& !list_empty(
>  							&musb->out_bulk)) {
>  					code = dump_queue(&musb->out_bulk,
> @@ -454,16 +454,16 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
>  		if (is_peripheral_active(musb)) {
>  			code = 0;
>  
> -			if (pEnd->ep_in.desc || !bEnd) {
> -				code = dump_ep(&pEnd->ep_in, buf, max);
> +			if (hw_ep->ep_in.desc || !bEnd) {
> +				code = dump_ep(&hw_ep->ep_in, buf, max);
>  				if (code <= 0)
>  					break;
>  				code = min(code, (int) max);
>  				buf += code;
>  				max -= code;
>  			}
> -			if (pEnd->ep_out.desc) {
> -				code = dump_ep(&pEnd->ep_out, buf, max);
> +			if (hw_ep->ep_out.desc) {
> +				code = dump_ep(&hw_ep->ep_out, buf, max);
>  				if (code <= 0)
>  					break;
>  				code = min(code, (int) max);
> --- a/drivers/usb/musb/plat_uds.c
> +++ b/drivers/usb/musb/plat_uds.c
> @@ -1179,7 +1179,7 @@ static int __init ep_config_from_table(struct musb *musb)
>  static int __init ep_config_from_hw(struct musb *musb)
>  {
>  	u8 bEnd = 0, reg;
> -	struct musb_hw_ep *pEnd;
> +	struct musb_hw_ep *hw_ep;
>  	void *pBase = musb->pRegs;
>  
>  	DBG(2, "<== static silicon ep config\n");
> @@ -1188,10 +1188,10 @@ static int __init ep_config_from_hw(struct musb *musb)
>  
>  	for (bEnd = 1; bEnd < MUSB_C_NUM_EPS; bEnd++) {
>  		MGC_SelectEnd(pBase, bEnd);
> -		pEnd = musb->aLocalEnd + bEnd;
> +		hw_ep = musb->aLocalEnd + bEnd;
>  
>  		/* read from core using indexed model */
> -		reg = musb_readb(pEnd->regs, 0x10 + MGC_O_HDRC_FIFOSIZE);
> +		reg = musb_readb(hw_ep->regs, 0x10 + MGC_O_HDRC_FIFOSIZE);
>  		if (!reg) {
>  			/* 0's returned when no more endpoints */
>  			break;
> @@ -1199,24 +1199,24 @@ static int __init ep_config_from_hw(struct musb *musb)
>  		musb->bEndCount++;
>  		musb->wEndMask |= (1 << bEnd);
>  
> -		pEnd->wMaxPacketSizeTx = 1 << (reg & 0x0f);
> +		hw_ep->wMaxPacketSizeTx = 1 << (reg & 0x0f);
>  
>  		/* shared TX/RX FIFO? */
>  		if ((reg & 0xf0) == 0xf0) {
> -			pEnd->wMaxPacketSizeRx = pEnd->wMaxPacketSizeTx;
> -			pEnd->bIsSharedFifo = TRUE;
> +			hw_ep->wMaxPacketSizeRx = hw_ep->wMaxPacketSizeTx;
> +			hw_ep->bIsSharedFifo = TRUE;
>  			continue;
>  		} else {
> -			pEnd->wMaxPacketSizeRx = 1 << ((reg & 0xf0) >> 4);
> -			pEnd->bIsSharedFifo = FALSE;
> +			hw_ep->wMaxPacketSizeRx = 1 << ((reg & 0xf0) >> 4);
> +			hw_ep->bIsSharedFifo = FALSE;
>  		}
>  
> -		/* FIXME set up pEnd->{rx,tx}_double_buffered */
> +		/* FIXME set up hw_ep->{rx,tx}_double_buffered */
>  
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
>  		/* pick an RX/TX endpoint for bulk */
> -		if (pEnd->wMaxPacketSizeTx < 512
> -				|| pEnd->wMaxPacketSizeRx < 512)
> +		if (hw_ep->wMaxPacketSizeTx < 512
> +				|| hw_ep->wMaxPacketSizeRx < 512)
>  			continue;
>  
>  		/* REVISIT:  this algorithm is lazy, we should at least
> @@ -1224,7 +1224,7 @@ static int __init ep_config_from_hw(struct musb *musb)
>  		 */
>  		if (musb->bulk_ep)
>  			continue;
> -		musb->bulk_ep = pEnd;
> +		musb->bulk_ep = hw_ep;
>  #endif
>  	}
>  
> -- 
> 1.5.2.3
> 

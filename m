From: Bryan Wu <bryan.wu@analog.com>
Subject: Re: [PATCH] MUSB: Coding style cleanup, kill all CPP style comments
Date: Fri, 24 Aug 2007 15:36:56 +0800
Message-ID: <1187941016.11318.1.camel@roc-laptop>
References: <1187938257.8499.4.camel@roc-laptop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187938257.8499.4.camel@roc-laptop>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: bryan.wu@analog.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Maybe lots of this change is useless because the CPP comments is for
debugging.
But I hope it is a start point for me in this MUSB development.

Thanks
- Bryan Wu

On Fri, 2007-08-24 at 14:50 +0800, Bryan Wu wrote:
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> ---
>  drivers/usb/musb/cppi_dma.c        |   12 ++++++------
>  drivers/usb/musb/cppi_dma.h        |    2 +-
>  drivers/usb/musb/musb_core.c       |   20 +++++++++++---------
>  drivers/usb/musb/musb_debug.h      |    2 +-
>  drivers/usb/musb/musb_dma.h        |    2 +-
>  drivers/usb/musb/musb_gadget.c     |   16 +++++++++-------
>  drivers/usb/musb/musb_gadget_ep0.c |    2 +-
>  drivers/usb/musb/musb_host.c       |   16 ++++++++--------
>  drivers/usb/musb/musb_host.h       |    2 +-
>  drivers/usb/musb/musb_procfs.c     |    8 ++++----
>  drivers/usb/musb/tusb6010.c        |    6 +++---
>  drivers/usb/musb/tusb6010_omap.c   |    4 ++--
>  12 files changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
> index 5403a4f..9b57fdf 100644
> --- a/drivers/usb/musb/cppi_dma.c
> +++ b/drivers/usb/musb/cppi_dma.c
> @@ -402,7 +402,7 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
>  
>  		musb_readl(c->stateRam, 4 * 4),	/* flags */
>  		musb_readl(c->stateRam, 5 * 4),	/* len */
> -		// dummy/unused word 6
> +		/* dummy/unused word 6 */
>  		musb_readl(c->stateRam, 7 * 4)	/* completion */
>  		);
>  }
> @@ -964,13 +964,13 @@ static int cppi_channel_program(struct dma_channel *pChannel,
>  		WARN("%cX DMA%d not cleaned up after abort!\n",
>  				otgChannel->transmit ? 'T' : 'R',
>  				otgChannel->chNo);
> -		//WARN_ON(1);
> +		/* WARN_ON(1); */
>  		break;
>  	case MUSB_DMA_STATUS_BUSY:
>  		WARN("program active channel?  %cX DMA%d\n",
>  				otgChannel->transmit ? 'T' : 'R',
>  				otgChannel->chNo);
> -		//WARN_ON(1);
> +		/* WARN_ON(1); */
>  		break;
>  	case MUSB_DMA_STATUS_UNKNOWN:
>  		DBG(1, "%cX DMA%d not allocated!\n",
> @@ -1207,7 +1207,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  				 *
>  				 * REVISIT have observed bit 18 set; huh??
>  				 */
> -//				if ((bdPtr->hOptions & CPPI_EOQ_MASK))
> +				/* if ((bdPtr->hOptions & CPPI_EOQ_MASK)) */
>  					txState->completionPtr = bdPtr->dma;
>  
>  				/* stop scanning on end-of-segment */
> @@ -1217,7 +1217,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
>  
>  			/* on end of segment, maybe go to next one */
>  			if (bReqComplete) {
> -				//cppi_dump_tx(4, txChannel, "/complete");
> +				/* cppi_dump_tx(4, txChannel, "/complete"); */
>  
>  				/* transfer more, or report completion */
>  				if (txChannel->currOffset
> @@ -1417,7 +1417,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
>  			musb_writel(regBase, DAVINCI_TXCPPI_INTCLR_REG,
>  					(1 << otgCh->chNo));
>  
> -		// REVISIT put timeouts on these controller handshakes
> +		/* REVISIT put timeouts on these controller handshakes */
>  
>  		cppi_dump_tx(6, otgCh, " (teardown)");
>  
> diff --git a/drivers/usb/musb/cppi_dma.h b/drivers/usb/musb/cppi_dma.h
> index 1d72c1b..af51f3b 100644
> --- a/drivers/usb/musb/cppi_dma.h
> +++ b/drivers/usb/musb/cppi_dma.h
> @@ -29,7 +29,7 @@
>  
>  /* CPPI data structure definitions */
>  
> -#define	CPPI_DESCRIPTOR_ALIGN	16	// bytes; 5-dec docs say 4-byte align
> +#define	CPPI_DESCRIPTOR_ALIGN	16	/* bytes; 5-dec docs say 4-byte align */
>  
>  struct cppi_descriptor {
>  	/* Hardware Overlay */
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index e02d65f..f7eea44 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -529,7 +529,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
>  					s = "<AValid"; break;
>  				case 2 << MUSB_DEVCTL_VBUS_SHIFT:
>  					s = "<VBusValid"; break;
> -				//case 3 << MUSB_DEVCTL_VBUS_SHIFT:
> +				/* case 3 << MUSB_DEVCTL_VBUS_SHIFT: */
>  				default:
>  					s = "VALID"; break;
>  				}; s; }),
> @@ -554,7 +554,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
>  #ifdef CONFIG_USB_MUSB_OTG
>  		/* flush endpoints when transitioning from Device Mode */
>  		if (is_peripheral_active(musb)) {
> -			// REVISIT HNP; just force disconnect
> +			/* REVISIT HNP; just force disconnect */
>  		}
>  		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
>  		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
> @@ -681,8 +681,10 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
>  		for (epnum = 1; (epnum < musb->nr_endpoints)
>  					&& (musb->epmask >= (1 << epnum));
>  				epnum++, ep++) {
> -			// FIXME handle framecounter wraps (12 bits)
> -			// eliminate duplicated StartUrb logic
> +			/*
> +			 * FIXME handle framecounter wraps (12 bits)
> +			 * eliminate duplicated StartUrb logic
> +			 */
>  			if (ep->dwWaitFrame >= frame) {
>  				ep->dwWaitFrame = 0;
>  				printk("SOF --> periodic TX%s on %d\n",
> @@ -812,7 +814,7 @@ void musb_start(struct musb *musb)
>  						| MUSB_POWER_SOFTCONN
>  						| MUSB_POWER_HSENAB
>  						/* ENSUSPEND wedges tusb */
> -						// | MUSB_POWER_ENSUSPEND
> +						/* | MUSB_POWER_ENSUSPEND */
>  						);
>  
>  	musb->is_active = 0;
> @@ -1142,7 +1144,7 @@ static int __init ep_config_from_table(struct musb *musb)
>  
> 
>  	offset = fifo_setup(musb, hw_ep, &ep0_cfg, 0);
> -	// assert(offset > 0)
> +	/* assert(offset > 0) */
>  
>  	/* NOTE:  for RTL versions >= 1.400 EPINFO and RAMINFO would
>  	 * be better than static MUSB_C_NUM_EPS and DYN_FIFO_SIZE...
> @@ -1496,7 +1498,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
>  	ep_num = 1;
>  	while (reg) {
>  		if (reg & 1) {
> -			// musb_ep_select(musb->mregs, ep_num);
> +			/* musb_ep_select(musb->mregs, ep_num); */
>  			/* REVISIT just retval = ep->rx_irq(...) */
>  			retval = IRQ_HANDLED;
>  			if (devctl & MUSB_DEVCTL_HM) {
> @@ -1517,7 +1519,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
>  	ep_num = 1;
>  	while (reg) {
>  		if (reg & 1) {
> -			// musb_ep_select(musb->mregs, ep_num);
> +			/* musb_ep_select(musb->mregs, ep_num); */
>  			/* REVISIT just retval |= ep->tx_irq(...) */
>  			retval = IRQ_HANDLED;
>  			if (devctl & MUSB_DEVCTL_HM) {
> @@ -1963,7 +1965,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  		goto fail2;
>  	}
>  	musb->nIrq = nIrq;
> -// FIXME this handles wakeup irqs wrong
> +/* FIXME this handles wakeup irqs wrong */
>  	if (enable_irq_wake(nIrq) == 0)
>  		device_init_wakeup(dev, 1);
>  
> diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
> index 5eff56e..a9a0055 100644
> --- a/drivers/usb/musb/musb_debug.h
> +++ b/drivers/usb/musb/musb_debug.h
> @@ -63,4 +63,4 @@ static inline int _dbg_level(unsigned l)
>  
>  extern const char *otg_state_string(struct musb *);
>  
> -#endif				//  __MUSB_LINUX_DEBUG_H__
> +#endif				/*  __MUSB_LINUX_DEBUG_H__ */
> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> index 74e38ec..679d4aa 100644
> --- a/drivers/usb/musb/musb_dma.h
> +++ b/drivers/usb/musb/musb_dma.h
> @@ -113,7 +113,7 @@ struct dma_controller;
>   */
>  struct dma_channel {
>  	void			*private_data;
> -	// FIXME not void* private_data, but a dma_controller *
> +	/* FIXME not void* private_data, but a dma_controller * */
>  	size_t			max_len;
>  	size_t			actual_len;
>  	enum dma_channel_status	status;
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 40c2283..8ab3197 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -322,7 +322,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  							MUSB_TXCSR_DMAMODE);
>  					csr |= (MUSB_TXCSR_DMAENAB |
>  							MUSB_TXCSR_MODE);
> -					// against programming guide
> +					/* against programming guide */
>  				}
>  				else
>  					csr |= (MUSB_TXCSR_AUTOSET
> @@ -646,7 +646,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  				csr |= MUSB_RXCSR_DMAENAB;
>  #ifdef USE_MODE1
>  				csr |= MUSB_RXCSR_AUTOCLEAR;
> -//				csr |= MUSB_RXCSR_DMAMODE;
> +				/* csr |= MUSB_RXCSR_DMAMODE; */
>  
>  				/* this special sequence (enabling and then
>  				   disabling MUSB_RXCSR_DMAMODE) is required
> @@ -769,7 +769,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
>  	}
>  
>  	if (csr & MUSB_RXCSR_P_OVERRUN) {
> -		// csr |= MUSB_RXCSR_P_WZC_BITS;
> +		/* csr |= MUSB_RXCSR_P_WZC_BITS; */
>  		csr &= ~MUSB_RXCSR_P_OVERRUN;
>  		musb_writew(epio, MUSB_RXCSR, csr);
>  
> @@ -1487,8 +1487,10 @@ static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
>  {
>  	DBG(2, "<= %s =>\n", __FUNCTION__);
>  
> -	// FIXME iff driver's softconnect flag is set (as it is during probe,
> -	// though that can clear it), just musb_pullup().
> +	/*
> +	 * FIXME iff driver's softconnect flag is set (as it is during probe,
> +	 * though that can clear it), just musb_pullup().
> +	 */
>  
>  	return -EINVAL;
>  }
> @@ -1534,7 +1536,7 @@ static const struct usb_gadget_ops musb_gadget_operations = {
>  	.get_frame		= musb_gadget_get_frame,
>  	.wakeup			= musb_gadget_wakeup,
>  	.set_selfpowered	= musb_gadget_set_self_powered,
> -	//.vbus_session		= musb_gadget_vbus_session,
> +	/* .vbus_session		= musb_gadget_vbus_session, */
>  	.vbus_draw		= musb_gadget_vbus_draw,
>  	.pullup			= musb_gadget_pullup,
>  };
> @@ -1551,7 +1553,7 @@ static struct musb *the_gadget;
>  
>  static void musb_gadget_release(struct device *dev)
>  {
> -	// kref_put(WHAT)
> +	/* kref_put(WHAT) */
>  	dev_dbg(dev, "%s\n", __FUNCTION__);
>  }
>  
> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 2395729..c4cb6a3 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -491,7 +491,7 @@ static void ep0_txstate(struct musb *musb)
>  	u8			fifo_count;
>  
>  	if (!request) {
> -		// WARN_ON(1);
> +		/* WARN_ON(1); */
>  		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MUSB_CSR0));
>  		return;
>  	}
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index e7935fb..0b9c0bc 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -247,7 +247,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
>  			qh->frame = urb->start_frame;
>  			/* enable SOF interrupt so we can count down */
>  DBG(1,"SOF for %d\n", epnum);
> -#if 1 // ifndef	CONFIG_ARCH_DAVINCI
> +#if 1 /* ifndef	CONFIG_ARCH_DAVINCI */
>  			musb_writeb(mbase, MUSB_INTRUSBE, 0xff);
>  #endif
>  		}
> @@ -481,7 +481,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
>  	int			pipe = urb->pipe;
>  	void			*buffer = urb->transfer_buffer;
>  
> -	// musb_ep_select(mbase, epnum);
> +	/* musb_ep_select(mbase, epnum); */
>  	rx_count = musb_readw(epio, MUSB_RXCOUNT);
>  	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, rx_count,
>  			urb->transfer_buffer, qh->offset,
> @@ -783,7 +783,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
>  				csr &= ~(MUSB_TXCSR_AUTOSET
>  					| MUSB_TXCSR_DMAMODE);
>  				csr |= (MUSB_TXCSR_DMAENAB);
> -					// against programming guide
> +					/* against programming guide */
>  			} else
>  				csr |= (MUSB_TXCSR_AUTOSET
>  					| MUSB_TXCSR_DMAENAB
> @@ -1312,7 +1312,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>  		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
>  
>  	} else if (!(tx_csr & MUSB_TXCSR_DMAENAB)) {
> -		// WARN_ON(!buf);
> +		/* WARN_ON(!buf); */
>  
>  		/* REVISIT:  some docs say that when hw_ep->tx_double_buffered,
>  		 * (and presumably, fifo is not half-full) we should write TWO
> @@ -1541,9 +1541,9 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  			status = -EPROTO;
>  			ERR("Rx interrupt with no errors or packet!\n");
>  
> -			// FIXME this is another "SHOULD NEVER HAPPEN"
> +			/* FIXME this is another "SHOULD NEVER HAPPEN" */
>  
> -// SCRUB (RX)
> +/* SCRUB (RX) */
>  			/* do the proper sequence to abort the transfer */
>  			musb_ep_select(mbase, epnum);
>  			val &= ~MUSB_RXCSR_H_REQPKT;
> @@ -2167,6 +2167,6 @@ const struct hc_driver musb_hc_driver = {
>  	.hub_control		= musb_hub_control,
>  	.bus_suspend		= musb_bus_suspend,
>  	.bus_resume		= musb_bus_resume,
> -//	.start_port_reset	= NULL,
> -//	.hub_irq_enable		= NULL,
> +	/* .start_port_reset	= NULL, */
> +	/* .hub_irq_enable	= NULL, */
>  };
> diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
> index cc8ab09..0f41b46 100644
> --- a/drivers/usb/musb/musb_host.h
> +++ b/drivers/usb/musb/musb_host.h
> @@ -54,7 +54,7 @@ struct musb_qh {
>  	struct musb_hw_ep	*hw_ep;		/* current binding */
>  
>  	struct list_head	ring;		/* of musb_qh */
> -	//struct musb_qh		*next;		/* for periodic tree */
> +	/* struct musb_qh		*next; */	/* for periodic tree */
>  
>  	unsigned		offset;		/* in urb->transfer_buffer */
>  	unsigned		segsize;	/* current xfer fragment */
> diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
> index 0db371b..5e63232 100644
> --- a/drivers/usb/musb/musb_procfs.c
> +++ b/drivers/usb/musb/musb_procfs.c
> @@ -705,8 +705,8 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
>  			reg = musb_readb(mbase, MUSB_DEVCTL);
>  			reg |= MUSB_DEVCTL_HR;
>  			musb_writeb(mbase, MUSB_DEVCTL, reg);
> -			//MUSB_HST_MODE( ((struct musb*)data) );
> -			//WARN("Host Mode\n");
> +			/* MUSB_HST_MODE( ((struct musb*)data) ); */
> +			/* WARN("Host Mode\n"); */
>  		}
>  		break;
>  
> @@ -802,7 +802,7 @@ static int musb_proc_read(char *page, char **start,
>  	}
>  
>  	/* generate the report for the end points */
> -	// REVISIT ... not unless something's connected!
> +	/* REVISIT ... not unless something's connected! */
>  	for (epnum = 0; count >= 0 && epnum < musb->nr_endpoints;
>  			epnum++) {
>  		code = dump_end_info(musb, epnum, buffer, count);
> @@ -840,7 +840,7 @@ musb_debug_create(char *name, struct musb *data)
>  					S_IFREG | S_IRUGO | S_IWUSR, NULL);
>  	if (pde) {
>  		pde->data = data;
> -		// pde->owner = THIS_MODULE;
> +		/* pde->owner = THIS_MODULE; */
>  
>  		pde->read_proc = musb_proc_read;
>  		pde->write_proc = musb_proc_write;
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index 525e24c..365bc3c 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -337,7 +337,7 @@ static void tusb_set_clock_source(struct musb *musb, unsigned mode)
>  
>  	musb_writel(base, TUSB_PRCM_CONF, reg);
>  
> -	// FIXME tusb6010_platform_retime(mode == 0);
> +	/* FIXME tusb6010_platform_retime(mode == 0); */
>  }
>  
>  /*
> @@ -669,7 +669,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
>  		if ((is_otg_enabled(musb) && !musb->xceiv.default_a)
>  				|| !is_host_enabled(musb)) {
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
> -			// ? musb_root_disconnect(musb);
> +			/* ? musb_root_disconnect(musb); */
>  			musb->port1_status &=
>  				~(USB_PORT_STAT_CONNECTION
>  				| USB_PORT_STAT_ENABLE
> @@ -837,7 +837,7 @@ static irqreturn_t tusb_interrupt(int irq, void *__hci)
>  		DBG(3, "wake %sactive %02x\n",
>  				musb->is_active ? "" : "in", reg);
>  
> -		// REVISIT host side TUSB_PRCM_WHOSTDISCON, TUSB_PRCM_WBUS
> +		/* REVISIT host side TUSB_PRCM_WHOSTDISCON, TUSB_PRCM_WBUS */
>  	}
>  
>  	if (int_src & TUSB_INT_SRC_USB_IP_CONN)
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index c7fbfba..768f013 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -75,7 +75,7 @@ static int tusb_omap_dma_start(struct dma_controller *c)
>  
>  	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
>  
> -	// DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch);
> +	/* DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
>  
>  	return 0;
>  }
> @@ -86,7 +86,7 @@ static int tusb_omap_dma_stop(struct dma_controller *c)
>  
>  	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
>  
> -	// DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch);
> +	/* DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
>  
>  	return 0;
>  }

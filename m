From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Fri, 23 Nov 2018 15:43:12 +0000
Message-ID: <20181123154311.GP6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 23, 2018 at 02:35:04PM +0200, Peter Ujfalusi wrote:
> > Also we can't deal with the omap_set_dma_dest_burst_mode() setting -
> > DMAengine always uses a 64 byte burst, but udc wants a smaller burst
> > setting.  Does this matter?
> 
> The tusb also fiddled with the burst before the conversion, I believe
> what the DMAengine driver is doing should be fine. If not then we fix it
> while converting the omap_udc.

That's good news, so I can ignore that difference.

> > I'm also not sure about this:
> > 
> >         if (cpu_is_omap15xx())
> >                 end++;
> > 
> > in dma_dest_len() - is that missing from the omap-dma driver?  It looks
> > like a work-around for some problem on OMAP15xx, but I can't make sense
> > about why it's in the UDC driver rather than the legacy DMA driver.
> 
> afaik no other legacy drivers were doing similar thing, this must be
> something which is needed for the omap_udc driver to fix up something?
> 
> > 
> > I'm also confused by:
> > 
> >         end |= start & (0xffff << 16);
> > 
> > also in dma_dest_len() - omap_get_dma_dst_pos() returns in the high 16
> > bits the full address:
> > 
> >         if (dma_omap1())
> >                 offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
> 
> CDSA is OMAP_DMA_REG_2X16BIT for omap1
> The CPC/CDAC holds the LSB of the _current_ DMA pointer. The code gets
> the MSB of the address from the CDSA registers.
> 
> > 
> > so if the address crosses a 64k physical address boundary, surely orring
> > in the start address is wrong?  The more I look at dma_dest_len(), the
> > more I wonder whether that and dma_src_len() are anywhere near correct,
> > and whether that is a source of breakage for Aaro.
> 
> Hrm, again... the position reporting on OMAP1 is certainly not something
> I would put my life on :o

My feeling is - if the code in plat-omap/dma.c doesn't work, we've got
the same problems in the dmaengine driver, so the reported residue will
be wrong.  Any workarounds need to be within the dmaengine driver, not
in individual drivers.  We can't just go subtracting 1 from the residue
reported by dmaengine.

> > diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
> > index 3a16431da321..a37e1d2f0f3e 100644
> > --- a/drivers/usb/gadget/udc/omap_udc.c
> > +++ b/drivers/usb/gadget/udc/omap_udc.c
> > @@ -204,6 +204,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
> >  	ep->dma_channel = 0;
> >  	ep->has_dma = 0;
> >  	ep->lch = -1;
> > +	ep->dma = NULL;
> >  	use_ep(ep, UDC_EP_SEL);
> >  	omap_writew(udc->clr_halt, UDC_CTRL);
> >  	ep->ackwait = 0;
> > @@ -576,21 +577,49 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
> >  static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
> >  {
> >  	unsigned packets = req->req.length - req->req.actual;
> > -	int dma_trigger = 0;
> > +	struct dma_async_tx_descriptor *tx;
> > +	struct dma_chan *dma = ep->dma;
> > +	dma_cookie_t cookie;
> >  	u16 w;
> >  
> > -	/* set up this DMA transfer, enable the fifo, start */
> > -	packets /= ep->ep.maxpacket;
> > -	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
> > +	packets = min_t(unsigned, packets / ep->ep.maxpacket, UDC_RXN_TC + 1);
> >  	req->dma_bytes = packets * ep->ep.maxpacket;
> > -	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
> > -			ep->ep.maxpacket >> 1, packets,
> > -			OMAP_DMA_SYNC_ELEMENT,
> > -			dma_trigger, 0);
> > -	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
> > -		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
> > -		0, 0);
> > -	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
> > +
> > +	if (dma) {
> > +		struct dma_slave_config cfg = {
> > +			.direction = DMA_DEV_TO_MEM,
> > +			.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTE,
> > +			/*
> > +			 * DMAengine uses frame sync mode, setting maxburst=1
> > +			 * is equivalent to element sync mode.
> > +			 */
> > +			.src_maxburst = 1,
> 
> We should fix the omap-dma driver for slave_sg  instead:
> 
> if (!burst)
> 	burst = 1;
> 
> I thought that I already did that.

It isn't in 4.19, and I see no changes between 4.19 and 4.20-rc for
ti/omap-dma.c.

> > +		struct dma_chan *dma;
> > +
> >  		dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
> > -		status = omap_request_dma(dma_channel,
> > -			ep->ep.name, dma_error, ep, &ep->lch);
> > -		if (status == 0) {
> > +
> > +		dma = __dma_request_channel(&mask, omap_dma_filter_fn,
> > +					    (void *)dma_channel);
> 
> dma_request_chan(dev, "ch_name");
> 
> where ch_name: rx0/1/2, tx0/1/2
> 
> and we don't need the omap_dma_filter_fn in here as all taken care via
> the dma_slave_map

Yea, we can switch to that once the DT has been modified, but let's
try to keep the conversion as separate small steps at the moment.

> I try to give this a try, thanks Russell for the patch!

Thanks for the response, I'll rip out the old non-DMAengine handling
for OUT transfers given your responses so far - I've been though all
the register constructions, and it looks like I've broadly got it
right, with the differences that I've already noted.

I'll send an updated patch shortly.

I've just spotted that I've missed a call to dma_dest_len() in
proc_ep_show() though...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

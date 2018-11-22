From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Thu, 22 Nov 2018 15:12:36 +0000
Message-ID: <20181122151236.GA9611@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122102948.GN6920@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > API were too annoying and flooding the console. And now that I tried
> > using DMA again with g_ether, it doesn't work anymore. The device get's
> > recognized on host side, but no traffic goes through. Switching back to
> > PIO makes it to work again.
> 
> A solution to that would be to do what the warning message says, and
> update the driver to the DMAengine API.

Here's a partial conversion (not even build tested) - it only supports
OUT transfers with dmaengine at the moment.

There's at least one thing that doesn't make sense - the driver
apparently can transfer more than req->length bytes, surely if it does
that, it's a serious problem - shouldn't it be noisy about that?

Also we can't deal with the omap_set_dma_dest_burst_mode() setting -
DMAengine always uses a 64 byte burst, but udc wants a smaller burst
setting.  Does this matter?

I've kept the old code for reference (and the driver will fall back if
we can't get a dmaengine channel.)  I haven't been through and checked
that we result in the channel setup largely the same either.

There will be one major difference - UDC uses element sync, where
an element is 16bits, ep->ep.maxpacket/2 in a frame, and "packets"
frames.  DMAengine is using frame sync, with a 16bit element, one
element in a frame, and packets*ep->ep.maxpacket/2 frames.  This
should be functionally equivalent but I'd like confirmation of that.

I'm also not sure about this:

        if (cpu_is_omap15xx())
                end++;

in dma_dest_len() - is that missing from the omap-dma driver?  It looks
like a work-around for some problem on OMAP15xx, but I can't make sense
about why it's in the UDC driver rather than the legacy DMA driver.

I'm also confused by:

        end |= start & (0xffff << 16);

also in dma_dest_len() - omap_get_dma_dst_pos() returns in the high 16
bits the full address:

        if (dma_omap1())
                offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);

so if the address crosses a 64k physical address boundary, surely orring
in the start address is wrong?  The more I look at dma_dest_len(), the
more I wonder whether that and dma_src_len() are anywhere near correct,
and whether that is a source of breakage for Aaro.

As I've already said, I've no way to test this on hardware.

Please review and let me know whether I missed anything on the OUT
handling path.

Fixing the IN path is going to be a bit more head-scratching.

 drivers/usb/gadget/udc/omap_udc.c | 154 +++++++++++++++++++++++++++++---------
 drivers/usb/gadget/udc/omap_udc.h |   2 +
 2 files changed, 120 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 3a16431da321..a37e1d2f0f3e 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -204,6 +204,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
 	ep->dma_channel = 0;
 	ep->has_dma = 0;
 	ep->lch = -1;
+	ep->dma = NULL;
 	use_ep(ep, UDC_EP_SEL);
 	omap_writew(udc->clr_halt, UDC_CTRL);
 	ep->ackwait = 0;
@@ -576,21 +577,49 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
 static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 {
 	unsigned packets = req->req.length - req->req.actual;
-	int dma_trigger = 0;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_chan *dma = ep->dma;
+	dma_cookie_t cookie;
 	u16 w;
 
-	/* set up this DMA transfer, enable the fifo, start */
-	packets /= ep->ep.maxpacket;
-	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
+	packets = min_t(unsigned, packets / ep->ep.maxpacket, UDC_RXN_TC + 1);
 	req->dma_bytes = packets * ep->ep.maxpacket;
-	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
-			ep->ep.maxpacket >> 1, packets,
-			OMAP_DMA_SYNC_ELEMENT,
-			dma_trigger, 0);
-	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
-		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
-		0, 0);
-	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
+
+	if (dma) {
+		struct dma_slave_config cfg = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTE,
+			/*
+			 * DMAengine uses frame sync mode, setting maxburst=1
+			 * is equivalent to element sync mode.
+			 */
+			.src_maxburst = 1,
+			.src_addr = UDC_DATA_DMA,
+		};
+
+		if (WARN_ON(dmaengine_slave_config(dma, &cfg)))
+			return;
+
+		tx = dmaengine_prep_slave_single(dma,
+						 req->req.dma + req->req.actual,
+						 req->dma_bytes,
+						 DMA_DEV_TO_MEM, 0);
+		if (WARN_ON(!tx))
+			return;
+	} else {
+		int dma_trigger = 0;
+
+		/* set up this DMA transfer, enable the fifo, start */
+		/* dt = S16, cen = ep->ep.maxpacket / 2, cfn = packets */
+		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
+				ep->ep.maxpacket >> 1, packets,
+				OMAP_DMA_SYNC_ELEMENT,
+				dma_trigger, 0);
+		omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
+			OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
+			0, 0);
+		ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
+	}
 
 	omap_writew(UDC_RXN_STOP | (packets - 1), UDC_RXDMA(ep->dma_channel));
 	w = omap_readw(UDC_DMA_IRQ_EN);
@@ -599,7 +628,15 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 	omap_writew(ep->bEndpointAddress & 0xf, UDC_EP_NUM);
 	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 
-	omap_start_dma(ep->lch);
+	if (dma) {
+		cookie = dmaengine_submit(tx);
+		if (WARN_ON(dma_submit_error(cookie)))
+			return;
+		ep->dma_cookie = cookie;
+		dma_async_issue_pending(dma);
+	} else {
+		omap_start_dma(ep->lch);
+	}
 }
 
 static void
@@ -607,21 +644,39 @@ finish_out_dma(struct omap_ep *ep, struct omap_req *req, int status, int one)
 {
 	u16	count, w;
 
-	if (status == 0)
-		ep->dma_counter = (u16) (req->req.dma + req->req.actual);
-	count = dma_dest_len(ep, req->req.dma + req->req.actual);
+	if (ep->dma) {
+		struct dma_tx_state state;
+
+		dmaengine_tx_status(ep->dma, ep->dma_cookie, &state);
+
+		count = req->dma_bytes - state.residual;
+	} else {
+		if (status == 0)
+			ep->dma_counter = (u16) (req->req.dma + req->req.actual);
+		count = dma_dest_len(ep, req->req.dma + req->req.actual);
+	}
+
 	count += req->req.actual;
 	if (one)
 		count--;
+
+	/*
+	 * FIXME: Surely if count > req->req.length, something has gone
+	 * seriously wrong and we've scribbled over memory we should not...
+	 * so surely we should be a WARN_ON() at the very least?
+	 */
 	if (count <= req->req.length)
 		req->req.actual = count;
 
-	if (count != req->dma_bytes || status)
-		omap_stop_dma(ep->lch);
-
+	if (count != req->dma_bytes || status) {
+		if (ep->dma)
+			dmaengine_terminate_async(ep->dma);
+		else
+			omap_stop_dma(ep->lch);
 	/* if this wasn't short, request may need another transfer */
-	else if (req->req.actual < req->req.length)
+	} else if (req->req.actual < req->req.length) {
 		return;
+	}
 
 	/* rx completion */
 	w = omap_readw(UDC_DMA_IRQ_EN);
@@ -709,6 +764,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 
 	ep->dma_channel = 0;
 	ep->lch = -1;
+	ep->dma = NULL;
 	if (channel == 0 || channel > 3) {
 		if ((reg & 0x0f00) == 0)
 			channel = 3;
@@ -742,26 +798,44 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				0, 0);
 		}
 	} else {
+		struct dma_chan *dma;
+
 		dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
-		status = omap_request_dma(dma_channel,
-			ep->ep.name, dma_error, ep, &ep->lch);
-		if (status == 0) {
+
+		dma = __dma_request_channel(&mask, omap_dma_filter_fn,
+					    (void *)dma_channel);
+		if (dma) {
+			ep->dma = dma;
 			omap_writew(reg, UDC_RXDMA_CFG);
-			/* TIPB */
-			omap_set_dma_src_params(ep->lch,
-				OMAP_DMA_PORT_TIPB,
-				OMAP_DMA_AMODE_CONSTANT,
-				UDC_DATA_DMA,
-				0, 0);
-			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
-			omap_set_dma_dest_data_pack(ep->lch, 1);
+		} else {
+			status = omap_request_dma(dma_channel,
+				ep->ep.name, dma_error, ep, &ep->lch);
+			if (status == 0) {
+				omap_writew(reg, UDC_RXDMA_CFG);
+				/* TIPB */
+				omap_set_dma_src_params(ep->lch,
+					OMAP_DMA_PORT_TIPB,
+					OMAP_DMA_AMODE_CONSTANT,
+					UDC_DATA_DMA,
+					0, 0);
+				/* EMIFF or SDRC */
+				/*
+				 * not ok - CSDP_DST_BURST_64 selected, but this selects
+				 * CSDP_DST_BURST_16 on omap2+ and CSDP_DST_BURST_32 on
+				 * omap1.
+				 */
+				omap_set_dma_dest_burst_mode(ep->lch,
+							OMAP_DMA_DATA_BURST_4);
+				/* ok - CSDP_DST_PACKED set for dmaengine */
+				omap_set_dma_dest_data_pack(ep->lch, 1);
+			}
 		}
 	}
-	if (status)
+	if (d->dma) {
+		ep->has_dma = 1;
+	} else if (status) {
 		ep->dma_channel = 0;
-	else {
+	} else {
 		ep->has_dma = 1;
 		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
 
@@ -777,6 +851,10 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 	if (status)
 		DBG("%s no dma channel: %d%s\n", ep->ep.name, status,
 			restart ? " (restart)" : "");
+	else if (d->dma)
+		DBG("%s claimed %cxdma%d dmaengine %s%s\n", ep->ep.name,
+			is_in ? 't' : 'r', ep->dma_channel - 1,
+			dma_chan_name(d->dma), restart ? " (restart)" : "");
 	else
 		DBG("%s claimed %cxdma%d lch %d%s\n", ep->ep.name,
 			is_in ? 't' : 'r',
@@ -850,9 +928,13 @@ static void dma_channel_release(struct omap_ep *ep)
 		if (req)
 			finish_out_dma(ep, req, -ECONNRESET, 0);
 	}
-	omap_free_dma(ep->lch);
+	if (ep->dma)
+		dma_release_channel(ep->dma);
+	else
+		omap_free_dma(ep->lch);
 	ep->dma_channel = 0;
 	ep->lch = -1;
+	ep->dma = NULL;
 	/* has_dma still set, till endpoint is fully quiesced */
 }
 
diff --git a/drivers/usb/gadget/udc/omap_udc.h b/drivers/usb/gadget/udc/omap_udc.h
index 00f9e608e755..68857ae8d763 100644
--- a/drivers/usb/gadget/udc/omap_udc.h
+++ b/drivers/usb/gadget/udc/omap_udc.h
@@ -153,6 +153,8 @@ struct omap_ep {
 	u8				dma_channel;
 	u16				dma_counter;
 	int				lch;
+	struct dma_chan			*dma;
+	dma_cookie_t			dma_cookie;
 	struct omap_udc			*udc;
 	struct timer_list		timer;
 };

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

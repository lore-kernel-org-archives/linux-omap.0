From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Fri, 23 Nov 2018 16:16:59 +0000
Message-ID: <20181123161659.GA3019@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123154311.GP6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123154311.GP6920@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

Here's the patch, which should now support IN as well as OUT.
Completely untested, as mentioned before.

 drivers/usb/gadget/udc/omap_udc.c | 286 ++++++++++++++++++--------------------
 drivers/usb/gadget/udc/omap_udc.h |   3 +-
 2 files changed, 135 insertions(+), 154 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 3a16431da321..ad6f315e4327 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -203,7 +204,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
 	/* set endpoint to initial state */
 	ep->dma_channel = 0;
 	ep->has_dma = 0;
-	ep->lch = -1;
+	ep->dma = NULL;
 	use_ep(ep, UDC_EP_SEL);
 	omap_writew(udc->clr_halt, UDC_CTRL);
 	ep->ackwait = 0;
@@ -468,43 +469,6 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 
 /*-------------------------------------------------------------------------*/
 
-static u16 dma_src_len(struct omap_ep *ep, dma_addr_t start)
-{
-	dma_addr_t	end;
-
-	/* IN-DMA needs this on fault/cancel paths, so 15xx misreports
-	 * the last transfer's bytecount by more than a FIFO's worth.
-	 */
-	if (cpu_is_omap15xx())
-		return 0;
-
-	end = omap_get_dma_src_pos(ep->lch);
-	if (end == ep->dma_counter)
-		return 0;
-
-	end |= start & (0xffff << 16);
-	if (end < start)
-		end += 0x10000;
-	return end - start;
-}
-
-static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
-{
-	dma_addr_t	end;
-
-	end = omap_get_dma_dst_pos(ep->lch);
-	if (end == ep->dma_counter)
-		return 0;
-
-	end |= start & (0xffff << 16);
-	if (cpu_is_omap15xx())
-		end++;
-	if (end < start)
-		end += 0x10000;
-	return end - start;
-}
-
-
 /* Each USB transfer request using DMA maps to one or more DMA transfers.
  * When DMA completion isn't request completion, the UDC continues with
  * the next DMA transfer for that USB transfer.
@@ -512,34 +476,53 @@ static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
 
 static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
 {
-	u16		txdma_ctrl, w;
-	unsigned	length = req->req.length - req->req.actual;
-	const int	sync_mode = cpu_is_omap15xx()
-				? OMAP_DMA_SYNC_FRAME
-				: OMAP_DMA_SYNC_ELEMENT;
-	int		dma_trigger = 0;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_chan *dma = ep->dma;
+	dma_cookie_t cookie;
+	unsigned burst, length;
+	u16 txdma_ctrl, w;
+	struct dma_slave_config omap_udc_in_cfg = {
+		.direction = DMA_MEM_TO_DEV,
+		.dst_addr = UDC_DATA_DMA,
+	};
+
+	length = req->req.length - req->req.actual;
 
 	/* measure length in either bytes or packets */
-	if ((cpu_is_omap16xx() && length <= UDC_TXN_TSC)
-			|| (cpu_is_omap15xx() && length < ep->maxpacket)) {
+	if ((cpu_is_omap16xx() && length <= UDC_TXN_TSC) ||
+	    (cpu_is_omap15xx() && length < ep->maxpacket)) {
+		omap_udc_in_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 		txdma_ctrl = UDC_TXN_EOT | length;
-		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
-				length, 1, sync_mode, dma_trigger, 0);
+		burst = length;
 	} else {
-		length = min(length / ep->maxpacket,
-				(unsigned) UDC_TXN_TSC + 1);
+		omap_udc_in_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTE;
+		length = min_t(unsigned, length / ep->maxpacket,
+		               UDC_TXN_TSC + 1);
 		txdma_ctrl = length;
-		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
-				ep->ep.maxpacket >> 1, length, sync_mode,
-				dma_trigger, 0);
 		length *= ep->maxpacket;
+		burst = ep->ep.maxpacket >> 1;
 	}
-	omap_set_dma_src_params(ep->lch, OMAP_DMA_PORT_EMIFF,
-		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
-		0, 0);
 
-	omap_start_dma(ep->lch);
-	ep->dma_counter = omap_get_dma_src_pos(ep->lch);
+	if (!cpu_is_omap15xx())
+		burst = 1;
+
+	omap_udc_in_cfg.dst_maxburst = burst;
+
+	if (WARN_ON(dmaengine_slave_config(dma, &omap_udc_in_cfg)))
+		return;
+
+	tx = dmaengine_prep_slave_single(dma, req->req.dma + req->req.actual,
+					 length, DMA_MEM_TO_DEV, 0);
+	if (WARN_ON(!tx))
+		return;
+
+	cookie = dmaengine_submit(tx);
+	if (WARN_ON(dma_submit_error(cookie)))
+		return;
+
+	ep->dma_cookie = cookie;
+	dma_async_issue_pending(dma);
+
 	w = omap_readw(UDC_DMA_IRQ_EN);
 	w |= UDC_TX_DONE_IE(ep->dma_channel);
 	omap_writew(w, UDC_DMA_IRQ_EN);
@@ -549,11 +532,14 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
 
 static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
 {
+	struct dma_tx_state state;
 	u16 w;
 
-	if (status == 0) {
-		req->req.actual += req->dma_bytes;
+	dmaengine_tx_status(ep->dma, ep->dma_cookie, &state);
 
+	req->req.actual += req->dma_bytes - state.residual;
+
+	if (status == 0) {
 		/* return if this request needs to send data or zlp */
 		if (req->req.actual < req->req.length)
 			return;
@@ -561,36 +547,47 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
 				&& req->dma_bytes != 0
 				&& (req->req.actual % ep->maxpacket) == 0)
 			return;
-	} else
-		req->req.actual += dma_src_len(ep, req->req.dma
-							+ req->req.actual);
+	}
 
 	/* tx completion */
-	omap_stop_dma(ep->lch);
+	dmaengine_terminate_async(ep->dma);
+
 	w = omap_readw(UDC_DMA_IRQ_EN);
 	w &= ~UDC_TX_DONE_IE(ep->dma_channel);
 	omap_writew(w, UDC_DMA_IRQ_EN);
 	done(ep, req, status);
 }
 
+static const struct dma_slave_config omap_udc_out_cfg = {
+	.direction = DMA_DEV_TO_MEM,
+	.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTE,
+	/*
+	 * DMAengine uses frame sync mode, setting maxburst=1
+	 * is equivalent to element sync mode.
+	 */
+	.src_maxburst = 1,
+	.src_addr = UDC_DATA_DMA,
+};
+
 static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 {
-	unsigned packets = req->req.length - req->req.actual;
-	int dma_trigger = 0;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_chan *dma = ep->dma;
+	dma_cookie_t cookie;
+	unsigned packets, length;
 	u16 w;
 
-	/* set up this DMA transfer, enable the fifo, start */
-	packets /= ep->ep.maxpacket;
-	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
-	req->dma_bytes = packets * ep->ep.maxpacket;
-	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
-			ep->ep.maxpacket >> 1, packets,
-			OMAP_DMA_SYNC_ELEMENT,
-			dma_trigger, 0);
-	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
-		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
-		0, 0);
-	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
+	length = req->req.length - req->req.actual;
+	packets = min_t(unsigned, length / ep->ep.maxpacket, UDC_RXN_TC + 1);
+	length = packets * ep->ep.maxpacket;
+
+	if (WARN_ON(dmaengine_slave_config(dma, &omap_udc_out_cfg)))
+		return;
+
+	tx = dmaengine_prep_slave_single(dma, req->req.dma + req->req.actual,
+					 length, DMA_DEV_TO_MEM, 0);
+	if (WARN_ON(!tx))
+		return;
 
 	omap_writew(UDC_RXN_STOP | (packets - 1), UDC_RXDMA(ep->dma_channel));
 	w = omap_readw(UDC_DMA_IRQ_EN);
@@ -599,29 +596,42 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 	omap_writew(ep->bEndpointAddress & 0xf, UDC_EP_NUM);
 	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 
-	omap_start_dma(ep->lch);
+	cookie = dmaengine_submit(tx);
+	if (WARN_ON(dma_submit_error(cookie)))
+		return;
+
+	ep->dma_cookie = cookie;
+	dma_async_issue_pending(dma);
+	req->dma_bytes = length;
 }
 
 static void
 finish_out_dma(struct omap_ep *ep, struct omap_req *req, int status, int one)
 {
+	struct dma_tx_state state;
 	u16	count, w;
 
-	if (status == 0)
-		ep->dma_counter = (u16) (req->req.dma + req->req.actual);
-	count = dma_dest_len(ep, req->req.dma + req->req.actual);
+	dmaengine_tx_status(ep->dma, ep->dma_cookie, &state);
+
+	count = req->dma_bytes - state.residual;
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
+		dmaengine_terminate_async(ep->dma);
 	/* if this wasn't short, request may need another transfer */
-	else if (req->req.actual < req->req.length)
+	} else if (req->req.actual < req->req.length) {
 		return;
+	}
 
 	/* rx completion */
 	w = omap_readw(UDC_DMA_IRQ_EN);
@@ -683,19 +693,10 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 	}
 }
 
-static void dma_error(int lch, u16 ch_status, void *data)
-{
-	struct omap_ep	*ep = data;
-
-	/* if ch_status & OMAP_DMA_DROP_IRQ ... */
-	/* if ch_status & OMAP1_DMA_TOUT_IRQ ... */
-	ERR("%s dma error, lch %d status %02x\n", ep->ep.name, lch, ch_status);
-
-	/* complete current transfer ... */
-}
-
 static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 {
+	dma_cap_mask_t mask;
+	struct dma_chan *dma;
 	u16	reg;
 	int	status, restart, is_in;
 	int	dma_channel;
@@ -708,7 +709,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 	reg |= UDC_DMA_REQ;		/* "pulse" activated */
 
 	ep->dma_channel = 0;
-	ep->lch = -1;
+	ep->dma = NULL;
 	if (channel == 0 || channel > 3) {
 		if ((reg & 0x0f00) == 0)
 			channel = 3;
@@ -722,65 +723,41 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		}
 	}
 	reg |= (0x0f & ep->bEndpointAddress) << (4 * (channel - 1));
-	ep->dma_channel = channel;
 
-	if (is_in) {
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	if (is_in)
 		dma_channel = OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
-		status = omap_request_dma(dma_channel,
-			ep->ep.name, dma_error, ep, &ep->lch);
-		if (status == 0) {
-			omap_writew(reg, UDC_TXDMA_CFG);
-			/* EMIFF or SDRC */
-			omap_set_dma_src_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
-			omap_set_dma_src_data_pack(ep->lch, 1);
-			/* TIPB */
-			omap_set_dma_dest_params(ep->lch,
-				OMAP_DMA_PORT_TIPB,
-				OMAP_DMA_AMODE_CONSTANT,
-				UDC_DATA_DMA,
-				0, 0);
-		}
-	} else {
+	else
 		dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
-		status = omap_request_dma(dma_channel,
-			ep->ep.name, dma_error, ep, &ep->lch);
-		if (status == 0) {
+
+	dma = __dma_request_channel(&mask, omap_dma_filter_fn,
+				    (void *)dma_channel);
+	if (dma) {
+		ep->dma_channel = channel;
+		ep->dma = dma;
+		if (is_in)
+			omap_writew(reg, UDC_TXDMA_CFG);
+		else
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
-		}
-	}
-	if (status)
-		ep->dma_channel = 0;
-	else {
 		ep->has_dma = 1;
-		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
-
-		/* channel type P: hw synch (fifo) */
-		if (!cpu_is_omap15xx())
-			omap_set_dma_channel_mode(ep->lch, OMAP_DMA_LCH_P);
+		status = 0;
+	} else {
+		ep->dma_channel = 0;
+		status = -EINVAL;
 	}
 
 just_restart:
 	/* restart any queue, even if the claim failed  */
 	restart = !ep->stopped && !list_empty(&ep->queue);
 
-	if (status)
-		DBG("%s no dma channel: %d%s\n", ep->ep.name, status,
-			restart ? " (restart)" : "");
+	if (d->dma)
+		DBG("%s claimed %cxdma%d dmaengine %s%s\n", ep->ep.name,
+			is_in ? 't' : 'r', ep->dma_channel - 1,
+			dma_chan_name(d->dma), restart ? " (restart)" : "");
 	else
-		DBG("%s claimed %cxdma%d lch %d%s\n", ep->ep.name,
-			is_in ? 't' : 'r',
-			ep->dma_channel - 1, ep->lch,
+		DBG("%s no dma channel: %d%s\n", ep->ep.name, status,
 			restart ? " (restart)" : "");
 
 	if (restart) {
@@ -814,7 +791,8 @@ static void dma_channel_release(struct omap_ep *ep)
 	else
 		req = NULL;
 
-	active = omap_get_dma_active_status(ep->lch);
+	active = dma_async_is_tx_complete(ep->dma, ep->dma_cookie, NULL, NULL)
+			== DMA_IN_PROGRESS;
 
 	DBG("%s release %s %cxdma%d %p\n", ep->ep.name,
 			active ? "active" : "idle",
@@ -850,9 +828,9 @@ static void dma_channel_release(struct omap_ep *ep)
 		if (req)
 			finish_out_dma(ep, req, -ECONNRESET, 0);
 	}
-	omap_free_dma(ep->lch);
+	dma_release_channel(ep->dma);
 	ep->dma_channel = 0;
-	ep->lch = -1;
+	ep->dma = NULL;
 	/* has_dma still set, till endpoint is fully quiesced */
 }
 
@@ -2146,9 +2124,9 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 	use_ep(ep, 0);
 
 	if (use_dma && ep->has_dma)
-		snprintf(buf, sizeof buf, "(%cxdma%d lch%d) ",
+		snprintf(buf, sizeof buf, "(%cxdma%d dma %s) ",
 			(ep->bEndpointAddress & USB_DIR_IN) ? 't' : 'r',
-			ep->dma_channel - 1, ep->lch);
+			ep->dma_channel - 1, dma_chan_name(ep->dma));
 	else
 		buf[0] = 0;
 
@@ -2194,9 +2172,11 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 			unsigned	length = req->req.actual;
 
 			if (use_dma && buf[0]) {
-				length += ((ep->bEndpointAddress & USB_DIR_IN)
-						? dma_src_len : dma_dest_len)
-					(ep, req->req.dma + length);
+				struct dma_tx_state state;
+
+				dmaengine_tx_status(ep->dma, ep->dma_cookie,
+						    &state);
+				length += req->dma_bytes - state.residual;
 				buf[0] = 0;
 			}
 			seq_printf(s, "\treq %p len %d/%d buf %p\n",
diff --git a/drivers/usb/gadget/udc/omap_udc.h b/drivers/usb/gadget/udc/omap_udc.h
index 00f9e608e755..e04c48f669ed 100644
--- a/drivers/usb/gadget/udc/omap_udc.h
+++ b/drivers/usb/gadget/udc/omap_udc.h
@@ -152,7 +152,8 @@ struct omap_ep {
 	u8				ackwait;
 	u8				dma_channel;
 	u16				dma_counter;
-	int				lch;
+	struct dma_chan			*dma;
+	dma_cookie_t			dma_cookie;
 	struct omap_udc			*udc;
 	struct timer_list		timer;
 };

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

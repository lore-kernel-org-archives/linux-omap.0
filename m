From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] USB: Remove omap2 support from omap_udc.c
Date: Mon, 21 May 2012 12:01:11 -0700
Message-ID: <20120521190111.927.38546.stgit@muffinssi.local>
References: <20120521185323.927.88012.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14949 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2EUTBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 15:01:14 -0400
In-Reply-To: <20120521185323.927.88012.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>

There are no active users of this code for omap2 as
the boards in use have either TUSB or MUSB controller.

While at it, also fix warnings related to uninitialized
dc_clk and hhc_clk.

Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/gadget/omap_udc.c |  113 ++++++++---------------------------------
 1 file changed, 23 insertions(+), 90 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 2acf06c..913587f 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -62,9 +62,6 @@
 
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
-#define OMAP2_DMA_CH(ch)	(((ch) - 1) << 1)
-#define OMAP24XX_DMA(name, ch)	(OMAP24XX_DMA_##name + OMAP2_DMA_CH(ch))
-
 /*
  * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
  * D+ pullup to allow enumeration.  That's too early for the gadget
@@ -537,12 +534,8 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
 				: OMAP_DMA_SYNC_ELEMENT;
 	int		dma_trigger = 0;
 
-	if (cpu_is_omap24xx())
-		dma_trigger = OMAP24XX_DMA(USB_W2FC_TX0, ep->dma_channel);
-
 	/* measure length in either bytes or packets */
 	if ((cpu_is_omap16xx() && length <= UDC_TXN_TSC)
-			|| (cpu_is_omap24xx() && length < ep->maxpacket)
 			|| (cpu_is_omap15xx() && length < ep->maxpacket)) {
 		txdma_ctrl = UDC_TXN_EOT | length;
 		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
@@ -601,28 +594,14 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 	int dma_trigger = 0;
 	u16 w;
 
-	if (cpu_is_omap24xx())
-		dma_trigger = OMAP24XX_DMA(USB_W2FC_RX0, ep->dma_channel);
-
-	/* NOTE:  we filtered out "short reads" before, so we know
-	 * the buffer has only whole numbers of packets.
-	 * except MODE SELECT(6) sent the 24 bytes data in OMAP24XX DMA mode
-	 */
-	if (cpu_is_omap24xx() && packets < ep->maxpacket) {
-		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
-				packets, 1, OMAP_DMA_SYNC_ELEMENT,
-				dma_trigger, 0);
-		req->dma_bytes = packets;
-	} else {
-		/* set up this DMA transfer, enable the fifo, start */
-		packets /= ep->ep.maxpacket;
-		packets = min(packets, (unsigned)UDC_RXN_TC + 1);
-		req->dma_bytes = packets * ep->ep.maxpacket;
-		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
-				ep->ep.maxpacket >> 1, packets,
-				OMAP_DMA_SYNC_ELEMENT,
-				dma_trigger, 0);
-	}
+	/* set up this DMA transfer, enable the fifo, start */
+	packets /= ep->ep.maxpacket;
+	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
+	req->dma_bytes = packets * ep->ep.maxpacket;
+	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
+			ep->ep.maxpacket >> 1, packets,
+			OMAP_DMA_SYNC_ELEMENT,
+			dma_trigger, 0);
 	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
 		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
 		0, 0);
@@ -761,10 +740,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 	ep->dma_channel = channel;
 
 	if (is_in) {
-		if (cpu_is_omap24xx())
-			dma_channel = OMAP24XX_DMA(USB_W2FC_TX0, channel);
-		else
-			dma_channel = OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
+		dma_channel = OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
 		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
@@ -781,11 +757,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				0, 0);
 		}
 	} else {
-		if (cpu_is_omap24xx())
-			dma_channel = OMAP24XX_DMA(USB_W2FC_RX0, channel);
-		else
-			dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
-
+		dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
 		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
@@ -809,7 +781,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
 
 		/* channel type P: hw synch (fifo) */
-		if (cpu_class_is_omap1() && !cpu_is_omap15xx())
+		if (!cpu_is_omap15xx())
 			omap_set_dma_channel_mode(ep->lch, OMAP_DMA_LCH_P);
 	}
 
@@ -929,13 +901,11 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 
 	/* this isn't bogus, but OMAP DMA isn't the only hardware to
 	 * have a hard time with partial packet reads...  reject it.
-	 * Except OMAP2 can handle the small packets.
 	 */
 	if (use_dma
 			&& ep->has_dma
 			&& ep->bEndpointAddress != 0
 			&& (ep->bEndpointAddress & USB_DIR_IN) == 0
-			&& !cpu_class_is_omap2()
 			&& (req->req.length % ep->ep.maxpacket) != 0) {
 		DBG("%s, no partial packet OUT reads\n", __func__);
 		return -EMSGSIZE;
@@ -2091,10 +2061,6 @@ static inline int machine_without_vbus_sense(void)
 {
 	return (machine_is_omap_innovator()
 		|| machine_is_omap_osk()
-		|| machine_is_omap_apollon()
-#ifndef CONFIG_MACH_OMAP_H4_OTG
-		|| machine_is_omap_h4()
-#endif
 		|| machine_is_sx1()
 		|| cpu_is_omap7xx() /* No known omap7xx boards with vbus sense */
 		);
@@ -2308,12 +2274,9 @@ static int proc_otg_show(struct seq_file *s)
 	u32		trans = 0;
 	char		*ctrl_name = "(UNKNOWN)";
 
-	/* XXX This needs major revision for OMAP2+ */
 	tmp = omap_readl(OTG_REV);
-	if (cpu_class_is_omap1()) {
-		ctrl_name = "tranceiver_ctrl";
-		trans = omap_readw(USB_TRANSCEIVER_CTRL);
-	}
+	ctrl_name = "tranceiver_ctrl";
+	trans = omap_readw(USB_TRANSCEIVER_CTRL);
 	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
 		tmp >> 4, tmp & 0xf, ctrl_name, trans);
 	tmp = omap_readw(OTG_SYSCON_1);
@@ -2400,14 +2363,12 @@ static int proc_udc_show(struct seq_file *s, void *_)
 		HMC,
 		udc->transceiver
 			? udc->transceiver->label
-			: ((cpu_is_omap1710() || cpu_is_omap24xx())
+			: (cpu_is_omap1710() 
 				? "external" : "(none)"));
-	if (cpu_class_is_omap1()) {
-		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
-			omap_readw(ULPD_CLOCK_CTRL),
-			omap_readw(ULPD_SOFT_REQ),
-			omap_readw(ULPD_STATUS_REQ));
-	}
+	seq_printf(s, "ULPD control %04x req %04x status %04x\n",
+		omap_readw(ULPD_CLOCK_CTRL),
+		omap_readw(ULPD_SOFT_REQ),
+		omap_readw(ULPD_STATUS_REQ));
 
 	/* OTG controller registers */
 	if (!cpu_is_omap15xx())
@@ -2592,7 +2553,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 		 * and ignored for PIO-IN on newer chips
 		 * (for more reliable behavior)
 		 */
-		if (!use_dma || cpu_is_omap15xx() || cpu_is_omap24xx())
+		if (!use_dma || cpu_is_omap15xx())
 			dbuf = 0;
 
 		switch (maxp) {
@@ -2796,8 +2757,8 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 	struct usb_phy		*xceiv = NULL;
 	const char		*type = NULL;
 	struct omap_usb_config	*config = pdev->dev.platform_data;
-	struct clk		*dc_clk;
-	struct clk		*hhc_clk;
+	struct clk		*dc_clk = NULL;
+	struct clk		*hhc_clk = NULL;
 
 	/* NOTE:  "knows" the order of the resources! */
 	if (!request_mem_region(pdev->resource[0].start,
@@ -2817,16 +2778,6 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 		udelay(100);
 	}
 
-	if (cpu_is_omap24xx()) {
-		dc_clk = clk_get(&pdev->dev, "usb_fck");
-		hhc_clk = clk_get(&pdev->dev, "usb_l4_ick");
-		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
-		/* can't use omap_udc_enable_clock yet */
-		clk_enable(dc_clk);
-		clk_enable(hhc_clk);
-		udelay(100);
-	}
-
 	if (cpu_is_omap7xx()) {
 		dc_clk = clk_get(&pdev->dev, "usb_dc_ck");
 		hhc_clk = clk_get(&pdev->dev, "l3_ocpi_ck");
@@ -2876,14 +2827,6 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 
 		hmc = HMC_1610;
 
-		if (cpu_is_omap24xx()) {
-			/* this could be transceiverless in one of the
-			 * "we don't need to know" modes.
-			 */
-			type = "external";
-			goto known;
-		}
-
 		switch (hmc) {
 		case 0:			/* POWERUP DEFAULT == 0 */
 		case 4:
@@ -2922,7 +2865,7 @@ bad_on_1710:
 			goto cleanup0;
 		}
 	}
-known:
+
 	INFO("hmc mode %d, %s transceiver\n", hmc, type);
 
 	/* a "gadget" abstracts/virtualizes the controller */
@@ -2976,16 +2919,6 @@ known:
 		clk_disable(dc_clk);
 	}
 
-	if (cpu_is_omap24xx()) {
-		udc->dc_clk = dc_clk;
-		udc->hhc_clk = hhc_clk;
-		/* FIXME OMAP2 don't release hhc & dc clock */
-#if 0
-		clk_disable(hhc_clk);
-		clk_disable(dc_clk);
-#endif
-	}
-
 	create_proc_file();
 	status = device_add(&udc->gadget.dev);
 	if (status)
@@ -3014,7 +2947,7 @@ cleanup0:
 	if (xceiv)
 		usb_put_transceiver(xceiv);
 
-	if (cpu_is_omap16xx() || cpu_is_omap24xx() || cpu_is_omap7xx()) {
+	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
 		clk_disable(hhc_clk);
 		clk_disable(dc_clk);
 		clk_put(hhc_clk);


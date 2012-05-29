From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/6] usb: gadget: omap_udc: make checkpatch.pl happy
Date: Tue, 29 May 2012 15:15:56 +0300
Message-ID: <1338293761-9457-2-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48518 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752062Ab2E2MRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 08:17:47 -0400
Received: by lags15 with SMTP id s15so2731627lag.20
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 05:17:43 -0700 (PDT)
In-Reply-To: <1338293761-9457-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

This patch is just a cleanup patch to make
checkpatch.pl a little happier with the
omap_udc.c driver.

No functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/omap_udc.c |  201 +++++++++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 24d81dc..aa2d174 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -36,9 +36,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/prefetch.h>
+#include <linux/io.h>
 
 #include <asm/byteorder.h>
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/unaligned.h>
 #include <asm/mach-types.h>
@@ -84,14 +84,14 @@
 #ifdef	USE_ISO
 static unsigned fifo_mode = 3;
 #else
-static unsigned fifo_mode = 0;
+static unsigned fifo_mode;
 #endif
 
 /* "modprobe omap_udc fifo_mode=42", or else as a kernel
  * boot parameter "omap_udc:fifo_mode=42"
  */
-module_param (fifo_mode, uint, 0);
-MODULE_PARM_DESC (fifo_mode, "endpoint configuration");
+module_param(fifo_mode, uint, 0);
+MODULE_PARM_DESC(fifo_mode, "endpoint configuration");
 
 #ifdef	USE_DMA
 static bool use_dma = 1;
@@ -99,8 +99,8 @@ static bool use_dma = 1;
 /* "modprobe omap_udc use_dma=y", or else as a kernel
  * boot parameter "omap_udc:use_dma=y"
  */
-module_param (use_dma, bool, 0);
-MODULE_PARM_DESC (use_dma, "enable/disable DMA");
+module_param(use_dma, bool, 0);
+MODULE_PARM_DESC(use_dma, "enable/disable DMA");
 #else	/* !USE_DMA */
 
 /* save a bit of code */
@@ -108,8 +108,8 @@ MODULE_PARM_DESC (use_dma, "enable/disable DMA");
 #endif	/* !USE_DMA */
 
 
-static const char driver_name [] = "omap_udc";
-static const char driver_desc [] = DRIVER_DESC;
+static const char driver_name[] = "omap_udc";
+static const char driver_desc[] = DRIVER_DESC;
 
 /*-------------------------------------------------------------------------*/
 
@@ -247,7 +247,7 @@ static int omap_ep_disable(struct usb_ep *_ep)
 
 	spin_lock_irqsave(&ep->udc->lock, flags);
 	ep->ep.desc = NULL;
-	nuke (ep, -ESHUTDOWN);
+	nuke(ep, -ESHUTDOWN);
 	ep->ep.maxpacket = ep->maxpacket;
 	ep->has_dma = 0;
 	omap_writew(UDC_SET_HALT, UDC_CTRL);
@@ -270,7 +270,7 @@ omap_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	req = kzalloc(sizeof(*req), gfp_flags);
 	if (req) {
 		req->req.dma = DMA_ADDR_INVALID;
-		INIT_LIST_HEAD (&req->queue);
+		INIT_LIST_HEAD(&req->queue);
 	}
 	return &req->req;
 }
@@ -281,7 +281,7 @@ omap_free_request(struct usb_ep *ep, struct usb_request *_req)
 	struct omap_req	*req = container_of(_req, struct omap_req, req);
 
 	if (_req)
-		kfree (req);
+		kfree(req);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -361,10 +361,10 @@ write_packet(u8 *buf, struct omap_req *req, unsigned max)
 	return len;
 }
 
-// FIXME change r/w fifo calling convention
+/* FIXME change r/w fifo calling convention */
 
 
-// return:  0 = still running, 1 = completed, negative = errno
+/* return:  0 = still running, 1 = completed, negative = errno */
 static int write_fifo(struct omap_ep *ep, struct omap_req *req)
 {
 	u8		*buf;
@@ -426,7 +426,7 @@ read_packet(u8 *buf, struct omap_req *req, unsigned avail)
 	return len;
 }
 
-// return:  0 = still running, 1 = queue empty, negative = errno
+/* return:  0 = still running, 1 = queue empty, negative = errno */
 static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 {
 	u8		*buf;
@@ -662,7 +662,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 		}
 		omap_writew(UDC_TXN_DONE, UDC_IRQ_SRC);
 
-		if (!list_empty (&ep->queue)) {
+		if (!list_empty(&ep->queue)) {
 			req = container_of(ep->queue.next,
 					struct omap_req, queue);
 			next_in_dma(ep, req);
@@ -681,7 +681,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 		}
 		omap_writew(UDC_RXN_EOT, UDC_IRQ_SRC);
 
-		if (!list_empty (&ep->queue)) {
+		if (!list_empty(&ep->queue)) {
 			req = container_of(ep->queue.next,
 					struct omap_req, queue);
 			next_out_dma(ep, req);
@@ -954,7 +954,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 		int	is_in;
 
 		if (ep->bEndpointAddress == 0) {
-			if (!udc->ep0_pending || !list_empty (&ep->queue)) {
+			if (!udc->ep0_pending || !list_empty(&ep->queue)) {
 				spin_unlock_irqrestore(&udc->lock, flags);
 				return -EL2HLT;
 			}
@@ -981,7 +981,8 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 				 * always an IN ... even for IN transfers,
 				 * a weird case which seem to stall OMAP.
 				 */
-				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
+				omap_writew(UDC_EP_SEL | UDC_EP_DIR,
+						UDC_EP_NUM);
 				omap_writew(UDC_CLR_EP, UDC_CTRL);
 				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
@@ -993,7 +994,8 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 
 			/* non-empty DATA stage */
 			} else if (is_in) {
-				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
+				omap_writew(UDC_EP_SEL | UDC_EP_DIR,
+						UDC_EP_NUM);
 			} else {
 				if (udc->ep0_setup)
 					goto irq_wait;
@@ -1041,7 +1043,7 @@ static int omap_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry (req, &ep->queue, queue) {
+	list_for_each_entry(req, &ep->queue, queue) {
 		if (&req->req == _req)
 			break;
 	}
@@ -1148,8 +1150,8 @@ static struct usb_ep_ops omap_ep_ops = {
 	.dequeue	= omap_ep_dequeue,
 
 	.set_halt	= omap_ep_set_halt,
-	// fifo_status ... report bytes in fifo
-	// fifo_flush ... flush fifo
+	/* fifo_status ... report bytes in fifo */
+	/* fifo_flush ... flush fifo */
 };
 
 /*-------------------------------------------------------------------------*/
@@ -1379,7 +1381,7 @@ static void udc_quiesce(struct omap_udc *udc)
 
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	nuke(&udc->ep[0], -ESHUTDOWN);
-	list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list)
+	list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list)
 		nuke(ep, -ESHUTDOWN);
 }
 
@@ -1495,7 +1497,8 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 				/* read next OUT packet of request, maybe
 				 * reactiviting the fifo; stall on errors.
 				 */
-				if (!req || (stat = read_fifo(ep0, req)) < 0) {
+				stat = read_fifo(ep0, req);
+				if (!req || stat < 0) {
 					omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
 					udc->ep0_pending = 0;
 					stat = 0;
@@ -1628,7 +1631,7 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 				/* this has rude side-effects (aborts) and
 				 * can't really work if DMA-IN is active
 				 */
-				DBG("%s host set_halt, NYET \n", ep->name);
+				DBG("%s host set_halt, NYET\n", ep->name);
 				goto do_stall;
 			}
 			use_ep(ep, 0);
@@ -1719,7 +1722,7 @@ delegate:
 			 */
 			udc->ep0_setup = 1;
 			spin_unlock(&udc->lock);
-			status = udc->driver->setup (&udc->gadget, &u.r);
+			status = udc->driver->setup(&udc->gadget, &u.r);
 			spin_lock(&udc->lock);
 			udc->ep0_setup = 0;
 		}
@@ -1764,7 +1767,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
 				VDBG("connect\n");
 				if (!udc->transceiver)
 					pullup_enable(udc);
-				// if (driver->connect) call it
+				/* if (driver->connect) call it */
 			} else if (udc->gadget.speed != USB_SPEED_UNKNOWN) {
 				udc->gadget.speed = USB_SPEED_UNKNOWN;
 				if (!udc->transceiver)
@@ -1796,7 +1799,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
 	}
 	if (change & UDC_SUS) {
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN) {
-			// FIXME tell isp1301 to suspend/resume (?)
+			/* FIXME tell isp1301 to suspend/resume (?) */
 			if (devstat & UDC_SUS) {
 				VDBG("suspend\n");
 				update_otg(udc);
@@ -1999,7 +2002,7 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* handle all non-DMA ISO transfers */
-	list_for_each_entry (ep, &udc->iso, iso) {
+	list_for_each_entry(ep, &udc->iso, iso) {
 		u16		stat;
 		struct omap_req	*req;
 
@@ -2058,11 +2061,11 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
 
 static inline int machine_without_vbus_sense(void)
 {
-	return (machine_is_omap_innovator()
+	return machine_is_omap_innovator()
 		|| machine_is_omap_osk()
 		|| machine_is_sx1()
-		|| cpu_is_omap7xx() /* No known omap7xx boards with vbus sense */
-		);
+		/* No known omap7xx boards with vbus sense */
+		|| cpu_is_omap7xx();
 }
 
 static int omap_udc_start(struct usb_gadget_driver *driver,
@@ -2076,7 +2079,7 @@ static int omap_udc_start(struct usb_gadget_driver *driver,
 	if (!udc)
 		return -ENODEV;
 	if (!driver
-			// FIXME if otg, check:  driver->is_otg
+			/* FIXME if otg, check:  driver->is_otg */
 			|| driver->max_speed < USB_SPEED_FULL
 			|| !bind || !driver->setup)
 		return -EINVAL;
@@ -2088,7 +2091,7 @@ static int omap_udc_start(struct usb_gadget_driver *driver,
 	}
 
 	/* reset state */
-	list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list) {
+	list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {
 		ep->irqs = 0;
 		if (ep->bmAttributes == USB_ENDPOINT_XFER_ISOC)
 			continue;
@@ -2126,7 +2129,7 @@ static int omap_udc_start(struct usb_gadget_driver *driver,
 		if (status < 0) {
 			ERR("can't bind to transceiver\n");
 			if (driver->unbind) {
-				driver->unbind (&udc->gadget);
+				driver->unbind(&udc->gadget);
 				udc->gadget.dev.driver = NULL;
 				udc->driver = NULL;
 			}
@@ -2134,9 +2137,9 @@ static int omap_udc_start(struct usb_gadget_driver *driver,
 		}
 	} else {
 		if (can_pullup(udc))
-			pullup_enable (udc);
+			pullup_enable(udc);
 		else
-			pullup_disable (udc);
+			pullup_disable(udc);
 	}
 
 	/* boards that don't have VBUS sensing can't autogate 48MHz;
@@ -2195,7 +2198,7 @@ static int omap_udc_stop(struct usb_gadget_driver *driver)
 static const char proc_filename[] = "driver/udc";
 
 #define FOURBITS "%s%s%s%s"
-#define EIGHTBITS FOURBITS FOURBITS
+#define EIGHTBITS "%s%s%s%s%s%s%s%s"
 
 static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 {
@@ -2217,12 +2220,21 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 		"\n%s %s%s%sirqs %ld stat %04x " EIGHTBITS FOURBITS "%s\n",
 		ep->name, buf,
 		ep->double_buf ? "dbuf " : "",
-		({char *s; switch(ep->ackwait){
-		case 0: s = ""; break;
-		case 1: s = "(ackw) "; break;
-		case 2: s = "(ackw2) "; break;
-		default: s = "(?) "; break;
-		} s;}),
+		({ char *s;
+		switch (ep->ackwait) {
+		case 0:
+			s = "";
+			break;
+		case 1:
+			s = "(ackw) ";
+			break;
+		case 2:
+			s = "(ackw2) ";
+			break;
+		default:
+			s = "(?) ";
+			break;
+		} s; }),
 		ep->irqs, stat_flg,
 		(stat_flg & UDC_NO_RXPACKET) ? "no_rxpacket " : "",
 		(stat_flg & UDC_MISS_IN) ? "miss_in " : "",
@@ -2238,10 +2250,10 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 		(stat_flg & UDC_NON_ISO_FIFO_EMPTY) ? "fifo_empty " : "",
 		(stat_flg & UDC_NON_ISO_FIFO_FULL) ? "fifo_full " : "");
 
-	if (list_empty (&ep->queue))
+	if (list_empty(&ep->queue))
 		seq_printf(s, "\t(queue empty)\n");
 	else
-		list_for_each_entry (req, &ep->queue, queue) {
+		list_for_each_entry(req, &ep->queue, queue) {
 			unsigned	length = req->req.actual;
 
 			if (use_dma && buf[0]) {
@@ -2259,11 +2271,16 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 static char *trx_mode(unsigned m, int enabled)
 {
 	switch (m) {
-	case 0:		return enabled ? "*6wire" : "unused";
-	case 1:		return "4wire";
-	case 2:		return "3wire";
-	case 3:		return "6wire";
-	default:	return "unknown";
+	case 0:
+		return enabled ? "*6wire" : "unused";
+	case 1:
+		return "4wire";
+	case 2:
+		return "3wire";
+	case 3:
+		return "6wire";
+	default:
+		return "unknown";
 	}
 }
 
@@ -2295,7 +2312,7 @@ static int proc_otg_show(struct seq_file *s)
 			" b_ase_brst=%d hmc=%d\n", tmp,
 		(tmp & OTG_EN) ? " otg_en" : "",
 		(tmp & USBX_SYNCHRO) ? " synchro" : "",
-		// much more SRP stuff
+		/* much more SRP stuff */
 		(tmp & SRP_DATA) ? " srp_data" : "",
 		(tmp & SRP_VBUS) ? " srp_vbus" : "",
 		(tmp & OTG_PADEN) ? " otg_paden" : "",
@@ -2383,7 +2400,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
 		(tmp & UDC_SELF_PWR) ? " self_pwr" : "",
 		(tmp & UDC_SOFF_DIS) ? " soff_dis" : "",
 		(tmp & UDC_PULLUP_EN) ? " PULLUP" : "");
-	// syscon2 is write-only
+	/* syscon2 is write-only */
 
 	/* UDC controller registers */
 	if (!(tmp & UDC_PULLUP_EN)) {
@@ -2467,7 +2484,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
 	if (tmp & UDC_ATT) {
 		proc_ep_show(s, &udc->ep[0]);
 		if (tmp & UDC_ADD) {
-			list_for_each_entry (ep, &udc->gadget.ep_list,
+			list_for_each_entry(ep, &udc->gadget.ep_list,
 					ep.ep_list) {
 				if (ep->ep.desc)
 					proc_ep_show(s, ep);
@@ -2536,14 +2553,29 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	/* chip setup ... bit values are same for IN, OUT */
 	if (type == USB_ENDPOINT_XFER_ISOC) {
 		switch (maxp) {
-		case 8:		epn_rxtx = 0 << 12; break;
-		case 16:	epn_rxtx = 1 << 12; break;
-		case 32:	epn_rxtx = 2 << 12; break;
-		case 64:	epn_rxtx = 3 << 12; break;
-		case 128:	epn_rxtx = 4 << 12; break;
-		case 256:	epn_rxtx = 5 << 12; break;
-		case 512:	epn_rxtx = 6 << 12; break;
-		default:	BUG();
+		case 8:
+			epn_rxtx = 0 << 12;
+			break;
+		case 16:
+			epn_rxtx = 1 << 12;
+			break;
+		case 32:
+			epn_rxtx = 2 << 12;
+			break;
+		case 64:
+			epn_rxtx = 3 << 12;
+			break;
+		case 128:
+			epn_rxtx = 4 << 12;
+			break;
+		case 256:
+			epn_rxtx = 5 << 12;
+			break;
+		case 512:
+			epn_rxtx = 6 << 12;
+			break;
+		default:
+			BUG();
 		}
 		epn_rxtx |= UDC_EPN_RX_ISO;
 		dbuf = 1;
@@ -2556,11 +2588,20 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 			dbuf = 0;
 
 		switch (maxp) {
-		case 8:		epn_rxtx = 0 << 12; break;
-		case 16:	epn_rxtx = 1 << 12; break;
-		case 32:	epn_rxtx = 2 << 12; break;
-		case 64:	epn_rxtx = 3 << 12; break;
-		default:	BUG();
+		case 8:
+			epn_rxtx = 0 << 12;
+			break;
+		case 16:
+			epn_rxtx = 1 << 12;
+			break;
+		case 32:
+			epn_rxtx = 2 << 12;
+			break;
+		case 64:
+			epn_rxtx = 3 << 12;
+			break;
+		default:
+			BUG();
 		}
 		if (dbuf && addr)
 			epn_rxtx |= UDC_EPN_RX_DB;
@@ -2600,7 +2641,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	ep->ep.name = ep->name;
 	ep->ep.ops = &omap_ep_ops;
 	ep->ep.maxpacket = ep->maxpacket = maxp;
-	list_add_tail (&ep->ep.ep_list, &udc->gadget.ep_list);
+	list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 
 	return buf;
 }
@@ -2608,7 +2649,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 static void omap_udc_release(struct device *dev)
 {
 	complete(udc->done);
-	kfree (udc);
+	kfree(udc);
 	udc = NULL;
 }
 
@@ -2626,13 +2667,13 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	omap_writew(0, UDC_TXDMA_CFG);
 
 	/* UDC_PULLUP_EN gates the chip clock */
-	// OTG_SYSCON_1 |= DEV_IDLE_EN;
+	/* OTG_SYSCON_1 |= DEV_IDLE_EN; */
 
 	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
 	if (!udc)
 		return -ENOMEM;
 
-	spin_lock_init (&udc->lock);
+	spin_lock_init(&udc->lock);
 
 	udc->gadget.ops = &omap_gadget_ops;
 	udc->gadget.ep0 = &udc->ep[0].ep;
@@ -2662,13 +2703,13 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 		omap_writew(0, UDC_EP_TX(tmp));
 	}
 
-#define OMAP_BULK_EP(name,addr) \
+#define OMAP_BULK_EP(name, addr) \
 	buf = omap_ep_setup(name "-bulk", addr, \
 			USB_ENDPOINT_XFER_BULK, buf, 64, 1);
-#define OMAP_INT_EP(name,addr, maxp) \
+#define OMAP_INT_EP(name, addr, maxp) \
 	buf = omap_ep_setup(name "-int", addr, \
 			USB_ENDPOINT_XFER_INT, buf, maxp, 0);
-#define OMAP_ISO_EP(name,addr, maxp) \
+#define OMAP_ISO_EP(name, addr, maxp) \
 	buf = omap_ep_setup(name "-iso", addr, \
 			USB_ENDPOINT_XFER_ISOC, buf, maxp, 1);
 
@@ -2869,11 +2910,11 @@ bad_on_1710:
 
 	/* a "gadget" abstracts/virtualizes the controller */
 	status = omap_udc_setup(pdev, xceiv);
-	if (status) {
+	if (status)
 		goto cleanup0;
-	}
+
 	xceiv = NULL;
-	// "udc" is now valid
+	/* "udc" is now valid */
 	pullup_disable(udc);
 #if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	udc->gadget.is_otg = (config->otg != 0);
@@ -2887,7 +2928,7 @@ bad_on_1710:
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
 	status = request_irq(pdev->resource[1].start, omap_udc_irq,
-			IRQF_SAMPLE_RANDOM, driver_name, udc);
+			0, driver_name, udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[1].start, status);
@@ -2896,7 +2937,7 @@ bad_on_1710:
 
 	/* USB "non-iso" IRQ (PIO for all but ep0) */
 	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
-			IRQF_SAMPLE_RANDOM, "omap_udc pio", udc);
+			0, "omap_udc pio", udc);
 	if (status != 0) {
 		ERR("can't get irq %d, err %d\n",
 			(int) pdev->resource[2].start, status);
@@ -2939,7 +2980,7 @@ cleanup2:
 	free_irq(pdev->resource[1].start, udc);
 
 cleanup1:
-	kfree (udc);
+	kfree(udc);
 	udc = NULL;
 
 cleanup0:
-- 
1.7.10.2


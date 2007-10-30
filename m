From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] initial musb urb fixes to make it work again
Date: Tue, 30 Oct 2007 08:53:06 -0700
Message-ID: <20071030155304.GA30658@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Attached is an initial patch to make musb driver work again.
I've only done minimal testing, and still need to check at least
the urb dequeue stuff tomorrow. Anyways, in case somebody else
is also looking into this, maybe this helps a bit.

Tony

--KsGdsel6WgEHnImy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-urb-fixes.patch"

--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -43,7 +43,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/usb/ch9.h>
-#include <linux/usb_gadget.h>
+#include <linux/usb/gadget.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/musb.h>
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -274,11 +274,7 @@ __acquires(musb->lock)
 			&& usb_pipein(urb->pipe))
 		status = -EREMOTEIO;
 
-	spin_lock(&urb->lock);
 	urb->hcpriv = NULL;
-	if (urb->status == -EINPROGRESS)
-		urb->status = status;
-	spin_unlock(&urb->lock);
 
 	DBG(({ int level; switch (urb->status) {
 				case 0:
@@ -304,7 +300,7 @@ __acquires(musb->lock)
 			);
 
 	spin_unlock(&musb->lock);
-	usb_hcd_giveback_urb(musb_to_hcd(musb), urb);
+	usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
 	spin_lock(&musb->lock);
 }
 
@@ -365,6 +361,8 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 		break;
 	}
 
+	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
+
 	qh->is_ready = 0;
 	__musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
@@ -1738,15 +1736,15 @@ success:
 
 static int musb_urb_enqueue(
 	struct usb_hcd			*hcd,
-	struct usb_host_endpoint	*hep,
 	struct urb			*urb,
 	gfp_t				mem_flags)
 {
 	unsigned long			flags;
 	struct musb			*musb = hcd_to_musb(hcd);
+	struct usb_host_endpoint	*hep = urb->ep;
 	struct musb_qh			*qh = hep->hcpriv;
 	struct usb_endpoint_descriptor	*epd = &hep->desc;
-	int				status;
+	int				ret;
 	unsigned			type_reg;
 	unsigned			interval;
 
@@ -1754,6 +1752,10 @@ static int musb_urb_enqueue(
 	if (!is_host_active(musb) || !musb->is_active)
 		return -ENODEV;
 
+	ret = usb_hcd_link_urb_to_ep(hcd, urb);
+	if (ret)
+		return ret;
+
 	/* DMA mapping was already done, if needed, and this urb is on
 	 * hep->urb_list ... so there's little to do unless hep wasn't
 	 * yet scheduled onto a live qh.
@@ -1774,8 +1776,10 @@ static int musb_urb_enqueue(
 	 * for bugs in other kernel code to break this driver...
 	 */
 	qh = kzalloc(sizeof *qh, mem_flags);
-	if (!qh)
+	if (!qh) {
+		usb_hcd_unlink_urb_from_ep(hcd, urb);
 		return -ENOMEM;
+	}
 
 	qh->hep = hep;
 	qh->dev = urb->dev;
@@ -1786,7 +1790,7 @@ static int musb_urb_enqueue(
 
 	/* no high bandwidth support yet */
 	if (qh->maxpacket & ~0x7ff) {
-		status = -EMSGSIZE;
+		ret = -EMSGSIZE;
 		goto done;
 	}
 
@@ -1870,12 +1874,12 @@ static int musb_urb_enqueue(
 		 * odd, rare, error prone, but legal.
 		 */
 		kfree(qh);
-		status = 0;
+		ret = 0;
 	} else
-		status = musb_schedule(musb, qh,
+		ret = musb_schedule(musb, qh,
 				epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK);
 
-	if (status == 0) {
+	if (ret == 0) {
 		urb->hcpriv = qh;
 		/* FIXME set urb->start_frame for iso/intr, it's tested in
 		 * musb_start_urb(), but otherwise only konicawc cares ...
@@ -1884,9 +1888,11 @@ static int musb_urb_enqueue(
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 done:
-	if (status != 0)
+	if (ret != 0) {
+		usb_hcd_unlink_urb_from_ep(hcd, urb);
 		kfree(qh);
-	return status;
+	}
+	return ret;
 }
 
 
@@ -1950,14 +1956,14 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 	return status;
 }
 
-static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
+static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 {
 	struct musb		*musb = hcd_to_musb(hcd);
 	struct musb_qh		*qh;
 	struct list_head	*sched;
 	struct urb		*tmp;
 	unsigned long		flags;
-	int			status = -ENOENT;
+	int			rc;
 
 	DBG(4, "urb=%p, dev%d ep%d%s\n", urb,
 			usb_pipedevice(urb->pipe),
@@ -1965,31 +1971,12 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 			usb_pipein(urb->pipe) ? "in" : "out");
 
 	spin_lock_irqsave(&musb->lock, flags);
-
-	/* make sure the urb is still queued and not completed */
-	spin_lock(&urb->lock);
-	qh = urb->hcpriv;
-	if (qh) {
-		struct usb_host_endpoint	*hep;
-
-		hep = qh->hep;
-		list_for_each_entry(tmp, &hep->urb_list, urb_list) {
-			if (urb == tmp) {
-				status = 0;
-				break;
-			}
-		}
-	}
-	spin_unlock(&urb->lock);
-
-	/* already completed */
-	if (!qh) {
-		status = 0;
+	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (rc)
 		goto done;
-	}
 
-	/* still queued but not found on the list */
-	if (status)
+	qh = urb->hcpriv;
+	if (!qh)
 		goto done;
 
 	/* Any URB not actively programmed into endpoint hardware can be
@@ -2002,7 +1989,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 	 * OK to hold off until after some IRQ, though.
 	 */
 	if (!qh->is_ready || urb->urb_list.prev != &qh->hep->urb_list)
-		status = -EINPROGRESS;
+		rc = -EINPROGRESS;
 	else {
 		switch (qh->type) {
 		case USB_ENDPOINT_XFER_CONTROL:
@@ -2025,18 +2012,18 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 	}
 
 	/* NOTE:  qh is invalid unless !list_empty(&hep->urb_list) */
-	if (status < 0 || (sched && qh != first_qh(sched))) {
+	if (rc < 0 || (sched && qh != first_qh(sched))) {
 		int	ready = qh->is_ready;
 
-		status = 0;
+		rc = 0;
 		qh->is_ready = 0;
 		__musb_giveback(musb, urb, 0);
 		qh->is_ready = ready;
 	} else
-		status = musb_cleanup_urb(urb, qh, urb->pipe & USB_DIR_IN);
+		rc = musb_cleanup_urb(urb, qh, urb->pipe & USB_DIR_IN);
 done:
 	spin_unlock_irqrestore(&musb->lock, flags);
-	return status;
+	return rc;
 }
 
 /* disable an endpoint */
@@ -2082,10 +2069,8 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		urb = next_urb(qh);
 
 		/* make software (then hardware) stop ASAP */
-		spin_lock(&urb->lock);
-		if (urb->status == -EINPROGRESS)
+		if (!urb->unlinked)
 			urb->status = -ESHUTDOWN;
-		spin_unlock(&urb->lock);
 
 		/* cleanup */
 		musb_cleanup_urb(urb, qh, urb->pipe & USB_DIR_IN);
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -172,12 +172,12 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		DBG(3, "Using PIO for remaining %lu bytes\n", pio);
 		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
 		if (chdat->tx) {
-			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
+			dma_cache_maint(phys_to_virt((u32)chdat->dma_addr),
 					chdat->transfer_len, DMA_TO_DEVICE);
 			musb_write_fifo(hw_ep, pio, buf);
 		} else {
 			musb_read_fifo(hw_ep, pio, buf);
-			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
+			dma_cache_maint(phys_to_virt((u32)chdat->dma_addr),
 					chdat->transfer_len, DMA_FROM_DEVICE);
 		}
 		channel->actual_len += pio;
@@ -303,9 +303,9 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
 	if (chdat->tx) {
-		consistent_sync(phys_to_virt(dma_addr), len, DMA_TO_DEVICE);
+		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_TO_DEVICE);
 	} else
-		consistent_sync(phys_to_virt(dma_addr), len, DMA_FROM_DEVICE);
+		dma_cache_maint(phys_to_virt(dma_addr), len, DMA_FROM_DEVICE);
 
 	/* Use 16-bit transfer if dma_addr is not 32-bit aligned */
 	if ((dma_addr & 0x3) == 0) {


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--KsGdsel6WgEHnImy--

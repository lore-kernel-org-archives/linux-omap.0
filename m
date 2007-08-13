From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/52] musb_hdrc: Search and replace Lock with lock
Date: Mon, 13 Aug 2007 06:48:53 -0700
Message-ID: <11870130122117-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870130103320-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace Lock with lock

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/davinci.c       |    8 ++--
 drivers/usb/musb/g_ep0.c         |   26 ++++++------
 drivers/usb/musb/musb_gadget.c   |   86 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_host.c     |   20 ++++----
 drivers/usb/musb/musb_procfs.c   |    4 +-
 drivers/usb/musb/musbdefs.h      |    2 +-
 drivers/usb/musb/plat_uds.c      |   46 ++++++++++----------
 drivers/usb/musb/tusb6010.c      |   14 +++---
 drivers/usb/musb/tusb6010_omap.c |    4 +-
 drivers/usb/musb/virthub.c       |    4 +-
 10 files changed, 107 insertions(+), 107 deletions(-)

--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -210,7 +210,7 @@ static void otg_timer(unsigned long _musb)
 	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
 	DBG(7, "poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv.state) {
 	case OTG_STATE_A_WAIT_VFALL:
 		/* Wait till VBUS falls below SessionEnd (~0.2V); the 1.3 RTL
@@ -252,7 +252,7 @@ static void otg_timer(unsigned long _musb)
 	default:
 		break;
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 static irqreturn_t davinci_interrupt(int irq, void *__hci)
@@ -263,7 +263,7 @@ static irqreturn_t davinci_interrupt(int irq, void *__hci)
 	void		*__iomem tibase = musb->ctrl_base;
 	u32		tmp;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	/* NOTE: DaVinci shadows the Mentor IRQs.  Don't manage them through
 	 * the Mentor registers (except for setup), use the TI ones and EOI.
@@ -366,7 +366,7 @@ static irqreturn_t davinci_interrupt(int irq, void *__hci)
 			&& musb->xceiv.state == OTG_STATE_B_IDLE)
 		mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	/* REVISIT we sometimes get unhandled IRQs
 	 * (e.g. ep0).  not clear why...
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -45,7 +45,7 @@
 #define	next_ep0_request(musb)	next_in_request(&(musb)->endpoints[0])
 
 /*
- * Locking note:  we use only the controller lock, for simpler correctness.
+ * locking note:  we use only the controller lock, for simpler correctness.
  * It's always held with IRQs blocked.
  *
  * It protects the ep0 request queue as well as ep0_state, not just the
@@ -226,8 +226,8 @@ static inline void musb_try_b_hnp_enable(struct musb *musb)
 static int
 service_zero_data_request(struct musb *musb,
 		struct usb_ctrlrequest *pControlRequest)
-__releases(musb->Lock)
-__acquires(musb->Lock)
+__releases(musb->lock)
+__acquires(musb->lock)
 {
 	int handled = -EINVAL;
 	void __iomem *mbase = musb->mregs;
@@ -273,9 +273,9 @@ __acquires(musb->Lock)
 					break;
 
 				/* REVISIT do it directly, no locking games */
-				spin_unlock(&musb->Lock);
+				spin_unlock(&musb->lock);
 				musb_gadget_set_halt(&musb_ep->end_point, 0);
-				spin_lock(&musb->Lock);
+				spin_lock(&musb->lock);
 
 				/* select ep0 again */
 				MGC_SelectEnd(mbase, 0);
@@ -579,15 +579,15 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 static int
 forward_to_driver(struct musb *musb,
 		const struct usb_ctrlrequest *pControlRequest)
-__releases(musb->Lock)
-__acquires(musb->Lock)
+__releases(musb->lock)
+__acquires(musb->lock)
 {
 	int retval;
 	if (!musb->pGadgetDriver)
 		return -EOPNOTSUPP;
-	spin_unlock(&musb->Lock);
+	spin_unlock(&musb->lock);
 	retval = musb->pGadgetDriver->setup(&musb->g, pControlRequest);
-	spin_lock(&musb->Lock);
+	spin_lock(&musb->lock);
 	return retval;
 }
 
@@ -837,7 +837,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	req->request.status = -EINPROGRESS;
 	req->bTx = ep->is_in;
 
-	spin_lock_irqsave(&musb->Lock, lockflags);
+	spin_lock_irqsave(&musb->lock, lockflags);
 
 	if (!list_empty(&ep->req_list)) {
 		status = -EBUSY;
@@ -892,7 +892,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	}
 
 cleanup:
-	spin_unlock_irqrestore(&musb->Lock, lockflags);
+	spin_unlock_irqrestore(&musb->lock, lockflags);
 	return status;
 }
 
@@ -920,7 +920,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	base = musb->mregs;
 	regs = musb->control_ep->regs;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (!list_empty(&ep->req_list)) {
 		status = -EBUSY;
@@ -945,7 +945,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	}
 
 cleanup:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -102,8 +102,8 @@ void musb_g_giveback(
 	struct musb_ep		*ep,
 	struct usb_request	*pRequest,
 	int status)
-__releases(ep->musb->Lock)
-__acquires(ep->musb->Lock)
+__releases(ep->musb->lock)
+__acquires(ep->musb->lock)
 {
 	struct musb_request	*req;
 	struct musb		*musb;
@@ -117,7 +117,7 @@ __acquires(ep->musb->Lock)
 	musb = req->musb;
 
 	ep->busy = 1;
-	spin_unlock(&musb->Lock);
+	spin_unlock(&musb->lock);
 	if (is_dma_capable()) {
 		if (req->mapped) {
 			dma_unmap_single(musb->controller,
@@ -146,7 +146,7 @@ __acquires(ep->musb->Lock)
 				req->request.actual, req->request.length,
 				pRequest->status);
 	req->request.complete(&req->ep->end_point, &req->request);
-	spin_lock(&musb->Lock);
+	spin_lock(&musb->lock);
 	ep->busy = busy;
 }
 
@@ -871,7 +871,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	mbase = musb->mregs;
 	epnum = musb_ep->current_epnum;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (musb_ep->desc) {
 		status = -EBUSY;
@@ -988,7 +988,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	schedule_work(&musb->irq_work);
 
 fail:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
@@ -1009,7 +1009,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	epnum = musb_ep->current_epnum;
 	epio = musb->endpoints[epnum].regs;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	MGC_SelectEnd(musb->mregs, epnum);
 
 	/* zero the endpoint sizes */
@@ -1032,7 +1032,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	schedule_work(&musb->irq_work);
 
-	spin_unlock_irqrestore(&(musb->Lock), flags);
+	spin_unlock_irqrestore(&(musb->lock), flags);
 
 	DBG(2, "%s\n", musb_ep->end_point.name);
 
@@ -1148,7 +1148,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	} else
 		pRequest->mapped = 0;
 
-	spin_lock_irqsave(&musb->Lock, lockflags);
+	spin_lock_irqsave(&musb->lock, lockflags);
 
 	/* don't queue if the ep is down */
 	if (!musb_ep->desc) {
@@ -1166,7 +1166,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 		musb_ep_restart(musb, pRequest);
 
 cleanup:
-	spin_unlock_irqrestore(&musb->Lock, lockflags);
+	spin_unlock_irqrestore(&musb->lock, lockflags);
 	return status;
 }
 
@@ -1181,7 +1181,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	if (!ep || !pRequest || to_musb_request(pRequest)->ep != musb_ep)
 		return -EINVAL;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	list_for_each_entry(r, &musb_ep->req_list, list) {
 		if (r == pRequest)
@@ -1216,7 +1216,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	}
 
 done:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
@@ -1242,7 +1242,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		return -EINVAL;
 	mbase = musb->mregs;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if ((USB_ENDPOINT_XFER_ISOC == musb_ep->type)) {
 		status = -EINVAL;
@@ -1257,7 +1257,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			DBG(3, "%s fifo busy, cannot halt\n", ep->name);
-			spin_unlock_irqrestore(&musb->Lock, flags);
+			spin_unlock_irqrestore(&musb->lock, flags);
 			return -EAGAIN;
 		}
 
@@ -1299,7 +1299,7 @@ done:
 		musb_ep_restart(musb, pRequest);
 	}
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
@@ -1315,13 +1315,13 @@ static int musb_gadget_fifo_status(struct usb_ep *ep)
 		void __iomem		*mbase = musb->mregs;
 		unsigned long		flags;
 
-		spin_lock_irqsave(&musb->Lock, flags);
+		spin_lock_irqsave(&musb->lock, flags);
 
 		MGC_SelectEnd(mbase, epnum);
 		/* FIXME return zero unless RXPKTRDY is set */
 		retval = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 
-		spin_unlock_irqrestore(&musb->Lock, flags);
+		spin_unlock_irqrestore(&musb->lock, flags);
 	}
 	return retval;
 }
@@ -1338,7 +1338,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 
 	mbase = musb->mregs;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	MGC_SelectEnd(mbase, (u8) nEnd);
 
 	/* disable interrupts */
@@ -1362,7 +1362,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 
 	/* re-enable interrupt */
 	musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 static const struct usb_ep_ops musb_ep_ops = {
@@ -1395,7 +1395,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 	u8		power, devctl;
 	int		retries;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	switch (musb->xceiv.state) {
 	case OTG_STATE_B_PERIPHERAL:
@@ -1450,7 +1450,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 	power &= ~MGC_M_POWER_RESUME;
 	musb_writeb(mregs, MGC_O_HDRC_POWER, power);
 done:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
@@ -1519,12 +1519,12 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	/* NOTE: this assumes we are sensing vbus; we'd rather
 	 * not pullup unless the B-session is active.
 	 */
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (is_on != musb->softconnect) {
 		musb->softconnect = is_on;
 		musb_pullup(musb, is_on);
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
 
@@ -1701,7 +1701,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	}
 
 	DBG(3, "registering driver %s\n", driver->function);
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (musb->pGadgetDriver) {
 		DBG(1, "%s is already bound to %s\n",
@@ -1716,7 +1716,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		retval = 0;
 	}
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	if (retval == 0)
 		retval = driver->bind(&musb->g);
@@ -1729,7 +1729,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	/* start peripheral and/or OTG engines */
 	if (retval == 0) {
-		spin_lock_irqsave(&musb->Lock, flags);
+		spin_lock_irqsave(&musb->lock, flags);
 
 		/* REVISIT always use otg_set_peripheral(), handling
 		 * issues including the root hub one below ...
@@ -1747,7 +1747,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		if (!is_otg_enabled(musb))
 			musb_start(musb);
 
-		spin_unlock_irqrestore(&musb->Lock, flags);
+		spin_unlock_irqrestore(&musb->lock, flags);
 
 		if (is_otg_enabled(musb)) {
 			DBG(3, "OTG startup...\n");
@@ -1759,12 +1759,12 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 			retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
 			if (retval < 0) {
 				DBG(1, "add_hcd failed, %d\n", retval);
-				spin_lock_irqsave(&musb->Lock, flags);
+				spin_lock_irqsave(&musb->lock, flags);
 				musb->xceiv.gadget = NULL;
 				musb->xceiv.state = OTG_STATE_UNDEFINED;
 				musb->pGadgetDriver = NULL;
 				musb->g.dev.driver = NULL;
-				spin_unlock_irqrestore(&musb->Lock, flags);
+				spin_unlock_irqrestore(&musb->lock, flags);
 			}
 		}
 	}
@@ -1810,9 +1810,9 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 			}
 		}
 
-		spin_unlock(&musb->Lock);
+		spin_unlock(&musb->lock);
 		driver->disconnect (&musb->g);
-		spin_lock(&musb->Lock);
+		spin_lock(&musb->lock);
 	}
 }
 
@@ -1835,7 +1835,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	 * this needs to shut down the OTG engine.
 	 */
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 #ifdef	CONFIG_USB_MUSB_OTG
 	musb_hnp_stop(musb);
@@ -1846,9 +1846,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 		stop_activity(musb, driver);
 
 		DBG(3, "unregistering driver %s\n", driver->function);
-		spin_unlock_irqrestore(&musb->Lock, flags);
+		spin_unlock_irqrestore(&musb->lock, flags);
 		driver->unbind(&musb->g);
-		spin_lock_irqsave(&musb->Lock, flags);
+		spin_lock_irqsave(&musb->lock, flags);
 
 		musb->pGadgetDriver = NULL;
 		musb->g.dev.driver = NULL;
@@ -1857,7 +1857,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 		musb_platform_try_idle(musb, 0);
 	} else
 		retval = -EINVAL;
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	if (is_otg_enabled(musb) && retval == 0) {
 		usb_remove_hcd(musb_to_hcd(musb));
@@ -1886,9 +1886,9 @@ void musb_g_resume(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_active = 1;
 		if (musb->pGadgetDriver && musb->pGadgetDriver->resume) {
-			spin_unlock(&musb->Lock);
+			spin_unlock(&musb->lock);
 			musb->pGadgetDriver->resume(&musb->g);
-			spin_lock(&musb->Lock);
+			spin_lock(&musb->lock);
 		}
 		break;
 	default:
@@ -1913,9 +1913,9 @@ void musb_g_suspend(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_suspended = 1;
 		if (musb->pGadgetDriver && musb->pGadgetDriver->suspend) {
-			spin_unlock(&musb->Lock);
+			spin_unlock(&musb->lock);
 			musb->pGadgetDriver->suspend(&musb->g);
-			spin_lock(&musb->Lock);
+			spin_lock(&musb->lock);
 		}
 		break;
 	default:
@@ -1949,9 +1949,9 @@ void musb_g_disconnect(struct musb *musb)
 
 	musb->g.speed = USB_SPEED_UNKNOWN;
 	if (musb->pGadgetDriver && musb->pGadgetDriver->disconnect) {
-		spin_unlock(&musb->Lock);
+		spin_unlock(&musb->lock);
 		musb->pGadgetDriver->disconnect(&musb->g);
-		spin_lock(&musb->Lock);
+		spin_lock(&musb->lock);
 	}
 
 	switch (musb->xceiv.state) {
@@ -1976,8 +1976,8 @@ void musb_g_disconnect(struct musb *musb)
 }
 
 void musb_g_reset(struct musb *musb)
-__releases(musb->Lock)
-__acquires(musb->Lock)
+__releases(musb->lock)
+__acquires(musb->lock)
 {
 	void __iomem	*mbase = musb->mregs;
 	u8		devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -267,8 +267,8 @@ start:
 /* caller owns controller lock, irqs are blocked */
 static void
 __musb_giveback(struct musb *musb, struct urb *urb, int status)
-__releases(musb->Lock)
-__acquires(musb->Lock)
+__releases(musb->lock)
+__acquires(musb->lock)
 {
 	if ((urb->transfer_flags & URB_SHORT_NOT_OK)
 			&& (urb->actual_length < urb->transfer_buffer_length)
@@ -305,9 +305,9 @@ __acquires(musb->Lock)
 			urb->actual_length, urb->transfer_buffer_length
 			);
 
-	spin_unlock(&musb->Lock);
+	spin_unlock(&musb->lock);
 	usb_hcd_giveback_urb(musb_to_hcd(musb), urb);
-	spin_lock(&musb->Lock);
+	spin_lock(&musb->lock);
 }
 
 /* for bulk/interrupt endpoints only */
@@ -1868,7 +1868,7 @@ static int musb_urb_enqueue(
 	 * until we get real dma queues (with an entry for each urb/buffer),
 	 * we only have work to do in the former case.
 	 */
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (hep->hcpriv) {
 		/* some concurrent activity submitted another urb to hep...
 		 * odd, rare, error prone, but legal.
@@ -1885,7 +1885,7 @@ static int musb_urb_enqueue(
 		 * musb_start_urb(), but otherwise only konicawc cares ...
 		 */
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 done:
 	if (status != 0)
@@ -1968,7 +1968,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 			usb_pipeendpoint(urb->pipe),
 			usb_pipein(urb->pipe) ? "in" : "out");
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	/* make sure the urb is still queued and not completed */
 	spin_lock(&urb->lock);
@@ -2039,7 +2039,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 	} else
 		status = musb_cleanup_urb(urb, qh, urb->pipe & USB_DIR_IN);
 done:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
 }
 
@@ -2058,7 +2058,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 	if (!qh)
 		return;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	switch (qh->type) {
 	case USB_ENDPOINT_XFER_CONTROL:
@@ -2100,7 +2100,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 	list_for_each_entry_safe_from(urb, tmp, &hep->urb_list, urb_list)
 		musb_giveback(qh, urb, -ESHUTDOWN);
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 static int musb_h_get_frame_number(struct usb_hcd *hcd)
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -792,7 +792,7 @@ static int musb_proc_read(char *page, char **start,
 	if (count <= 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	code = dump_header_stats(musb, buffer);
 	if (code > 0) {
@@ -813,7 +813,7 @@ static int musb_proc_read(char *page, char **start,
 
 	musb_platform_try_idle(musb, 0);
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	*eof = 1;
 
 	return buffer - page;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -342,7 +342,7 @@ static inline struct usb_request *next_out_request(struct musb_hw_ep *hw_ep)
  * struct musb - Driver instance data.
  */
 struct musb {
-	spinlock_t		Lock;
+	spinlock_t		lock;
 	struct clk		*clock;
 	irqreturn_t		(*isr)(int, void *);
 	struct work_struct	irq_work;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -297,14 +297,14 @@ void musb_otg_timer_func(unsigned long data)
 	struct musb	*musb = (struct musb *)data;
 	unsigned long	flags;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (musb->xceiv.state == OTG_STATE_B_WAIT_ACON) {
 		DBG(1, "HNP: B_WAIT_ACON timeout, going back to B_PERIPHERAL\n");
 		musb_g_disconnect(musb);
 		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
 		musb->is_active = 0;
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 static DEFINE_TIMER(musb_otg_timer, musb_otg_timer_func, 0, 0);
@@ -882,14 +882,14 @@ static void musb_shutdown(struct platform_device *pdev)
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 	unsigned long	flags;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
 	if (musb->clock) {
 		clk_put(musb->clock);
 		musb->clock = NULL;
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	/* FIXME power down */
 }
@@ -1419,7 +1419,7 @@ static irqreturn_t generic_interrupt(int irq, void *__hci)
 	irqreturn_t	retval = IRQ_NONE;
 	struct musb	*musb = __hci;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	musb->int_usb = musb_readb(musb->mregs, MGC_O_HDRC_INTRUSB);
 	musb->int_tx = musb_readw(musb->mregs, MGC_O_HDRC_INTRTX);
@@ -1428,7 +1428,7 @@ static irqreturn_t generic_interrupt(int irq, void *__hci)
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	/* REVISIT we sometimes get spurious IRQs on g_ep0
 	 * not clear why...
@@ -1592,9 +1592,9 @@ musb_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	ret = sprintf(buf, "%s\n", otg_state_string(musb));
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return ret;
 }
@@ -1606,14 +1606,14 @@ musb_mode_store(struct device *dev, struct device_attribute *attr,
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (!strncmp(buf, "host", 4))
 		musb_platform_set_mode(musb, MUSB_HOST);
 	if (!strncmp(buf, "peripheral", 10))
 		musb_platform_set_mode(musb, MUSB_PERIPHERAL);
 	if (!strncmp(buf, "otg", 3))
 		musb_platform_set_mode(musb, MUSB_OTG);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return n;
 }
@@ -1627,7 +1627,7 @@ musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
 	unsigned long flags;
 	int vbus;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 #if defined(CONFIG_USB_TUSB6010) && !defined(CONFIG_USB_MUSB_OTG)
 	/* REVISIT: connect-A != connect-B ... */
 	vbus = musb_platform_get_vbus_status(musb);
@@ -1659,7 +1659,7 @@ musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
 		v2 = "disconnected";
 #endif
 	musb_platform_try_idle(musb, 0);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return sprintf(buf, "%s%s\n", v1, v2);
 }
@@ -1673,7 +1673,7 @@ musb_vbus_store(struct device *dev, struct device_attribute *attr,
 	unsigned long	flags;
 	unsigned long	val;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (sscanf(buf, "%lu", &val) < 1) {
 		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
 		return -EINVAL;
@@ -1682,7 +1682,7 @@ musb_vbus_store(struct device *dev, struct device_attribute *attr,
 	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
 		musb->is_active = 0;
 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return n;
 }
@@ -1694,9 +1694,9 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	unsigned long	flags;
 	unsigned long	val;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return sprintf(buf, "%lu\n", val);
 }
@@ -1716,10 +1716,10 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	if (srp == 1)
 		musb_g_wakeup(musb);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return n;
 }
@@ -1881,7 +1881,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (!musb)
 		return -ENOMEM;
 
-	spin_lock_init(&musb->Lock);
+	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
 	musb->set_clock = plat->set_clock;
@@ -2108,7 +2108,7 @@ static int musb_suspend(struct platform_device *pdev, pm_message_t message)
 	if (!musb->clock)
 		return 0;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (is_peripheral_active(musb)) {
 		/* FIXME force disconnect unless we know USB will wake
@@ -2124,7 +2124,7 @@ static int musb_suspend(struct platform_device *pdev, pm_message_t message)
 		musb->set_clock(musb->clock, 0);
 	else
 		clk_disable(musb->clock);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
 
@@ -2136,7 +2136,7 @@ static int musb_resume(struct platform_device *pdev)
 	if (!musb->clock)
 		return 0;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
@@ -2147,7 +2147,7 @@ static int musb_resume(struct platform_device *pdev)
 	 * unless for some reason the whole soc powered down and we're
 	 * not treating that as a whole-system restart (e.g. swsusp)
 	 */
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
 
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -394,7 +394,7 @@ static void musb_do_idle(unsigned long _musb)
 	struct musb	*musb = (void *)_musb;
 	unsigned long	flags;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	switch (musb->xceiv.state) {
 	case OTG_STATE_A_WAIT_BCON:
@@ -437,7 +437,7 @@ static void musb_do_idle(unsigned long _musb)
 		tusb_allow_idle(musb, wakeups);
 	}
 done:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 /*
@@ -771,7 +771,7 @@ static irqreturn_t tusb_interrupt(int irq, void *__hci)
 	unsigned long	flags, idle_timeout = 0;
 	u32		int_mask, int_src;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	/* Mask all interrupts to allow using both edge and level GPIO irq */
 	int_mask = musb_readl(base, TUSB_INT_MASK);
@@ -869,7 +869,7 @@ static irqreturn_t tusb_interrupt(int irq, void *__hci)
 	musb_platform_try_idle(musb, idle_timeout);
 
 	musb_writel(base, TUSB_INT_MASK, int_mask);
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -991,7 +991,7 @@ static int __init tusb_start(struct musb *musb)
 		return ret;
 	}
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (musb_readl(base, TUSB_PROD_TEST_RESET) !=
 		TUSB_PROD_TEST_RESET_VAL) {
@@ -1033,12 +1033,12 @@ static int __init tusb_start(struct musb *musb)
 	reg |= TUSB_PHY_OTG_CTRL_WRPROTECT | TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 	musb_writel(base, TUSB_PHY_OTG_CTRL, reg);
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return 0;
 
 err:
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 
 	if (musb->board_set_power)
 		musb->board_set_power(0);
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -149,7 +149,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	unsigned long		remaining, flags, pio;
 	int			ch;
 
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 
 	if (dmareq_works())
 		ch = chdat->ch;
@@ -230,7 +230,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		}
 	}
 
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
 static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -233,7 +233,7 @@ int musb_hub_control(
 	 * port features: reported, sometimes updated when host is active
 	 * no indicators
 	 */
-	spin_lock_irqsave(&musb->Lock, flags);
+	spin_lock_irqsave(&musb->lock, flags);
 	switch (typeReq) {
 	case ClearHubFeature:
 	case SetHubFeature:
@@ -411,6 +411,6 @@ error:
 		/* "protocol stall" on error */
 		retval = -EPIPE;
 	}
-	spin_unlock_irqrestore(&musb->Lock, flags);
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return retval;
 }
-- 
1.5.2.3

From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/2] ARM: OMAP: MUSB: BUG on potential deadlocks
Date: Thu, 30 Aug 2007 19:54:01 -0700
Message-ID: <20070831025811.887406517@mvista.com>
References: <20070831025359.663866890@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=musb-lock-debug.patch
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

Help track down locking bugs.

There are several places where locks are assumed to be held and are
unlocked.  BUG-out when the lock is not actually held.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/usb/musb/musb_gadget.c     |    7 +++++++
 drivers/usb/musb/musb_gadget_ep0.c |    4 ++++
 drivers/usb/musb/musb_host.c       |    1 +
 3 files changed, 12 insertions(+)

Index: dev/drivers/usb/musb/musb_gadget.c
===================================================================
--- dev.orig/drivers/usb/musb/musb_gadget.c
+++ dev/drivers/usb/musb/musb_gadget.c
@@ -118,6 +118,7 @@ __acquires(ep->musb->lock)
 	musb = req->musb;
 
 	ep->busy = 1;
+	BUG_ON(!spin_is_locked(&musb->lock));
 	spin_unlock(&musb->lock);
 	if (is_dma_capable()) {
 		if (req->mapped) {
@@ -1812,6 +1813,7 @@ stop_activity(struct musb *musb, struct 
 			}
 		}
 
+		BUG_ON(!spin_is_locked(&musb->lock));
 		spin_unlock(&musb->lock);
 		driver->disconnect (&musb->g);
 		spin_lock(&musb->lock);
@@ -1851,6 +1853,8 @@ int usb_gadget_unregister_driver(struct 
 		stop_activity(musb, driver);
 
 		DBG(3, "unregistering driver %s\n", driver->function);
+
+		BUG_ON(!spin_is_locked(&musb->lock));
 		spin_unlock_irqrestore(&musb->lock, flags);
 		driver->unbind(&musb->g);
 		spin_lock_irqsave(&musb->lock, flags);
@@ -1891,6 +1895,7 @@ void musb_g_resume(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_active = 1;
 		if (musb->gadget_driver && musb->gadget_driver->resume) {
+			BUG_ON(!spin_is_locked(&musb->lock));
 			spin_unlock(&musb->lock);
 			musb->gadget_driver->resume(&musb->g);
 			spin_lock(&musb->lock);
@@ -1918,6 +1923,7 @@ void musb_g_suspend(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_suspended = 1;
 		if (musb->gadget_driver && musb->gadget_driver->suspend) {
+			BUG_ON(!spin_is_locked(&musb->lock));
 			spin_unlock(&musb->lock);
 			musb->gadget_driver->suspend(&musb->g);
 			spin_lock(&musb->lock);
@@ -1954,6 +1960,7 @@ void musb_g_disconnect(struct musb *musb
 
 	musb->g.speed = USB_SPEED_UNKNOWN;
 	if (musb->gadget_driver && musb->gadget_driver->disconnect) {
+		BUG_ON(!spin_is_locked(&musb->lock));
 		spin_unlock(&musb->lock);
 		musb->gadget_driver->disconnect(&musb->g);
 		spin_lock(&musb->lock);
Index: dev/drivers/usb/musb/musb_gadget_ep0.c
===================================================================
--- dev.orig/drivers/usb/musb/musb_gadget_ep0.c
+++ dev/drivers/usb/musb/musb_gadget_ep0.c
@@ -273,7 +273,9 @@ __acquires(musb->lock)
 				if (!musb_ep->desc)
 					break;
 
+
 				/* REVISIT do it directly, no locking games */
+				BUG_ON(!spin_is_locked(&musb->lock));
 				spin_unlock(&musb->lock);
 				musb_gadget_set_halt(&musb_ep->end_point, 0);
 				spin_lock(&musb->lock);
@@ -586,6 +588,8 @@ __acquires(musb->lock)
 	int retval;
 	if (!musb->gadget_driver)
 		return -EOPNOTSUPP;
+
+	BUG_ON(!spin_is_locked(&musb->lock));
 	spin_unlock(&musb->lock);
 	retval = musb->gadget_driver->setup(&musb->g, ctrlrequest);
 	spin_lock(&musb->lock);
Index: dev/drivers/usb/musb/musb_host.c
===================================================================
--- dev.orig/drivers/usb/musb/musb_host.c
+++ dev/drivers/usb/musb/musb_host.c
@@ -305,6 +305,7 @@ __acquires(musb->lock)
 			urb->actual_length, urb->transfer_buffer_length
 			);
 
+	BUG_ON(!spin_is_locked(&musb->lock));
 	spin_unlock(&musb->lock);
 	usb_hcd_giveback_urb(musb_to_hcd(musb), urb);
 	spin_lock(&musb->lock);

--

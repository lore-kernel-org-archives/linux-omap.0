From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-omap] misc musb tweaks
Date: Fri, 12 Oct 2007 14:26:00 -0700
Message-ID: <200710121426.00525.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

The patch below fixes a few minor infelicities.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/musb_host.c    |    6 +++---
 drivers/usb/musb/musb_host.h    |    9 ++++-----
 drivers/usb/musb/musb_virthub.c |   14 +++++++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)

--- o26.orig/drivers/usb/musb/musb_host.c	2007-08-27 17:24:01.000000000 -0700
+++ o26/drivers/usb/musb/musb_host.c	2007-08-28 14:54:08.000000000 -0700
@@ -1513,9 +1513,9 @@ void musb_host_rx(struct musb *musb, u8 
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		/* done if urb buffer is full or short packet is recd */
-		done = ((urb->actual_length + xfer_len) >=
-				urb->transfer_buffer_length)
-			|| (dma->actual_len & (qh->maxpacket - 1));
+		done = (urb->actual_length + xfer_len >=
+				urb->transfer_buffer_length
+			|| dma->actual_len < qh->maxpacket);
 
 		/* send IN token for next packet, without AUTOREQ */
 		if (!done) {
--- o26.orig/drivers/usb/musb/musb_virthub.c	2007-08-27 17:24:01.000000000 -0700
+++ o26/drivers/usb/musb/musb_virthub.c	2007-08-28 14:54:08.000000000 -0700
@@ -202,6 +202,7 @@ void musb_root_disconnect(struct musb *m
 
 /*---------------------------------------------------------------------*/
 
+/* Caller may or may not hold musb->lock */
 int musb_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	struct musb	*musb = hcd_to_musb(hcd);
@@ -228,14 +229,17 @@ int musb_hub_control(
 	int		retval = 0;
 	unsigned long	flags;
 
-	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)))
+	spin_lock_irqsave(&musb->lock, flags);
+
+	if (unlikely(!test_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags))) {
+		spin_unlock_irqrestore(&musb->lock, flags);
 		return -ESHUTDOWN;
+	}
 
 	/* hub features:  always zero, setting is a NOP
 	 * port features: reported, sometimes updated when host is active
 	 * no indicators
 	 */
-	spin_lock_irqsave(&musb->lock, flags);
 	switch (typeReq) {
 	case ClearHubFeature:
 	case SetHubFeature:
@@ -248,7 +252,7 @@ int musb_hub_control(
 		}
 		break;
 	case ClearPortFeature:
-		if (wIndex != 1)
+		if ((wIndex & 0xff) != 1)
 			goto error;
 
 		switch (wValue) {
@@ -302,12 +306,12 @@ int musb_hub_control(
 
 		/* finish RESET signaling? */
 		if ((musb->port1_status & USB_PORT_STAT_RESET)
-				&& time_after(jiffies, musb->rh_timer))
+				&& time_after_eq(jiffies, musb->rh_timer))
 			musb_port_reset(musb, false);
 
 		/* finish RESUME signaling? */
 		if ((musb->port1_status & MUSB_PORT_STAT_RESUME)
-				&& time_after(jiffies, musb->rh_timer)) {
+				&& time_after_eq(jiffies, musb->rh_timer)) {
 			u8		power;
 
 			power = musb_readb(musb->mregs, MUSB_POWER);
--- o26.orig/drivers/usb/musb/musb_host.h	2007-08-27 17:24:01.000000000 -0700
+++ o26/drivers/usb/musb/musb_host.h	2007-08-28 14:54:08.000000000 -0700
@@ -37,13 +37,12 @@
 
 static inline struct usb_hcd *musb_to_hcd(struct musb *musb)
 {
-	return (struct usb_hcd *) (((void *)musb)
-			- offsetof(struct usb_hcd, hcd_priv));
+	return container_of((void *) musb, struct usb_hcd, hcd_priv);
 }
 
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
-	return (void *) hcd->hcd_priv;
+	return (struct musb *) (hcd->hcd_priv);
 }
 
 /* stored in "usb_host_endpoint.hcpriv" for scheduled endpoints */
@@ -77,7 +76,7 @@ static inline struct musb_qh *first_qh(s
 {
 	if (list_empty(q))
 		return NULL;
-	return container_of(q->next, struct musb_qh, ring);
+	return list_entry(q->next, struct musb_qh, ring);
 }
 
 
@@ -102,7 +101,7 @@ static inline struct urb *next_urb(struc
 	queue = &qh->hep->urb_list;
 	if (list_empty(queue))
 		return NULL;
-	return container_of(queue->next, struct urb, urb_list);
+	return list_entry(queue->next, struct urb, urb_list);
 #else
 	return NULL;
 #endif

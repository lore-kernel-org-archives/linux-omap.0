From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 16:09:06 +0530
Message-ID: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933893Ab0BZKjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 05:39:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, stern@rowland.harvard.edu, oliver@neukum.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

Current musb host driver does the giveback of completed urb first and
then start the next request. This is significantly affecting the streaming
from an USB camera wherein we observe huge delay between the two IN tokens
from musb host. This is due to the fact that UVC driver is doing decoding
and further processing in giveback context.

The patch tries to defer the giveback part to a workqueue and continues
with the start of new request in completion path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch created against latest linus's tree and all musb patches in
Greg's queue.
Patch is also updated with the comments from Alan on handling
URBs which got completed with errors.

 drivers/usb/musb/musb_core.c |   22 +++++++++
 drivers/usb/musb/musb_core.h |   18 +++++++
 drivers/usb/musb/musb_host.c |  107 ++++++++++++++++++++++++++++++++++++++----
 drivers/usb/musb/musb_host.h |    2 +
 4 files changed, 139 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0f13ded..9ce21ec 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1857,6 +1857,9 @@ static void musb_free(struct musb *musb)
 	}
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
+	if (musb->gb_queue)
+		destroy_workqueue(musb->gb_queue);
+	free_queue(musb);
 	usb_put_hcd(musb_to_hcd(musb));
 #else
 	kfree(musb);
@@ -1915,6 +1918,9 @@ bad_config:
 		return -ENOMEM;
 
 	spin_lock_init(&musb->lock);
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	spin_lock_init(&musb->qlock);
+#endif
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
 	musb->set_clock = plat->set_clock;
@@ -2078,8 +2084,24 @@ bad_config:
 			? "DMA" : "PIO",
 			musb->nIrq);
 
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	musb->gb_queue = create_singlethread_workqueue(dev_name(dev));
+	if (musb->gb_queue == NULL)
+		goto fail2;
+	/* Init giveback workqueue */
+	INIT_WORK(&musb->gb_work, musb_gb_work);
+
+	/* init queue */
+	init_queue(musb);
+	if (!musb->qhead)
+		goto fail3;
+#endif
 	return 0;
 
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+fail3:
+	destroy_workqueue(musb->gb_queue);
+#endif
 fail2:
 	musb_platform_exit(musb);
 fail:
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 17e7115..ef93c13 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -322,6 +322,16 @@ static inline struct usb_request *next_out_request(struct musb_hw_ep *hw_ep)
 #endif
 }
 
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+/*
+ * struct queue - Queue data structure
+ */
+struct queue {
+	struct urb *urb;
+	struct queue *next;
+};
+#endif
+
 /*
  * struct musb - Driver instance data.
  */
@@ -355,6 +365,11 @@ struct musb {
 	struct list_head	in_bulk;	/* of musb_qh */
 	struct list_head	out_bulk;	/* of musb_qh */
 
+	struct workqueue_struct *gb_queue;
+	struct work_struct      gb_work;
+	spinlock_t		qlock;
+	struct queue		*qhead;
+
 	struct timer_list	otg_timer;
 #endif
 
@@ -610,5 +625,8 @@ extern int musb_platform_get_vbus_status(struct musb *musb);
 
 extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+extern void musb_gb_work(struct work_struct *data);
+#endif
 
 #endif	/* __MUSB_CORE_H__ */
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3421cf9..33a4568 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -99,7 +99,56 @@
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, int is_out,
 			u8 *buf, u32 offset, u32 len);
+struct queue *create(void)
+{
+	struct queue *new;
+	new = kmalloc(sizeof(struct queue), GFP_ATOMIC);
+	if (!new)
+		return NULL;
+	new->next = NULL;
+	return new;
+}
+void push_queue(struct musb *musb, struct urb *urb)
+{
+	struct queue *new, *temp;
+
+	new = create();
+	new->urb = urb;
+
+	temp = musb->qhead;
+
+	spin_lock(&musb->qlock);
+	while (temp->next != NULL)
+		temp = temp->next;
+	temp->next = new;
+	spin_unlock(&musb->qlock);
+}
+
+struct urb *pop_queue(struct musb *musb)
+{
+	struct urb *urb;
+	struct queue *head = musb->qhead;
+	struct queue *temp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&musb->qlock, flags);
+	temp = head->next;
+	if (!temp) {
+		spin_unlock_irqrestore(&musb->qlock, flags);
+		return NULL;
+	}
+	head->next = head->next->next;
+	spin_unlock_irqrestore(&musb->qlock, flags);
+
+	urb = temp->urb;
+	kfree(temp);
+	return urb;
+}
 
+void init_queue(struct musb *musb)
+{
+	musb->qhead = create();
+}
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
  */
@@ -297,8 +346,6 @@ start:
 
 /* Context: caller owns controller lock, IRQs are blocked */
 static void musb_giveback(struct musb *musb, struct urb *urb, int status)
-__releases(musb->lock)
-__acquires(musb->lock)
 {
 	DBG(({ int level; switch (status) {
 				case 0:
@@ -323,10 +370,20 @@ __acquires(musb->lock)
 			urb->actual_length, urb->transfer_buffer_length
 			);
 
-	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
-	spin_unlock(&musb->lock);
 	usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
-	spin_lock(&musb->lock);
+}
+
+void free_queue(struct musb *musb)
+{
+	struct urb *urb;
+
+	/* giveback any urb still in queue */
+	while ((urb = pop_queue(musb)) != 0)
+		musb_giveback(musb, urb, 0);
+
+	/* free up the queue head memory */
+	kfree(musb->qhead);
+	musb->qhead = NULL;
 }
 
 /* For bulk/interrupt endpoints only */
@@ -348,6 +405,15 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
 
 	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
 }
+/* Used to complete urb giveback */
+void musb_gb_work(struct work_struct *data)
+{
+	struct musb *musb = container_of(data, struct musb, gb_work);
+	struct urb *urb;
+
+	while ((urb = pop_queue(musb)) != 0)
+		musb_giveback(musb, urb, 0);
+}
 
 /*
  * Advance this hardware endpoint's queue, completing the specified URB and
@@ -378,10 +444,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 		break;
 	}
 
-	qh->is_ready = 0;
-	musb_giveback(musb, urb, status);
-	qh->is_ready = ready;
+	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
 
+	/* If URB completed with error then giveback first */
+	if (status != 0) {
+		qh->is_ready = 0;
+		spin_unlock(&musb->lock);
+		musb_giveback(musb, urb, status);
+		spin_lock(&musb->lock);
+		qh->is_ready = ready;
+	}
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
@@ -429,6 +501,12 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
 	}
+
+	/* if URB is successfully completed then giveback in workqueue */
+	if (status == 0) {
+		push_queue(musb, urb);
+		queue_work(musb->gb_queue, &musb->gb_work);
+	}
 }
 
 static u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
@@ -2167,8 +2245,12 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 			|| musb_ep_get_qh(qh->hw_ep, is_in) != qh) {
 		int	ready = qh->is_ready;
 
+		usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
+
 		qh->is_ready = 0;
+		spin_unlock(&musb->lock);
 		musb_giveback(musb, urb, 0);
+		spin_lock(&musb->lock);
 		qh->is_ready = ready;
 
 		/* If nothing else (usually musb_giveback) is using it
@@ -2229,8 +2311,13 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		 * other transfers, and since !qh->is_ready nothing
 		 * will activate any of these as it advances.
 		 */
-		while (!list_empty(&hep->urb_list))
-			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
+		while (!list_empty(&hep->urb_list)) {
+			urb = next_urb(qh);
+			usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
+			spin_unlock(&musb->lock);
+			musb_giveback(musb, urb, -ESHUTDOWN);
+			spin_lock(&musb->lock);
+		}
 
 		hep->hcpriv = NULL;
 		list_del(&qh->ring);
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 14b0077..a1a01df 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -83,6 +83,8 @@ static inline struct musb_qh *first_qh(struct list_head *q)
 
 
 extern void musb_root_disconnect(struct musb *musb);
+extern void init_queue(struct musb *musb);
+extern void free_queue(struct musb *musb);
 
 struct usb_hcd;
 
-- 
1.6.2.4


From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 1/5] usb: musb: move port reset to worker
Date: Tue,  1 Oct 2013 15:39:53 +0200
Message-ID: <1380634797-29541-2-git-send-email-zonque@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50994 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab3JANkE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:40:04 -0400
In-Reply-To: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

musb_port_reset() sleeps, so we can't call it from atomic context. It
is, however, called from places inside musb_hub_control() while
&musb->lock is held, which leads to a "scheduling while atomic" warning.

Fix this by moving the logic into a worker, and call it where the
function was previously called directly.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_core.c    |  7 +++++++
 drivers/usb/musb/musb_core.h    |  3 +++
 drivers/usb/musb/musb_host.h    |  2 ++
 drivers/usb/musb/musb_virthub.c | 13 ++++++++-----
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 18e877f..2b9f4b4 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1699,6 +1699,12 @@ static void musb_irq_work(struct work_struct *data)
 	}
 }
 
+static void musb_port_reset_work(struct work_struct *data)
+{
+	struct musb *musb = container_of(data, struct musb, port_reset_work);
+	musb_port_reset(musb);
+}
+
 /* --------------------------------------------------------------------------
  * Init support
  */
@@ -1857,6 +1863,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	/* Init IRQ workqueue before request_irq */
 	INIT_WORK(&musb->irq_work, musb_irq_work);
+	INIT_WORK(&musb->port_reset_work, musb_port_reset_work);
 
 	/* attach to the IRQ */
 	if (request_irq(nIrq, musb->isr, 0, dev_name(dev), musb)) {
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 65f3917..9529512 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -294,6 +294,9 @@ struct musb {
 
 	irqreturn_t		(*isr)(int, void *);
 	struct work_struct	irq_work;
+	struct work_struct	port_reset_work;
+	bool			port_reset_state;
+
 	u16			hwvers;
 
 	u16			intrrxe;
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 960d735..843f48e 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -92,6 +92,7 @@ extern void musb_host_rx(struct musb *, u8);
 extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
+extern void musb_port_reset(struct musb *musb);
 #else
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
@@ -121,6 +122,7 @@ static inline void musb_root_disconnect(struct musb *musb)	{}
 static inline void musb_host_resume_root_hub(struct musb *musb)	{}
 static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
+static inline void musb_port_reset(struct musb *musb)		{}
 #endif
 
 struct usb_hcd;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index a523950..30b43a1 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -155,7 +155,7 @@ static void musb_port_suspend(struct musb *musb, bool do_suspend)
 	}
 }
 
-static void musb_port_reset(struct musb *musb, bool do_reset)
+void musb_port_reset(struct musb *musb)
 {
 	u8		power;
 	void __iomem	*mbase = musb->mregs;
@@ -173,7 +173,7 @@ static void musb_port_reset(struct musb *musb, bool do_reset)
 	 * the appropriate amount of time has passed
 	 */
 	power = musb_readb(mbase, MUSB_POWER);
-	if (do_reset) {
+	if (musb->port_reset_state) {
 
 		/*
 		 * If RESUME is set, we must make sure it stays minimum 20 ms.
@@ -356,8 +356,10 @@ int musb_hub_control(
 
 		/* finish RESET signaling? */
 		if ((musb->port1_status & USB_PORT_STAT_RESET)
-				&& time_after_eq(jiffies, musb->rh_timer))
-			musb_port_reset(musb, false);
+				&& time_after_eq(jiffies, musb->rh_timer)) {
+			musb->port_reset_state = false;
+			schedule_work(&musb->port_reset_work);
+		}
 
 		/* finish RESUME signaling? */
 		if ((musb->port1_status & MUSB_PORT_STAT_RESUME)
@@ -412,7 +414,8 @@ int musb_hub_control(
 				musb_start(musb);
 			break;
 		case USB_PORT_FEAT_RESET:
-			musb_port_reset(musb, true);
+			musb->port_reset_state = true;
+			schedule_work(&musb->port_reset_work);
 			break;
 		case USB_PORT_FEAT_SUSPEND:
 			musb_port_suspend(musb, true);
-- 
1.8.3.1


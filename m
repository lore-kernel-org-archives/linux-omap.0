From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Mon, 2 May 2016 15:18:53 +0300
Message-ID: <1462191537-10314-11-git-send-email-rogerq@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462191537-10314-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Since some host controller (e.g. EHCI) needs a companion host controller
(e.g. OHCI), this patch adds such a configuration to use it in the OTG
core.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/generic.txt |  3 +++
 drivers/usb/common/usb-otg.c                      | 32 ++++++++++++++++-------
 include/linux/usb/otg.h                           |  7 ++++-
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index f6866c1..1db1c33 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -27,6 +27,9 @@ Optional properties:
  - otg-controller: phandle to otg controller. Host or gadget controllers can
 			contain this property to link it to a particular OTG
 			controller.
+ - hcd-needs-companion: must be present if otg controller is dealing with
+			EHCI host controller that needs a companion OHCI host
+			controller.
 
 This is an attribute to a USB controller such as:
 
diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
index 702bca8..77048aa 100644
--- a/drivers/usb/common/usb-otg.c
+++ b/drivers/usb/common/usb-otg.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/gadget.h>
 #include <linux/workqueue.h>
@@ -582,6 +583,10 @@ struct usb_otg *usb_otg_register(struct device *dev,
 	else
 		INIT_WORK(&otg->work, usb_drd_work);
 
+	if (of_find_property(dev->of_node, "hcd-needs-companion", NULL) ||
+	    config->hcd_needs_companion)	/* needs companion ? */
+		otg->flags |= OTG_FLAG_HCD_NEEDS_COMPANION;
+
 	otg->wq = create_singlethread_workqueue("usb_otg");
 	if (!otg->wq) {
 		dev_err(dev, "otg: %s: can't create workqueue\n",
@@ -805,15 +810,18 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
 	/* HCD will be started by OTG fsm when needed */
 	mutex_lock(&otg->fsm.lock);
 	if (otg->primary_hcd.hcd) {
-		/* probably a shared HCD ? */
-		if (usb_otg_hcd_is_primary_hcd(hcd)) {
+		/* probably a shared HCD or a companion OHCI HCD ? */
+		if (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
+		    usb_otg_hcd_is_primary_hcd(hcd)) {
 			dev_err(otg_dev, "otg: primary host already registered\n");
 			goto err;
 		}
 
-		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
+		if (otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION ||
+		    (hcd->shared_hcd == otg->primary_hcd.hcd)) {
 			if (otg->shared_hcd.hcd) {
-				dev_err(otg_dev, "otg: shared host already registered\n");
+				dev_err(otg_dev,
+					"otg: shared/companion host already registered\n");
 				goto err;
 			}
 
@@ -821,10 +829,12 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
 			otg->shared_hcd.irqnum = irqnum;
 			otg->shared_hcd.irqflags = irqflags;
 			otg->shared_hcd.ops = ops;
-			dev_info(otg_dev, "otg: shared host %s registered\n",
+			dev_info(otg_dev,
+				 "otg: shared/companion host %s registered\n",
 				 dev_name(hcd->self.controller));
 		} else {
-			dev_err(otg_dev, "otg: invalid shared host %s\n",
+			dev_err(otg_dev,
+				"otg: invalid shared/companion host %s\n",
 				dev_name(hcd->self.controller));
 			goto err;
 		}
@@ -847,14 +857,17 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
 	 * we're ready only if we have shared HCD
 	 * or we don't need shared HCD.
 	 */
-	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
+	if (otg->shared_hcd.hcd ||
+	    (!(otg->flags & OTG_FLAG_HCD_NEEDS_COMPANION) &&
+	     !otg->primary_hcd.hcd->shared_hcd)) {
 		otg->host = hcd_to_bus(hcd);
 		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
 
 		/* start FSM */
 		usb_otg_start_fsm(otg);
 	} else {
-		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
+		dev_dbg(otg_dev,
+			"otg: can't start till shared/companion host registers\n");
 	}
 
 	mutex_unlock(&otg->fsm.lock);
@@ -905,7 +918,8 @@ int usb_otg_unregister_hcd(struct usb_hcd *hcd)
 			 dev_name(hcd_dev));
 	} else if (hcd == otg->shared_hcd.hcd) {
 		otg->shared_hcd.hcd = NULL;
-		dev_info(otg_dev, "otg: shared host %s unregistered\n",
+		dev_info(otg_dev,
+			 "otg: shared/companion host %s unregistered\n",
 			 dev_name(hcd_dev));
 	} else {
 		dev_err(otg_dev, "otg: host %s wasn't registered with otg\n",
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index b094352..6f4ca77 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -57,7 +57,8 @@ struct otg_hcd {
  * @list: list of otg controllers
  * @work: otg state machine work
  * @wq: otg state machine work queue
- * @flags: to track if host/gadget is running
+ * @flags: to track if host/gadget is running, or to indicate if hcd needs
+ *	   companion
  */
 struct usb_otg {
 	u8			default_a;
@@ -84,6 +85,7 @@ struct usb_otg {
 	u32 flags;
 #define OTG_FLAG_GADGET_RUNNING (1 << 0)
 #define OTG_FLAG_HOST_RUNNING (1 << 1)
+#define OTG_FLAG_HCD_NEEDS_COMPANION (1 << 2)
 	/* use otg->fsm.lock for serializing access */
 
 /*------------- deprecated interface -----------------------------*/
@@ -125,11 +127,14 @@ struct usb_otg_caps {
  * @caps: otg capabilities of the controller
  * @ops: otg fsm operations
  * @otg_work: optional custom otg state machine work function
+ * @hcd_needs_companion: Indicates if host controller needs a companion
+ *			 controller
  */
 struct usb_otg_config {
 	struct usb_otg_caps *otg_caps;
 	struct otg_fsm_ops *fsm_ops;
 	void (*otg_work)(struct work_struct *work);
+	bool hcd_needs_companion;
 };
 
 extern const char *usb_otg_state_string(enum usb_otg_state state);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

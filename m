From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 10/14] usb: otg: add hcd companion support
Date: Fri, 13 May 2016 13:03:24 +0300
Message-ID: <1463133808-10630-11-git-send-email-rogerq@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463133808-10630-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since some host controller (e.g. EHCI) needs a companion host controller
(e.g. OHCI), this patch adds such a configuration to use it in the OTG
core.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
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
index 64be6df..8a2a0d4 100644
--- a/drivers/usb/common/usb-otg.c
+++ b/drivers/usb/common/usb-otg.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/gadget.h>
 #include <linux/workqueue.h>
@@ -584,6 +585,10 @@ struct usb_otg *usb_otg_register(struct device *dev,
 	else
 		INIT_WORK(&otg->work, usb_drd_work);
 
+	if (of_find_property(dev->of_node, "hcd-needs-companion", NULL) ||
+	    config->hcd_needs_companion)	/* needs companion ? */
+		otg->flags |= OTG_FLAG_HCD_NEEDS_COMPANION;
+
 	otg->wq = create_freezable_workqueue("usb_otg");
 	if (!otg->wq) {
 		dev_err(dev, "otg: %s: can't create workqueue\n",
@@ -807,15 +812,18 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
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
 
@@ -823,10 +831,12 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
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
@@ -849,14 +859,17 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
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
@@ -907,7 +920,8 @@ int usb_otg_unregister_hcd(struct usb_hcd *hcd)
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

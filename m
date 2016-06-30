From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET is 'm'
Date: Thu, 30 Jun 2016 11:40:56 +0300
Message-ID: <1467276056-19357-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: stern@rowland.harvard.edu, sre@kernel.org, peter.chen@nxp.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

NOP_USB_XCEIV is used not only by gadget drivers but by
host drivers as well e.g. EHCI_OMAP.

commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm'.
But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.

Fix this undesired behaviour by moving usb_gadget_vbus_connect/disconnect()
to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
on USB_GADGET.

Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
by drivers that need it.

Fixes: 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/core.c | 60 -------------------------------------------
 drivers/usb/host/Kconfig      |  2 +-
 drivers/usb/phy/Kconfig       |  5 ++--
 include/linux/usb/gadget.h    | 44 ++++++++++++++++++++++++++-----
 4 files changed, 41 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index ff8685e..687828d 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -538,37 +538,6 @@ out:
 EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
 
 /**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- * Context: can sleep
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	if (!gadget->ops->vbus_session) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_session(gadget, 1);
-
-out:
-	trace_usb_gadget_vbus_connect(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
-
-/**
  * usb_gadget_vbus_draw - constrain controller's VBUS power usage
  * @gadget:The device whose VBUS usage is being described
  * @mA:How much current to draw, in milliAmperes.  This should be twice
@@ -601,35 +570,6 @@ out:
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
 
 /**
- * usb_gadget_vbus_disconnect - notify controller about VBUS session end
- * @gadget:the device whose VBUS supply is being described
- * Context: can sleep
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session ending.  Common responses include
- * reversing everything done in usb_gadget_vbus_connect().
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	if (!gadget->ops->vbus_session) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_session(gadget, 0);
-
-out:
-	trace_usb_gadget_vbus_disconnect(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
-
-/**
  * usb_gadget_connect - software-controlled connect to USB host
  * @gadget:the peripheral being connected
  *
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2e710a4..d8f5674 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -180,7 +180,7 @@ config USB_EHCI_MXC
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
 	depends on ARCH_OMAP
-	depends on NOP_USB_XCEIV
+	select NOP_USB_XCEIV
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index b9c409a..fe94bbc 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -45,7 +45,7 @@ config ISP1301_OMAP
 config KEYSTONE_USB_PHY
 	tristate "Keystone USB PHY Driver"
 	depends on ARCH_KEYSTONE || COMPILE_TEST
-	depends on NOP_USB_XCEIV
+	select NOP_USB_XCEIV
 	help
 	  Enable this to support Keystone USB phy. This driver provides
 	  interface to interact with USB 2.0 and USB 3.0 PHY that is part
@@ -53,7 +53,6 @@ config KEYSTONE_USB_PHY
 
 config NOP_USB_XCEIV
 	tristate "NOP USB Transceiver Driver"
-	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, NOP can't be built-in
 	select USB_PHY
 	help
 	  This driver is to be used by all the usb transceiver which are either
@@ -66,7 +65,7 @@ config AM335X_CONTROL_USB
 config AM335X_PHY_USB
 	tristate "AM335x USB PHY Driver"
 	depends on ARM || COMPILE_TEST
-	depends on NOP_USB_XCEIV
+	select NOP_USB_XCEIV
 	select USB_PHY
 	select AM335X_CONTROL_USB
 	select USB_COMMON
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 612dbdf..305d81e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -508,14 +508,50 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * usb_gadget_vbus_connect - Notify controller that VBUS is powered
+ * @gadget:The device which now has VBUS power.
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session starting.  Common responses include
+ * resuming the controller, activating the D+ (or D-) pullup to let the
+ * host detect that a USB device is attached, and starting to draw power
+ * (8mA or possibly more, especially after SET_CONFIGURATION).
+ *
+ * Returns zero on success, else negative errno.
+ */
+static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->vbus_session)
+		return -EOPNOTSUPP;
+	return gadget->ops->vbus_session(gadget, 1);
+}
+
+/**
+ * usb_gadget_vbus_disconnect - notify controller about VBUS session end
+ * @gadget:the device whose VBUS supply is being described
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session ending.  Common responses include
+ * reversing everything done in usb_gadget_vbus_connect().
+ *
+ * Returns zero on success, else negative errno.
+ */
+static inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->vbus_session)
+		return -EOPNOTSUPP;
+	return gadget->ops->vbus_session(gadget, 0);
+}
+
 #if IS_ENABLED(CONFIG_USB_GADGET)
 int usb_gadget_frame_number(struct usb_gadget *gadget);
 int usb_gadget_wakeup(struct usb_gadget *gadget);
 int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
 int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
-int usb_gadget_vbus_connect(struct usb_gadget *gadget);
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA);
-int usb_gadget_vbus_disconnect(struct usb_gadget *gadget);
 int usb_gadget_connect(struct usb_gadget *gadget);
 int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
@@ -529,12 +565,8 @@ static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
 { return 0; }
-static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{ return 0; }
 static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 { return 0; }
-static inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
-{ return 0; }
 static inline int usb_gadget_connect(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
-- 
2.7.4

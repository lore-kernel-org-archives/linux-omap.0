From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] USB: Fix OTG HNP for hub.c
Date: Tue, 29 May 2007 15:02:38 +0300
Message-ID: <1180440176127-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
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

From: Tony Lindgren <tony@atomide.com>

This patch makes makes OTG Host Negotiation Protocol (HNP)
to behave.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/core/hub.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/core/hub.c	2007-05-25 14:12:31.000000000 +0300
+++ linux-omap-2.6/drivers/usb/core/hub.c	2007-05-25 14:17:02.000000000 +0300
@@ -1252,6 +1252,81 @@
 #ifdef	CONFIG_USB_OTG
 #include "otg_whitelist.h"
 static int __usb_port_suspend(struct usb_device *, int port1);
+
+/*
+ * OTG-aware devices on OTG-capable root hubs may be able to use SRP,
+ * to wake us after we've powered off VBUS; and HNP, switching roles
+ * "host" to "peripheral".  The OTG descriptor helps figure this out.
+ */
+static int usb_new_device_offer_hnp(struct usb_device *udev)
+{
+	struct usb_bus			*bus = udev->bus;
+	unsigned			port1 = udev->portnum;
+	struct usb_otg_descriptor	*desc = 0;
+	int				err;
+
+	if (udev->bus->is_b_host || !udev->config
+			|| udev->parent != udev->bus->root_hub)
+		return 0;
+
+	/* Descriptor may appear anywhere in config */
+	err = __usb_get_extra_descriptor(udev->rawdescriptors[0],
+				le16_to_cpu(udev->config[0].desc.wTotalLength),
+				USB_DT_OTG, (void **) &desc);
+	if (err < 0)
+		return 0;
+
+	if (!(desc->bmAttributes & USB_OTG_HNP))
+		return 0;
+
+	dev_info(&udev->dev, "Dual-Role OTG device on %sHNP port\n",
+				(port1 == bus->otg_port) ? "" : "non-");
+
+	/* Tell B-device if we support HNP */
+	if (port1 == bus->otg_port)
+		bus->b_hnp_enable = 1;
+	err = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			USB_REQ_SET_FEATURE, 0,
+			bus->b_hnp_enable ? USB_DEVICE_B_HNP_ENABLE
+			: USB_DEVICE_A_ALT_HNP_SUPPORT,
+			0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	if (err < 0) {
+		/*
+		 * OTG MESSAGE: report errors here, customize to match your
+		 * product.
+		 */
+		dev_err(&udev->dev, "can't set HNP mode; %d\n", err);
+		bus->b_hnp_enable = 0;
+		return 0;
+	}
+
+	/* If B-device wants to do HNP, it will do it after we suspend */
+	if (bus->b_hnp_enable) {
+		dev_err(&udev->dev, "trying HNP, suspending bus\n");
+		err = __usb_port_suspend(udev, udev->bus->otg_port);
+		if (err < 0) {
+			dev_err(&udev->dev, "suspend for HNP failed\n");
+			return -ENODEV;
+		}
+
+		/* TB_ASE0_BRST, minimum 3.125 ms */
+		mdelay(4);
+
+		/* Failed resume means B-device took over the bus with HNP */
+		err = usb_port_resume(udev);
+		if (err < 0) {
+			dev_err(&udev->dev, "HNP success\n");
+			return -ENODEV;
+		}
+	}
+
+	/* HNP failed. Reject B-devices not in our whitelist */
+	if (!is_targeted(udev))
+		return -ENODEV;
+
+	return 0;
+}
+
 #endif
 
 /**
@@ -1305,63 +1380,8 @@
 	show_string(udev, "SerialNumber", udev->serial);
 
 #ifdef	CONFIG_USB_OTG
-	/*
-	 * OTG-aware devices on OTG-capable root hubs may be able to use SRP,
-	 * to wake us after we've powered off VBUS; and HNP, switching roles
-	 * "host" to "peripheral".  The OTG descriptor helps figure this out.
-	 */
-	if (!udev->bus->is_b_host
-			&& udev->config
-			&& udev->parent == udev->bus->root_hub) {
-		struct usb_otg_descriptor	*desc = 0;
-		struct usb_bus			*bus = udev->bus;
-
-		/* descriptor may appear anywhere in config */
-		if (__usb_get_extra_descriptor (udev->rawdescriptors[0],
-					le16_to_cpu(udev->config[0].desc.wTotalLength),
-					USB_DT_OTG, (void **) &desc) == 0) {
-			if (desc->bmAttributes & USB_OTG_HNP) {
-				unsigned		port1 = udev->portnum;
-
-				dev_info(&udev->dev,
-					"Dual-Role OTG device on %sHNP port\n",
-					(port1 == bus->otg_port)
-						? "" : "non-");
-
-				/* enable HNP before suspend, it's simpler */
-				if (port1 == bus->otg_port)
-					bus->b_hnp_enable = 1;
-				err = usb_control_msg(udev,
-					usb_sndctrlpipe(udev, 0),
-					USB_REQ_SET_FEATURE, 0,
-					bus->b_hnp_enable
-						? USB_DEVICE_B_HNP_ENABLE
-						: USB_DEVICE_A_ALT_HNP_SUPPORT,
-					0, NULL, 0, USB_CTRL_SET_TIMEOUT);
-				if (err < 0) {
-					/* OTG MESSAGE: report errors here,
-					 * customize to match your product.
-					 */
-					dev_info(&udev->dev,
-						"can't set HNP mode; %d\n",
-						err);
-					bus->b_hnp_enable = 0;
-				}
-			}
-		}
-	}
-
-	if (!is_targeted(udev)) {
-
-		/* Maybe it can talk to us, though we can't talk to it.
-		 * (Includes HNP test device.)
-		 */
-		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
-			err = __usb_port_suspend(udev, udev->bus->otg_port);
-			if (err < 0)
-				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
-		}
-		err = -ENODEV;
+	err = usb_new_device_offer_hnp(udev);
+	if (err < 0) {
 		goto fail;
 	}
 #endif

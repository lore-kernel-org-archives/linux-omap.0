From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 12/13] usb: dwc3: add dual-role support
Date: Tue, 14 Apr 2015 13:41:59 +0300
Message-ID: <1429008120-5395-13-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with the USB OTG core. Since we don't support
OTG yet we just work as a dual-role device even
if device tree says "otg".

Use extcon framework to get VBUS/ID cable events and
kick the OTG state machine.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c          | 146 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h          |   6 ++
 drivers/usb/dwc3/platform_data.h |   1 +
 3 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f0e209..3e04b96 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/usb-otg.h>
 
 #include "platform_data.h"
 #include "core.h"
@@ -504,7 +505,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		 * SOF/ITP Mode Used
 		 */
 		if ((dwc->dr_mode == USB_DR_MODE_HOST ||
-				dwc->dr_mode == USB_DR_MODE_OTG) &&
+				dwc->dr_mode == USB_DR_MODE_OTG ||
+				dwc->dr_mode == USB_DR_MODE_DRD) &&
 				(dwc->revision >= DWC3_REVISION_210A &&
 				dwc->revision <= DWC3_REVISION_250A))
 			reg |= DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SOFITPSYNC;
@@ -656,6 +658,119 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+/* --------------------- Dual-Role management ------------------------------- */
+
+static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
+{
+	int id, vbus;
+
+	/* get ID */
+	id = extcon_get_cable_state(dwc->edev, "USB-HOST");
+	/* Host means ID == 0 */
+	id = !id;
+
+	/* get VBUS */
+	vbus = extcon_get_cable_state(dwc->edev, "USB");
+	dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
+
+	dwc->fsm->id = id;
+	dwc->fsm->vbus = vbus;
+	usb_otg_sync_inputs(dwc->fsm);
+}
+
+static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
+{
+	struct device *dev = usb_otg_fsm_to_dev(fsm);
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+
+	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
+	if (on)
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+
+	return 0;
+}
+
+static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
+{
+	struct device *dev = usb_otg_fsm_to_dev(fsm);
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+
+	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
+	if (on) {
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_event_buffers_setup(dwc);
+	}
+
+	return 0;
+}
+
+static struct otg_fsm_ops dwc3_drd_ops = {
+	.start_host = dwc3_drd_start_host,
+	.start_gadget = dwc3_drd_start_gadget,
+};
+
+static int dwc3_drd_notifier(struct notifier_block *nb,
+		unsigned long event, void *ptr)
+{
+	struct dwc3 *dwc = container_of(nb, struct dwc3, otg_nb);
+
+	dwc3_drd_fsm_sync(dwc);
+
+	return NOTIFY_DONE;
+}
+
+static int dwc3_drd_init(struct dwc3 *dwc)
+{
+	int ret, id, vbus;
+
+	if (!dwc->edev) {
+		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
+		return -ENODEV;
+	}
+
+	dwc->otg_nb.notifier_call = dwc3_drd_notifier;
+	ret = extcon_register_notifier(dwc->edev, &dwc->otg_nb);
+	if (ret < 0) {
+		dev_err(dwc->dev, "Couldn't register USB cable notifier\n");
+		return -ENODEV;
+	}
+
+	/* sanity check id & vbus states */
+	id = extcon_get_cable_state(dwc->edev, "USB-HOST");
+	vbus = extcon_get_cable_state(dwc->edev, "USB");
+	if (id < 0 || vbus < 0) {
+		dev_err(dwc->dev, "Invalid USB cable state. id %d, vbus %d\n",
+			id, vbus);
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	/* register parent as OTG device with USB core */
+	dwc->fsm = usb_otg_register(dwc->dev, &dwc3_drd_ops, true);
+	if (IS_ERR(dwc->fsm)) {
+		dev_err(dwc->dev, "Failed to register with OTG core\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	dwc3_drd_fsm_sync(dwc);
+
+	return 0;
+
+fail:
+	extcon_unregister_notifier(dwc->edev, &dwc->otg_nb);
+
+	return ret;
+}
+
+static void dwc3_drd_exit(struct dwc3 *dwc)
+{
+	usb_otg_unregister(dwc->dev);
+	extcon_unregister_notifier(dwc->edev, &dwc->otg_nb);
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -679,7 +794,15 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dev_info(dev, "otg not implemented, we'll work as dual-role\n");
+		/* fall through */
+	case USB_DR_MODE_DRD:
+		ret = dwc3_drd_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize drd\n");
+			return ret;
+		}
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize host\n");
@@ -710,8 +833,10 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
+	case USB_DR_MODE_DRD:
 		dwc3_host_exit(dwc);
 		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
@@ -799,6 +924,16 @@ static int dwc3_probe(struct platform_device *pdev)
 	hird_threshold = 12;
 
 	if (node) {
+		if (of_property_read_bool(node, "extcon"))
+			dwc->edev = extcon_get_edev_by_phandle(dev, 0);
+		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
+			dwc->edev = extcon_get_edev_by_phandle(dev->parent, 0);
+
+		if (IS_ERR(dwc->edev)) {
+			dev_vdbg(dev, "couldn't get extcon device\n");
+			return -EPROBE_DEFER;
+		}
+
 		dwc->maximum_speed = of_usb_get_maximum_speed(node);
 		dwc->has_lpm_erratum = of_property_read_bool(node,
 				"snps,has-lpm-erratum");
@@ -839,6 +974,13 @@ static int dwc3_probe(struct platform_device *pdev)
 		of_property_read_u8(node, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
 	} else if (pdata) {
+		if (pdata->extcon) {
+			dwc->edev = extcon_get_extcon_dev(pdata->extcon);
+			if (!dwc->edev) {
+				dev_vdbg(dev, "couldn't get extcon device\n");
+				return -EPROBE_DEFER;
+			}
+		}
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
 		if (pdata->lpm_nyet_threshold)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d201910..2ece013 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -30,8 +30,10 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/otg-fsm.h>
 
 #include <linux/phy/phy.h>
+#include <linux/extcon.h>
 
 #define DWC3_MSG_MAX	500
 
@@ -738,6 +740,10 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	struct extcon_dev	*edev;	/* USB cable events ID & VBUS */
+	struct notifier_block	otg_nb;	/* notifier for USB cable events */
+	struct otg_fsm		*fsm;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a3a3b6d5..9552601 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -24,6 +24,7 @@ struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
 	bool tx_fifo_resize;
+	const char *extcon;	/* extcon name for USB cable events ID/VBUS */
 
 	unsigned is_utmi_l1_suspend:1;
 	u8 hird_threshold;
-- 
2.1.0

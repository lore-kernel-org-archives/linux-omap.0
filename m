From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 7/9] usb: dwc3: adapt to OTG core
Date: Wed, 18 Mar 2015 15:56:01 +0200
Message-ID: <1426686963-11613-8-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with the USB OTG core.

Use extcon framework to get VBUS/ID cable events and
kick the OTG state machine.

TODO:
- OTG driver ops to configure dwc3 otg core during role switches.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c          | 101 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h          |   6 +++
 drivers/usb/dwc3/platform_data.h |   1 +
 3 files changed, 108 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f0e209..9d8c306 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/usb-otg.h>
 
 #include "platform_data.h"
 #include "core.h"
@@ -656,6 +657,82 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_sync_cable_state_to_otg(struct dwc3 *dwc)
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
+	dwc->fsm->a_vbus_vld = vbus;
+	/* simulate b_sess_vld */
+	dwc->fsm->b_sess_vld = id && vbus;
+	usb_otg_sync_inputs(dwc->fsm);
+}
+
+static int dwc3_otg_notifier(struct notifier_block *nb,
+		unsigned long event, void *ptr)
+{
+	struct dwc3 *dwc = container_of(nb, struct dwc3, otg_nb);
+
+	dwc3_sync_cable_state_to_otg(dwc);
+
+	return NOTIFY_DONE;
+}
+
+static struct otg_fsm_ops dwc3_otg_ops; /* FIXME. need real stuff */
+
+static int dwc3_otg_init(struct dwc3 *dwc)
+{
+	int ret, id, vbus;
+
+	if (!dwc->edev) {
+		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
+		return -ENODEV;
+	}
+
+	dwc->otg_nb.notifier_call = dwc3_otg_notifier;
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
+	dwc->fsm = usb_otg_register(dwc->dev, &dwc3_otg_ops);
+	if (IS_ERR(dwc->fsm)) {
+		dev_err(dwc->dev, "Failed to register with OTG core\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	dwc3_sync_cable_state_to_otg(dwc);
+
+	return 0;
+
+fail:
+	extcon_unregister_notifier(dwc->edev, &dwc->otg_nb);
+
+	return ret;
+}
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -680,6 +757,12 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		break;
 	case USB_DR_MODE_OTG:
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		ret = dwc3_otg_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize OTG\n");
+			return ret;
+		}
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize host\n");
@@ -712,6 +795,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_OTG:
 		dwc3_host_exit(dwc);
 		dwc3_gadget_exit(dwc);
+		usb_otg_unregister(dwc->dev);
 		break;
 	default:
 		/* do nothing */
@@ -799,6 +883,16 @@ static int dwc3_probe(struct platform_device *pdev)
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
@@ -839,6 +933,13 @@ static int dwc3_probe(struct platform_device *pdev)
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

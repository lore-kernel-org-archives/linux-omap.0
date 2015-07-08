From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/9] usb: dwc3: add dual-role support
Date: Wed, 8 Jul 2015 13:31:56 +0300
Message-ID: <1436351524-28385-2-git-send-email-rogerq@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with the USB OTG core. Since we don't support
OTG yet we just work as a dual-role device even
if device tree says "otg".

Use extcon framework to get VBUS/ID cable events and
kick the OTG state machine.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c          | 155 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h          |   6 ++
 drivers/usb/dwc3/platform_data.h |   1 +
 3 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ff5773c..a7498e0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -706,6 +706,133 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
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
+	ret = extcon_register_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
+	if (ret < 0) {
+		dev_err(dwc->dev, "Couldn't register USB cable notifier\n");
+		return -ENODEV;
+	}
+
+	ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
+				       &dwc->otg_nb);
+	if (ret < 0) {
+		dev_err(dwc->dev, "Couldn't register USB-HOST cable notifier\n");
+		ret = -ENODEV;
+		goto extcon_fail;
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
+	/* register parent as DRD device with OTG core */
+	dwc->fsm = usb_otg_register(dwc->dev, &dwc3_drd_ops, true);
+	if (IS_ERR(dwc->fsm)) {
+		ret = PTR_ERR(dwc->fsm);
+		if (ret == -ENOSYS)
+			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
+		else
+			dev_err(dwc->dev, "Failed to register with OTG core\n");
+
+		goto fail;
+	}
+
+	dwc3_drd_fsm_sync(dwc);
+
+	return 0;
+fail:
+	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
+extcon_fail:
+	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
+
+	return ret;
+}
+
+static void dwc3_drd_exit(struct dwc3 *dwc)
+{
+	usb_otg_unregister(dwc->dev);
+	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
+	extcon_unregister_notifier(dwc->edev, EXTCON_USB,&dwc->otg_nb);
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -729,13 +856,21 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		ret = dwc3_drd_init(dwc);
+		if (ret) {
+			dev_err(dev, "limiting to peripheral only\n");
+			dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+			goto gadget_init;
+		}
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 
+gadget_init:
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize gadget\n");
@@ -762,6 +897,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_OTG:
 		dwc3_host_exit(dwc);
 		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
@@ -845,6 +981,16 @@ static int dwc3_probe(struct platform_device *pdev)
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
@@ -889,6 +1035,13 @@ static int dwc3_probe(struct platform_device *pdev)
 		of_property_read_string(node, "snps,hsphy_interface",
 					&dwc->hsphy_interface);
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
index 0447788..d0fda04 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -31,8 +31,10 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/ulpi/interface.h>
+#include <linux/usb/otg-fsm.h>
 
 #include <linux/phy/phy.h>
+#include <linux/extcon.h>
 
 #define DWC3_MSG_MAX	500
 
@@ -753,6 +755,10 @@ struct dwc3 {
 
 	struct ulpi		*ulpi;
 
+	struct extcon_dev	*edev;	/* USB cable events ID & VBUS */
+	struct notifier_block	otg_nb;	/* notifier for USB cable events */
+	struct otg_fsm		*fsm;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index d3614ec..b3b245c 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -47,4 +47,5 @@ struct dwc3_platform_data {
 	unsigned tx_de_emphasis:2;
 
 	const char *hsphy_interface;
+	const char *extcon;	/* extcon name for USB cable events ID/VBUS */
 };
-- 
2.1.4

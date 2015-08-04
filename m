From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] usb: musb: omap2430: use *syscon* framework API to write to mailbox register
Date: Tue, 4 Aug 2015 19:36:09 +0530
Message-ID: <1438697169-32359-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
Cc: gregkh@linuxfoundation.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Deprecate using phy-omap-control driver to write to the mailbox register
and start using *syscon* framework to do the same.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |    7 +-
 drivers/usb/musb/omap2430.c                        |  115 ++++++++++++++++----
 2 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index 38d9bb8..c001306 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -20,10 +20,15 @@ OMAP MUSB GLUE
  - phy-names : the names of the PHY corresponding to the PHYs present in the
    *phy* phandle.
 
-Optional properties:
+Optional Properties:
+Deprecated properties:
  - ctrl-module : phandle of the control module this glue uses to write to
    mailbox
 
+Recommended properies:
+ - syscon-otghs : phandle/offset pair. Phandle to the system control module and the
+   register offset of the mailbox.
+
 SOC specific device node entry
 usb_otg_hs: usb_otg_hs@4a0ab000 {
 	compatible = "ti,omap4-musb";
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 70f2b8a..a03cf1e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -39,16 +39,27 @@
 #include <linux/usb/musb-omap.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
 
+#define OMAP2430_MUSB_MODE_MASK	0x1f
+#define OMAP2430_MUSB_AVALID	BIT(0)
+#define OMAP2430_MUSB_BVALID	BIT(1)
+#define OMAP2430_MUSB_VBUSVALID	BIT(2)
+#define OMAP2430_MUSB_SESSEND	BIT(3)
+#define OMAP2430_MUSB_IDDIG	BIT(4)
+
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
 	enum omap_musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
+	struct regmap		*syscon_otghs; /* ctrl. reg. acces */
+	unsigned int            otghs_reg; /* otghs reg. index within syscon */
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -253,6 +264,44 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 }
 EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
+static void omap2430_musb_set_usbmode(struct omap2430_glue *glue,
+				      enum omap_control_usb_mode mode)
+{
+	u32 val;
+	int ret;
+
+	if (glue->syscon_otghs) {
+		switch (mode) {
+		case USB_MODE_HOST:
+			val = OMAP2430_MUSB_AVALID | OMAP2430_MUSB_VBUSVALID;
+			break;
+		case USB_MODE_DEVICE:
+			val = OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_AVALID |
+				OMAP2430_MUSB_VBUSVALID;
+			break;
+		case USB_MODE_DISCONNECT:
+			val = OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_SESSEND;
+			break;
+		default:
+			dev_dbg(glue->dev, "Invalid mode\n");
+			goto err_regmap_update;
+		}
+
+		ret = regmap_update_bits(glue->syscon_otghs,
+					 glue->otghs_reg,
+					 OMAP2430_MUSB_MODE_MASK, val);
+		if (ret < 0)
+			goto err_regmap_update;
+	} else {
+		omap_control_usb_set_mode(glue->control_otghs, mode);
+	}
+
+	return;
+
+err_regmap_update:
+	dev_err(glue->dev, "Failed to set mode to %d\n", mode);
+}
+
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
 	struct musb *musb = glue_to_musb(glue);
@@ -270,8 +319,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		musb->xceiv->last_event = USB_EVENT_ID;
 		if (musb->gadget_driver) {
 			pm_runtime_get_sync(dev);
-			omap_control_usb_set_mode(glue->control_otghs,
-				USB_MODE_HOST);
+			omap2430_musb_set_usbmode(glue, USB_MODE_HOST);
 			omap2430_musb_set_vbus(musb, 1);
 		}
 		break;
@@ -284,7 +332,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		musb->xceiv->last_event = USB_EVENT_VBUS;
 		if (musb->gadget_driver)
 			pm_runtime_get_sync(dev);
-		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
+		omap2430_musb_set_usbmode(glue, USB_MODE_DEVICE);
 		break;
 
 	case OMAP_MUSB_ID_FLOAT:
@@ -301,8 +349,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		if (data->interface_type == MUSB_INTERFACE_UTMI)
 			otg_set_vbus(musb->xceiv->otg, 0);
 
-		omap_control_usb_set_mode(glue->control_otghs,
-			USB_MODE_DISCONNECT);
+		omap2430_musb_set_usbmode(glue, USB_MODE_DISCONNECT);
 		break;
 	default:
 		dev_dbg(dev, "ID float\n");
@@ -444,7 +491,7 @@ static void omap2430_musb_enable(struct musb *musb)
 	switch (glue->status) {
 
 	case OMAP_MUSB_ID_GROUND:
-		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_HOST);
+		omap2430_musb_set_usbmode(glue, USB_MODE_HOST);
 		if (data->interface_type != MUSB_INTERFACE_UTMI)
 			break;
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
@@ -463,7 +510,7 @@ static void omap2430_musb_enable(struct musb *musb)
 		break;
 
 	case OMAP_MUSB_VBUS_VALID:
-		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
+		omap2430_musb_set_usbmode(glue, USB_MODE_DEVICE);
 		break;
 
 	default:
@@ -477,8 +524,7 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
 	if (glue->status != OMAP_MUSB_UNKNOWN)
-		omap_control_usb_set_mode(glue->control_otghs,
-			USB_MODE_DISCONNECT);
+		omap2430_musb_set_usbmode(glue, USB_MODE_DISCONNECT);
 }
 
 static int omap2430_musb_exit(struct musb *musb)
@@ -512,6 +558,40 @@ static const struct musb_platform_ops omap2430_ops = {
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
 
+static int omap2430_get_sys_ctrl(struct omap2430_glue *glue,
+				 struct device_node *np)
+{
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
+	glue->syscon_otghs = syscon_regmap_lookup_by_phandle(np,
+							     "syscon-otghs");
+	if (IS_ERR(glue->syscon_otghs)) {
+		dev_dbg(glue->dev, "can't get syscon, using control device\n");
+		glue->syscon_otghs = NULL;
+
+		control_node = of_parse_phandle(np, "ctrl-module", 0);
+		if (control_node) {
+			control_pdev = of_find_device_by_node(control_node);
+			if (!control_pdev) {
+				dev_err(glue->dev,
+					"Failed to get control device\n");
+				return -EINVAL;
+			}
+			glue->control_otghs = &control_pdev->dev;
+		}
+	} else {
+		if (of_property_read_u32_index(np, "syscon-otghs", 1,
+					       &glue->otghs_reg)) {
+			dev_err(glue->dev,
+				"couldn't get otghs reg. offset\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int omap2430_probe(struct platform_device *pdev)
 {
 	struct resource			musb_resources[3];
@@ -543,9 +623,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	glue->control_otghs = ERR_PTR(-ENODEV);
 
 	if (np) {
-		struct device_node *control_node;
-		struct platform_device *control_pdev;
-
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 		if (!pdata)
 			goto err2;
@@ -572,16 +649,10 @@ static int omap2430_probe(struct platform_device *pdev)
 		pdata->board_data	= data;
 		pdata->config		= config;
 
-		control_node = of_parse_phandle(np, "ctrl-module", 0);
-		if (control_node) {
-			control_pdev = of_find_device_by_node(control_node);
-			if (!control_pdev) {
-				dev_err(&pdev->dev, "Failed to get control device\n");
-				ret = -EINVAL;
-				goto err2;
-			}
-			glue->control_otghs = &control_pdev->dev;
-		}
+		ret = omap2430_get_sys_ctrl(glue, np);
+		if (ret)
+			goto err2;
+
 	}
 	pdata->platform_ops		= &omap2430_ops;
 
-- 
1.7.9.5

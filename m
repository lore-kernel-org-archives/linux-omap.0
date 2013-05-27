From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] usb: dwc3: use extcon fwrk to receive connect/disconnect
 notification
Date: Mon, 27 May 2013 19:05:40 +0530
Message-ID: <1369661740-15966-1-git-send-email-kishon@ti.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369405896-30246-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Modified dwc3-omap to receive connect and disconnect notification using
extcon framework. Also did the necessary cleanups required after
adapting to extcon framework.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Changes from v1:
* regulator enable/disable is now done here instead of palmas-usb as some users
of palmas-usb wont need regulator.
 drivers/usb/dwc3/dwc3-omap.c  | 103 ++++++++++++++++++++++++++++++++++--------
 include/linux/usb/dwc3-omap.h |  30 ------------
 2 files changed, 85 insertions(+), 48 deletions(-)
 delete mode 100644 include/linux/usb/dwc3-omap.h

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 34638b9..158f903 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -43,13 +43,14 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dwc3-omap.h>
-#include <linux/usb/dwc3-omap.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/extcon.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/usb/otg.h>
 
@@ -124,9 +125,21 @@ struct dwc3_omap {
 	u32			utmi_otg_status;
 
 	u32			dma_status:1;
+
+	struct extcon_specific_cable_nb extcon_vbus_dev;
+	struct extcon_specific_cable_nb extcon_id_dev;
+	struct notifier_block	vbus_nb;
+	struct notifier_block	id_nb;
+
+	struct regulator	*vbus_reg;
 };
 
-static struct dwc3_omap		*_omap;
+enum omap_dwc3_vbus_id_status {
+	OMAP_DWC3_ID_FLOAT,
+	OMAP_DWC3_ID_GROUND,
+	OMAP_DWC3_VBUS_OFF,
+	OMAP_DWC3_VBUS_VALID,
+};
 
 static inline u32 dwc3_omap_readl(void __iomem *base, u32 offset)
 {
@@ -138,18 +151,21 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
 	writel(value, base + offset);
 }
 
-int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
+static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
+	enum omap_dwc3_vbus_id_status status)
 {
-	u32			val;
-	struct dwc3_omap	*omap = _omap;
-
-	if (!omap)
-		return -EPROBE_DEFER;
+	int	ret;
+	u32	val;
 
 	switch (status) {
 	case OMAP_DWC3_ID_GROUND:
 		dev_dbg(omap->dev, "ID GND\n");
 
+		ret = regulator_enable(omap->vbus_reg);
+		if (ret) {
+			dev_dbg(omap->dev, "regulator enable failed\n");
+			return;
+		}
 		val = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 		val &= ~(USBOTGSS_UTMI_OTG_STATUS_IDDIG
 				| USBOTGSS_UTMI_OTG_STATUS_VBUSVALID
@@ -162,6 +178,11 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
 	case OMAP_DWC3_VBUS_VALID:
 		dev_dbg(omap->dev, "VBUS Connect\n");
 
+		ret = regulator_enable(omap->vbus_reg);
+		if (ret) {
+			dev_dbg(omap->dev, "regulator enable failed\n");
+			return;
+		}
 		val = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 		val &= ~USBOTGSS_UTMI_OTG_STATUS_SESSEND;
 		val |= USBOTGSS_UTMI_OTG_STATUS_IDDIG
@@ -182,15 +203,13 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
 		val |= USBOTGSS_UTMI_OTG_STATUS_SESSEND
 				| USBOTGSS_UTMI_OTG_STATUS_IDDIG;
 		dwc3_omap_writel(omap->base, USBOTGSS_UTMI_OTG_STATUS, val);
+		regulator_disable(omap->vbus_reg);
 		break;
 
 	default:
-		dev_dbg(omap->dev, "ID float\n");
+		dev_dbg(omap->dev, "invalid state\n");
 	}
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(dwc3_omap_mailbox);
 
 static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 {
@@ -282,6 +301,32 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
 
 static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
 
+static int dwc3_omap_id_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, id_nb);
+
+	if (event)
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
+	else
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_FLOAT);
+
+	return NOTIFY_DONE;
+}
+
+static int dwc3_omap_vbus_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, vbus_nb);
+
+	if (event)
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
+	else
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_OFF);
+
+	return NOTIFY_DONE;
+}
+
 static int dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
@@ -289,6 +334,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	struct dwc3_omap	*omap;
 	struct resource		*res;
 	struct device		*dev = &pdev->dev;
+	struct extcon_dev	*edev;
+	struct regulator	*vbus_reg;
 
 	int			ret = -ENOMEM;
 	int			irq;
@@ -330,19 +377,32 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	edev = extcon_get_extcon_dev("palmas-usb");
+	if (!edev) {
+		dev_dbg(dev, "couldn't get extcon device\n");
+		return -EPROBE_DEFER;
+	}
+
+	vbus_reg = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(vbus_reg)) {
+		dev_err(dev, "vbus init failed\n");
+		return PTR_ERR(vbus_reg);
+	}
+
 	spin_lock_init(&omap->lock);
 
 	omap->dev	= dev;
 	omap->irq	= irq;
 	omap->base	= base;
+	omap->vbus_reg	= vbus_reg;
+	omap->vbus_nb.notifier_call = dwc3_omap_vbus_notifier;
+	extcon_register_interest(&omap->extcon_vbus_dev, "palmas-usb", "USB",
+		&omap->vbus_nb);
+	omap->id_nb.notifier_call = dwc3_omap_id_notifier;
+	extcon_register_interest(&omap->extcon_id_dev, "palmas-usb", "USB-HOST",
+		&omap->id_nb);
 	dev->dma_mask	= &dwc3_omap_dma_mask;
 
-	/*
-	 * REVISIT if we ever have two instances of the wrapper, we will be
-	 * in big trouble
-	 */
-	_omap	= omap;
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -387,6 +447,11 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (extcon_get_cable_state(edev, "USB") == true)
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
+	if (extcon_get_cable_state(edev, "USB-HOST") == true)
+		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
+
 	return 0;
 }
 
@@ -394,6 +459,8 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 {
 	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
 
+	extcon_unregister_interest(&omap->extcon_vbus_dev);
+	extcon_unregister_interest(&omap->extcon_id_dev);
 	dwc3_omap_disable_irqs(omap);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/include/linux/usb/dwc3-omap.h b/include/linux/usb/dwc3-omap.h
deleted file mode 100644
index 5615f4d..0000000
--- a/include/linux/usb/dwc3-omap.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2013 by Texas Instruments
- *
- * The Inventra Controller Driver for Linux is free software; you
- * can redistribute it and/or modify it under the terms of the GNU
- * General Public License version 2 as published by the Free Software
- * Foundation.
- */
-
-#ifndef __DWC3_OMAP_H__
-#define __DWC3_OMAP_H__
-
-enum omap_dwc3_vbus_id_status {
-	OMAP_DWC3_UNKNOWN = 0,
-	OMAP_DWC3_ID_GROUND,
-	OMAP_DWC3_ID_FLOAT,
-	OMAP_DWC3_VBUS_VALID,
-	OMAP_DWC3_VBUS_OFF,
-};
-
-#if (defined(CONFIG_USB_DWC3) || defined(CONFIG_USB_DWC3_MODULE))
-extern int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status);
-#else
-static inline int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
-{
-	return -ENODEV;
-}
-#endif
-
-#endif	/* __DWC3_OMAP_H__ */
-- 
1.8.1.2

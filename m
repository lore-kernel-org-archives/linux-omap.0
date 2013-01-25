From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 1/8] usb: otg: palmas-usb: make palmas-usb as a comparator driver
Date: Fri, 25 Jan 2013 08:42:24 +0530
Message-ID: <1359083551-8524-2-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359083551-8524-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

palmas-usb is made as a comparator driver to omap usb2 phy, so that
omap usb can make use of palmas for srp and also to set vbus.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/palmas-usb.c |   20 ++++++++++++++++++--
 include/linux/mfd/palmas.h   |    3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index 8389ad6..76240ef 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -31,6 +31,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/phy_companion.h>
+#include <linux/usb/omap_usb.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/notifier.h>
@@ -208,16 +210,20 @@ static void palmas_set_vbus_work(struct work_struct *data)
 		regulator_disable(palmas_usb->vbus_reg);
 }
 
-static int palmas_set_vbus(struct palmas_usb *palmas_usb, bool enabled)
+static int palmas_set_vbus(struct phy_companion *comparator, bool enabled)
 {
+	struct palmas_usb *palmas_usb = comparator_to_palmas(comparator);
+
 	palmas_usb->vbus_enable = enabled;
 	schedule_work(&palmas_usb->set_vbus_work);
 
 	return 0;
 }
 
-static int palmas_start_srp(struct palmas_usb *palmas_usb)
+static int palmas_start_srp(struct phy_companion *comparator)
 {
+	struct palmas_usb *palmas_usb = comparator_to_palmas(comparator);
+
 	palmas_usb_write(palmas_usb->palmas, PALMAS_USB_VBUS_CTRL_SET,
 			PALMAS_USB_VBUS_CTRL_SET_VBUS_DISCHRG |
 			PALMAS_USB_VBUS_CTRL_SET_VBUS_IADP_SINK);
@@ -253,6 +259,7 @@ static void palmas_dt_to_pdata(struct device_node *node,
 
 static int palmas_usb_probe(struct platform_device *pdev)
 {
+	u32 ret;
 	struct palmas *palmas = dev_get_drvdata(pdev->dev.parent);
 	struct palmas_usb_platform_data	*pdata = pdev->dev.platform_data;
 	struct device_node *node = pdev->dev.of_node;
@@ -289,6 +296,15 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	palmas_usb->irq4 = regmap_irq_get_virq(palmas->irq_data,
 						PALMAS_VBUS_IRQ);
 
+	palmas_usb->comparator.set_vbus	= palmas_set_vbus;
+	palmas_usb->comparator.start_srp = palmas_start_srp;
+
+	ret = omap_usb2_set_comparator(&palmas_usb->comparator);
+	if (ret == -ENODEV) {
+		dev_info(&pdev->dev, "phy not ready, deferring probe");
+		return -EPROBE_DEFER;
+	}
+
 	palmas_usb_wakeup(palmas, pdata->wakeup);
 
 	/* init spinlock for workqueue */
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 82932db..a557db6 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -19,6 +19,7 @@
 #include <linux/leds.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
+#include <linux/usb/phy_companion.h>
 
 #define PALMAS_NUM_CLIENTS		3
 
@@ -343,6 +344,8 @@ struct palmas_usb {
 	struct palmas *palmas;
 	struct device *dev;
 
+	struct phy_companion comparator;
+
 	/* for vbus reporting with irqs disabled */
 	spinlock_t lock;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

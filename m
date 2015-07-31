From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/2] extcon: palmas: Support GPIO based USB ID detection
Date: Fri, 31 Jul 2015 14:08:32 +0300
Message-ID: <55BB5730.8030600@ti.com>
References: <1438002617-15152-1-git-send-email-rogerq@ti.com> <1438002617-15152-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438002617-15152-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Some palmas based chip variants do not have OTG based ID logic.
For these variants we rely on GPIO based USB ID detection.

These chips do have VBUS comparator for VBUS detection so we
continue to use the old way of detecting VBUS.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---

v3:
-rebased on extcon-next. 
-don't use deperecated name based extcon_set_cable_state()

 .../devicetree/bindings/extcon/extcon-palmas.txt   |   5 +-
 drivers/extcon/extcon-palmas.c                     | 115 ++++++++++++++++++---
 include/linux/mfd/palmas.h                         |   6 ++
 3 files changed, 110 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
index 45414bb..f61d5af 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
@@ -10,8 +10,11 @@ Required Properties:
 
 Optional Properties:
  - ti,wakeup : To enable the wakeup comparator in probe
- - ti,enable-id-detection: Perform ID detection.
+ - ti,enable-id-detection: Perform ID detection. If id-gpio is specified
+		it performs id-detection using GPIO else using OTG core.
  - ti,enable-vbus-detection: Perform VBUS detection.
+ - id-gpio: gpio for GPIO ID detection. See gpio binding.
+ - debounce-delay-ms: debounce delay for GPIO ID pin in milliseconds.
 
 palmas-usb {
        compatible = "ti,twl6035-usb", "ti,palmas-usb";
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 8933e7e..b948984 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -28,6 +28,9 @@
 #include <linux/mfd/palmas.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+
+#define USB_GPIO_DEBOUNCE_MS	20	/* ms */
 
 static const unsigned int palmas_extcon_cable[] = {
 	EXTCON_USB,
@@ -118,19 +121,53 @@ static irqreturn_t palmas_id_irq_handler(int irq, void *_palmas_usb)
 	return IRQ_HANDLED;
 }
 
+static void palmas_gpio_id_detect(struct palmas_usb *palmas_usb)
+{
+	int id;
+	struct extcon_dev *edev = palmas_usb->edev;
+
+	if (!palmas_usb->id_gpiod)
+		return;
+
+	id = gpiod_get_value_cansleep(palmas_usb->id_gpiod);
+
+	if (id) {
+		extcon_set_cable_state_(edev, EXTCON_USB_HOST, false);
+		dev_info(palmas_usb->dev, "USB-HOST cable is detached\n");
+	} else {
+		extcon_set_cable_state_(edev, EXTCON_USB_HOST, true);
+		dev_info(palmas_usb->dev, "USB-HOST cable is attached\n");
+	}
+}
+
+static irqreturn_t palmas_gpio_id_irq_handler(int irq, void *_palmas_usb)
+{
+	struct palmas_usb *palmas_usb = _palmas_usb;
+
+	if (palmas_usb->sw_debounce_ms)
+		mdelay(palmas_usb->sw_debounce_ms);
+
+	palmas_gpio_id_detect(palmas_usb);
+
+	return IRQ_HANDLED;
+}
+
 static void palmas_enable_irq(struct palmas_usb *palmas_usb)
 {
 	palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
 		PALMAS_USB_VBUS_CTRL_SET,
 		PALMAS_USB_VBUS_CTRL_SET_VBUS_ACT_COMP);
 
-	palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
-		PALMAS_USB_ID_CTRL_SET, PALMAS_USB_ID_CTRL_SET_ID_ACT_COMP);
+	if (palmas_usb->enable_id_detection) {
+		palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
+			     PALMAS_USB_ID_CTRL_SET,
+			     PALMAS_USB_ID_CTRL_SET_ID_ACT_COMP);
 
-	palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
-		PALMAS_USB_ID_INT_EN_HI_SET,
-		PALMAS_USB_ID_INT_EN_HI_SET_ID_GND |
-		PALMAS_USB_ID_INT_EN_HI_SET_ID_FLOAT);
+		palmas_write(palmas_usb->palmas, PALMAS_USB_OTG_BASE,
+			     PALMAS_USB_ID_INT_EN_HI_SET,
+			     PALMAS_USB_ID_INT_EN_HI_SET_ID_GND |
+			     PALMAS_USB_ID_INT_EN_HI_SET_ID_FLOAT);
+	}
 
 	if (palmas_usb->enable_vbus_detection)
 		palmas_vbus_irq_handler(palmas_usb->vbus_irq, palmas_usb);
@@ -169,20 +206,34 @@ static int palmas_usb_probe(struct platform_device *pdev)
 			palmas_usb->wakeup = pdata->wakeup;
 	}
 
+	palmas_usb->id_gpiod = devm_gpiod_get_optional(&pdev->dev, "id");
+	if (IS_ERR(palmas_usb->id_gpiod)) {
+		dev_err(&pdev->dev, "failed to get id gpio\n");
+		return PTR_ERR(palmas_usb->id_gpiod);
+	}
+
+	if (palmas_usb->enable_id_detection && palmas_usb->id_gpiod) {
+		palmas_usb->enable_id_detection = false;
+		palmas_usb->enable_gpio_id_detection = true;
+	}
+
+	if (palmas_usb->enable_gpio_id_detection) {
+		u32 debounce;
+
+		if (of_property_read_u32(node, "debounce-delay-ms", &debounce))
+			debounce = USB_GPIO_DEBOUNCE_MS;
+
+		status = gpiod_set_debounce(palmas_usb->id_gpiod,
+					    debounce * 1000);
+		if (status < 0)
+			palmas_usb->sw_debounce_ms = debounce;
+	}
+
 	palmas->usb = palmas_usb;
 	palmas_usb->palmas = palmas;
 
 	palmas_usb->dev	 = &pdev->dev;
 
-	palmas_usb->id_otg_irq = regmap_irq_get_virq(palmas->irq_data,
-						PALMAS_ID_OTG_IRQ);
-	palmas_usb->id_irq = regmap_irq_get_virq(palmas->irq_data,
-						PALMAS_ID_IRQ);
-	palmas_usb->vbus_otg_irq = regmap_irq_get_virq(palmas->irq_data,
-						PALMAS_VBUS_OTG_IRQ);
-	palmas_usb->vbus_irq = regmap_irq_get_virq(palmas->irq_data,
-						PALMAS_VBUS_IRQ);
-
 	palmas_usb_wakeup(palmas, palmas_usb->wakeup);
 
 	platform_set_drvdata(pdev, palmas_usb);
@@ -201,6 +252,10 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	}
 
 	if (palmas_usb->enable_id_detection) {
+		palmas_usb->id_otg_irq = regmap_irq_get_virq(palmas->irq_data,
+							     PALMAS_ID_OTG_IRQ);
+		palmas_usb->id_irq = regmap_irq_get_virq(palmas->irq_data,
+							 PALMAS_ID_IRQ);
 		status = devm_request_threaded_irq(palmas_usb->dev,
 				palmas_usb->id_irq,
 				NULL, palmas_id_irq_handler,
@@ -212,9 +267,33 @@ static int palmas_usb_probe(struct platform_device *pdev)
 					palmas_usb->id_irq, status);
 			return status;
 		}
+	} else if (palmas_usb->enable_gpio_id_detection) {
+		palmas_usb->gpio_id_irq = gpiod_to_irq(palmas_usb->id_gpiod);
+		if (palmas_usb->gpio_id_irq < 0) {
+			dev_err(&pdev->dev, "failed to get id irq\n");
+			return palmas_usb->gpio_id_irq;
+		}
+		status = devm_request_threaded_irq(&pdev->dev,
+						   palmas_usb->gpio_id_irq,
+						   NULL,
+						   palmas_gpio_id_irq_handler,
+						   IRQF_TRIGGER_RISING |
+						   IRQF_TRIGGER_FALLING |
+						   IRQF_ONESHOT,
+						   "palmas_usb_id",
+						   palmas_usb);
+		if (status < 0) {
+			dev_err(&pdev->dev,
+				"failed to request handler for id irq\n");
+			return status;
+		}
 	}
 
 	if (palmas_usb->enable_vbus_detection) {
+		palmas_usb->vbus_otg_irq = regmap_irq_get_virq(palmas->irq_data,
+						       PALMAS_VBUS_OTG_IRQ);
+		palmas_usb->vbus_irq = regmap_irq_get_virq(palmas->irq_data,
+							   PALMAS_VBUS_IRQ);
 		status = devm_request_threaded_irq(palmas_usb->dev,
 				palmas_usb->vbus_irq, NULL,
 				palmas_vbus_irq_handler,
@@ -229,6 +308,8 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	}
 
 	palmas_enable_irq(palmas_usb);
+	/* perform initial detection */
+	palmas_gpio_id_detect(palmas_usb);
 	device_set_wakeup_capable(&pdev->dev, true);
 	return 0;
 }
@@ -243,6 +324,8 @@ static int palmas_usb_suspend(struct device *dev)
 			enable_irq_wake(palmas_usb->vbus_irq);
 		if (palmas_usb->enable_id_detection)
 			enable_irq_wake(palmas_usb->id_irq);
+		if (palmas_usb->enable_gpio_id_detection)
+			enable_irq_wake(palmas_usb->gpio_id_irq);
 	}
 	return 0;
 }
@@ -256,6 +339,8 @@ static int palmas_usb_resume(struct device *dev)
 			disable_irq_wake(palmas_usb->vbus_irq);
 		if (palmas_usb->enable_id_detection)
 			disable_irq_wake(palmas_usb->id_irq);
+		if (palmas_usb->enable_gpio_id_detection)
+			disable_irq_wake(palmas_usb->gpio_id_irq);
 	}
 	return 0;
 };
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index bb270bd..1a202a6 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/extcon.h>
+#include <linux/of_gpio.h>
 #include <linux/usb/phy_companion.h>
 
 #define PALMAS_NUM_CLIENTS		3
@@ -551,10 +552,15 @@ struct palmas_usb {
 	int vbus_otg_irq;
 	int vbus_irq;
 
+	int gpio_id_irq;
+	struct gpio_desc *id_gpiod;
+	int sw_debounce_ms;
+
 	enum palmas_usb_state linkstat;
 	int wakeup;
 	bool enable_vbus_detection;
 	bool enable_id_detection;
+	bool enable_gpio_id_detection;
 };
 
 #define comparator_to_palmas(x) container_of((x), struct palmas_usb, comparator)
-- 
2.1.4

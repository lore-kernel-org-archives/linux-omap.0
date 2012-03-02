From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Fri, 2 Mar 2012 17:50:13 +0100
Message-ID: <1330707024-23730-2-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44267 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab2CBQvB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:51:01 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Felipe Balbi <balbi@ti.com>

With sparse IRQs the driver shouldn't depend at all on
any IRQ values coming from board-file.

Remove every occurences of pdata->irq_base/end.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 drivers/mfd/twl-core.c |   49 ++++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4970d43..f28a1dc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -648,7 +648,8 @@ add_regulator(int num, struct regulator_init_data *pdata,
  */
 
 static int
-add_children(struct twl4030_platform_data *pdata, unsigned long features)
+add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
+		unsigned long features)
 {
 	struct device	*child;
 	unsigned sub_chip_id;
@@ -656,7 +657,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	if (twl_has_gpio() && pdata->gpio) {
 		child = add_child(SUB_CHIP_ID1, "twl4030_gpio",
 				pdata->gpio, sizeof(*pdata->gpio),
-				false, pdata->irq_base + GPIO_INTR_OFFSET, 0);
+				false, irq_base + GPIO_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -664,7 +665,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	if (twl_has_keypad() && pdata->keypad) {
 		child = add_child(SUB_CHIP_ID2, "twl4030_keypad",
 				pdata->keypad, sizeof(*pdata->keypad),
-				true, pdata->irq_base + KEYPAD_INTR_OFFSET, 0);
+				true, irq_base + KEYPAD_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -672,7 +673,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	if (twl_has_madc() && pdata->madc) {
 		child = add_child(2, "twl4030_madc",
 				pdata->madc, sizeof(*pdata->madc),
-				true, pdata->irq_base + MADC_INTR_OFFSET, 0);
+				true, irq_base + MADC_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -688,7 +689,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		sub_chip_id = twl_map[TWL_MODULE_RTC].sid;
 		child = add_child(sub_chip_id, "twl_rtc",
 				NULL, 0,
-				true, pdata->irq_base + RTC_INTR_OFFSET, 0);
+				true, irq_base + RTC_INTR_OFFSET, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -741,8 +742,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 				pdata->usb, sizeof(*pdata->usb),
 				true,
 				/* irq0 = USB_PRES, irq1 = USB */
-				pdata->irq_base + USB_PRES_INTR_OFFSET,
-				pdata->irq_base + USB_INTR_OFFSET);
+				irq_base + USB_PRES_INTR_OFFSET,
+				irq_base + USB_INTR_OFFSET);
 
 		if (IS_ERR(child))
 			return PTR_ERR(child);
@@ -790,8 +791,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			pdata->usb, sizeof(*pdata->usb),
 			true,
 			/* irq1 = VBUS_PRES, irq0 = USB ID */
-			pdata->irq_base + USBOTG_INTR_OFFSET,
-			pdata->irq_base + USB_PRES_INTR_OFFSET);
+			irq_base + USBOTG_INTR_OFFSET,
+			irq_base + USB_PRES_INTR_OFFSET);
 
 		if (IS_ERR(child))
 			return PTR_ERR(child);
@@ -818,7 +819,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 
 	if (twl_has_pwrbutton() && twl_class_is_4030()) {
 		child = add_child(1, "twl4030_pwrbutton",
-				NULL, 0, true, pdata->irq_base + 8 + 0, 0);
+				NULL, 0, true, irq_base + 8 + 0, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -1052,8 +1053,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		child = add_child(3, "twl4030_bci",
 				pdata->bci, sizeof(*pdata->bci), false,
 				/* irq0 = CHG_PRES, irq1 = BCI */
-				pdata->irq_base + BCI_PRES_INTR_OFFSET,
-				pdata->irq_base + BCI_INTR_OFFSET);
+				irq_base + BCI_PRES_INTR_OFFSET,
+				irq_base + BCI_INTR_OFFSET);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
@@ -1187,6 +1188,8 @@ static int twl_remove(struct i2c_client *client)
 static int __devinit
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	int				irq_base;
+	int				irq_end;
 	int				status;
 	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
@@ -1215,15 +1218,15 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
-	status = irq_alloc_descs(-1, pdata->irq_base, nr_irqs, 0);
+	status = irq_alloc_descs(-1, 0, nr_irqs, 0);
 	if (IS_ERR_VALUE(status)) {
 		dev_err(&client->dev, "Fail to allocate IRQ descs\n");
 		return status;
 	}
 
-	pdata->irq_base = status;
-	pdata->irq_end = pdata->irq_base + nr_irqs;
-	irq_domain_add_legacy(node, nr_irqs, pdata->irq_base, 0,
+	irq_base = status;
+	irq_end = irq_base + nr_irqs;
+	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
 			      &irq_domain_simple_ops, NULL);
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
@@ -1277,16 +1280,14 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		twl4030_power_init(pdata->power);
 
 	/* Maybe init the T2 Interrupt subsystem */
-	if (client->irq
-			&& pdata->irq_base
-			&& pdata->irq_end > pdata->irq_base) {
+	if (client->irq) {
 		if (twl_class_is_4030()) {
 			twl4030_init_chip_irq(id->name);
-			status = twl4030_init_irq(client->irq, pdata->irq_base,
-			pdata->irq_end);
+			status = twl4030_init_irq(client->irq, irq_base,
+			irq_end);
 		} else {
-			status = twl6030_init_irq(client->irq, pdata->irq_base,
-			pdata->irq_end);
+			status = twl6030_init_irq(client->irq, irq_base,
+			irq_end);
 		}
 
 		if (status < 0)
@@ -1309,7 +1310,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (node)
 		status = of_platform_populate(node, NULL, NULL, &client->dev);
 	if (status)
-		status = add_children(pdata, id->driver_data);
+		status = add_children(pdata, irq_base, id->driver_data);
 
 fail:
 	if (status < 0)
-- 
1.7.0.4


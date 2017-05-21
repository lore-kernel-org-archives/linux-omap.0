From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v5 1/3] drivers:power:twl4030-charger: remove nonstandard max_current sysfs attribute
Date: Sun, 21 May 2017 12:38:16 +0200
Message-ID: <2cfdb1799219d883cde31779e97d570dc003f8cf.1495363097.git.hns@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495363097.git.hns@goldelico.com>
In-Reply-To: <cover.1495363097.git.hns@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since we now support the standard 'input_current_limit' property by

commit 3fb319c2cdcd ("power: supply: twl4030-charger: add writable INPUT_CURRENT_LIMIT property")

we can now remove the nonstandard 'max_current' sysfs attribute.

See Documentation/power/power_supply_class.txt line 125

Both are functionally equivalent. From ABI point of view it is just a rename
of the property.

This also removes the entry in Documentation/ABI/testing/sysfs-class-power-twl4030

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../ABI/testing/sysfs-class-power-twl4030          | 17 ------
 drivers/power/supply/twl4030_charger.c             | 63 ----------------------
 2 files changed, 80 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-twl4030 b/Documentation/ABI/testing/sysfs-class-power-twl4030
index be26af0f1895..b4fd32d210c5 100644
--- a/Documentation/ABI/testing/sysfs-class-power-twl4030
+++ b/Documentation/ABI/testing/sysfs-class-power-twl4030
@@ -1,20 +1,3 @@
-What: /sys/class/power_supply/twl4030_ac/max_current
-      /sys/class/power_supply/twl4030_usb/max_current
-Description:
-	Read/Write limit on current which may
-	be drawn from the ac (Accessory Charger) or
-	USB port.
-
-	Value is in micro-Amps.
-
-	Value is set automatically to an appropriate
-	value when a cable is plugged or unplugged.
-
-	Value can the set by writing to the attribute.
-	The change will only persist until the next
-	plug event.  These event are reported via udev.
-
-
 What: /sys/class/power_supply/twl4030_usb/mode
 Description:
 	Changing mode for USB port.
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 2f82d0e9ec1b..785a07bc4f39 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -624,63 +624,6 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/*
- * Provide "max_current" attribute in sysfs.
- */
-static ssize_t
-twl4030_bci_max_current_store(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t n)
-{
-	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
-	int cur = 0;
-	int status = 0;
-	status = kstrtoint(buf, 10, &cur);
-	if (status)
-		return status;
-	if (cur < 0)
-		return -EINVAL;
-	if (dev == &bci->ac->dev)
-		bci->ac_cur = cur;
-	else
-		bci->usb_cur_target = cur;
-
-	twl4030_charger_update_current(bci);
-	return n;
-}
-
-/*
- * sysfs max_current show
- */
-static ssize_t twl4030_bci_max_current_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	int status = 0;
-	int cur = -1;
-	u8 bcictl1;
-	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
-
-	if (dev == &bci->ac->dev) {
-		if (!bci->ac_is_active)
-			cur = bci->ac_cur;
-	} else {
-		if (bci->ac_is_active)
-			cur = bci->usb_cur_target;
-	}
-	if (cur < 0) {
-		cur = twl4030bci_read_adc_val(TWL4030_BCIIREF1);
-		if (cur < 0)
-			return cur;
-		status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
-		if (status < 0)
-			return status;
-		cur = regval2ua(cur, bcictl1 & TWL4030_CGAIN);
-	}
-	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
-}
-
-static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
-			twl4030_bci_max_current_store);
-
 static void twl4030_bci_usb_work(struct work_struct *data)
 {
 	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
@@ -1111,14 +1054,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
 
 	twl4030_charger_update_current(bci);
-	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
-		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(&bci->ac->dev, &dev_attr_mode))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
-	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
-		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
 	twl4030_charger_enable_ac(bci, true);
 	if (!IS_ERR_OR_NULL(bci->transceiver))
@@ -1150,9 +1089,7 @@ static int twl4030_bci_remove(struct platform_device *pdev)
 
 	iio_channel_release(bci->channel_vac);
 
-	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
-	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
 	device_remove_file(&bci->ac->dev, &dev_attr_mode);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
-- 
2.12.2

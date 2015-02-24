From: NeilBrown <neilb@suse.de>
Subject: [PATCH 09/15] twl4030_charger: allow max_current to be managed via
 sysfs.
Date: Tue, 24 Feb 2015 15:33:52 +1100
Message-ID: <20150224043351.4243.46323.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbbBXU4y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 15:56:54 -0500
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

'max_current' sysfs attributes are created which allow the
max to be set.
Whenever a current source changes, the default is restored.
This will be followed by a uevent, so user-space can decide to
update again.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index bfc9b808301e..b0242786d047 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -473,6 +473,8 @@ static irqreturn_t twl4030_charger_interrupt(int irq, void *arg)
 	struct twl4030_bci *bci = arg;
 
 	dev_dbg(bci->dev, "CHG_PRES irq\n");
+	/* reset current on each 'plug' event */
+	bci->ac_cur = 500000;
 	twl4030_charger_update_current(bci);
 	power_supply_changed(&bci->ac);
 	power_supply_changed(&bci->usb);
@@ -527,6 +529,67 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/*
+ * sysfs max_current store
+ */
+static ssize_t
+twl4030_bci_max_current_store(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t n)
+{
+	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
+	int cur = 0;
+	int status = 0;
+	status = kstrtoint(buf, 10, &cur);
+	if (status)
+		return status;
+	if (cur < 0)
+		return -EINVAL;
+	if (dev == bci->ac.dev) {
+		if (bci->ac_cur == cur)
+			return n;
+		bci->ac_cur = cur;
+	} else {
+		if (bci->usb_cur == cur)
+			return n;
+		bci->usb_cur = cur;
+	}
+	twl4030_charger_update_current(bci);
+	return (status == 0) ? n : status;
+}
+
+/*
+ * sysfs max_current show
+ */
+static ssize_t twl4030_bci_max_current_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int status = 0;
+	int cur = -1;
+	u8 bcictl1;
+	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
+
+	if (dev == bci->ac.dev) {
+		if (!bci->ac_is_active)
+			cur = bci->ac_cur;
+	} else {
+		if (bci->ac_is_active)
+			cur = bci->usb_cur;
+	}
+	if (cur < 0) {
+		cur = twl4030bci_read_adc_val(TWL4030_BCIIREF1);
+		if (cur < 0)
+			return cur;
+		status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
+		if (status < 0)
+			return status;
+		cur = regval2ua(cur, bcictl1 & TWL4030_CGAIN);
+	}
+	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
+}
+
+static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
+			twl4030_bci_max_current_store);
+
 static void twl4030_bci_usb_work(struct work_struct *data)
 {
 	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
@@ -549,6 +612,12 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 
 	dev_dbg(bci->dev, "OTG notify %lu\n", val);
 
+	/* reset current on each 'plug' event */
+	if (allow_usb)
+		bci->usb_cur = 500000;
+	else
+		bci->usb_cur = 100000;
+
 	bci->event = val;
 	schedule_work(&bci->work);
 
@@ -809,6 +878,11 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
 
 	twl4030_charger_update_current(bci);
+	if (device_create_file(bci->usb.dev, &dev_attr_max_current))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+	if (device_create_file(bci->ac.dev, &dev_attr_max_current))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
 	twl4030_charger_enable_ac(true);
 	if (!IS_ERR_OR_NULL(bci->transceiver))
 		twl4030_bci_usb_ncb(&bci->usb_nb,
@@ -836,6 +910,8 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl4030_charger_enable_usb(bci, false);
 	twl4030_charger_enable_backup(0, 0);
 
+	device_remove_file(bci->usb.dev, &dev_attr_max_current);
+	device_remove_file(bci->ac.dev, &dev_attr_max_current);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR1A);



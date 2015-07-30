From: NeilBrown <neil@brown.name>
Subject: [PATCH 08/13] twl4030_charger: allow max_current to be managed via
 sysfs.
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.15657.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

'max_current' sysfs attributes are created which allow the
max to be set.
Whenever a current source changes, the default is restored.
This will be followed by a uevent, so user-space can decide to
update again.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 .../ABI/testing/sysfs-class-power-twl4030          |   15 ++++
 drivers/power/twl4030_charger.c                    |   72 ++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-twl4030

diff --git a/Documentation/ABI/testing/sysfs-class-power-twl4030 b/Documentation/ABI/testing/sysfs-class-power-twl4030
new file mode 100644
index 000000000000..0331bba4605d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-twl4030
@@ -0,0 +1,15 @@
+What: /sys/class/power_supply/twl4030_ac/max_current
+      /sys/class/power_supply/twl4030_usb/max_current
+Description:
+	Read/Write limit on current which may
+	be drawn from the ac (Accessory Charger) or
+	USB port.
+
+	Value is in micro-Amps.
+
+	Value is set automatically to an appropriate
+	value when a cable is plugged or unplugged.
+
+	Value can the set by writing to the attribute.
+	The change will only persist until the next
+	plug event.  These event are reported via udev.
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 982675df21b7..b0a50adebfda 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -482,6 +482,8 @@ static irqreturn_t twl4030_charger_interrupt(int irq, void *arg)
 	struct twl4030_bci *bci = arg;
 
 	dev_dbg(bci->dev, "CHG_PRES irq\n");
+	/* reset current on each 'plug' event */
+	bci->ac_cur = 500000;
 	twl4030_charger_update_current(bci);
 	power_supply_changed(bci->ac);
 	power_supply_changed(bci->usb);
@@ -536,6 +538,63 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Provide "max_current" attribute in sysfs.
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
+	if (dev == &bci->ac->dev)
+		bci->ac_cur = cur;
+	else
+		bci->usb_cur = cur;
+
+	twl4030_charger_update_current(bci);
+	return n;
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
+	if (dev == &bci->ac->dev) {
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
@@ -558,6 +617,12 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 
 	dev_dbg(bci->dev, "OTG notify %lu\n", val);
 
+	/* reset current on each 'plug' event */
+	if (allow_usb)
+		bci->usb_cur = 500000;
+	else
+		bci->usb_cur = 100000;
+
 	bci->event = val;
 	schedule_work(&bci->work);
 
@@ -831,6 +896,11 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
 
 	twl4030_charger_update_current(bci);
+	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
 	twl4030_charger_enable_ac(true);
 	if (!IS_ERR_OR_NULL(bci->transceiver))
 		twl4030_bci_usb_ncb(&bci->usb_nb,
@@ -855,6 +925,8 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl4030_charger_enable_usb(bci, false);
 	twl4030_charger_enable_backup(0, 0);
 
+	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
+	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR1A);



From: NeilBrown <neil@brown.name>
Subject: [PATCH 09/13] twl4030_charger: enable manual enable/disable of usb
 charging.
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.70650.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

'off' or 'auto' to

 /sys/class/power/twl4030_usb/mode

will now enable or disable charging from USB port.  Normally this is
enabled on 'plug' and disabled on 'unplug'.
Unplug will still disable charging.  'plug' will only enable it if
'auto' if selected.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 .../ABI/testing/sysfs-class-power-twl4030          |   11 ++++
 drivers/power/twl4030_charger.c                    |   59 ++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-twl4030 b/Documentation/ABI/testing/sysfs-class-power-twl4030
index 0331bba4605d..40e0f919cbde 100644
--- a/Documentation/ABI/testing/sysfs-class-power-twl4030
+++ b/Documentation/ABI/testing/sysfs-class-power-twl4030
@@ -13,3 +13,14 @@ Description:
 	Value can the set by writing to the attribute.
 	The change will only persist until the next
 	plug event.  These event are reported via udev.
+
+
+What: /sys/class/power_supply/twl4030_usb/mode
+Description:
+	Changing mode for USB port.
+	Writing to this can disable charging.
+
+	Possible values are:
+		"auto" - draw power as appropriate for detected
+			 power source and battery status.
+		"off"  - do not draw any power.
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index b0a50adebfda..6fa928ed3128 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -109,10 +109,16 @@ struct twl4030_bci {
 	unsigned int		ichg_eoc, ichg_lo, ichg_hi;
 	unsigned int		usb_cur, ac_cur;
 	bool			ac_is_active;
+	int			usb_mode; /* charging mode requested */
+#define	CHARGE_OFF	0
+#define	CHARGE_AUTO	1
 
 	unsigned long		event;
 };
 
+/* strings for 'usb_mode' values */
+static char *modes[] = { "off", "auto" };
+
 /*
  * clear and set bits on an given register on a given module
  */
@@ -386,6 +392,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
 
+	if (bci->usb_mode == CHARGE_OFF)
+		enable = false;
 	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
 
 		twl4030_charger_update_current(bci);
@@ -629,6 +637,53 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
+/*
+ * sysfs charger enabled store
+ */
+static ssize_t
+twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t n)
+{
+	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
+	int mode;
+	int status;
+
+	if (sysfs_streq(buf, modes[0]))
+		mode = 0;
+	else if (sysfs_streq(buf, modes[1]))
+		mode = 1;
+	else
+		return -EINVAL;
+	twl4030_charger_enable_usb(bci, false);
+	bci->usb_mode = mode;
+	status = twl4030_charger_enable_usb(bci, true);
+	return (status == 0) ? n : status;
+}
+
+/*
+ * sysfs charger enabled show
+ */
+static ssize_t
+twl4030_bci_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct twl4030_bci *bci = dev_get_drvdata(dev->parent);
+	int len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(modes); i++)
+		if (bci->usb_mode == i)
+			len += snprintf(buf+len, PAGE_SIZE-len,
+					"[%s] ", modes[i]);
+		else
+			len += snprintf(buf+len, PAGE_SIZE-len,
+					"%s ", modes[i]);
+	buf[len-1] = '\n';
+	return len;
+}
+static DEVICE_ATTR(mode, 0644, twl4030_bci_mode_show,
+		   twl4030_bci_mode_store);
+
 static int twl4030_charger_get_current(void)
 {
 	int curr;
@@ -815,6 +870,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		bci->usb_cur = 500000;  /* 500mA */
 	else
 		bci->usb_cur = 100000;  /* 100mA */
+	bci->usb_mode = CHARGE_AUTO;
 
 	bci->dev = &pdev->dev;
 	bci->irq_chg = platform_get_irq(pdev, 0);
@@ -898,6 +954,8 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	twl4030_charger_update_current(bci);
 	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
+	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
@@ -926,6 +984,7 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl4030_charger_enable_backup(0, 0);
 
 	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
+	device_remove_file(&bci->usb->dev, &dev_attr_mode);
 	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,

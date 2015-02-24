From: NeilBrown <neilb@suse.de>
Subject: [PATCH 11/15] twl4030_charger: enable manual enable/disable of usb
 charging.
Date: Tue, 24 Feb 2015 15:33:52 +1100
Message-ID: <20150224043352.4243.543.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

'off' or 'auto' to

 /sys/class/power/twl4030_usb/mode

will now enable or disable charging from USB port.  Normally this is
enabled on 'plug' and disabled on 'unplug'.
Unplug will still disable charging.  'plug' will only enable it if
'auto' if selected.

Signed-off-by: NeilBrown <neilb@suse.de>

Conflicts:
	drivers/power/twl4030_charger.c
---
 drivers/power/twl4030_charger.c |   57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 01090a440583..19e8dbb1303e 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -107,6 +107,9 @@ struct twl4030_bci {
 	int			ichg_eoc, ichg_lo, ichg_hi;
 	int			usb_cur, ac_cur;
 	bool			ac_is_active;
+	int			usb_mode; /* charging mode requested */
+#define	CHARGE_OFF	0
+#define	CHARGE_AUTO	1
 
 	unsigned long		event;
 };
@@ -377,6 +380,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
 
+	if (bci->usb_mode == CHARGE_OFF)
+		enable = false;
 	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
 
 		twl4030_charger_update_current(bci);
@@ -629,6 +634,54 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
+/*
+ * sysfs charger enabled store
+ */
+static char *modes[] = { "off", "auto" };
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
@@ -799,6 +852,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 		bci->usb_cur = 500000;  /* 500mA */
 	else
 		bci->usb_cur = 100000;  /* 100mA */
+	bci->usb_mode = CHARGE_AUTO;
 
 	bci->dev = &pdev->dev;
 	bci->irq_chg = platform_get_irq(pdev, 0);
@@ -885,6 +939,8 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	twl4030_charger_update_current(bci);
 	if (device_create_file(bci->usb.dev, &dev_attr_max_current))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
+	if (device_create_file(bci->usb.dev, &dev_attr_mode))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
 	if (device_create_file(bci->ac.dev, &dev_attr_max_current))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
@@ -917,6 +973,7 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 
 	device_remove_file(bci->usb.dev, &dev_attr_max_current);
 	device_remove_file(bci->ac.dev, &dev_attr_max_current);
+	device_remove_file(bci->usb.dev, &dev_attr_mode);
 	/* mask interrupts */
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR1A);

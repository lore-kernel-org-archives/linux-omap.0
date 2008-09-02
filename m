From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/2] i2c: twl4030-usb: add 'vbus' sysfs file
Date: Tue,  2 Sep 2008 15:31:52 +0300
Message-ID: <1220358712-25737-3-git-send-email-felipe.balbi@nokia.com>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
 <1220358712-25737-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56242 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYIBMcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:32:20 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m82CVt0M012074
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 07:32:17 -0500
In-Reply-To: <1220358712-25737-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

vbus sysfs file will report the state of vbus irq coming from
twl4030-usb.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |   51 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 0d62e65..1429557 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -29,6 +29,8 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/ch9.h>
@@ -39,11 +41,17 @@
 #include <mach/usb.h>
 
 struct twl4030_usb {
+	struct work_struct	irq_work;
 	struct otg_transceiver	otg;
 	struct device		*dev;
 
+	/* for vbus reporting with irqs disabled */
+	spinlock_t		lock;
+
 	/* pin configuration */
 	enum twl4030_usb_mode	usb_mode;
+
+	unsigned		vbus:1;
 	int			irq;
 	u8			asleep;
 };
@@ -309,6 +317,29 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, PROTECT_KEY);
 }
 
+static ssize_t twl4030_usb_vbus_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&twl->lock, flags);
+	ret = sprintf(buf, "%s\n", twl->vbus ? "on" : "off");
+	spin_unlock_irqrestore(&twl->lock, flags);
+
+	return ret;
+}
+static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
+
+static void twl4030_usb_irq_work(struct work_struct *work)
+{
+	struct twl4030_usb *twl = container_of(work,
+			struct twl4030_usb, irq_work);
+
+	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+}
+
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
@@ -321,10 +352,13 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	if (val & USB_PRES_RISING) {
 		twl4030_phy_resume(twl);
 		twl4030charger_usb_en(1);
+		twl->vbus = 1;
 	} else {
 		twl4030charger_usb_en(0);
+		twl->vbus = 0;
 		twl4030_phy_suspend(twl, 0);
 	}
+	schedule_work(&twl->irq_work);
 
 	return IRQ_HANDLED;
 }
@@ -414,16 +448,22 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	struct twl4030_usb_platform_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
 	int status;
+	u8			vbus;
 
 	twl = kzalloc(sizeof *twl, GFP_KERNEL);
 	if (!twl)
 		return -ENOMEM;
 
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&vbus, REG_PWR_EDR1) < 0);
+	vbus &= USB_PRES_RISING;
+
 	twl->dev		= &pdev->dev;
 	twl->irq		= TWL4030_PWRIRQ_USB_PRES;
 	twl->otg.set_host	= twl4030_set_host;
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
+	twl->vbus		= vbus ? 1 : 0;
 
 	if (!pdata) {
 		dev_info(&pdev->dev, "platform_data not available, defaulting"
@@ -433,6 +473,12 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 		twl->usb_mode	= pdata->usb_mode;
 	}
 
+	/* init spinlock for workqueue */
+	spin_lock_init(&twl->lock);
+
+	/* init irq workqueue before request_irq */
+	INIT_WORK(&twl->irq_work, twl4030_usb_irq_work);
+
 	usb_irq_disable(twl);
 	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
 	if (status < 0) {
@@ -442,7 +488,6 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-
 	twl4030_usb_ldo_init(twl);
 	twl4030_phy_power(twl, 1);
 	twl4030_i2c_access(twl, 1);
@@ -459,6 +504,9 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, twl);
 	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
 
+	if (device_create_file(&pdev->dev, &dev_attr_vbus))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
 	return 0;
 }
 
@@ -469,6 +517,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 
 	usb_irq_disable(twl);
 	free_irq(twl->irq, twl);
+	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
-- 
1.6.0.1.126.ga118


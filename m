From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 06/25] i2c: twl4030-usb: add 'vbus' sysfs file
Date: Tue, 30 Sep 2008 21:42:50 +0300
Message-ID: <1222800189-29737-7-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51238 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbYI3Snh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:43:37 -0400
In-Reply-To: <1222800189-29737-6-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

vbus sysfs file will report the state of vbus irq coming from
twl4030-usb.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |   51 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 246aa9d..f530e71 100644
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
@@ -259,11 +261,17 @@
 
 
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
@@ -529,6 +537,29 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
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
@@ -541,10 +572,13 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
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
@@ -634,6 +668,7 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
 	int status;
+	u8			vbus;
 
 	twl = kzalloc(sizeof *twl, GFP_KERNEL);
 	if (!twl)
@@ -644,12 +679,23 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&vbus, REG_PWR_EDR1) < 0);
+	vbus &= USB_PRES_RISING;
+
 	twl->dev		= &pdev->dev;
 	twl->irq		= TWL4030_PWRIRQ_USB_PRES;
 	twl->otg.set_host	= twl4030_set_host;
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
 	twl->usb_mode		= pdata->usb_mode;
+	twl->vbus		= vbus ? 1 : 0;
+
+	/* init spinlock for workqueue */
+	spin_lock_init(&twl->lock);
+
+	/* init irq workqueue before request_irq */
+	INIT_WORK(&twl->irq_work, twl4030_usb_irq_work);
 
 	usb_irq_disable(twl);
 	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
@@ -660,7 +706,6 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-
 	twl4030_usb_ldo_init(twl);
 	twl4030_phy_power(twl, 1);
 	twl4030_i2c_access(twl, 1);
@@ -677,6 +722,9 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, twl);
 	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
 
+	if (device_create_file(&pdev->dev, &dev_attr_vbus))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
 	return 0;
 }
 
@@ -687,6 +735,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 
 	usb_irq_disable(twl);
 	free_irq(twl->irq, twl);
+	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
-- 
1.6.0.1.196.g01914


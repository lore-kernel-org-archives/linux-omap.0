From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 05/10] cbus: tahvo-usb: make it build again
Date: Thu,  3 Dec 2009 00:28:27 +0200
Message-ID: <1259792912-11328-6-git-send-email-felipe.balbi@nokia.com>
References: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47888 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbZLBW2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:28:52 -0500
In-Reply-To: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

plenty of legacy code sitting there. Make it build
again. Later patches will come to clean that up.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo-usb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index c08f08d..9f8bbcc 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -114,8 +114,8 @@ static struct platform_device *tahvo_otg_dev;
 
 static irqreturn_t omap_otg_irq(int irq, void *arg)
 {
-	struct platform_device *otg_dev = (struct platform_device *) arg;
-	struct tahvo_usb *tu = (struct tahvo_usb *) otg_dev->dev.driver_data;
+	struct platform_device *otg_dev = arg;
+	struct tahvo_usb *tu = platform_get_drvdata(otg_dev);
 	u16 otg_irq;
 
 	otg_irq = omap_readw(OTG_IRQ_SRC);
@@ -227,7 +227,7 @@ struct device_driver omap_otg_driver = {
 static ssize_t vbus_state_show(struct device *device,
 			       struct device_attribute *attr, char *buf)
 {
-	struct tahvo_usb *tu = (struct tahvo_usb*) device->driver_data;
+	struct tahvo_usb *tu = dev_get_drvdata(device);
 	return sprintf(buf, "%d\n", tu->vbus_state);
 }
 static DEVICE_ATTR(vbus_state, 0444, vbus_state_show, NULL);
@@ -590,7 +590,7 @@ static void tahvo_usb_vbus_interrupt(unsigned long arg)
 static ssize_t otg_mode_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
-	struct tahvo_usb *tu = (struct tahvo_usb*) device->driver_data;
+	struct tahvo_usb *tu = dev_get_drvdata(device);
 	switch (tu->tahvo_mode) {
 	case TAHVO_MODE_HOST:
 		return sprintf(buf, "host\n");
@@ -604,7 +604,7 @@ static ssize_t otg_mode_store(struct device *device,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct tahvo_usb *tu = (struct tahvo_usb*) device->driver_data;
+	struct tahvo_usb *tu = dev_get_drvdata(device);
 	int r;
 
 	r = strlen(buf);
@@ -706,7 +706,7 @@ static int tahvo_usb_probe(struct device *dev)
 		return ret;
 	}
 
-	dev->driver_data = tu;
+	dev_set_drvdata(dev, tu);
 
 	/* Act upon current vbus state once at startup. A vbus state irq may or
 	 * may not be generated in addition to this. */
-- 
1.6.6.rc0


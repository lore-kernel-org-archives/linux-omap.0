From: NeilBrown <neilb@suse.de>
Subject: [PATCH 3/4] usb: phy: twl4030: add support for reading restore on
 ID pin.
Date: Tue, 24 Feb 2015 14:40:37 +1100
Message-ID: <20150224034037.31400.52748.stgit@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224033730.31400.78200.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The twl4030 phy can measure, with low precision, the
resistance-to-ground of the ID pin.

Add a function to read the value, and export the result
via sysfs.

If the read fails, which it does sometimes, try again in 50msec.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/phy/phy-twl4030-usb.c |   63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 023fe150c7a1..759950898df9 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -374,6 +374,56 @@ static void twl4030_i2c_access(struct twl4030_usb *twl, int on)
 	}
 }
 
+enum twl4030_id_status {
+	TWL4030_GROUND,
+	TWL4030_102K,
+	TWL4030_200K,
+	TWL4030_440K,
+	TWL4030_FLOATING,
+	TWL4030_ID_UNKNOWN,
+};
+static char *twl4030_id_names[] = {
+	"ground",
+	"102k",
+	"200k",
+	"440k",
+	"floating",
+	"unknown"
+};
+
+enum twl4030_id_status twl4030_get_id(struct twl4030_usb *twl)
+{
+	int ret;
+
+	pm_runtime_get_sync(twl->dev);
+	if (twl->usb_mode == T2_USB_MODE_ULPI)
+		twl4030_i2c_access(twl, 1);
+	ret = twl4030_usb_read(twl, ULPI_OTG_CTRL);
+	if (ret < 0 || !(ret & ULPI_OTG_ID_PULLUP)) {
+		/* Need pull-up to read ID */
+		twl4030_usb_set_bits(twl, ULPI_OTG_CTRL,
+				     ULPI_OTG_ID_PULLUP);
+		mdelay(50);
+	}
+	ret = twl4030_usb_read(twl, ID_STATUS);
+	if (ret < 0 || (ret & 0x1f) == 0) {
+		mdelay(50);
+		ret = twl4030_usb_read(twl, ID_STATUS);
+	}
+
+	if (twl->usb_mode == T2_USB_MODE_ULPI)
+		twl4030_i2c_access(twl, 0);
+	pm_runtime_put_autosuspend(twl->dev);
+
+	if (ret < 0)
+		return TWL4030_ID_UNKNOWN;
+	ret = ffs(ret) - 1;
+	if (ret < TWL4030_GROUND || ret > TWL4030_FLOATING)
+		return TWL4030_ID_UNKNOWN;
+
+	return ret;
+}
+
 static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
 {
 	u8 pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
@@ -531,6 +581,16 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,
 }
 static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
 
+static ssize_t twl4030_usb_id_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 twl4030_id_names[twl4030_get_id(twl)]);
+}
+static DEVICE_ATTR(id, 0444, twl4030_usb_id_show, NULL);
+
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
@@ -723,6 +783,8 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, twl);
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
+	if (device_create_file(&pdev->dev, &dev_attr_id))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
 
@@ -768,6 +830,7 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(twl->dev);
 	cancel_delayed_work(&twl->id_workaround_work);
 	device_remove_file(twl->dev, &dev_attr_vbus);
+	device_remove_file(twl->dev, &dev_attr_id);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);

From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: phy: Implement am335x advisory 1.0.34
Date: Fri, 20 Jan 2017 12:01:04 -0800
Message-ID: <20170120200104.16921-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I noticed in sprz360i.pdf there's "Advisory 1.0.34 USB2PHY: Register
Accesses After a USB Subsystem Soft Reset May Lock Up the Entire System"
that seems to affect am335x revisions 1.0, 2.0 and 2.1:

"The synchronization bridge connecting the USB2PHY register interface
 to the L3S interconnect may hang and lock up the entire system. When
 there is a sequence of any USB2PHY register access, followed by a USB
 subsystem soft reset initiated with the SOFT_RESET bit in the SYSCONFIG
 register, followed by any USB2PHY register access, the L3S interconnect
 may hang on the second USB2PHY register access."

As the USB2PHY is a child of the otg interconnect target module, I don't
think we can easily hit this as we have now musb doing runtime PM that
keeps the module enabled.

But as we now have musb and cppi41 components in the same interonnect
target module use runtime PM, let's also add runtime PM to the phy
driver. This way we have have them all behave the same way.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/phy/phy-am335x.c | 61 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/of.h>
 
 #include "phy-am335x-control.h"
@@ -22,16 +23,40 @@ struct am335x_phy {
 static int am335x_init(struct usb_phy *phy)
 {
 	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
+	int error;
+
+	error = pm_runtime_get_sync(phy->dev);
+	if (error < 0) {
+		dev_err(phy->dev, "%s pm_runtime_get: %i\n", __func__, error);
+
+		return error;
+	}
 
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, true);
+
+	pm_runtime_mark_last_busy(phy->dev);
+	pm_runtime_put_autosuspend(phy->dev);
+
 	return 0;
 }
 
 static void am335x_shutdown(struct usb_phy *phy)
 {
 	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
+	int error;
+
+	error = pm_runtime_get_sync(phy->dev);
+	if (error < 0) {
+		dev_err(phy->dev, "%s pm_runtime_get: %i\n", __func__, error);
+
+		return;
+	}
 
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, false);
+
+	pm_runtime_mark_last_busy(phy->dev);
+	pm_runtime_put_autosuspend(phy->dev);
+
 }
 
 static int am335x_phy_probe(struct platform_device *pdev)
@@ -56,13 +81,23 @@ static int am335x_phy_probe(struct platform_device *pdev)
 
 	am_phy->dr_mode = of_usb_get_dr_mode_by_phy(pdev->dev.of_node, -1);
 
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s pm_runtime_get: %i\n", __func__, ret);
+
+		return ret;
+	}
+
 	ret = usb_phy_gen_create_phy(dev, &am_phy->usb_phy_gen, NULL);
 	if (ret)
-		return ret;
+		goto disable;
 
 	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
 	if (ret)
-		return ret;
+		goto disable;
 	am_phy->usb_phy_gen.phy.init = am335x_init;
 	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
 
@@ -81,14 +116,34 @@ static int am335x_phy_probe(struct platform_device *pdev)
 	device_set_wakeup_enable(dev, false);
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, false);
 
-	return 0;
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+
+disable:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
 }
 
 static int am335x_phy_remove(struct platform_device *pdev)
 {
 	struct am335x_phy *am_phy = platform_get_drvdata(pdev);
+	int error;
+
+	error = pm_runtime_get_sync(&pdev->dev);
+	if (error < 0)
+		dev_err(&pdev->dev, "%s pm_runtime_get: %i\n", __func__, error);
 
 	usb_remove_phy(&am_phy->usb_phy_gen.phy);
+
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

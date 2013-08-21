From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] usb: phy: signedness bugs in suspend/resume functions
Date: Wed, 21 Aug 2013 11:41:22 +0300
Message-ID: <20130821084122.GL5240@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"ret" needs to be signed for the error handling to work.

Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
I can't compile this.

diff --git a/drivers/usb/phy/phy-omap-usb2.c b/drivers/usb/phy/phy-omap-usb2.c
index 844ab68..d266861 100644
--- a/drivers/usb/phy/phy-omap-usb2.c
+++ b/drivers/usb/phy/phy-omap-usb2.c
@@ -98,8 +98,8 @@ static int omap_usb_set_peripheral(struct usb_otg *otg,
 
 static int omap_usb2_suspend(struct usb_phy *x, int suspend)
 {
-	u32 ret;
 	struct omap_usb *phy = phy_to_omapusb(x);
+	int ret;
 
 	if (suspend && !phy->is_suspended) {
 		omap_control_usb_phy_power(phy->control_dev, 0);
@@ -108,8 +108,7 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
 	} else if (!suspend && phy->is_suspended) {
 		ret = pm_runtime_get_sync(phy->dev);
 		if (ret < 0) {
-			dev_err(phy->dev, "get_sync failed with err %d\n",
-									ret);
+			dev_err(phy->dev, "get_sync failed with err %d\n", ret);
 			return ret;
 		}
 		omap_control_usb_phy_power(phy->control_dev, 1);
@@ -209,9 +208,9 @@ static int omap_usb2_runtime_suspend(struct device *dev)
 
 static int omap_usb2_runtime_resume(struct device *dev)
 {
-	u32 ret = 0;
 	struct platform_device	*pdev = to_platform_device(dev);
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
+	int ret;
 
 	ret = clk_enable(phy->wkupclk);
 	if (ret < 0) {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

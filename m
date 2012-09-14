From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] usb: phy: signedness bug in suspend/resume
Date: Fri, 14 Sep 2012 09:52:49 +0300
Message-ID: <20120914065249.GC11886@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"ret" should be signed here for the error handling to work.

Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index 15ab3d6..d36c282 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -120,7 +120,7 @@ static int omap_usb_set_peripheral(struct usb_otg *otg,
 
 static int omap_usb2_suspend(struct usb_phy *x, int suspend)
 {
-	u32 ret;
+	int ret;
 	struct omap_usb *phy = phy_to_omapusb(x);
 
 	if (suspend && !phy->is_suspended) {
@@ -223,7 +223,7 @@ static int omap_usb2_runtime_suspend(struct device *dev)
 
 static int omap_usb2_runtime_resume(struct device *dev)
 {
-	u32 ret = 0;
+	int ret;
 	struct platform_device	*pdev = to_platform_device(dev);
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

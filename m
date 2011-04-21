From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] mfd: Fix usbhs_enable error handling
Date: Thu, 21 Apr 2011 19:52:41 +0530
Message-ID: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In the case of missing platform_data we do not hold a spin_lock,
thus we should not call spin_unlock_irqrestore in the error path.

Also simplify the error handling by separating the successful path
from error path. I think this change improves readability.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 53450f4..b3bb3ac 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -700,8 +700,7 @@ static int usbhs_enable(struct device *dev)
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 	if (!pdata) {
 		dev_dbg(dev, "missing platform_data\n");
-		ret =  -ENODEV;
-		goto end_enable;
+		return  -ENODEV;
 	}
 
 	spin_lock_irqsave(&omap->lock, flags);
@@ -915,7 +914,8 @@ static int usbhs_enable(struct device *dev)
 
 end_count:
 	omap->count++;
-	goto end_enable;
+	spin_unlock_irqrestore(&omap->lock, flags);
+	return 0;
 
 err_tll:
 	if (pdata->ehci_data->phy_reset) {
@@ -931,8 +931,6 @@ err_tll:
 	clk_disable(omap->usbhost_fs_fck);
 	clk_disable(omap->usbhost_hs_fck);
 	clk_disable(omap->usbhost_ick);

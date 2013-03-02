From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 06/10] usb: xhci: Enable runtime pm in xhci-plat
Date: Sat, 02 Mar 2013 18:53:07 +0530
Message-ID: <1362230590-20960-7-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

By enabling runtime pm in this driver allows users of
xhci-plat to enter into runtime pm. This is not full
runtime pm support (AKA xhci-plat doesn't actually power
anything off when in runtime suspend mode) but,
just basic enablement.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/usb/host/xhci-plat.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c9c7e13..595cb52 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -149,6 +150,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_usb3_hcd;
 
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 put_usb3_hcd:
@@ -174,6 +177,10 @@ static int xhci_plat_remove(struct platform_device *dev)
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 
+	if (!pm_runtime_suspended(&dev->dev))
+		pm_runtime_put(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+
 	usb_remove_hcd(xhci->shared_hcd);
 	usb_put_hcd(xhci->shared_hcd);
 
-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

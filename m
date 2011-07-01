From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support of ehci and ohci
Date: Sat, 2 Jul 2011 00:24:34 +0530
Message-ID: <1309546474-15363-7-git-send-email-keshava_mgowda@ti.com>
References: <1309546474-15363-1-git-send-email-keshava_mgowda@ti.com>
 <1309546474-15363-2-git-send-email-keshava_mgowda@ti.com>
 <1309546474-15363-3-git-send-email-keshava_mgowda@ti.com>
 <1309546474-15363-4-git-send-email-keshava_mgowda@ti.com>
 <1309546474-15363-5-git-send-email-keshava_mgowda@ti.com>
 <1309546474-15363-6-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1309546474-15363-6-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The global suspend and resume functions for ehci and ohci
drivers are implemented; these functions does the
pm_runtime_get_sync and pm_runtime_put_sync of the
parent device usbhs core driver respectively.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c  |   22 ++++++++++++++++++++--
 drivers/usb/host/ohci-omap3.c |   21 +++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 178f63e..a02a684 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -259,14 +259,32 @@ static void ehci_hcd_omap_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static int omap_ehci_resume(struct device *dev)
+{
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+	return 0;
+}
+
+static int omap_ehci_suspend(struct device *dev)
+{
+	if (dev->parent)
+		pm_runtime_put_sync(dev->parent);
+	return 0;
+}
+
+static const struct dev_pm_ops omap_ehci_dev_pm_ops = {
+	.suspend	= omap_ehci_suspend,
+	.resume		= omap_ehci_resume,
+};
+
 static struct platform_driver ehci_hcd_omap_driver = {
 	.probe			= ehci_hcd_omap_probe,
 	.remove			= ehci_hcd_omap_remove,
 	.shutdown		= ehci_hcd_omap_shutdown,
-	/*.suspend		= ehci_hcd_omap_suspend, */
-	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
 		.name		= "ehci-omap",
+		.pm		= &omap_ehci_dev_pm_ops,
 	}
 };
 
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 6ce50de..a1a7981 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -230,12 +230,33 @@ static void ohci_hcd_omap3_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+
+static int omap_ohci_resume(struct device *dev)
+{
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+	return 0;
+}
+
+static int omap_ohci_suspend(struct device *dev)
+{
+	if (dev->parent)
+		pm_runtime_put_sync(dev->parent);
+	return 0;
+}
+
+static const struct dev_pm_ops omap_ohci_dev_pm_ops = {
+	.suspend	= omap_ohci_suspend,
+	.resume		= omap_ohci_resume,
+};
+
 static struct platform_driver ohci_hcd_omap3_driver = {
 	.probe		= ohci_hcd_omap3_probe,
 	.remove		= __devexit_p(ohci_hcd_omap3_remove),
 	.shutdown	= ohci_hcd_omap3_shutdown,
 	.driver		= {
 		.name	= "ohci-omap3",
+		.pm		= &omap_ohci_dev_pm_ops,
 	},
 };
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

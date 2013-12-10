From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC 3/4] xhci: Tune PHY for the DWC3-Exynos host controller
Date: Tue, 10 Dec 2013 16:25:25 +0530
Message-ID: <1386672926-26885-4-git-send-email-gautam.vivek@samsung.com>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, jg1.han@samsung.com, jwerner@chromium.org
List-Id: linux-omap@vger.kernel.org

The DWC3-exynos eXtensible host controller on Exynos5420 SoC
is quirky in a way that the PHY needs to be tuned to get it
working at SuperSpeed.
Add relevant calls for tuning the PHY for DWC3-Exynos's
host controller, for that matter passing just USB3 PHY
from DWC3 core, which is saved in secondary HCD of XHCI.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/host.c      |    7 ++++++
 drivers/usb/host/xhci-plat.c |   43 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/usb/hcd.h      |    1 +
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 32db328..cc1f6ff 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -46,6 +46,13 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
+	ret = platform_device_add_data(xhci, &dwc->usb3_generic_phy,
+					sizeof(dwc->usb3_generic_phy));
+	if (ret) {
+		dev_err(dwc->dev, "failed to add platform data\n");
+		goto err1;
+	}
+
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 395c9e9..a0f3cbc 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/dma-mapping.h>
+#include <linux/phy/phy.h>
 
 #include "xhci.h"
 
@@ -51,7 +52,24 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
-	return xhci_gen_setup(hcd, xhci_plat_quirks);
+	struct xhci_hcd	*xhci;
+	int ret = 0;
+
+	ret = xhci_gen_setup(hcd, xhci_plat_quirks);
+	if (ret) {
+		dev_err(hcd->self.controller, "xhci setup failed\n");
+		goto err0;
+	}
+
+	/* Valid for secondary HCD only which gives SuperSpeed ports */
+	if (!usb_hcd_is_primary_hcd(hcd)) {
+		xhci = hcd_to_xhci(hcd);
+		if (xhci->quirks & XHCI_DWC3_EXYNOS)
+			phy_tune(hcd->phy_generic);
+	}
+
+err0:
+	return ret;
 }
 
 static const struct hc_driver xhci_plat_xhci_driver = {
@@ -111,6 +129,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct usb_hcd		*hcd;
 	int			ret;
 	int			irq;
+	struct phy		**phy_generic;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -170,6 +189,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	}
 
 	/*
+	 * The parent of the xhci-plat device may pass in a PHY via
+	 * platform data.  If it exists, store it in our struct usb_hcd
+	 * so that we can use it later.
+	 */
+	phy_generic = dev_get_platdata(&pdev->dev);
+	if (phy_generic)
+		xhci->shared_hcd->phy_generic = *phy_generic;
+
+	/*
 	 * Set the xHCI pointer before xhci_plat_setup() (aka hcd_driver.reset)
 	 * is called by usb_add_hcd().
 	 */
@@ -229,8 +257,19 @@ static int xhci_plat_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
 
-	return xhci_resume(xhci, 0);
+	/* Valid for secondary HCD only which gives SuperSpeed ports */
+	if (!usb_hcd_is_primary_hcd(hcd)) {
+		if (xhci->quirks & XHCI_DWC3_EXYNOS)
+			phy_tune(hcd->phy_generic);
+	}
+
+	return 0;
 }
 
 static const struct dev_pm_ops xhci_plat_pm_ops = {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index b8aba19..241ed2b 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -107,6 +107,7 @@ struct usb_hcd {
 	 * other external phys should be software-transparent
 	 */
 	struct usb_phy	*phy;
+	struct phy	*phy_generic;
 
 	/* Flags that need to be manipulated atomically because they can
 	 * change while the host controller is running.  Always use
-- 
1.7.6.5

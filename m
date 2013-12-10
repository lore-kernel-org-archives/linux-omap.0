From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC 2/4] xhci: Add quirk for DWC3-Exynos controller
Date: Tue, 10 Dec 2013 16:25:24 +0530
Message-ID: <1386672926-26885-3-git-send-email-gautam.vivek@samsung.com>
References: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1386672926-26885-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com, jg1.han@samsung.com, jwerner@chromium.org
List-Id: linux-omap@vger.kernel.org

The DWC3-exynos eXtensible host controller on Exynos5420 SoC
is quirky in a way that the PHY needs to be tuned to get it
working at SuperSpeed.
By default this PHY works as High-speed phy and therefore
detects even Super-speed devices as high-speed ones.
So, the PHY needs to be tuned after controller has been reset.

Adding a xHCI quirk for this purpose.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/xhci-plat.c |   19 +++++++++++++++++++
 drivers/usb/host/xhci.h      |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d9c169f..395c9e9 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -21,6 +21,25 @@
 
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
+	struct device *parent_dev;
+	struct device *vendor_parent_dev;
+
+	parent_dev = dev->parent;
+	vendor_parent_dev = parent_dev->parent;
+
+	/*
+	 * The DWC3-exynos host controller on Exynos5420 SoC is quirky
+	 * in a way that the PHY needs to be tuned to get it working
+	 * at SuperSpeed. By default this PHY works as High-speed phy
+	 * and so detects even Super-speed devices as high-speed ones.
+	 * Therefor the PHY needs to be tuned after controller
+	 * has been reset, since a controller reset actually forces the
+	 * PHY to fall back to its default state wherein it works as
+	 * High-Speed PHY only.
+	 */
+	if (!strstr(dev_name(vendor_parent_dev), "exynos"))
+		xhci->quirks |= XHCI_DWC3_EXYNOS;
+
 	/*
 	 * As of now platform drivers don't provide MSI support so we ensure
 	 * here that the generic code does not try to make a pci_dev from our
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7807f62..f69af8c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1560,6 +1560,7 @@ struct xhci_hcd {
 #define XHCI_PLAT		(1 << 16)
 #define XHCI_SLOW_SUSPEND	(1 << 17)
 #define XHCI_SPURIOUS_WAKEUP	(1 << 18)
+#define XHCI_DWC3_EXYNOS	(1 << 19)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
-- 
1.7.6.5

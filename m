From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH usb-next v9 5/8] usb: host: xhci-mtk: remove custom USB PHY handling
Date: Sun, 11 Feb 2018 22:06:48 +0100
Message-ID: <20180211210651.2046-6-martin.blumenstingl@googlemail.com>
References: <20180211210651.2046-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180211210651.2046-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The new PHY wrapper is now wired up in the core HCD code. This means
that PHYs are now controlled (initialized, enabled, disabled, exited)
without requiring any host-driver specific code.
Remove the custom USB PHY handling from the xhci-mtk driver as the core
HCD code now handles this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/usb/host/xhci-mtk.c | 98 +--------------------------------------------
 1 file changed, 2 insertions(+), 96 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b0ab4d5e2751..7334da9e9779 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -14,7 +14,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -352,62 +351,6 @@ static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
 
 static struct hc_driver __read_mostly xhci_mtk_hc_driver;
 
-static int xhci_mtk_phy_init(struct xhci_hcd_mtk *mtk)
-{
-	int i;
-	int ret;
-
-	for (i = 0; i < mtk->num_phys; i++) {
-		ret = phy_init(mtk->phys[i]);
-		if (ret)
-			goto exit_phy;
-	}
-	return 0;
-
-exit_phy:
-	for (; i > 0; i--)
-		phy_exit(mtk->phys[i - 1]);
-
-	return ret;
-}
-
-static int xhci_mtk_phy_exit(struct xhci_hcd_mtk *mtk)
-{
-	int i;
-
-	for (i = 0; i < mtk->num_phys; i++)
-		phy_exit(mtk->phys[i]);
-
-	return 0;
-}
-
-static int xhci_mtk_phy_power_on(struct xhci_hcd_mtk *mtk)
-{
-	int i;
-	int ret;
-
-	for (i = 0; i < mtk->num_phys; i++) {
-		ret = phy_power_on(mtk->phys[i]);
-		if (ret)
-			goto power_off_phy;
-	}
-	return 0;
-
-power_off_phy:
-	for (; i > 0; i--)
-		phy_power_off(mtk->phys[i - 1]);
-
-	return ret;
-}
-
-static void xhci_mtk_phy_power_off(struct xhci_hcd_mtk *mtk)
-{
-	unsigned int i;
-
-	for (i = 0; i < mtk->num_phys; i++)
-		phy_power_off(mtk->phys[i]);
-}
-
 static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
 {
 	int ret;
@@ -488,8 +431,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	struct xhci_hcd *xhci;
 	struct resource *res;
 	struct usb_hcd *hcd;
-	struct phy *phy;
-	int phy_num;
 	int ret = -ENODEV;
 	int irq;
 
@@ -529,16 +470,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mtk->num_phys = of_count_phandle_with_args(node,
-			"phys", "#phy-cells");
-	if (mtk->num_phys > 0) {
-		mtk->phys = devm_kcalloc(dev, mtk->num_phys,
-					sizeof(*mtk->phys), GFP_KERNEL);
-		if (!mtk->phys)
-			return -ENOMEM;
-	} else {
-		mtk->num_phys = 0;
-	}
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	device_enable_async_suspend(dev);
@@ -596,23 +527,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 		mtk->has_ippc = false;
 	}
 
-	for (phy_num = 0; phy_num < mtk->num_phys; phy_num++) {
-		phy = devm_of_phy_get_by_index(dev, node, phy_num);
-		if (IS_ERR(phy)) {
-			ret = PTR_ERR(phy);
-			goto put_usb2_hcd;
-		}
-		mtk->phys[phy_num] = phy;
-	}
-
-	ret = xhci_mtk_phy_init(mtk);
-	if (ret)
-		goto put_usb2_hcd;
-
-	ret = xhci_mtk_phy_power_on(mtk);
-	if (ret)
-		goto exit_phys;
-
 	device_init_wakeup(dev, true);
 
 	xhci = hcd_to_xhci(hcd);
@@ -630,7 +544,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 			dev_name(dev), hcd);
 	if (!xhci->shared_hcd) {
 		ret = -ENOMEM;
-		goto power_off_phys;
+		goto disable_device_wakeup;
 	}
 
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
@@ -653,13 +567,9 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	xhci_mtk_sch_exit(mtk);
 	usb_put_hcd(xhci->shared_hcd);
 
-power_off_phys:
-	xhci_mtk_phy_power_off(mtk);
+disable_device_wakeup:
 	device_init_wakeup(dev, false);
 
-exit_phys:
-	xhci_mtk_phy_exit(mtk);
-
 put_usb2_hcd:
 	usb_put_hcd(hcd);
 
@@ -682,8 +592,6 @@ static int xhci_mtk_remove(struct platform_device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 
 	usb_remove_hcd(xhci->shared_hcd);
-	xhci_mtk_phy_power_off(mtk);
-	xhci_mtk_phy_exit(mtk);
 	device_init_wakeup(&dev->dev, false);
 
 	usb_remove_hcd(hcd);
@@ -718,7 +626,6 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 	del_timer_sync(&xhci->shared_hcd->rh_timer);
 
 	xhci_mtk_host_disable(mtk);
-	xhci_mtk_phy_power_off(mtk);
 	xhci_mtk_clks_disable(mtk);
 	usb_wakeup_set(mtk, true);
 	return 0;
@@ -732,7 +639,6 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 
 	usb_wakeup_set(mtk, false);
 	xhci_mtk_clks_enable(mtk);
-	xhci_mtk_phy_power_on(mtk);
 	xhci_mtk_host_enable(mtk);
 
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-- 
2.16.1

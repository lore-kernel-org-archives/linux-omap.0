From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] USB: set device dma_mask without reference to global data
Date: Tue,  7 May 2013 16:53:52 -0600
Message-ID: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Many USB host drivers contain code such as:

if (!pdev->dev.dma_mask)
        pdev->dev.dma_mask = &tegra_ehci_dma_mask;

... where tegra_ehci_dma_mask is a global. I suspect this code originated
in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
was simply copied everywhere else.

This works fine when the code is built-in, but can cause a crash when the
code is in a module. The first module load sets up the dma_mask pointer,
but if the module is removed and re-inserted, the value is now non-NULL,
and hence is not updated to point at the new location, and hence points
at a stale location within the previous module load address, which in
turn causes a crash if the pointer is de-referenced.

The simplest way of solving this seems to be to copy the code from
ehci-platform.c, which uses the coherent_dma_mask as the target for the
dma_mask pointer.

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/usb/chipidea/ci13xxx_imx.c |   15 ++++-----------
 drivers/usb/dwc3/dwc3-exynos.c     |    6 +++---
 drivers/usb/host/ehci-atmel.c      |    6 +++---
 drivers/usb/host/ehci-omap.c       |    8 ++++----
 drivers/usb/host/ehci-orion.c      |    6 +++---
 drivers/usb/host/ehci-s5p.c        |    4 +---
 drivers/usb/host/ehci-spear.c      |    6 +++---
 drivers/usb/host/ehci-tegra.c      |    6 +++---
 drivers/usb/host/ohci-at91.c       |    6 +++---
 drivers/usb/host/ohci-exynos.c     |    4 +---
 drivers/usb/host/ohci-omap3.c      |    8 ++++----
 drivers/usb/host/ohci-pxa27x.c     |    6 +++---
 drivers/usb/host/ohci-spear.c      |    6 +++---
 drivers/usb/host/uhci-platform.c   |    6 +++---
 14 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 8faec9d..73f9d5f 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -173,17 +173,10 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 
 	ci13xxx_imx_platdata.phy = data->phy;
 
-	if (!pdev->dev.dma_mask) {
-		pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
-				      sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask) {
-			ret = -ENOMEM;
-			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
-			goto err;
-		}
-		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
-		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
-	}
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	if (usbmisc_ops && usbmisc_ops->init) {
 		ret = usbmisc_ops->init(&pdev->dev);
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index a8afe6e..929e7dd 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -95,8 +95,6 @@ static int dwc3_exynos_remove_child(struct device *dev, void *unused)
 	return 0;
 }
 
-static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
-
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos;
@@ -118,7 +116,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	 * Once we move to full device tree support this will vanish off.
 	 */
 	if (!dev->dma_mask)
-		dev->dma_mask = &dwc3_exynos_dma_mask;
+		dev->dma_mask = &dev->coherent_dma_mask;
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	platform_set_drvdata(pdev, exynos);
 
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 6642009..02f4611 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -63,8 +63,6 @@ static void atmel_stop_ehci(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static u64 at91_ehci_dma_mask = DMA_BIT_MASK(32);
-
 static int ehci_atmel_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
@@ -93,7 +91,9 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &at91_ehci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 3d1491b..16d7150 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -90,8 +90,6 @@ static const struct ehci_driver_overrides ehci_omap_overrides __initdata = {
 	.extra_priv_size = sizeof(struct omap_hcd),
 };
 
-static u64 omap_ehci_dma_mask = DMA_BIT_MASK(32);
-
 /**
  * ehci_hcd_omap_probe - initialize TI-based HCDs
  *
@@ -146,8 +144,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &omap_ehci_dma_mask;
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, dev,
 			dev_name(dev));
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 54c5794..efbc588 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -137,8 +137,6 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
-static u64 ehci_orion_dma_mask = DMA_BIT_MASK(32);
-
 static int ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
@@ -183,7 +181,9 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 * now. Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &ehci_orion_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	if (!request_mem_region(res->start, resource_size(res),
 				ehci_orion_hc_driver.description)) {
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 6357752..a81465e 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -71,8 +71,6 @@ static void s5p_setup_vbus_gpio(struct platform_device *pdev)
 		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
 }
 
-static u64 ehci_s5p_dma_mask = DMA_BIT_MASK(32);
-
 static int s5p_ehci_probe(struct platform_device *pdev)
 {
 	struct s5p_ehci_platdata *pdata = pdev->dev.platform_data;
@@ -90,7 +88,7 @@ static int s5p_ehci_probe(struct platform_device *pdev)
 	 * Once we move to full device tree support this will vanish off.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &ehci_s5p_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 61ecfb3..bd3e5cb 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -58,8 +58,6 @@ static int ehci_spear_drv_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ehci_spear_pm_ops, ehci_spear_drv_suspend,
 		ehci_spear_drv_resume);
 
-static u64 spear_ehci_dma_mask = DMA_BIT_MASK(32);
-
 static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd ;
@@ -84,7 +82,9 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &spear_ehci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	usbh_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(usbh_clk)) {
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index e3eddc3..59d111b 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -637,8 +637,6 @@ static void tegra_ehci_set_phcd(struct usb_phy *x, bool enable)
 	writel(val, base + TEGRA_USB_PORTSC1);
 }
 
-static u64 tegra_ehci_dma_mask = DMA_BIT_MASK(32);
-
 static int tegra_ehci_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -661,7 +659,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &tegra_ehci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	setup_vbus_gpio(pdev, pdata);
 
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index a0cb44f..2ee1496 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -504,8 +504,6 @@ static const struct of_device_id at91_ohci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, at91_ohci_dt_ids);
 
-static u64 at91_ohci_dma_mask = DMA_BIT_MASK(32);
-
 static int ohci_at91_of_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -522,7 +520,9 @@ static int ohci_at91_of_init(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &at91_ohci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 07592c0..b0b542c 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -98,8 +98,6 @@ static const struct hc_driver exynos_ohci_hc_driver = {
 	.start_port_reset	= ohci_start_port_reset,
 };
 
-static u64 ohci_exynos_dma_mask = DMA_BIT_MASK(32);
-
 static int exynos_ohci_probe(struct platform_device *pdev)
 {
 	struct exynos4_ohci_platdata *pdata = pdev->dev.platform_data;
@@ -117,7 +115,7 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	 * Once we move to full device tree support this will vanish off.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &ohci_exynos_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index ddfc314..8663851 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -114,8 +114,6 @@ static const struct hc_driver ohci_omap3_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static u64 omap_ohci_dma_mask = DMA_BIT_MASK(32);
-
 /*
  * configure so an HC device and id are always provided
  * always called with process context; sleeping is OK
@@ -168,8 +166,10 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &omap_ohci_dma_mask;
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	hcd = usb_create_hcd(&ohci_omap3_hc_driver, dev,
 			dev_name(dev));
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index efe71f3..279b2ef 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -282,8 +282,6 @@ static const struct of_device_id pxa_ohci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, pxa_ohci_dt_ids);
 
-static u64 pxa_ohci_dma_mask = DMA_BIT_MASK(32);
-
 static int ohci_pxa_of_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -298,7 +296,9 @@ static int ohci_pxa_of_init(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pxa_ohci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 9020bf0..3e19e01 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -91,8 +91,6 @@ static const struct hc_driver ohci_spear_hc_driver = {
 	.start_port_reset	= ohci_start_port_reset,
 };
 
-static u64 spear_ohci_dma_mask = DMA_BIT_MASK(32);
-
 static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 {
 	const struct hc_driver *driver = &ohci_spear_hc_driver;
@@ -114,7 +112,9 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &spear_ohci_dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	usbh_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(usbh_clk)) {
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 8c4dace..f1db61a 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -60,8 +60,6 @@ static const struct hc_driver uhci_platform_hc_driver = {
 	.hub_control =		uhci_hub_control,
 };
 
-static u64 platform_uhci_dma_mask = DMA_BIT_MASK(32);

From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RESEND PATCH 07/11] ARM: OMAP: USB: Host: Ehci driver uses the usbhs port data
Date: Wed, 31 Oct 2012 19:56:48 +0530
Message-ID: <1351693612-23314-8-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, b-cousson@ti.com
List-Id: linux-omap@vger.kernel.org

The usbhs core driver data is used by the ehci driver, because
the ehci driver is child of usbhs core. The unused ehci, ohci
and tll specific structures are removed.
platform device creation of usbhs and tll using hwmod is
removed.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/usb-host.c         |   66 --------------------------------
 drivers/usb/host/ehci-omap.c           |   40 ++++++++++---------
 include/linux/platform_data/usb-omap.h |   16 --------
 3 files changed, 21 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 239c175..75fa7ca 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -32,24 +32,6 @@
 
 #ifdef CONFIG_MFD_OMAP_USB_HOST
 
-#define OMAP_USBHS_DEVICE	"usbhs_omap"
-#define OMAP_USBTLL_DEVICE	"usbhs_tll"
-#define	USBHS_UHH_HWMODNAME	"usb_host_hs"
-#define USBHS_TLL_HWMODNAME	"usb_tll_hs"
-
-static struct usbhs_omap_platform_data		usbhs_data;
-static struct usbtll_omap_platform_data		usbtll_data;
-static struct ehci_hcd_omap_platform_data	ehci_data;
-static struct ohci_hcd_omap_platform_data	ohci_data;
-
-static struct omap_device_pm_latency omap_uhhtll_latency[] = {
-	  {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	  },
-};
-
 /* MUX settings for EHCI pins */
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
@@ -487,22 +469,6 @@ void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
-	struct omap_hwmod	*uhh_hwm, *tll_hwm;
-	struct platform_device	*pdev;
-	int			bus_id = -1;
-	int			i;
-
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
-		usbhs_data.port_mode[i] = pdata->port_mode[i];
-		usbtll_data.port_mode[i] = pdata->port_mode[i];
-		ohci_data.port_mode[i] = pdata->port_mode[i];
-		ehci_data.port_mode[i] = pdata->port_mode[i];
-		ehci_data.reset_gpio_port[i] = pdata->reset_gpio_port[i];
-		ehci_data.regulator[i] = pdata->regulator[i];
-	}
-	ehci_data.phy_reset = pdata->phy_reset;
-	ohci_data.es2_compatibility = pdata->es2_compatibility;
-
 	if (cpu_is_omap34xx()) {
 		setup_ehci_io_mux(pdata->port_mode);
 		setup_ohci_io_mux(pdata->port_mode);
@@ -510,38 +476,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 		setup_4430ehci_io_mux(pdata->port_mode);
 		setup_4430ohci_io_mux(pdata->port_mode);
 	}
-
-	uhh_hwm = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
-	if (!uhh_hwm) {
-		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
-		return;
-	}
-
-	tll_hwm = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
-	if (!tll_hwm) {
-		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
-		return;
-	}
-
-	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
-				&usbtll_data, sizeof(usbtll_data),
-				omap_uhhtll_latency,
-				ARRAY_SIZE(omap_uhhtll_latency), false);
-	if (IS_ERR(pdev)) {
-		pr_err("Could not build hwmod device %s\n",
-		       USBHS_TLL_HWMODNAME);
-		return;
-	}
-
-	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
-				&usbhs_data, sizeof(usbhs_data),
-				omap_uhhtll_latency,
-				ARRAY_SIZE(omap_uhhtll_latency), false);
-	if (IS_ERR(pdev)) {
-		pr_err("Could not build hwmod devices %s\n",
-		       USBHS_UHH_HWMODNAME);
-		return;
-	}
 }
 
 #else
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 0d5ac36..a4d57b4 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -107,17 +107,17 @@ static int omap_ehci_init(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	int			rc;
-	struct ehci_hcd_omap_platform_data	*pdata;
+	struct usbhs_omap_platform_data	*pdata;
 
-	pdata = hcd->self.controller->platform_data;
+	pdata = hcd->self.controller->parent->platform_data;
 
 	/* Hold PHYs in reset while initializing EHCI controller */
 	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
+		if (gpio_is_valid(pdata->reset_gpio[0]))
+			gpio_set_value_cansleep(pdata->reset_gpio[0], 0);
 
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
+		if (gpio_is_valid(pdata->reset_gpio[1]))
+			gpio_set_value_cansleep(pdata->reset_gpio[1], 0);
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
 		udelay(10);
@@ -140,11 +140,11 @@ static int omap_ehci_init(struct usb_hcd *hcd)
 		 */
 		udelay(10);
 
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
+		if (gpio_is_valid(pdata->reset_gpio[0]))
+			gpio_set_value_cansleep(pdata->reset_gpio[0], 1);
 
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
+		if (gpio_is_valid(pdata->reset_gpio[1]))
+			gpio_set_value_cansleep(pdata->reset_gpio[1], 1);
 	}
 
 	/* root ports should always stay powered */
@@ -154,7 +154,7 @@ static int omap_ehci_init(struct usb_hcd *hcd)
 }
 
 static void disable_put_regulator(
-		struct ehci_hcd_omap_platform_data *pdata)
+		struct usbhs_omap_platform_data *pdata)
 {
 	int i;
 
@@ -179,7 +179,7 @@ static void disable_put_regulator(
 static int ehci_hcd_omap_probe(struct platform_device *pdev)
 {
 	struct device				*dev = &pdev->dev;
-	struct ehci_hcd_omap_platform_data	*pdata = dev->platform_data;
+	struct usbhs_omap_platform_data		*pdata;
 	struct resource				*res;
 	struct usb_hcd				*hcd;
 	void __iomem				*regs;
@@ -196,6 +196,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	pdata = dev->parent->platform_data;
+
 	irq = platform_get_irq_byname(pdev, "ehci-irq");
 	if (irq < 0) {
 		dev_err(dev, "EHCI irq failed\n");
@@ -289,9 +291,9 @@ err_io:
  */
 static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
-	struct device *dev				= &pdev->dev;
-	struct usb_hcd *hcd				= dev_get_drvdata(dev);
-	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;
+	struct device			*dev = &pdev->dev;
+	struct usb_hcd			*hcd = dev_get_drvdata(dev);
+	struct usbhs_omap_platform_data *pdata	= dev->platform_data;
 
 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
@@ -302,11 +304,11 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 
 	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_free(pdata->reset_gpio_port[0]);
+		if (gpio_is_valid(pdata->reset_gpio[0]))
+			gpio_free(pdata->reset_gpio[0]);
 
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_free(pdata->reset_gpio_port[1]);
+		if (gpio_is_valid(pdata->reset_gpio[1]))
+			gpio_free(pdata->reset_gpio[1]);
 	}
 	return 0;
 }
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index 3ad2d8a..b352bfc 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -38,22 +38,6 @@ enum usbhs_omap_port_mode {
 	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
 };
 
-struct usbtll_omap_platform_data {
-	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
-};
-
-struct ehci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
-	unsigned			phy_reset:1;
-};
-
-struct ohci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			es2_compatibility:1;
-};
-
 struct usbhs_omap_platform_data {
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	int				reset_gpio[OMAP3_HS_USB_PORTS];
-- 
1.7.9.5


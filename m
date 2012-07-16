From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V4 4/5] ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
Date: Mon, 16 Jul 2012 19:01:10 +0530
Message-ID: <1342445471-18704-5-git-send-email-keshava_mgowda@ti.com>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342445471-18704-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The TLL specific code such as channels clocks enable/disable,
initialization functions are removed from the USBHS core
driver. The hwmod of the usb tll is retrieved and omap device
build is performed to created the platform device for the
usb tll component.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c |   31 ++++--
 drivers/mfd/omap-usb-host.c    |  231 ++--------------------------------------
 2 files changed, 32 insertions(+), 230 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index dde8a11..b2a2dd7 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -35,10 +35,12 @@
 #ifdef CONFIG_MFD_OMAP_USB_HOST
 
 #define OMAP_USBHS_DEVICE	"usbhs_omap"
+#define OMAP_USBTLL_DEVICE	"usbhs_tll"
 #define	USBHS_UHH_HWMODNAME	"usb_host_hs"
 #define USBHS_TLL_HWMODNAME	"usb_tll_hs"
 
 static struct usbhs_omap_platform_data		usbhs_data;
+static struct usbtll_omap_platform_data		usbtll_data;
 static struct ehci_hcd_omap_platform_data	ehci_data;
 static struct ohci_hcd_omap_platform_data	ohci_data;
 
@@ -487,13 +489,14 @@ void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
-	struct omap_hwmod	*oh[2];
+	struct omap_hwmod	*uhh_hwm, *tll_hwm;
 	struct platform_device	*pdev;
 	int			bus_id = -1;
 	int			i;
 
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
 		usbhs_data.port_mode[i] = pdata->port_mode[i];
+		usbtll_data.port_mode[i] = pdata->port_mode[i];
 		ohci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.reset_gpio_port[i] = pdata->reset_gpio_port[i];
@@ -512,25 +515,35 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 		setup_4430ohci_io_mux(pdata->port_mode);
 	}
 
-	oh[0] = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
-	if (!oh[0]) {
+	uhh_hwm = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
+	if (!uhh_hwm) {
 		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
 		return;
 	}
 
-	oh[1] = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
-	if (!oh[1]) {
+	tll_hwm = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
+	if (!tll_hwm) {
 		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
 		return;
 	}
 
-	pdev = omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 2,
-				(void *)&usbhs_data, sizeof(usbhs_data),
+	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
+				&usbtll_data, sizeof(usbtll_data),
 				omap_uhhtll_latency,
 				ARRAY_SIZE(omap_uhhtll_latency), false);
 	if (IS_ERR(pdev)) {
-		pr_err("Could not build hwmod devices %s,%s\n",
-			USBHS_UHH_HWMODNAME, USBHS_TLL_HWMODNAME);
+		pr_err("Could not build hwmod device %s\n",
+		       USBHS_TLL_HWMODNAME);
+		return;
+	}
+
+	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
+				&usbhs_data, sizeof(usbhs_data),
+				omap_uhhtll_latency,
+				ARRAY_SIZE(omap_uhhtll_latency), false);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build hwmod devices %s\n",
+		       USBHS_UHH_HWMODNAME);
 		return;
 	}
 }
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 8a256df..23cec57 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -35,63 +35,6 @@
 
 /* OMAP USBHOST Register addresses  */
 
-/* TLL Register Set */
-#define	OMAP_USBTLL_REVISION				(0x00)
-#define	OMAP_USBTLL_SYSCONFIG				(0x10)
-#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY			(1 << 8)
-#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE			(1 << 3)
-#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP			(1 << 2)
-#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET			(1 << 1)
-#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE			(1 << 0)
-
-#define	OMAP_USBTLL_SYSSTATUS				(0x14)
-#define	OMAP_USBTLL_SYSSTATUS_RESETDONE			(1 << 0)
-
-#define	OMAP_USBTLL_IRQSTATUS				(0x18)
-#define	OMAP_USBTLL_IRQENABLE				(0x1C)
-
-#define	OMAP_TLL_SHARED_CONF				(0x30)
-#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
-#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
-#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
-#define	OMAP_TLL_SHARED_CONF_FCLK_REQ			(1 << 1)
-#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
-
-#define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
-#define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
-#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
-#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
-#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
-#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
-#define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
-#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
-
-#define OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0		0x0
-#define OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM		0x1
-#define OMAP_TLL_FSLSMODE_3PIN_PHY			0x2
-#define OMAP_TLL_FSLSMODE_4PIN_PHY			0x3
-#define OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0		0x4
-#define OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM		0x5
-#define OMAP_TLL_FSLSMODE_3PIN_TLL			0x6
-#define OMAP_TLL_FSLSMODE_4PIN_TLL			0x7
-#define OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0		0xA
-#define OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM		0xB
-
-#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)		(0x804 + 0x100 * num)
-#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)		(0x807 + 0x100 * num)
-#define	OMAP_TLL_ULPI_OTG_CTRL(num)			(0x80A + 0x100 * num)
-#define	OMAP_TLL_ULPI_INT_EN_RISE(num)			(0x80D + 0x100 * num)
-#define	OMAP_TLL_ULPI_INT_EN_FALL(num)			(0x810 + 0x100 * num)
-#define	OMAP_TLL_ULPI_INT_STATUS(num)			(0x813 + 0x100 * num)
-#define	OMAP_TLL_ULPI_INT_LATCH(num)			(0x814 + 0x100 * num)
-#define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
-#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
-
-#define OMAP_TLL_CHANNEL_COUNT				3
-#define OMAP_TLL_CHANNEL_1_EN_MASK			(1 << 0)
-#define OMAP_TLL_CHANNEL_2_EN_MASK			(1 << 1)
-#define OMAP_TLL_CHANNEL_3_EN_MASK			(1 << 2)
-
 /* UHH Register Set */
 #define	OMAP_UHH_REVISION				(0x00)
 #define	OMAP_UHH_SYSCONFIG				(0x10)
@@ -131,8 +74,6 @@
 #define OMAP4_P2_MODE_TLL				(1 << 18)
 #define OMAP4_P2_MODE_HSIC				(3 << 18)
 
-#define OMAP_REV2_TLL_CHANNEL_COUNT			2
-
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
 /* Values of UHH_REVISION - Note: these are not given in the TRM */
@@ -152,15 +93,12 @@ struct usbhs_hcd_omap {
 	struct clk			*xclk60mhsp2_ck;
 	struct clk			*utmi_p1_fck;
 	struct clk			*usbhost_p1_fck;
-	struct clk			*usbtll_p1_fck;
 	struct clk			*utmi_p2_fck;
 	struct clk			*usbhost_p2_fck;
-	struct clk			*usbtll_p2_fck;
 	struct clk			*init_60m_fclk;
 	struct clk			*ehci_logic_fck;
 
 	void __iomem			*uhh_base;
-	void __iomem			*tll_base;
 
 	struct usbhs_omap_platform_data	platdata;
 
@@ -335,93 +273,6 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 	}
 }
 
-/*
- * convert the port-mode enum to a value we can use in the FSLSMODE
- * field of USBTLL_CHANNEL_CONF
- */
-static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
-{
-	switch (mode) {
-	case OMAP_USBHS_PORT_MODE_UNUSED:
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
-		return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
-
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
-		return OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM;
-
-	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
-		return OMAP_TLL_FSLSMODE_3PIN_PHY;
-
-	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
-		return OMAP_TLL_FSLSMODE_4PIN_PHY;
-
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
-		return OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0;
-
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
-		return OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM;
-
-	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
-		return OMAP_TLL_FSLSMODE_3PIN_TLL;
-
-	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
-		return OMAP_TLL_FSLSMODE_4PIN_TLL;
-
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
-		return OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0;
-
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
-		return OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM;
-	default:
-		pr_warning("Invalid port mode, using default\n");
-		return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
-	}
-}
-
-static void usbhs_omap_tll_init(struct device *dev, u8 tll_channel_count)
-{
-	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
-	unsigned			reg;
-	int				i;
-
-	/* Program Common TLL register */
-	reg = usbhs_read(omap->tll_base, OMAP_TLL_SHARED_CONF);
-	reg |= (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
-		| OMAP_TLL_SHARED_CONF_USB_DIVRATION);
-	reg &= ~OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN;
-	reg &= ~OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN;
-
-	usbhs_write(omap->tll_base, OMAP_TLL_SHARED_CONF, reg);
-
-	/* Enable channels now */
-	for (i = 0; i < tll_channel_count; i++) {
-		reg = usbhs_read(omap->tll_base,
-				OMAP_TLL_CHANNEL_CONF(i));
-
-		if (is_ohci_port(pdata->port_mode[i])) {
-			reg |= ohci_omap3_fslsmode(pdata->port_mode[i])
-				<< OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
-			reg |= OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
-		} else if (pdata->port_mode[i] == OMAP_EHCI_PORT_MODE_TLL) {
-
-			/* Disable AutoIdle, BitStuffing and use SDR Mode */
-			reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
-				| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
-				| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
-
-		} else
-			continue;
-
-		reg |= OMAP_TLL_CHANNEL_CONF_CHANEN;
-		usbhs_write(omap->tll_base,
-				OMAP_TLL_CHANNEL_CONF(i), reg);
-
-		usbhs_writeb(omap->tll_base,
-				OMAP_TLL_ULPI_SCRATCH_REGISTER(i), 0xbe);
-	}
-}
-
 static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
@@ -441,14 +292,11 @@ static int usbhs_runtime_resume(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0])) {
+	if (is_ehci_tll_mode(pdata->port_mode[0]))
 		clk_enable(omap->usbhost_p1_fck);
-		clk_enable(omap->usbtll_p1_fck);
-	}
-	if (is_ehci_tll_mode(pdata->port_mode[1])) {
+	if (is_ehci_tll_mode(pdata->port_mode[1]))
 		clk_enable(omap->usbhost_p2_fck);
-		clk_enable(omap->usbtll_p2_fck);
-	}
+
 	clk_enable(omap->utmi_p1_fck);
 	clk_enable(omap->utmi_p2_fck);
 
@@ -472,14 +320,11 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&omap->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0])) {
+	if (is_ehci_tll_mode(pdata->port_mode[0]))
 		clk_disable(omap->usbhost_p1_fck);
-		clk_disable(omap->usbtll_p1_fck);
-	}
-	if (is_ehci_tll_mode(pdata->port_mode[1])) {
+	if (is_ehci_tll_mode(pdata->port_mode[1]))
 		clk_disable(omap->usbhost_p2_fck);
-		clk_disable(omap->usbtll_p2_fck);
-	}
+
 	clk_disable(omap->utmi_p2_fck);
 	clk_disable(omap->utmi_p1_fck);
 
@@ -501,8 +346,6 @@ static void omap_usbhs_init(struct device *dev)
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 
-	pm_runtime_get_sync(dev);
-
 	if (pdata->ehci_data->phy_reset) {
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
 			gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
@@ -516,6 +359,7 @@ static void omap_usbhs_init(struct device *dev)
 		udelay(10);
 	}
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&omap->lock, flags);
 	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
 	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
@@ -581,22 +425,9 @@ static void omap_usbhs_init(struct device *dev)
 	usbhs_write(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 	dev_dbg(dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
-		is_ehci_tll_mode(pdata->port_mode[1]) ||
-		is_ehci_tll_mode(pdata->port_mode[2]) ||
-		(is_ohci_port(pdata->port_mode[0])) ||
-		(is_ohci_port(pdata->port_mode[1])) ||
-		(is_ohci_port(pdata->port_mode[2]))) {
-
-		/* Enable UTMI mode for required TLL channels */
-		if (is_omap_usbhs_rev2(omap))
-			usbhs_omap_tll_init(dev, OMAP_REV2_TLL_CHANNEL_COUNT);
-		else
-			usbhs_omap_tll_init(dev, OMAP_TLL_CHANNEL_COUNT);
-	}
-
 	spin_unlock_irqrestore(&omap->lock, flags);
 
+	pm_runtime_put_sync(dev);
 	if (pdata->ehci_data->phy_reset) {
 		/* Hold the PHY in RESET for enough time till
 		 * PHY is settled and ready
@@ -611,8 +442,6 @@ static void omap_usbhs_init(struct device *dev)
 			gpio_set_value_cansleep
 				(pdata->ehci_data->reset_gpio_port[1], 1);
 	}
-
-	pm_runtime_put_sync(dev);
 }
 
 static void omap_usbhs_deinit(struct device *dev)
@@ -715,32 +544,18 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_xclk60mhsp2_ck;
 	}
 
-	omap->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
-	if (IS_ERR(omap->usbtll_p1_fck)) {
-		ret = PTR_ERR(omap->usbtll_p1_fck);
-		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
-		goto err_usbhost_p1_fck;
-	}
-
 	omap->usbhost_p2_fck = clk_get(dev, "usb_host_hs_utmi_p2_clk");
 	if (IS_ERR(omap->usbhost_p2_fck)) {
 		ret = PTR_ERR(omap->usbhost_p2_fck);
 		dev_err(dev, "usbhost_p2_fck failed error:%d\n", ret);
-		goto err_usbtll_p1_fck;
-	}
-
-	omap->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
-	if (IS_ERR(omap->usbtll_p2_fck)) {
-		ret = PTR_ERR(omap->usbtll_p2_fck);
-		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
-		goto err_usbhost_p2_fck;
+		goto err_usbhost_p1_fck;
 	}
 
 	omap->init_60m_fclk = clk_get(dev, "init_60m_fclk");
 	if (IS_ERR(omap->init_60m_fclk)) {
 		ret = PTR_ERR(omap->init_60m_fclk);
 		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
-		goto err_usbtll_p2_fck;
+		goto err_usbhost_p2_fck;
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
@@ -786,20 +601,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_init_60m_fclk;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tll");
-	if (!res) {
-		dev_err(dev, "UHH EHCI get resource failed\n");
-		ret = -ENODEV;
-		goto err_tll;
-	}
-
-	omap->tll_base = ioremap(res->start, resource_size(res));
-	if (!omap->tll_base) {
-		dev_err(dev, "TLL ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_tll;
-	}
-
 	platform_set_drvdata(pdev, omap);
 
 	omap_usbhs_init(dev);
@@ -813,23 +614,14 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
-	iounmap(omap->tll_base);
-
-err_tll:
 	iounmap(omap->uhh_base);
 
 err_init_60m_fclk:
 	clk_put(omap->init_60m_fclk);
 
-err_usbtll_p2_fck:
-	clk_put(omap->usbtll_p2_fck);
-
 err_usbhost_p2_fck:
 	clk_put(omap->usbhost_p2_fck);
 
-err_usbtll_p1_fck:
-	clk_put(omap->usbtll_p1_fck);

From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5 RESEND] ARM: OMAP: USB: Remove TLL specific code
Date: Mon, 19 Mar 2012 12:18:33 +0530
Message-ID: <1332139715-1495-4-git-send-email-keshava_mgowda@ti.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-3-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332139715-1495-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The TLL specific code such as channels clocks enable/disable,
initialization functions are removed from the USBHS core
driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |  225 ++-----------------------------------------
 1 files changed, 8 insertions(+), 217 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 9927129..4de87c6 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -34,63 +34,6 @@
 
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
@@ -130,8 +73,6 @@
 #define OMAP4_P2_MODE_TLL				(1 << 18)
 #define OMAP4_P2_MODE_HSIC				(3 << 18)
 
-#define OMAP_REV2_TLL_CHANNEL_COUNT			2
-
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
 /* Values of UHH_REVISION - Note: these are not given in the TRM */
@@ -151,15 +92,12 @@ struct usbhs_hcd_omap {
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
 
@@ -334,93 +272,6 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
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
@@ -439,14 +290,11 @@ static int usbhs_runtime_resume(struct device *dev)
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
 
@@ -470,14 +318,11 @@ static int usbhs_runtime_suspend(struct device *dev)
 
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
 
@@ -565,20 +410,6 @@ static void omap_usbhs_init(struct device *dev)
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
 	pm_runtime_put_sync(dev);
 }
@@ -669,32 +500,18 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
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
@@ -740,20 +557,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
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
 
 	ret = omap_usbhs_alloc_children(pdev);
@@ -767,23 +570,14 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	goto end_probe;
 
 err_alloc:
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

From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/8] ehci: portwise configurations
Date: Fri, 10 Jul 2009 14:47:12 +0530
Message-ID: <1247217434-6309-6-git-send-email-ajay.gupta@ti.com>
References: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-3-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-4-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-5-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41147 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbZGJJR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jul 2009 05:17:29 -0400
In-Reply-To: <1247217434-6309-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

OMAP3 EHCI has three ports and we can configure port modes
(PHY/TLL) on per port basis in silicon version ES3.0 onwards.

This patch modifies the existing EHCI driver to accomodate
portwise mode configuration.

Changes being done:

        - Pass platform_data pointer as parameter to usb_ehci_init()
          to avoid multiple parameters.
        - Use platform_data pointer in usb-ehci.c as platform_data
          directly without copying it to another *pdata*.
        - Initializing platform_data in all platform files with
          platform specific ehci parameters.
        - Added port_mode[OMAP_HS_USB_PORTS]in platform_data
          structures.This allows to setup mux pins on per port basis.
        - Added phy_reset_gpio[OMAP_HS_USB_PORTS].

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   15 +++++-
 arch/arm/mach-omap2/board-omap3beagle.c  |   15 +++++-
 arch/arm/mach-omap2/board-omap3evm.c     |   15 +++++-
 arch/arm/mach-omap2/board-omap3pandora.c |   15 +++++-
 arch/arm/mach-omap2/usb-ehci.c           |   95 +++++++++++++++---------------
 arch/arm/plat-omap/include/mach/usb.h    |   12 ++--
 drivers/usb/host/ehci-omap.c             |   63 +++++++++++---------
 7 files changed, 145 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 21b4a52..4d7a176 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -478,6 +478,19 @@ static inline void board_smc91x_init(void)
 
 #endif
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.chargepump = true,
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 57,
+	.reset_gpio_port[1]  = 61,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -495,7 +508,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
+	usb_ehci_init(&ehci_pdata);
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..1868e56 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -392,6 +392,19 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.chargepump = true,
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 57,
+	.reset_gpio_port[1]  = 61,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -407,7 +420,7 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);
 
 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
+	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b497979..d2477e7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -295,6 +295,19 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.chargepump = false,
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 135,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -310,7 +323,7 @@ static void __init omap3_evm_init(void)
 	usb_musb_init();
 	/* Setup EHCI phy reset padconfig */
 	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, -EINVAL, 135);
+	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 85cc2a7..5b20b3d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -384,6 +384,19 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 };
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.chargepump = false,
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 16,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
@@ -395,7 +408,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 16, -EINVAL);
+	usb_ehci_init(&ehci_pdata);
 	pandora_keys_gpio_init();
 	usb_musb_init();
 }
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 53e6e85..3af3236 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -68,14 +68,10 @@ static struct platform_device ehci_device = {
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
  */
-static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
+static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 {
-	if (phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
-		/* PHY mode of operation for board: 750-2083-001
-		 * ISP1504 connected to Port1 and Port2
-		 * Do Func Mux setting for 12-pin ULPI PHY mode
-		 */
-		/* Port1 */
+	switch (port_mode[0]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
 		omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
 		omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
 		omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
@@ -88,28 +84,8 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
 		omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
 		omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
 		omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
-
-		/* Port2 */
-		omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
-		omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
-		omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
-		omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
-		omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
-		omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
-		omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
-		omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
-		omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
-		omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
-		omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
-		omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
-
-	} else {
-		/* Set Func mux for :
-		 * TLL mode of operation
-		 * 12-pin ULPI SDR TLL mode for Port1/2/3
-		 */
-
-		/* Port1 */
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
 		omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
 		omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
 		omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
@@ -122,8 +98,29 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
 		omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
 		omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
 		omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
 
-		/* Port2 */
+	switch (port_mode[1]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		omap_cfg_reg(AA10_3430_USB2HS_PHY_STP);
+		omap_cfg_reg(AA8_3430_USB2HS_PHY_CLK);
+		omap_cfg_reg(AA9_3430_USB2HS_PHY_DIR);
+		omap_cfg_reg(AB11_3430_USB2HS_PHY_NXT);
+		omap_cfg_reg(AB10_3430_USB2HS_PHY_DATA0);
+		omap_cfg_reg(AB9_3430_USB2HS_PHY_DATA1);
+		omap_cfg_reg(W3_3430_USB2HS_PHY_DATA2);
+		omap_cfg_reg(T4_3430_USB2HS_PHY_DATA3);
+		omap_cfg_reg(T3_3430_USB2HS_PHY_DATA4);
+		omap_cfg_reg(R3_3430_USB2HS_PHY_DATA5);
+		omap_cfg_reg(R4_3430_USB2HS_PHY_DATA6);
+		omap_cfg_reg(T2_3430_USB2HS_PHY_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
 		omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
 		omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
 		omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
@@ -136,8 +133,18 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
 		omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
 		omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
 		omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
 
-		/* Port3 */
+	switch (port_mode[2]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		printk(KERN_WARNING "Port3 can't be used in PHY mode\n");
+		break;
+	case EHCI_HCD_OMAP_MODE_TLL:
 		omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
 		omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
 		omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
@@ -150,28 +157,23 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode phy_mode)
 		omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
 		omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
 		omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
 	}
 
 	return;
 }
 
-static struct ehci_hcd_omap_platform_data pdata __initconst;
-
-void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
-		int chargepump, int phy_reset, int reset_gpio_port1,
-		int reset_gpio_port2)
+void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
 {
-	pdata.phy_mode		= phy_mode;
-	pdata.chargepump	= chargepump;
-	pdata.phy_reset		= phy_reset;
-	pdata.reset_gpio_port1	= reset_gpio_port1;
-	pdata.reset_gpio_port2	= reset_gpio_port2;
-
-	platform_device_add_data(&ehci_device, &pdata, sizeof(pdata));
+	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
 	/* Setup Pin IO MUX for EHCI */
 	if (cpu_is_omap34xx())
-		setup_ehci_io_mux(phy_mode);
+		setup_ehci_io_mux(pdata->port_mode);
 
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
@@ -181,9 +183,8 @@ void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
 
 #else
 
-void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
-		int chargepump, int phy_reset, int reset_gpio_port1,
-		int reset_gpio_port2)
+void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+
 {
 }
 
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index 1b1366c..d1b14cc 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -5,6 +5,7 @@
 
 #include <mach/board.h>
 
+#define OMAP3_HS_USB_PORTS	3
 enum ehci_hcd_omap_mode {
 	EHCI_HCD_OMAP_MODE_UNKNOWN,
 	EHCI_HCD_OMAP_MODE_PHY,
@@ -12,13 +13,12 @@ enum ehci_hcd_omap_mode {
 };
 
 struct ehci_hcd_omap_platform_data {
-	enum ehci_hcd_omap_mode		phy_mode;
+	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
 	unsigned			chargepump:1;
 	unsigned			phy_reset:1;
 
-	/* have to be valid if phy_reset is true */
-	int				reset_gpio_port1;
-	int				reset_gpio_port2;
+	/* have to be valid if phy_reset is true and portx is in phy mode */
+	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
 };
 
 /*-------------------------------------------------------------------------*/
@@ -45,9 +45,7 @@ struct ehci_hcd_omap_platform_data {
 
 extern void usb_musb_init(void);
 
-extern void usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
-		int chargepump, int phy_reset, int reset_gpio_port1,
-		int reset_gpio_port2);
+extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
 
 #endif
 
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e7d0898..e64ba9f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -163,8 +163,7 @@ struct ehci_hcd_omap {
 	 */
 
 	/* gpio for resetting phy */
-	int			reset_gpio_port1;
-	int			reset_gpio_port2;
+	int			reset_gpio_port[OMAP3_HS_USB_PORTS];
 
 	/* phy reset workaround */
 	int			phy_reset;
@@ -173,7 +172,7 @@ struct ehci_hcd_omap {
 	int			chargepump;
 
 	/* desired phy_mode: TLL, PHY */
-	enum ehci_hcd_omap_mode	phy_mode;
+	enum ehci_hcd_omap_mode	port_mode[OMAP3_HS_USB_PORTS];
 
 	void __iomem		*uhh_base;
 	void __iomem		*tll_base;
@@ -298,14 +297,16 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	if (omap->phy_reset) {
 		/* Refer: ISSUE1 */
-		if (gpio_is_valid(omap->reset_gpio_port1)) {
-			gpio_request(omap->reset_gpio_port1, "USB1 PHY reset");
-			gpio_direction_output(omap->reset_gpio_port1, 0);
+		if (gpio_is_valid(omap->reset_gpio_port[0])) {
+			gpio_request(omap->reset_gpio_port[0],
+						"USB1 PHY reset");
+			gpio_direction_output(omap->reset_gpio_port[0], 0);
 		}
 
-		if (gpio_is_valid(omap->reset_gpio_port2)) {
-			gpio_request(omap->reset_gpio_port2, "USB2 PHY reset");
-			gpio_direction_output(omap->reset_gpio_port2, 0);
+		if (gpio_is_valid(omap->reset_gpio_port[1])) {
+			gpio_request(omap->reset_gpio_port[1],
+						"USB2 PHY reset");
+			gpio_direction_output(omap->reset_gpio_port[1], 0);
 		}
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
@@ -362,7 +363,10 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
-	if (omap->phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
+	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
+		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
+		(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)) {
+
 		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 
 		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
@@ -375,7 +379,9 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 		dev_dbg(omap->dev, "Entered ULPI PHY MODE: success\n");
 
-	} else if (omap->phy_mode == EHCI_HCD_OMAP_MODE_TLL) {
+	} else if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
+		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
+		(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)) {
 
 		/* Enable UTMI mode for all 3 TLL channels */
 		omap_usb_utmi_init(omap,
@@ -397,11 +403,11 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		 */
 		udelay(10);
 
-		if (gpio_is_valid(omap->reset_gpio_port1))
-			gpio_set_value(omap->reset_gpio_port1, 1);
+		if (gpio_is_valid(omap->reset_gpio_port[0]))
+			gpio_set_value(omap->reset_gpio_port[0], 1);
 
-		if (gpio_is_valid(omap->reset_gpio_port2))
-			gpio_set_value(omap->reset_gpio_port2, 1);
+		if (gpio_is_valid(omap->reset_gpio_port[1]))
+			gpio_set_value(omap->reset_gpio_port[1], 1);
 	}
 
 	if (omap->chargepump) {
@@ -439,11 +445,11 @@ err_tll_fck:
 	clk_put(omap->usbhost1_48m_fck);
 
 	if (omap->phy_reset) {
-		if (gpio_is_valid(omap->reset_gpio_port1))
-			gpio_free(omap->reset_gpio_port1);
+		if (gpio_is_valid(omap->reset_gpio_port[0]))
+			gpio_free(omap->reset_gpio_port[0]);
 
-		if (gpio_is_valid(omap->reset_gpio_port2))
-			gpio_free(omap->reset_gpio_port2);
+		if (gpio_is_valid(omap->reset_gpio_port[1]))
+			gpio_free(omap->reset_gpio_port[1]);
 	}
 
 err_host_48m_fck:
@@ -532,11 +538,11 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 
 	if (omap->phy_reset) {
-		if (gpio_is_valid(omap->reset_gpio_port1))
-			gpio_free(omap->reset_gpio_port1);
+		if (gpio_is_valid(omap->reset_gpio_port[0]))
+			gpio_free(omap->reset_gpio_port[0]);
 
-		if (gpio_is_valid(omap->reset_gpio_port2))
-			gpio_free(omap->reset_gpio_port2);
+		if (gpio_is_valid(omap->reset_gpio_port[1]))
+			gpio_free(omap->reset_gpio_port[1]);
 	}
 
 	dev_dbg(omap->dev, "Clock to USB host has been disabled\n");
@@ -591,10 +597,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	omap->dev		= &pdev->dev;
 	omap->phy_reset		= pdata->phy_reset;
-	omap->reset_gpio_port1	= pdata->reset_gpio_port1;
-	omap->reset_gpio_port2	= pdata->reset_gpio_port2;
-	omap->phy_mode		= pdata->phy_mode;
-	omap->chargepump	= pdata->chargepump;
+	omap->reset_gpio_port[0]	= pdata->reset_gpio_port[0];
+	omap->reset_gpio_port[1]	= pdata->reset_gpio_port[1];
+	omap->reset_gpio_port[2]	= pdata->reset_gpio_port[2];
+	omap->port_mode[0]		= pdata->port_mode[0];
+	omap->port_mode[1]		= pdata->port_mode[1];
+	omap->port_mode[2]		= pdata->port_mode[2];
+	omap->chargepump		= pdata->chargepump;
 	omap->ehci		= hcd_to_ehci(hcd);
 	omap->ehci->sbrn	= 0x20;
 
-- 
1.6.2.4


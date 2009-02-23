From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 16/23] usb: host: ehci: add platform_data
Date: Mon, 23 Feb 2009 20:55:28 +0200
Message-ID: <1235415335-17408-17-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43131 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbZBWTAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:00:07 -0500
In-Reply-To: <1235415335-17408-16-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Adding a platform_data to the driver allow us
to remove some of the ifdeferry in the code.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/board-overo.c        |    2 +-
 arch/arm/mach-omap2/usb-ehci.c           |   14 +-
 arch/arm/plat-omap/include/mach/usb.h    |   24 ++-
 drivers/usb/host/Kconfig                 |   19 --
 drivers/usb/host/ehci-omap.c             |  401 +++++++++++++++---------------
 9 files changed, 241 insertions(+), 227 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 758183c..3f85c6e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -643,7 +643,7 @@ static void __init omap_3430sdp_init(void)
 	msecure_init();
 	omap_serial_init();
 	usb_musb_init();
-	usb_ehci_init();
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5f5cc39..18d9a86 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -380,7 +380,7 @@ static void __init omap3_beagle_init(void)
 	gpio_direction_output(170, true);
 
 	usb_musb_init();
-	usb_ehci_init();
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3beagle_flash_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6577726..514058f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -255,7 +255,7 @@ static void __init omap3_evm_init(void)
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
-	usb_ehci_init();
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3evm_flash_init();
 	ads7846_dev_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b8a78c0..08215c0 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -297,7 +297,7 @@ static void __init omap3pandora_init(void)
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	usb_musb_init();
-	usb_ehci_init();
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3pandora_flash_init();
 	omap3pandora_ads7846_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e5a3412..b51c835 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -246,7 +246,7 @@ static void __init overo_init(void)
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
-	usb_ehci_init();
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	overo_flash_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 23fe857..30e1ad6 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -145,8 +145,20 @@ static void setup_ehci_io_mux(void)
 	return;
 }
 
-void __init usb_ehci_init(void)
+void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
+		int chargepump, int phy_reset, int reset_gpio_port1,
+		int reset_gpio_port2)
 {
+	struct ehci_hcd_omap_platform_data pdata = {
+		.phy_mode		= phy_mode,
+		.chargepump		= chargepump,
+		.phy_reset		= phy_reset,
+		.reset_gpio_port1	= reset_gpio_port1,
+		.reset_gpio_port2	= reset_gpio_port2,
+	};
+
+	ehci_device.dev.platform_data = &pdata;
+
 	/* Setup Pin IO MUX for EHCI */
 	if (cpu_is_omap34xx())
 		setup_ehci_io_mux();
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index 47aba6b..8a341ca 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -5,6 +5,22 @@
 
 #include <mach/board.h>
 
+enum ehci_hcd_omap_mode {
+	EHCI_HCD_OMAP_MODE_UNKNOWN,
+	EHCI_HCD_OMAP_MODE_PHY,
+	EHCI_HCD_OMAP_MODE_TLL,
+};
+
+struct ehci_hcd_omap_platform_data {
+	enum ehci_hcd_omap_mode		phy_mode;
+	unsigned			chargepump:1;
+	unsigned			phy_reset:1;
+
+	/* have to be valid if phy_reset is true */
+	int				reset_gpio_port1;
+	int				reset_gpio_port2;
+};
+
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -36,9 +52,13 @@ static inline void usb_musb_init(void)
 #endif
 
 #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
-extern void usb_ehci_init(void);
+extern void usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
+		int chargepump, int phy_reset, int reset_gpio_port1,
+		int reset_gpio_port2);
 #else
-static inline void usb_ehci_init(void)
+static inline void usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
+		int chargepump, int phy_reset, int reset_gpio_port1,
+		int reset_gpio_port2)
 {
 }
 #endif
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 02df795..2c63bfb 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -41,25 +41,6 @@ config USB_EHCI_HCD
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ehci-hcd.
-choice
-	prompt "PHY/TLL mode"
-	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
-	---help---
-	Choose PHY or TLL mode of operation
-
-config OMAP_EHCI_PHY_MODE
-	bool "PHY mode: ISP1504 on Port1/2 (NEW 3430ES2.0)"
-	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
-	---help---
-	  EHCI PHY mode. Port1 and Port2 are connected to ISP1504 transcievers
-
-config OMAP_EHCI_TLL_MODE
-	bool "TLL mode: (EXPERIMENTAL)"
-	depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH_OMAP34XX
-	---help---
-	OMAP EHCI controller has TLL mode of operation for all 3 ports.
-	Use this mode when no transciever is present
-endchoice
 
 config USB_EHCI_ROOT_HUB_TT
 	bool "Root Hub Transaction Translators"
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index b058ada..cd891cc 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -29,6 +29,9 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 
+/* platform_data lives here */
+#include <mach/usb.h>
+
 /* FIXME remove platform-specific code */
 #include <mach/hardware.h>
 #include "../../../arch/arm/mach-omap2/cm.h"
@@ -129,44 +132,30 @@
 /* OHCI Register Set */
 #define	OMAP_USBHOST_OHCI_BASE	(OMAP_USBHOST_BASE + 0x4400)
 
-#ifdef CONFIG_OMAP_EHCI_PHY_MODE
-/* EHCI connected to External PHY */
+/*-------------------------------------------------------------------------*/
 
-/* External USB connectivity board: 750-2083-001
- * Connected to OMAP3430 SDP
- * The board has Port1 and Port2 connected to ISP1504 in 12-pin ULPI mode
- */
+struct ehci_hcd_omap {
+	struct ehci_hcd		*ehci;
+	struct device		*dev;
 
-/* ISSUE1:
- *      ISP1504 for input clocking mode needs special reset handling
- *	Hold the PHY in reset by asserting RESET_N signal
- *	Then start the 60Mhz clock input to PHY
- *	Release the reset after a delay -
- *		to get the PHY state machine in working state
- */
-#define EXTERNAL_PHY_RESET
-#define	EXT_PHY_RESET_GPIO_PORT1	(57)
-#define	EXT_PHY_RESET_GPIO_PORT2	(61)
-#define	EXT_PHY_RESET_DELAY		(10)
-
-/* ISSUE2:
- * USBHOST supports External charge pump PHYs only
- * Use the VBUS from Port1 to power VBUS of Port2 externally
- * So use Port2 as the working ULPI port
- */
-#define VBUS_INTERNAL_CHARGEPUMP_HACK
+	struct clk		*usbhost_ick;
+	struct clk		*usbhost2_120m_fck;
+	struct clk		*usbhost1_48m_fck;
+	struct clk		*usbtll_fck;
+	struct clk		*usbtll_ick;
 
-#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
+	/* gpio for resetting phy */
+	int			reset_gpio_port1;
+	int			reset_gpio_port2;
 
-/*-------------------------------------------------------------------------*/
+	/* phy reset workaround */
+	int			phy_reset;
 
-/* Define USBHOST clocks for clock management */
-struct ehci_omap_clock_defs {
-	struct clk	*usbhost_ick_clk;
-	struct clk	*usbhost2_120m_fck_clk;
-	struct clk	*usbhost1_48m_fck_clk;
-	struct clk	*usbtll_fck_clk;
-	struct clk	*usbtll_ick_clk;
+	/* vbus internal chargepump workaround */
+	int			chargepump;
+
+	/* desired phy_mode: TLL, PHY */
+	enum ehci_hcd_omap_mode	phy_mode;
 };
 
 /* Clock names as per clock framework: May change so keep as #defs */
@@ -178,8 +167,6 @@ struct ehci_omap_clock_defs {
 
 /*-------------------------------------------------------------------------*/
 
-#ifndef CONFIG_OMAP_EHCI_PHY_MODE
-
 static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
@@ -211,16 +198,16 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 
 		/* Disable AutoIdle */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1 << OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
-			    OMAP_TLL_CHANNEL_CONF(i));
+			~(1 << OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
+			OMAP_TLL_CHANNEL_CONF(i));
 		/* Disable BitStuffing */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
-			    OMAP_TLL_CHANNEL_CONF(i));
+			~(1 << OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
+			OMAP_TLL_CHANNEL_CONF(i));
 		/* SDR Mode */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
-			    OMAP_TLL_CHANNEL_CONF(i));
+				~(1 << OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
+				OMAP_TLL_CHANNEL_CONF(i));
 
 	}
 
@@ -239,8 +226,8 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 			continue;
 
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
-			    (1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
-			    OMAP_TLL_CHANNEL_CONF(i));
+				(1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
+				OMAP_TLL_CHANNEL_CONF(i));
 
 		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
 		dev_dbg(hcd->self.controller, "ULPI_SCRATCH_REG[ch=%d]"
@@ -249,27 +236,18 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 	}
 }
 
-#else
-# define omap_usb_utmi_init(x, y)	0
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 /* omap_start_ehc
  *	- Start the TI USBHOST controller
  */
-static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
+static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
-	struct ehci_omap_clock_defs *ehci_clocks;
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 	int ret = 0;
 
 	dev_dbg(hcd->self.controller, "starting TI EHCI USB Controller\n");
 
-	ehci_clocks = (struct ehci_omap_clock_defs *)(
-				((char *)hcd_to_ehci(hcd)) +
-					sizeof(struct ehci_hcd));
-
 	/* Start DPLL5 Programming:
 	 * Clock Framework is not doing this now:
 	 * This will be done in clock framework later
@@ -317,55 +295,52 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 				OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
 
 	/* Enable Clocks for USBHOST */
-	ehci_clocks->usbhost_ick_clk = clk_get(&dev->dev,
-						USBHOST_ICKL);
-	if (IS_ERR(ehci_clocks->usbhost_ick_clk)) {
-		ret =  PTR_ERR(ehci_clocks->usbhost_ick_clk);
+	omap->usbhost_ick = clk_get(omap->dev, USBHOST_ICKL);
+	if (IS_ERR(omap->usbhost_ick)) {
+		ret =  PTR_ERR(omap->usbhost_ick);
 		goto err_host_ick;
 	}
-	clk_enable(ehci_clocks->usbhost_ick_clk);
+	clk_enable(omap->usbhost_ick);
 
-	ehci_clocks->usbhost2_120m_fck_clk = clk_get(&dev->dev,
-							USBHOST_120M_FCLK);
-	if (IS_ERR(ehci_clocks->usbhost2_120m_fck_clk)) {
-		ret = PTR_ERR(ehci_clocks->usbhost2_120m_fck_clk);
+	omap->usbhost2_120m_fck = clk_get(omap->dev, USBHOST_120M_FCLK);
+	if (IS_ERR(omap->usbhost2_120m_fck)) {
+		ret = PTR_ERR(omap->usbhost2_120m_fck);
 		goto err_host_120m_fck;
 	}
-	clk_enable(ehci_clocks->usbhost2_120m_fck_clk);
+	clk_enable(omap->usbhost2_120m_fck);
 
-	ehci_clocks->usbhost1_48m_fck_clk = clk_get(&dev->dev,
-						USBHOST_48M_FCLK);
-	if (IS_ERR(ehci_clocks->usbhost1_48m_fck_clk)) {
-		ret = PTR_ERR(ehci_clocks->usbhost1_48m_fck_clk);
+	omap->usbhost1_48m_fck = clk_get(omap->dev, USBHOST_48M_FCLK);
+	if (IS_ERR(omap->usbhost1_48m_fck)) {
+		ret = PTR_ERR(omap->usbhost1_48m_fck);
 		goto err_host_48m_fck;
 	}
-	clk_enable(ehci_clocks->usbhost1_48m_fck_clk);
+	clk_enable(omap->usbhost1_48m_fck);
 
 
-#ifdef EXTERNAL_PHY_RESET
-	/* Refer: ISSUE1 */
-	gpio_request(EXT_PHY_RESET_GPIO_PORT1, "USB1 PHY reset");
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
-	gpio_request(EXT_PHY_RESET_GPIO_PORT2, "USB2 PHY reset");
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
-	/* Hold the PHY in RESET for enough time till DIR is high */
-	udelay(EXT_PHY_RESET_DELAY);
-#endif
+	if (omap->phy_reset) {
+		/* Refer: ISSUE1 */
+		gpio_request(omap->reset_gpio_port1, "USB1 PHY reset");
+		gpio_direction_output(omap->reset_gpio_port1, 0);
+		gpio_request(omap->reset_gpio_port2, "USB2 PHY reset");
+		gpio_direction_output(omap->reset_gpio_port2, 0);
+		/* Hold the PHY in RESET for enough time till DIR is high */
+		udelay(10);
+	}
 
 	/* Configure TLL for 60Mhz clk for ULPI */
-	ehci_clocks->usbtll_fck_clk = clk_get(&dev->dev, USBHOST_TLL_FCLK);
-	if (IS_ERR(ehci_clocks->usbtll_fck_clk)) {
-		ret = PTR_ERR(ehci_clocks->usbtll_fck_clk);
+	omap->usbtll_fck = clk_get(omap->dev, USBHOST_TLL_FCLK);
+	if (IS_ERR(omap->usbtll_fck)) {
+		ret = PTR_ERR(omap->usbtll_fck);
 		goto err_tll_fck;
 	}
-	clk_enable(ehci_clocks->usbtll_fck_clk);
+	clk_enable(omap->usbtll_fck);
 
-	ehci_clocks->usbtll_ick_clk = clk_get(&dev->dev, USBHOST_TLL_ICKL);
-	if (IS_ERR(ehci_clocks->usbtll_ick_clk)) {
-		ret = PTR_ERR(ehci_clocks->usbtll_ick_clk);
+	omap->usbtll_ick = clk_get(omap->dev, USBHOST_TLL_ICKL);
+	if (IS_ERR(omap->usbtll_ick)) {
+		ret = PTR_ERR(omap->usbtll_ick);
 		goto err_tll_ick;
 	}
-	clk_enable(ehci_clocks->usbtll_ick_clk);
+	clk_enable(omap->usbtll_ick);
 
 	/* Disable Auto Idle of USBTLL */
 	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL_SHIFT),
@@ -416,120 +391,124 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			(1 << OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT),
 			OMAP_UHH_SYSCONFIG);
 
-#ifdef CONFIG_OMAP_EHCI_PHY_MODE
-	/* Bypass the TLL module for PHY mode operation */
-	omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
+	if (omap->phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
+
+		/* Bypass the TLL module for PHY mode operation */
+		omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
 			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
 			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
 			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
 			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
-						OMAP_UHH_HOSTCONFIG);
+			OMAP_UHH_HOSTCONFIG);
 
-	/* Ensure that BYPASS is set */
-	while (omap_readl(OMAP_UHH_HOSTCONFIG)
+		/* Ensure that BYPASS is set */
+		while (omap_readl(OMAP_UHH_HOSTCONFIG)
 			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)) {
-		cpu_relax();
-
-		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_ulpi_bypass;
+			cpu_relax();
+
+			if (time_after(timeout, jiffies)) {
+				dev_dbg(hcd->self.controller,
+						"operation timed out\n");
+				ret = -EINVAL;
+				goto err_ulpi_bypass;
+			}
 		}
-	}
-
-	dev_dbg(hcd->self.controller, "Entered ULPI PHY MODE: success\n");
-
-#else
-	/* Enable UTMI mode for all 3 TLL channels */
-	omap_usb_utmi_init(hcd,
-		OMAP_TLL_CHANNEL_1_EN_MASK |
-		OMAP_TLL_CHANNEL_2_EN_MASK |
-		OMAP_TLL_CHANNEL_3_EN_MASK
-		);
-#endif
 
-#ifdef EXTERNAL_PHY_RESET
-	/* Refer ISSUE1:
-	 * Hold the PHY in RESET for enough time till PHY is settled and ready
-	 */
-	udelay(EXT_PHY_RESET_DELAY);
-	gpio_set_value(EXT_PHY_RESET_GPIO_PORT1, 1);
-	gpio_set_value(EXT_PHY_RESET_GPIO_PORT2, 1);
-#endif
-
-#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
-	/* Refer ISSUE2: LINK assumes external charge pump */
+		dev_dbg(hcd->self.controller,
+				"Entered ULPI PHY MODE: success\n");
+
+	} else if (omap->phy_mode == EHCI_HCD_OMAP_MODE_TLL) {
+
+		/* Enable UTMI mode for all 3 TLL channels */
+		omap_usb_utmi_init(hcd,
+			OMAP_TLL_CHANNEL_1_EN_MASK |
+			OMAP_TLL_CHANNEL_2_EN_MASK |
+			OMAP_TLL_CHANNEL_3_EN_MASK
+			);
+	} else {
+		dev_err(hcd->self.controller,
+				"UNKOWN mode requested\n");
+		ret = -EINVAL;
+		goto err_unknown_mode;
+	}
 
-	/* use Port1 VBUS to charge externally Port2:
-	 *	So for PHY mode operation use Port2 only
-	 */
-	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
-			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
-			(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
-			(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
-			(0x26),
-			EHCI_INSNREG05_ULPI);
-
-	while (!(omap_readl(EHCI_INSNREG05_ULPI)
-			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
-		cpu_relax();
+	if (omap->phy_reset) {
+		/* Refer ISSUE1:
+		 * Hold the PHY in RESET for enough time till
+		 * PHY is settled and ready
+		 */
+		udelay(10);
+		gpio_set_value(omap->reset_gpio_port1, 1);
+		gpio_set_value(omap->reset_gpio_port2, 1);
+	}
 
-		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_ulpi_control;
+	if (omap->chargepump) {
+
+		/* Refer ISSUE2: LINK assumes external charge pump */
+
+		/* use Port1 VBUS to charge externally Port2:
+		 *	So for PHY mode operation use Port2 only
+		 */
+		omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
+				(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
+				(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
+				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
+				(0x26),
+				EHCI_INSNREG05_ULPI);
+
+		while (!(omap_readl(EHCI_INSNREG05_ULPI)
+				& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
+			cpu_relax();
+
+			if (time_after(timeout, jiffies)) {
+				dev_dbg(hcd->self.controller,
+						"operation timed out\n");
+				ret = -EINVAL;
+				goto err_ulpi_control;
+			}
 		}
 	}
 
-#endif
-
 	return 0;
 
-#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
 err_ulpi_control:
-#endif
-#ifdef CONFIG_OMAP_EHCI_PHY_MODE
+err_unknown_mode:
 err_ulpi_bypass:
-#endif
 err_sys_status:
 err_idlest3:
-	clk_disable(ehci_clocks->usbtll_ick_clk);
-	clk_put(ehci_clocks->usbtll_ick_clk);
+	clk_disable(omap->usbtll_ick);
+	clk_put(omap->usbtll_ick);
 
 err_tll_ick:
-	clk_disable(ehci_clocks->usbtll_fck_clk);
-	clk_put(ehci_clocks->usbtll_fck_clk);
+	clk_disable(omap->usbtll_fck);
+	clk_put(omap->usbtll_fck);
 
 err_tll_fck:
-	clk_disable(ehci_clocks->usbhost1_48m_fck_clk);
-	clk_put(ehci_clocks->usbhost1_48m_fck_clk);
+	clk_disable(omap->usbhost1_48m_fck);
+	clk_put(omap->usbhost1_48m_fck);
 
-#ifdef EXTERNAL_PHY_RESET
-	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
-	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
-#endif
+	if (omap->phy_reset) {
+		gpio_free(omap->reset_gpio_port1);
+		gpio_free(omap->reset_gpio_port2);
+	}
 
 err_host_48m_fck:
-	clk_disable(ehci_clocks->usbhost2_120m_fck_clk);
-	clk_put(ehci_clocks->usbhost2_120m_fck_clk);
+	clk_disable(omap->usbhost2_120m_fck);
+	clk_put(omap->usbhost2_120m_fck);
 
 err_host_120m_fck:
-	clk_disable(ehci_clocks->usbhost_ick_clk);
-	clk_put(ehci_clocks->usbhost_ick_clk);
+	clk_disable(omap->usbhost_ick);
+	clk_put(omap->usbhost_ick);
 
 err_host_ick:
 err_idlest2:
 	return ret;
 }
 
-static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
+static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
-	struct ehci_omap_clock_defs *ehci_clocks;
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 
-	ehci_clocks = (struct ehci_omap_clock_defs *)
-			(((char *)hcd_to_ehci(hcd)) + sizeof(struct ehci_hcd));
-
 	dev_dbg(hcd->self.controller, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
@@ -575,40 +554,40 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	}
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
-	if (ehci_clocks->usbtll_fck_clk != NULL) {
-		clk_disable(ehci_clocks->usbtll_fck_clk);
-		clk_put(ehci_clocks->usbtll_fck_clk);
-		ehci_clocks->usbtll_fck_clk = NULL;
+	if (omap->usbtll_fck != NULL) {
+		clk_disable(omap->usbtll_fck);
+		clk_put(omap->usbtll_fck);
+		omap->usbtll_fck = NULL;
 	}
 
-	if (ehci_clocks->usbhost_ick_clk != NULL) {
-		clk_disable(ehci_clocks->usbhost_ick_clk);
-		clk_put(ehci_clocks->usbhost_ick_clk);
-		ehci_clocks->usbhost_ick_clk = NULL;
+	if (omap->usbhost_ick != NULL) {
+		clk_disable(omap->usbhost_ick);
+		clk_put(omap->usbhost_ick);
+		omap->usbhost_ick = NULL;
 	}
 
-	if (ehci_clocks->usbhost1_48m_fck_clk != NULL) {
-		clk_disable(ehci_clocks->usbhost1_48m_fck_clk);
-		clk_put(ehci_clocks->usbhost1_48m_fck_clk);
-		ehci_clocks->usbhost1_48m_fck_clk = NULL;
+	if (omap->usbhost1_48m_fck != NULL) {
+		clk_disable(omap->usbhost1_48m_fck);
+		clk_put(omap->usbhost1_48m_fck);
+		omap->usbhost1_48m_fck = NULL;
 	}
 
-	if (ehci_clocks->usbhost2_120m_fck_clk != NULL) {
-		clk_disable(ehci_clocks->usbhost2_120m_fck_clk);
-		clk_put(ehci_clocks->usbhost2_120m_fck_clk);
-		ehci_clocks->usbhost2_120m_fck_clk = NULL;
+	if (omap->usbhost2_120m_fck != NULL) {
+		clk_disable(omap->usbhost2_120m_fck);
+		clk_put(omap->usbhost2_120m_fck);
+		omap->usbhost2_120m_fck = NULL;
 	}
 
-	if (ehci_clocks->usbtll_ick_clk != NULL) {
-		clk_disable(ehci_clocks->usbtll_ick_clk);
-		clk_put(ehci_clocks->usbtll_ick_clk);
-		ehci_clocks->usbtll_ick_clk = NULL;
+	if (omap->usbtll_ick != NULL) {
+		clk_disable(omap->usbtll_ick);
+		clk_put(omap->usbtll_ick);
+		omap->usbtll_ick = NULL;
 	}
 
-#ifdef EXTERNAL_PHY_RESET
-	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
-	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
-#endif
+	if (omap->phy_reset) {
+		gpio_free(omap->reset_gpio_port1);
+		gpio_free(omap->reset_gpio_port2);
+	}
 
 	dev_dbg(hcd->self.controller,
 		"Clock to USB host has been disabled\n");
@@ -630,16 +609,28 @@ static const struct hc_driver ehci_omap_hc_driver;
  */
 static int ehci_hcd_omap_probe(struct platform_device *pdev)
 {
-	struct ehci_hcd *ehci;
+	struct ehci_hcd_omap_platform_data *pdata = pdev->dev.platform_data;
+	struct ehci_hcd_omap *omap;
 	struct resource *res;
 	struct usb_hcd *hcd;
 
 	int irq = platform_get_irq(pdev, 0);
 	int ret = -ENODEV;
 
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "missing platform_data\n");
+		goto err_pdata;
+	}
+
 	if (usb_disabled())
 		goto err_disabled;
 
+	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
+	if (!omap) {
+		ret = -ENOMEM;
+		goto err_create_hcd;
+	}
+
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, &pdev->dev,
 			dev_name(&pdev->dev));
 	if (!hcd) {
@@ -648,7 +639,17 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_create_hcd;
 	}
 
-	ret = omap_start_ehc(pdev, hcd);
+	platform_set_drvdata(pdev, omap);
+	omap->dev		= &pdev->dev;
+	omap->reset_gpio_port1	= pdata->reset_gpio_port1;
+	omap->reset_gpio_port2	= pdata->reset_gpio_port2;
+	omap->phy_mode		= pdata->phy_mode;
+	omap->chargepump	= pdata->chargepump;
+	omap->ehci		= hcd_to_ehci(hcd);
+	omap->ehci->caps	= hcd->regs;
+	omap->ehci->sbrn	= 0x20;
+
+	ret = omap_start_ehc(omap, hcd);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to start ehci\n");
 		goto err_start;
@@ -668,16 +669,15 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	ehci = hcd_to_ehci(hcd);
-	ehci->caps = hcd->regs;
-	ehci->sbrn = 0x20;
+	omap->ehci->regs = hcd->regs
+		+ HC_LENGTH(readl(&omap->ehci->caps->hc_capbase));
 
-	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
 	/* cache this readonly data; minimize chip reads */
-	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+	omap->ehci->hcs_params = readl(&omap->ehci->caps->hcs_params);
 
 	/* SET 1 micro-frame Interrupt interval */
-	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
+	writel(readl(&omap->ehci->regs->command) | (1 << 16),
+			&omap->ehci->regs->command);
 
 	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (ret) {
@@ -691,13 +691,14 @@ err_add_hcd:
 	iounmap(hcd->regs);
 
 err_ioremap:
-	omap_stop_ehc(pdev, hcd);
+	omap_stop_ehc(omap, hcd);
 
 err_start:
 	usb_put_hcd(hcd);
 
 err_create_hcd:
 err_disabled:
+err_pdata:
 	return ret;
 }
 
@@ -714,11 +715,12 @@ err_disabled:
  */
 static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
 
 	usb_remove_hcd(hcd);
 	iounmap(hcd->regs);
-	omap_stop_ehc(pdev, hcd);
+	omap_stop_ehc(omap, hcd);
 	usb_put_hcd(hcd);
 
 	return 0;
@@ -738,10 +740,9 @@ static struct platform_driver ehci_hcd_omap_driver = {
 /*-------------------------------------------------------------------------*/
 
 static const struct hc_driver ehci_omap_hc_driver = {
-	.description = hcd_name,
+	.description		= hcd_name,
 	.product_desc		= "OMAP-EHCI Host Controller",
-	.hcd_priv_size		= sizeof(struct ehci_hcd)
-				+ sizeof(struct ehci_omap_clock_defs),
+	.hcd_priv_size		= sizeof(struct ehci_hcd_omap),
 
 	/*
 	 * generic hardware linkage
-- 
1.6.1.3


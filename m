From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/9] omap: mux: Replace omap_cfg_reg() with new style signal
	or gpio functions
Date: Wed, 02 Dec 2009 16:22:35 -0800
Message-ID: <20091203002235.2769.42085.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59813 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZLCAWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:22:30 -0500
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Replace omap_cfg_reg() with new style signal or gpio functions

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    4 -
 arch/arm/mach-omap2/board-3630sdp.c          |    5 +
 arch/arm/mach-omap2/board-cm-t35.c           |    3 
 arch/arm/mach-omap2/board-omap3beagle.c      |   10 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   10 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 -
 arch/arm/mach-omap2/board-overo.c            |    4 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    7 +
 arch/arm/mach-omap2/board-rx51.c             |    4 -
 arch/arm/mach-omap2/devices.c                |   62 +++++++---
 arch/arm/mach-omap2/usb-ehci.c               |  166 +++++++++++++++++---------
 11 files changed, 177 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e5d9118..ded3e87 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -626,7 +626,9 @@ static inline void board_smc91x_init(void)
 
 static void enable_board_wakeup_source(void)
 {
-	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
+	/* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 348b70b..e6cbc27 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -23,6 +23,7 @@
 
 #include <mach/board-zoom.h>
 
+#include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
@@ -48,7 +49,9 @@ static inline void board_smc91x_init(void)
 
 static void enable_board_wakeup_source(void)
 {
-	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
+	/* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 84321f6..10a5955 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -503,7 +503,8 @@ static void __init cm_t35_init(void)
 
 	usb_musb_init();
 
-	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e669dbb..9e606b1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -141,10 +141,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
-		omap_cfg_reg(AG9_34XX_GPIO23);
+		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
 	} else {
-		omap_cfg_reg(AH8_34XX_GPIO29);
+		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
@@ -439,7 +439,7 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
-	omap_cfg_reg(J25_34XX_GPIO170);
+	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
@@ -449,8 +449,8 @@ static void __init omap3_beagle_init(void)
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ad174ae..0457f61 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -224,7 +224,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	omap_cfg_reg(L8_34XX_GPIO63);
+	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
@@ -450,24 +450,24 @@ static void __init omap3_evm_init(void)
 #endif
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
-		omap_cfg_reg(AF9_34XX_GPIO22);
+		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
 		gpio_request(OMAP3_EVM_EHCI_VBUS, "enable EHCI VBUS");
 		gpio_direction_output(OMAP3_EVM_EHCI_VBUS, 0);
 		gpio_set_value(OMAP3_EVM_EHCI_VBUS, 1);
 
 		/* Select EHCI port on main board */
-		omap_cfg_reg(U3_34XX_GPIO61);
+		omap_mux_init_gpio(61, OMAP_PIN_INPUT_PULLUP);
 		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
 		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
 		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
 
 		/* setup EHCI phy reset config */
-		omap_cfg_reg(AH14_34XX_GPIO21);
+		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
 		ehci_pdata.reset_gpio_port[1] = 21;
 
 	} else {
 		/* setup EHCI phy reset on MDC */
-		omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
 		ehci_pdata.reset_gpio_port[1] = 135;
 	}
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 9f59c03..bca5ad9 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -433,8 +433,8 @@ static void __init omap3pandora_init(void)
 	usb_musb_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 40f3c85..1ebde4c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -427,8 +427,8 @@ static void __init overo_init(void)
 	overo_init_smsc911x();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4f347f8..f903104 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -33,6 +33,7 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
@@ -630,9 +631,9 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 
 static void __init board_smc91x_init(void)
 {
-	omap_cfg_reg(U8_34XX_GPIO54_DOWN);
-	omap_cfg_reg(G25_34XX_GPIO86_OUT);
-	omap_cfg_reg(H19_34XX_GPIO164_OUT);
+	omap_mux_init_gpio(54, OMAP_PIN_INPUT_PULLDOWN);
+	omap_mux_init_gpio(86, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(164, OMAP_PIN_OUTPUT);
 
 	gpmc_smc91x_init(&board_smc91x_data);
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index c0c99ad..fd71c00 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -87,8 +87,8 @@ static void __init rx51_init(void)
 	rx51_peripherals_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
 static void __init rx51_map_io(void)
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 733d3dc..18ad931 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,6 +27,8 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 
+#include "mux.h"
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -595,27 +597,40 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 
 	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
-			omap_cfg_reg(N28_3430_MMC1_CLK);
-			omap_cfg_reg(M27_3430_MMC1_CMD);
-			omap_cfg_reg(N27_3430_MMC1_DAT0);
+			omap_mux_init_signal("sdmmc1_clk",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_cmd",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_dat0",
+				OMAP_PIN_INPUT_PULLUP);
 			if (mmc_controller->slots[0].wires == 4 ||
 				mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(N26_3430_MMC1_DAT1);
-				omap_cfg_reg(N25_3430_MMC1_DAT2);
-				omap_cfg_reg(P28_3430_MMC1_DAT3);
+				omap_mux_init_signal("sdmmc1_dat1",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat2",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat3",
+					OMAP_PIN_INPUT_PULLUP);
 			}
 			if (mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(P27_3430_MMC1_DAT4);
-				omap_cfg_reg(P26_3430_MMC1_DAT5);
-				omap_cfg_reg(R27_3430_MMC1_DAT6);
-				omap_cfg_reg(R25_3430_MMC1_DAT7);
+				omap_mux_init_signal("sdmmc1_dat4",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat5",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat6",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat7",
+					OMAP_PIN_INPUT_PULLUP);
 			}
 		}
 		if (controller_nr == 1) {
 			/* MMC2 */
-			omap_cfg_reg(AE2_3430_MMC2_CLK);
-			omap_cfg_reg(AG5_3430_MMC2_CMD);
-			omap_cfg_reg(AH5_3430_MMC2_DAT0);
+			omap_mux_init_signal("sdmmc2_clk",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc2_cmd",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc2_dat0",
+				OMAP_PIN_INPUT_PULLUP);
 
 			/*
 			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7 need to be muxed
@@ -623,15 +638,22 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			 */
 			if (mmc_controller->slots[0].wires == 4 ||
 				mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(AH4_3430_MMC2_DAT1);
-				omap_cfg_reg(AG4_3430_MMC2_DAT2);
-				omap_cfg_reg(AF4_3430_MMC2_DAT3);
+				omap_mux_init_signal("sdmmc2_dat1",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat2",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat3",
+					OMAP_PIN_INPUT_PULLUP);
 			}
 			if (mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(AE4_3430_MMC2_DAT4);
-				omap_cfg_reg(AH3_3430_MMC2_DAT5);
-				omap_cfg_reg(AF3_3430_MMC2_DAT6);
-				omap_cfg_reg(AE3_3430_MMC2_DAT7);
+				omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
+					OMAP_PIN_INPUT_PULLUP);
 			}
 		}
 
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index e448abd..f1df873 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -27,6 +27,8 @@
 #include <mach/irqs.h>
 #include <plat/usb.h>
 
+#include "mux.h"
+
 #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
 
 static struct resource ehci_resources[] = {
@@ -72,32 +74,44 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case EHCI_HCD_OMAP_MODE_PHY:
-		omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
-		omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
-		omap_cfg_reg(AA14_3430_USB1HS_PHY_DIR);
-		omap_cfg_reg(AA11_3430_USB1HS_PHY_NXT);
-		omap_cfg_reg(W13_3430_USB1HS_PHY_DATA0);
-		omap_cfg_reg(W12_3430_USB1HS_PHY_DATA1);
-		omap_cfg_reg(W11_3430_USB1HS_PHY_DATA2);
-		omap_cfg_reg(Y11_3430_USB1HS_PHY_DATA3);
-		omap_cfg_reg(W9_3430_USB1HS_PHY_DATA4);
-		omap_cfg_reg(Y12_3430_USB1HS_PHY_DATA5);
-		omap_cfg_reg(W8_3430_USB1HS_PHY_DATA6);
-		omap_cfg_reg(Y13_3430_USB1HS_PHY_DATA7);
+		omap_mux_init_signal("hsusb1_stp", OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("hsusb1_clk", OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("hsusb1_dir", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_nxt", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data0", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data1", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data2", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data3", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data4", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data5", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data6", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_data7", OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_TLL:
-		omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
-		omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
-		omap_cfg_reg(AA14_3430_USB1HS_TLL_DIR);
-		omap_cfg_reg(AA11_3430_USB1HS_TLL_NXT);
-		omap_cfg_reg(W13_3430_USB1HS_TLL_DATA0);
-		omap_cfg_reg(W12_3430_USB1HS_TLL_DATA1);
-		omap_cfg_reg(W11_3430_USB1HS_TLL_DATA2);
-		omap_cfg_reg(Y11_3430_USB1HS_TLL_DATA3);
-		omap_cfg_reg(W9_3430_USB1HS_TLL_DATA4);
-		omap_cfg_reg(Y12_3430_USB1HS_TLL_DATA5);
-		omap_cfg_reg(W8_3430_USB1HS_TLL_DATA6);
-		omap_cfg_reg(Y13_3430_USB1HS_TLL_DATA7);
+		omap_mux_init_signal("hsusb1_tll_stp",
+			OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb1_tll_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data7",
+			OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */
@@ -107,32 +121,52 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 
 	switch (port_mode[1]) {
 	case EHCI_HCD_OMAP_MODE_PHY:
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
+		omap_mux_init_signal("hsusb2_stp", OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("hsusb2_clk", OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("hsusb2_dir", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_nxt", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data7",
+			OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_TLL:
-		omap_cfg_reg(AA10_3430_USB2HS_TLL_STP);
-		omap_cfg_reg(AA8_3430_USB2HS_TLL_CLK);
-		omap_cfg_reg(AA9_3430_USB2HS_TLL_DIR);
-		omap_cfg_reg(AB11_3430_USB2HS_TLL_NXT);
-		omap_cfg_reg(AB10_3430_USB2HS_TLL_DATA0);
-		omap_cfg_reg(AB9_3430_USB2HS_TLL_DATA1);
-		omap_cfg_reg(W3_3430_USB2HS_TLL_DATA2);
-		omap_cfg_reg(T4_3430_USB2HS_TLL_DATA3);
-		omap_cfg_reg(T3_3430_USB2HS_TLL_DATA4);
-		omap_cfg_reg(R3_3430_USB2HS_TLL_DATA5);
-		omap_cfg_reg(R4_3430_USB2HS_TLL_DATA6);
-		omap_cfg_reg(T2_3430_USB2HS_TLL_DATA7);
+		omap_mux_init_signal("hsusb2_tll_stp",
+			OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb2_tll_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data7",
+			OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */
@@ -145,18 +179,30 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 		printk(KERN_WARNING "Port3 can't be used in PHY mode\n");
 		break;
 	case EHCI_HCD_OMAP_MODE_TLL:
-		omap_cfg_reg(AB3_3430_USB3HS_TLL_STP);
-		omap_cfg_reg(AA6_3430_USB3HS_TLL_CLK);
-		omap_cfg_reg(AA3_3430_USB3HS_TLL_DIR);
-		omap_cfg_reg(Y3_3430_USB3HS_TLL_NXT);
-		omap_cfg_reg(AA5_3430_USB3HS_TLL_DATA0);
-		omap_cfg_reg(Y4_3430_USB3HS_TLL_DATA1);
-		omap_cfg_reg(Y5_3430_USB3HS_TLL_DATA2);
-		omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
-		omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
-		omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
-		omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
-		omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
+		omap_mux_init_signal("hsusb3_tll_stp",
+			OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb3_tll_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data7",
+			OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */


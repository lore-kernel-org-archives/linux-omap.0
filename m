From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: mux: Replace omap_cfg_reg() with new style signal or
 gpio functions (Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing
 data for 34xx)
Date: Tue, 3 Nov 2009 14:55:18 -0800
Message-ID: <20091103225517.GQ8981@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <20091029203631.11843.1364.stgit@localhost>
 <4AED6330.8020007@compulab.co.il>
 <20091102191018.GD6692@atomide.com>
 <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com>
 <20091103164324.GE8981@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3siQDZowHQqNOShm"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53611 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZKCWzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 17:55:19 -0500
Content-Disposition: inline
In-Reply-To: <20091103164324.GE8981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [091103 08:44]:
> * Mike Rapoport <mike.rapoport@gmail.com> [091102 23:10]:
> > On Mon, Nov 2, 2009 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
> > >>
> > >>
> > >> Tony Lindgren wrote:
> > >> > Add new style mux data for 34xx. This should also
> > >> > work with 3630 easily by adding the processor subset
> > >> > and ball data.
> > >> >
> > >> > Note that this data is __initdata, and gets optimized
> > >> > out if CONFIG_OMAP_MUX is not set. Also, the debug data
> > >> > gets optimized out if CONFIG_DEBUG_FS is not set.
> > >> >
> > >> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >> > ---
> > >> >  arch/arm/mach-omap2/Makefile  |    4
> > >> >  arch/arm/mach-omap2/mux.h     |    2
> > >> >  arch/arm/mach-omap2/mux34xx.c | 1552 +++++++++++++++++++++++++++++++++++++++++
> > >> >  arch/arm/mach-omap2/mux34xx.h |  352 +++++++++
> > >> >  4 files changed, 1910 insertions(+), 0 deletions(-)
> > >> >  create mode 100644 arch/arm/mach-omap2/mux34xx.c
> > >> >  create mode 100644 arch/arm/mach-omap2/mux34xx.h
> > >> >
> > 
> > [ snip ]
> > 
> > >> > +
> > >> > +#define OMAP3_CONTROL_PADCONF_MUX_SIZE                             \
> > >> > +           (OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
> > >>
> > >> What about adding defines for each possible mode configuration, except, perhaps,
> > >> GPIO?
> > >
> > > Yeah it would be nice to make it easy. How about someting like:
> > >
> > > int __init omap_mux_init_by_name(char *name, int flags);
> > > ...
> > >
> > > omap_mux_init_by_name("i2c1_scl", OMAP_PIN_INPUT_PULLUP);

Here's an experimental patch to replace the omap_cfg_reg() calls
for omap3. It at least seems to make the code more readable with
the gpio numbers and signal names :)

The arch/arm/plat-omap/i2c.c muxing needs to be implemented
under mach-omap2.

The functions are only stubs right now in the mux branch in the
linux-omap tree, so that's only compile tested right now..

Will repost the whole series once things are working properly
again.

Regards,

Tony

--3siQDZowHQqNOShm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-replace.patch"

>From 763a5474f2c304e1cc8f3f8ce805c1bb84bafece Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 3 Nov 2009 14:46:00 -0800
Subject: [PATCH] omap: mux: Replace omap_cfg_reg() with new style signal or gpio functions

Replace omap_cfg_reg() with new style signal or gpio functions

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 94d850d..dc1bbc1 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -482,7 +482,7 @@ static inline void board_smc91x_init(void)
 
 static void enable_board_wakeup_source(void)
 {
-	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq", OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP); /* T2 interrupt line (keypad) */
 }
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1143588..7acb3a2 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -469,7 +469,7 @@ static void __init cm_t35_init(void)
 
 	usb_musb_init();
 
-	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
+	omap_mux_init_signal("sys_nirq", OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 
 	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CUS);
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5bb096a..fb5f33a 100644
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
@@ -426,7 +426,7 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
-	omap_cfg_reg(J25_34XX_GPIO170);
+	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
@@ -436,8 +436,8 @@ static void __init omap3_beagle_init(void)
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 77b1a20..7ca673a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -171,7 +171,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	omap_cfg_reg(L8_34XX_GPIO63);
+	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
 	twl4030_mmc_init(mmc);
 
@@ -378,7 +378,7 @@ static void __init omap3_evm_init(void)
 #endif
 	usb_musb_init();
 	/* Setup EHCI phy reset padconfig */
-	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+	omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index d1ea8d5..5cb81f0 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -420,8 +420,8 @@ static void __init omap3pandora_init(void)
 	usb_musb_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 63e85c2..16f25a0 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -414,8 +414,8 @@ static void __init overo_init(void)
 	overo_init_smsc911x();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cf4583a..da42018 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -31,6 +31,7 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "mux.h"
 #include "mmc-twl4030.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
@@ -521,9 +522,9 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 
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
index 6bfe4db..03787ba 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -79,8 +79,8 @@ static void __init rx51_init(void)
 	rx51_peripherals_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_cfg_reg(H16_34XX_SDRC_CKE0);
-	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	omap3_mux_init(board_mux, OMAP_MUX_ALL_DYNAMIC | OMAP_PACKAGE_CBB);
 }
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7d4513b..8a7882d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,6 +27,8 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 
+#include "mux.h"
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -577,27 +579,27 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 
 	if (cpu_is_omap3430()) {
 		if (controller_nr == 0) {
-			omap_cfg_reg(N28_3430_MMC1_CLK);
-			omap_cfg_reg(M27_3430_MMC1_CMD);
-			omap_cfg_reg(N27_3430_MMC1_DAT0);
+			omap_mux_init_signal("mmc1_clk", OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("mmc1_cmd", OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("mmc1_dat0", OMAP_PIN_INPUT_PULLUP);
 			if (mmc_controller->slots[0].wires == 4 ||
 				mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(N26_3430_MMC1_DAT1);
-				omap_cfg_reg(N25_3430_MMC1_DAT2);
-				omap_cfg_reg(P28_3430_MMC1_DAT3);
+				omap_mux_init_signal("mmc1_dat1", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc1_dat2", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc1_dat3", OMAP_PIN_INPUT_PULLUP);
 			}
 			if (mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(P27_3430_MMC1_DAT4);
-				omap_cfg_reg(P26_3430_MMC1_DAT5);
-				omap_cfg_reg(R27_3430_MMC1_DAT6);
-				omap_cfg_reg(R25_3430_MMC1_DAT7);
+				omap_mux_init_signal("mmc1_dat4", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc1_dat5", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc1_dat6", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc1_dat7", OMAP_PIN_INPUT_PULLUP);
 			}
 		}
 		if (controller_nr == 1) {
 			/* MMC2 */
-			omap_cfg_reg(AE2_3430_MMC2_CLK);
-			omap_cfg_reg(AG5_3430_MMC2_CMD);
-			omap_cfg_reg(AH5_3430_MMC2_DAT0);
+			omap_mux_init_signal("mmc2_clk", OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("mmc2_cmd", OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("mmc2_dat0", OMAP_PIN_INPUT_PULLUP);
 
 			/*
 			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7 need to be muxed
@@ -605,9 +607,9 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			 */
 			if (mmc_controller->slots[0].wires == 4 ||
 				mmc_controller->slots[0].wires == 8) {
-				omap_cfg_reg(AH4_3430_MMC2_DAT1);
-				omap_cfg_reg(AG4_3430_MMC2_DAT2);
-				omap_cfg_reg(AF4_3430_MMC2_DAT3);
+				omap_mux_init_signal("mmc2_dat1", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc2_dat2", OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("mmc2_dat3", OMAP_PIN_INPUT_PULLUP);
 			}
 		}
 
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index e448abd..d0f11fb 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -27,6 +27,8 @@
 #include <mach/irqs.h>
 #include <plat/usb.h>
 
+#include "mux.h"
+
 #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
 
 static struct resource ehci_resources[] = {
@@ -72,32 +74,32 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
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
+		omap_mux_init_signal("hsusb1_tll_stp", OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb1_tll_clk", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_dir", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_nxt", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data0", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data1", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data2", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data3", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data4", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data5", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data6", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb1_tll_data7", OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */
@@ -107,32 +109,32 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 
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
+		omap_mux_init_signal("hsusb2_data0", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data1", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data2", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data3", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data4", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data5", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data6", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_data7", OMAP_PIN_INPUT_PULLDOWN);
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
+		omap_mux_init_signal("hsusb2_tll_stp", OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb2_tll_clk", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_dir", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_nxt", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data0", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data1", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data2", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data3", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data4", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data5", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data6", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb2_tll_data7", OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */
@@ -145,18 +147,18 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
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
+		omap_mux_init_signal("hsusb3_tll_stp", OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("hsusb3_tll_clk", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_dir", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_nxt", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data0", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data1", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data2", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data3", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data4", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data5", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data6", OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("hsusb3_tll_data7", OMAP_PIN_INPUT_PULLDOWN);
 		break;
 	case EHCI_HCD_OMAP_MODE_UNKNOWN:
 		/* FALLTHROUGH */

--3siQDZowHQqNOShm--

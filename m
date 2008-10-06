From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc7-omap1-git] beagle: two more GPIOs
Date: Mon, 6 Oct 2008 13:17:35 -0700
Message-ID: <200810061317.35589.david-b@pacbell.net>
References: <200809281055.05000.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:23603 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752842AbYJFURh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 16:17:37 -0400
In-Reply-To: <200809281055.05000.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Request two more GPIOs on Beagle:  MMC write protect, DVI enable.

Also define the first OMAP3 GPIO mux config symbols, with a new
naming convention.  Examples:

  - GPIO42 is bidirectional, and uses external pull up/down (if any);
  - GPIO42_UP is bidirectional, with an internal pullup;
  - GPIO42_DOWN is bidirectional, with an internal pulldown.
  - GPIO42_OUT is output-only, and needs no pullup or pulldown.

All of those would be fully functional through the standard GPIO
interface as well as the legacy OMAP-only one, except GPIO42_OUT
which won't let you read the actual pin value after setting it.

There's no special off-mode support for these particular pins;
on Beagle they have external pullups or pulldowns.

(OMAP2 can use this naming convention too, except that since it
has no input-enable the "_OUT" convention can't be used there.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
REFRESHED against 2.6.27-rc8-omap-git as of today ...

 arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
 arch/arm/mach-omap2/mux.c               |    8 ++++++++
 arch/arm/plat-omap/include/mach/mux.h   |    8 ++++++++
 3 files changed, 27 insertions(+)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -43,6 +43,7 @@
 #include <mach/common.h>
 #include <mach/gpmc.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 
 
 #define GPMC_CS0_BASE  0x60
@@ -291,7 +292,17 @@ static void __init omap3_beagle_init(voi
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
+
+	omap_cfg_reg(AH8_34XX_GPIO29);
+	gpio_request(29, "mmc0_wp");
+	gpio_direction_input(29);
 	hsmmc_init();
+
+	omap_cfg_reg(J25_34XX_GPIO170);
+	gpio_request(170, "DVI_nPD");
+	/* REVISIT leave DVI powered down until it's needed ... */
+	gpio_direction_output(170, true);
+
 	usb_musb_init();
 	usb_ehci_init();
 	omap3beagle_flash_init();
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -416,6 +416,14 @@ MUX_CFG_34XX("AD2_3430_USB3FS_PHY_MM3_TX
 MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
 		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
 
+
+/* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
+ * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
+ */
+MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -749,6 +749,14 @@ enum omap34xx_index {
 	AD2_3430_USB3FS_PHY_MM3_TXDAT,
 	AC1_3430_USB3FS_PHY_MM3_TXEN_N,
 
+	/* 34xx GPIO
+	 *  - normally these are bidirectional, no internal pullup/pulldown
+	 *  - "_UP" suffix (GPIO3_UP) if internal pullup is configured
+	 *  - "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
+	 *  - "_OUT" suffix (GPIO3_OUT) for output-only pins (unlike 24xx)
+	 */
+	AH8_34XX_GPIO29,
+	J25_34XX_GPIO170,
 };
 
 struct omap_mux_cfg {

From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7-omap1-git] beagle: two more GPIOs
Date: Sun, 28 Sep 2008 10:55:04 -0700
Message-ID: <200809281055.05000.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:37048 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751896AbYI1RzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Sep 2008 13:55:08 -0400
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
p.s. Looks like for GPIOs we could probably stop requiring
the prefix saying which ball it uses on one BGA package...

 arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
 arch/arm/mach-omap2/mux.c               |    9 +++++++++
 arch/arm/plat-omap/include/mach/mux.h   |   10 +++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -43,6 +43,7 @@
 #include <mach/common.h>
 #include <mach/gpmc.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 
 
 #define GPMC_CS0_BASE  0x60
@@ -255,7 +256,17 @@ static void __init omap3_beagle_init(voi
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
@@ -373,6 +373,15 @@ MUX_CFG_34XX("AA13_3430_USB3HS_TLL_D6", 
 		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
 MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
 		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+
+/* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
+ * no internal pullup/pulldown without "_UP" or "_DOWN" suffix.
+ */
+MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -723,8 +723,16 @@ enum omap34xx_index {
 	AB12_3430_USB3HS_TLL_DATA4,
 	AB13_3430_USB3HS_TLL_DATA5,
 	AA13_3430_USB3HS_TLL_DATA6,
-	AA12_3430_USB3HS_TLL_DATA7
+	AA12_3430_USB3HS_TLL_DATA7,
 
+	/* 34xx GPIO
+	 *  - normally these are bidirectional, no internal pullup/pulldown
+	 *  - use "_UP" suffix (GPIO3_UP) if internal pullup is configured
+	 *  - use "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
+	 *  - use "_OUT" suffix (GPIO3_OUT) for output-only pins
+	 */
+	AH8_34XX_GPIO29,
+	J25_34XX_GPIO170,
 };
 
 struct omap_mux_cfg {

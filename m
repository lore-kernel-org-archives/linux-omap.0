From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/8] musb: Update musb_init() call for all OMAP3 boards
Date: Tue, 17 Nov 2009 20:39:51 +0530
Message-ID: <1258470596-24321-4-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbZKQPKu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 10:10:50 -0500
In-Reply-To: <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

musb_init() has been modified to pass board specific data so updating
this function call from all OMAP3 boards.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    7 ++++++-
 arch/arm/mach-omap2/board-3430sdp.c      |    8 +++++++-
 arch/arm/mach-omap2/board-ldp.c          |    7 ++++++-
 arch/arm/mach-omap2/board-omap3beagle.c  |    8 +++++++-
 arch/arm/mach-omap2/board-omap3evm.c     |    8 +++++++-
 arch/arm/mach-omap2/board-omap3pandora.c |    8 +++++++-
 arch/arm/mach-omap2/board-overo.c        |    8 +++++++-
 arch/arm/mach-omap2/board-rx51.c         |    7 ++++++-
 arch/arm/mach-omap2/board-zoom2.c        |    8 +++++++-
 arch/arm/mach-omap2/usb-musb.c           |   13 +++++--------
 arch/arm/plat-omap/include/mach/usb.h    |    3 ++-
 11 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 42217b3..970dcab 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -194,6 +195,10 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap_2430sdp_init(void)
 {
 	int ret;
@@ -203,7 +208,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 0acb556..85cd24f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -484,6 +485,11 @@ static void enable_board_wakeup_source(void)
 	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
 }
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -497,7 +503,7 @@ static void __init omap_3430sdp_init(void)
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	board_smc91x_init();
 	enable_board_wakeup_source();
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d57ec2f..a8338a4 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -27,6 +27,7 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -374,6 +375,10 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
@@ -384,7 +389,7 @@ static void __init omap_ldp_init(void)
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 08b0816..113bcfe 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -30,6 +30,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -400,6 +401,11 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -412,7 +418,7 @@ static void __init omap3_beagle_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 4c4d7f8..9e2656a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,6 +27,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -297,6 +298,11 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -311,7 +317,7 @@ static void __init omap3_evm_init(void)
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
 #endif
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	ads7846_dev_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7519edb..9bcd324 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -29,6 +29,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -387,6 +388,11 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
@@ -397,7 +403,7 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
 	pandora_keys_gpio_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9917d2f..e2acb91 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -384,13 +385,18 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init overo_init(void)
 {
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
 	overo_flash_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 78869a9..839d7a8 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -53,6 +54,10 @@ static struct omap_board_config_kernel rx51_config[] = {
 	{ OMAP_TAG_LCD,		&rx51_lcd_config },
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 static void __init rx51_init_irq(void)
 {
 	omap_board_config = rx51_config;
@@ -67,7 +72,7 @@ extern void __init rx51_peripherals_init(void);
 static void __init rx51_init(void)
 {
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	rx51_peripherals_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index ea00486..abe3059 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/regulator/machine.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -265,6 +266,11 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+/* musb board specific details */
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50,
+};
+
 extern int __init omap_zoom2_debugboard_init(void);
 
 static void __init omap_zoom2_init(void)
@@ -272,7 +278,7 @@ static void __init omap_zoom2_init(void)
 	omap_i2c_init();
 	omap_serial_init();
 	omap_zoom2_debugboard_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 }
 
 static void __init omap_zoom2_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 1145a25..0e9380c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -124,12 +124,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 	/* .clock is set dynamically */
 	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
-
-	/* REVISIT charge pump on TWL4030 can supply up to
-	 * 100 mA ... but this value is board-specific, like
-	 * "mode", and should be passed to usb_musb_init().
-	 */
-	.power		= 50,			/* up to 100 mA */
 };
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
@@ -146,8 +140,11 @@ static struct platform_device musb_device = {
 	.resource	= musb_resources,
 };
 
-void __init usb_musb_init(void)
+void __init usb_musb_init(struct musb_hdrc_board_data *board_data)
 {
+	/* get board-specific data */
+	musb_plat.board_data = board_data;
+
 	if (cpu_is_omap243x())
 		musb_resources[0].start = OMAP243X_HS_BASE;
 	else
@@ -167,7 +164,7 @@ void __init usb_musb_init(void)
 }
 
 #else
-void __init usb_musb_init(void)
+void __init usb_musb_init(struct musb_hdrc_board_data *board_data)
 {
 }
 #endif /* CONFIG_USB_MUSB_SOC */
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index f337e17..c64bd8c 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/usb/musb.h>
 #include <mach/board.h>
 
 /*-------------------------------------------------------------------------*/
@@ -27,7 +28,7 @@
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
-extern void usb_musb_init(void);
+extern void usb_musb_init(struct musb_hdrc_board_data *board_data);
 
 #endif
 
-- 
1.6.2.4


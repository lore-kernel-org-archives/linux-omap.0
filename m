From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/7] musb: Update musb_init() call for all OMAP3 boards
Date: Sun, 15 Nov 2009 14:29:34 +0530
Message-ID: <1258275578-1773-4-git-send-email-ajay.gupta@ti.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53844 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbZKOI7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:59:44 -0500
In-Reply-To: <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: felipe.balbi@nokia.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

musb_init() has been modified to pass board specific data so updating
this function call from all OMAP3 boards.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    7 ++++++-
 arch/arm/mach-omap2/board-3430sdp.c      |    7 ++++++-
 arch/arm/mach-omap2/board-cm-t35.c       |    7 ++++++-
 arch/arm/mach-omap2/board-ldp.c          |    7 ++++++-
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 ++++++-
 arch/arm/mach-omap2/board-omap3evm.c     |    7 ++++++-
 arch/arm/mach-omap2/board-omap3pandora.c |    7 ++++++-
 arch/arm/mach-omap2/board-overo.c        |    7 ++++++-
 arch/arm/mach-omap2/board-rx51.c         |    7 ++++++-
 arch/arm/mach-omap2/usb-musb.c           |    7 +++++--
 arch/arm/plat-omap/include/plat/usb.h    |    3 ++-
 11 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index db9374b..03d3634 100644
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
+	.power = 50
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
index a3c1271..dde1a96 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -484,6 +485,10 @@ static void enable_board_wakeup_source(void)
 	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
 }
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
@@ -509,7 +514,7 @@ static void __init omap_3430sdp_init(void)
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 22c4529..5d7656c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/regulator/machine.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -383,6 +384,10 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -491,7 +496,7 @@ static void __init cm_t35_init(void)
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 
 	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..0546c78 100644
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
+	.power = 50
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
index 7ad9846..683b468 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -30,6 +30,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -400,6 +401,10 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
@@ -424,7 +429,7 @@ static void __init omap3_beagle_init(void)
 	/* REVISIT leave DVI powered down until it's needed ... */
 	gpio_direction_output(170, true);
 
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index be93142..dad690f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,6 +27,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/musb.h>
 
 #include <linux/regulator/machine.h>
 
@@ -376,6 +377,10 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
@@ -427,7 +432,7 @@ static void __init omap3_evm_init(void)
 		omap_cfg_reg(AF4_34XX_GPIO135_OUT);
 		ehci_pdata.reset_gpio_port[1] = 135;
 	}
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index d81d1a0..da97a0d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -29,6 +29,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -387,6 +388,10 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
@@ -410,7 +415,7 @@ static void __init omap3pandora_init(void)
 	omap3pandora_ads7846_init();
 	usb_ehci_init(&ehci_pdata);
 	pandora_keys_gpio_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_cfg_reg(H16_34XX_SDRC_CKE0);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 92f3f3a..d16c714 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/usb/musb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -384,6 +385,10 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -402,7 +407,7 @@ static void __init overo_init(void)
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
 	overo_flash_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1bb1de2..60c8f9f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -55,6 +56,10 @@ static struct omap_board_config_kernel rx51_config[] = {
 	{ OMAP_TAG_LCD,		&rx51_lcd_config },
 };
 
+static struct musb_hdrc_board_data musb_bdata __initdata = {
+	.power = 50
+};
+
 static void __init rx51_init_irq(void)
 {
 	struct omap_sdrc_params *sdrc_params;
@@ -72,7 +77,7 @@ extern void __init rx51_peripherals_init(void);
 static void __init rx51_init(void)
 {
 	omap_serial_init();
-	usb_musb_init();
+	usb_musb_init(&musb_bdata);
 	rx51_peripherals_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index e89c6b1..29a59c9 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -140,8 +140,11 @@ static struct platform_device musb_device = {
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
@@ -161,7 +164,7 @@ void __init usb_musb_init(void)
 }
 
 #else
-void __init usb_musb_init(void)
+void __init usb_musb_init(struct musb_hdrc_board_data *board_data)
 {
 }
 #endif /* CONFIG_USB_MUSB_SOC */
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 33a500e..ec6bfe0 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/usb/musb.h>
 #include <plat/board.h>
 
 #define OMAP3_HS_USB_PORTS	3
@@ -42,7 +43,7 @@ struct ehci_hcd_omap_platform_data {
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
-extern void usb_musb_init(void);
+extern void usb_musb_init(struct musb_hdrc_board_data *board_data);
 
 extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
 
-- 
1.6.2.4


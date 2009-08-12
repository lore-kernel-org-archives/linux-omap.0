From: charu@ti.com
Subject: [RFC][PATCH 3/3] board files for msecure line mux configuration
Date: Wed, 12 Aug 2009 21:15:45 +0530
Message-ID: <1250091945-5472-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48219 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbZHLPqG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 11:46:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

Board files do platform dependent msecure line mux configuration.
Board files initialize rtc platform data.
RTC platform data required for configuring msecure line in rtc-twl4030.c.
mux.c and mux.h files modified for defining muxed RTC msecure GPIO lines.
These msecure lines are used in various twl4030 based platforms.


Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c      |   18 ++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c          |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c     |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c |    1 +
 arch/arm/mach-omap2/board-overo.c        |    1 +
 arch/arm/mach-omap2/board-zoom2.c        |    1 +
 arch/arm/mach-omap2/mux.c                |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h    |    2 ++
 10 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 06c644d..2b871a1 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -40,6 +40,8 @@
 
 #include "mmc-twl4030.h"
 
+#define TWL4030_MSECURE_GPIO    118
+
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
 
@@ -163,12 +165,17 @@ static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
+static struct twl4030_rtc_platform_data sdp2430_rtc_data = {
+	.msecure_gpio	= TWL4030_MSECURE_GPIO,
+};
+
 static struct twl4030_platform_data sdp2430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &sdp2430_gpio_data,
+	.rtc		= &sdp2430_rtc_data,
 };
 
 static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 351e8c5..8c47a08 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -274,6 +274,10 @@ static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.setup		= sdp3430_twl_gpio_setup,
 };
 
+static struct twl4030_rtc_platform_data sdp3430_rtc_data = {
+	.msecure_gpio	= TWL4030_MSECURE_GPIO,
+};
+
 static struct twl4030_usb_data sdp3430_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -511,6 +515,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	/* platform_data for children goes here */
 	.bci		= &sdp3430_bci_data,
 	.gpio		= &sdp3430_gpio_data,
+	.rtc		= &sdp3430_rtc_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
 	.power		= &sdp3430_t2scripts_data,
@@ -574,6 +579,16 @@ static inline void board_smc91x_init(void)
 
 #endif
 
+int sdp3430_rtc_init(void)
+{
+	/* msecure mux cfg */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			omap_rev() < OMAP3430_REV_ES2_0)
+		return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
+	else
+		return 0;
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -585,6 +600,9 @@ static void __init omap_3430sdp_init(void)
 	sdp3430_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
+	if (sdp3430_rtc_init())
+		printk(KERN_ERR "Failed to configure msecure gpio: "
+			"RTC functionality will not be available\n");
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 73e2bbb..ee66a35 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -33,6 +33,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mcspi.h>
+#include <mach/mux.h>
 #include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/common.h>
@@ -45,6 +46,8 @@
 
 #include "mmc-twl4030.h"
 
+#define TWL4030_MSECURE_GPIO	22
+
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
 #define DEBUG_BASE		0x08000000
@@ -306,6 +309,10 @@ static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
+static struct twl4030_rtc_platform_data ldp_rtc_data = {
+	.msecure_gpio	= TWL4030_MSECURE_GPIO,
+};
+
 static struct twl4030_madc_platform_data ldp_madc_data = {
 	.irq_line	= 1,
 };
@@ -338,6 +345,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.usb		= &ldp_usb_data,
 	.vmmc1		= &ldp_vmmc1,
 	.gpio		= &ldp_gpio_data,
+	.rtc		= &ldp_rtc_data,
 	.keypad		= &ldp_kp_twl4030_data,
 };
 
@@ -375,6 +383,16 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };
 
+int ldp_rtc_init(void)
+{
+	/* msecure mux cfg */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			omap_rev() < OMAP3430_REV_ES2_0)
+		return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
+	else
+		return 0;
+}
+
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
@@ -383,6 +401,9 @@ static void __init omap_ldp_init(void)
 	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
+	if (ldp_rtc_init())
+		printk(KERN_ERR "Failed to configure msecure gpio: "
+			"RTC functionality will not be available\n");
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 0c427ec..84e1bca 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -259,6 +259,7 @@ static struct twl4030_platform_data beagle_twldata = {
 
 	/* platform_data for children goes here */
 	.gpio		= &beagle_gpio_data,
+	.rtc		= NULL,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,
 	.vdac		= &beagle_vdac,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b35efaa..d667843 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -206,6 +206,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
+	.rtc		= NULL,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index bf6e09a..663c0ed 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -285,6 +285,7 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &omap3pandora_gpio_data,
+	.rtc		= NULL,
 	.usb		= &omap3pandora_usb_data,
 	.vmmc1		= &pandora_vmmc1,
 	.vmmc2		= &pandora_vmmc2,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 7f4937e..6dc590e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -338,6 +338,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
+	.rtc		= NULL,
 	.usb		= &overo_usb_data,
 	.vmmc1		= &overo_vmmc1,
 };
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 56b6f00..6b84d75 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -54,6 +54,7 @@ static struct twl4030_platform_data zoom2_twldata = {
 
 	/* platform_data for children goes here */
 	.gpio		= &zoom2_gpio_data,
+	.rtc		= NULL,
 };
 
 static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 43d6b92..9e1caeb 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -492,6 +492,11 @@ MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF9_34XX_GPIO22_OUT", 0x5ec,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OFF_OUTPUT_HIGH)
+/* AF9_34XX_V1_X_GPIO22_OUT pin used only for omap 3430 version<2.0 */
+MUX_CFG_34XX("AF9_34XX_V1_X_GPIO22_OUT", 0xa3c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 80281c4..efa9d0c 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -857,6 +857,8 @@ enum omap34xx_index {
 	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
 	H16_34XX_SDRC_CKE0,
 	H17_34XX_SDRC_CKE1,
+	AF9_34XX_GPIO22_OUT,
+	AF9_34XX_V1_X_GPIO22_OUT
 };
 
 struct omap_mux_cfg {
-- 
1.6.0.4


From: charu@ti.com
Subject: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
Date: Mon, 24 Aug 2009 20:37:35 +0530
Message-ID: <1251126455-27258-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58318 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZHXPHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 11:07:43 -0400
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
 arch/arm/mach-omap2/board-2430sdp.c   |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c   |   18 +++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c       |   19 +++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h |    2 ++
 5 files changed, 50 insertions(+), 1 deletions(-)

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
index 351e8c5..1bb79f5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -54,7 +54,7 @@
 #define ENABLE_VAUX3_DEDICATED	0x03
 #define ENABLE_VAUX3_DEV_GRP	0x20
 
-#define TWL4030_MSECURE_GPIO 22
+#define TWL4030_MSECURE_GPIO	22
 
 static int sdp3430_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
@@ -574,8 +574,24 @@ static inline void board_smc91x_init(void)
 
 #endif
 
+int sdp3430_rtc_init(void)
+{
+	struct twl4030_rtc_platform_data sdp3430_rtc_data;
+	/* msecure mux cfg */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			omap_rev() < OMAP3430_REV_ES2_0) {
+		sdp3430_rtc_data.msecure_gpio = TWL4030_MSECURE_GPIO;
+		sdp3430_twldata.rtc = &sdp3430_rtc_data;
+		return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
+	} else
+		return 0;
+};
+
 static void __init omap_3430sdp_init(void)
 {
+	if (sdp3430_rtc_init())
+		printk(KERN_ERR "Failed to configure msecure gpio: "
+				"RTC functionality will not be available\n");
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	if (omap_rev() > OMAP3430_REV_ES1_0)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 73e2bbb..92f8473 100644
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
@@ -375,8 +378,24 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };
 
+int ldp_rtc_init(void)
+{
+	struct twl4030_rtc_platform_data ldp_rtc_data;
+	/* msecure mux cfg */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
+			omap_rev() < OMAP3430_REV_ES2_0) {
+		ldp_rtc_data.msecure_gpio = TWL4030_MSECURE_GPIO;
+		ldp_twldata.rtc = &ldp_rtc_data;
+		return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
+	} else
+		return 0;
+}
+
 static void __init omap_ldp_init(void)
 {
+	if (ldp_rtc_init())
+		printk(KERN_ERR "Failed to configure msecure gpio: "
+				"RTC functionality will not be available\n");
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	ts_gpio = 54;
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


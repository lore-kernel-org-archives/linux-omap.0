From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: add MMC configuration for Palm Tungsten E
Date: Tue,  4 Dec 2018 19:58:12 +0200
Message-ID: <20181204175812.2678-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Add initial MMC configuration for Palm Tungsten E to allow using a proper
rootfs on the device. This still assumes the bootloader enabling the MMC,
and that the card is always present and writeable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-palmte.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 2dc5deb19803..d4d8a32e57eb 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -43,6 +43,7 @@
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
+#include "mmc.h"
 #include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
@@ -208,6 +209,33 @@ static void __init palmte_misc_gpio_setup(void)
 	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
 }
 
+#if IS_ENABLED(CONFIG_MMC_OMAP)
+
+static struct omap_mmc_platform_data _palmte_mmc_config = {
+	.nr_slots			= 1,
+	.slots[0]			= {
+		.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+		.name			= "mmcblk",
+	},
+};
+
+static struct omap_mmc_platform_data *palmte_mmc_config[OMAP15XX_NR_MMC] = {
+	[0] = &_palmte_mmc_config,
+};
+
+static void palmte_mmc_init(void)
+{
+	omap1_init_mmc(palmte_mmc_config, OMAP15XX_NR_MMC);
+}
+
+#else /* CONFIG_MMC_OMAP */
+
+static void palmte_mmc_init(void)
+{
+}
+
+#endif /* CONFIG_MMC_OMAP */
+
 static void __init omap_palmte_init(void)
 {
 	/* mux pins for uarts */
@@ -228,6 +256,7 @@ static void __init omap_palmte_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	omapfb_set_lcd_config(&palmte_lcd_config);
+	palmte_mmc_init();
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
-- 
2.17.0

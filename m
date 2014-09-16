From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap2: n8x0: move i2c devices to DT
Date: Tue, 16 Sep 2014 15:31:40 -0500
Message-ID: <1410899500-21323-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45349 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbaIPUcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 16:32:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

By moving i2c devices to DT we can clean up
i2c_board_info and fix a problem with moving
INTC to irq domain where IRQs can be renumbered
on each boot.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/omap2420-n810.dts         |  7 +++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi |  6 ++++++
 arch/arm/mach-omap2/board-n8x0.c            | 26 +++-----------------------
 arch/arm/mach-omap2/common-board-devices.h  |  5 +++++
 arch/arm/mach-omap2/pdata-quirks.c          |  2 ++
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/omap2420-n810.dts
index 21baec1..b604d26 100644
--- a/arch/arm/boot/dts/omap2420-n810.dts
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -6,3 +6,10 @@
 	model = "Nokia N810";
 	compatible = "nokia,n810", "nokia,n8x0", "ti,omap2420", "ti,omap2";
 };
+
+&i2c2 {
+	aic3x@18 {
+		compatible = "tlv320aic3x";
+		reg = <0x18>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 89608b2..24c50db 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -27,6 +27,12 @@
 
 &i2c1 {
 	clock-frequency = <400000>;
+
+	pmic@72 {
+		compatible = "menelaus";
+		reg = <0x72>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+	};
 };
 
 &i2c2 {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index aead77a..97767a2 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -33,6 +33,7 @@
 #include "mmc.h"
 #include "soc.h"
 #include "gpmc-onenand.h"
+#include "common-board-devices.h"
 
 #define TUSB6010_ASYNC_CS	1
 #define TUSB6010_SYNC_CS	4
@@ -568,29 +569,14 @@ static int n8x0_menelaus_late_init(struct device *dev)
 }
 #endif
 
-static struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
+struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
 	.late_init = n8x0_menelaus_late_init,
 };
 
-static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] __initdata = {
-	{
-		I2C_BOARD_INFO("menelaus", 0x72),
-		.irq = 7 + OMAP_INTC_START,
-		.platform_data = &n8x0_menelaus_platform_data,
-	},
-};
-
-static struct aic3x_pdata n810_aic33_data __initdata = {
+struct aic3x_pdata n810_aic33_data __initdata = {
 	.gpio_reset = 118,
 };
 
-static struct i2c_board_info n810_i2c_board_info_2[] __initdata = {
-	{
-		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-		.platform_data = &n810_aic33_data,
-	},
-};
-
 static int __init n8x0_late_initcall(void)
 {
 	if (!board_caps)
@@ -612,11 +598,5 @@ void * __init n8x0_legacy_init(void)
 	board_check_revision();
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
-	i2c_register_board_info(0, n8x0_i2c_board_info_1,
-				ARRAY_SIZE(n8x0_i2c_board_info_1));
-	if (board_is_n810())
-		i2c_register_board_info(1, n810_i2c_board_info_2,
-					ARRAY_SIZE(n810_i2c_board_info_2));
-
 	return &mmc1_data;
 }
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index f338177..07c88ae 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -1,6 +1,8 @@
 #ifndef __OMAP_COMMON_BOARD_DEVICES__
 #define __OMAP_COMMON_BOARD_DEVICES__
 
+#include <sound/tlv320aic3x.h>
+#include <linux/mfd/menelaus.h>
 #include "twl-common.h"
 
 #define NAND_BLOCK_SIZE	SZ_128K
@@ -12,4 +14,7 @@ void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
 void *n8x0_legacy_init(void);
 
+extern struct menelaus_platform_data n8x0_menelaus_platform_data;
+extern struct aic3x_pdata n810_aic33_data;
+
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 8695fd4..06a0ccf 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -336,6 +336,8 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
+	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
+	OF_DEV_AUXDATA("tlv320aic3x", 0x18, "2-0018", &n810_aic33_data),
 #endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
-- 
2.0.1.563.g66f467c


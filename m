From: "Hemanth V" <hemanthv@ti.com>
Subject: [RFC] [PATCH 2/2] Platform changes for CMA3000
Date: Fri, 30 Apr 2010 20:13:37 +0530 (IST)
Message-ID: <12076.10.24.255.18.1272638617.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Ossi.Kauppinen@vti.fi, hemanthv@ti.com
List-Id: linux-omap@vger.kernel.org

>From 68cde2e0304b1bd44e9fdbfbaa071e91cfcad419 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Fri, 30 Apr 2010 11:56:30 +0530
Subject: [PATCH] Platform changes for CMA3000


Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   38 ++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 72e7b14..717ad4b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/usb/otg.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/input/sfh7741.h>

@@ -39,9 +40,12 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/i2c/twl.h>
+#include <linux/i2c/cma3000.h>
 #include <linux/regulator/machine.h>
 #include "mmc-twl4030.h"

+#define OMAP4_CMA3000ACCL_GPIO		186
+
 static int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
@@ -503,6 +507,18 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.bci            = &sdp4430_bci_data,
 };

+static struct cma3000_platform_data cma3000_platform_data = {
+	.fuzz_x = 25,
+	.fuzz_y = 25,
+	.fuzz_z = 25,
+	.g_range = CMARANGE_8G,
+	.mode = CMAMODE_MOTDET,
+	.mdthr = 0x8,
+	.mdfftmr = 0x33,
+	.ffthr = 0x8,
+	.irqflags = IRQF_TRIGGER_HIGH,
+};
+
 static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl6030", 0x48),
@@ -526,6 +542,14 @@ static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 	},
 };

+static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("cma3000_accl", 0x1c),
+		.platform_data = &cma3000_platform_data,
+		.irq = OMAP_GPIO_IRQ(OMAP4_CMA3000ACCL_GPIO),
+	},
+};
+
 static int __init omap4_i2c_init(void)
 {
 	/* Phoenix Audio IC needs I2C1 to srat with 400 KHz and less */
@@ -535,7 +559,8 @@ static int __init omap4_i2c_init(void)
 				ARRAY_SIZE(sdp4430_i2c_2_boardinfo));
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
-	omap_register_i2c_bus(4, 400, 0, 0);
+	omap_register_i2c_bus(4, 400, sdp4430_i2c_4_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_4_boardinfo));

 	return 0;
 }
@@ -578,6 +603,16 @@ static void omap_ethernet_init(void)
 	gpio_direction_input(34);
 }

+static void omap_cma3000accl_init(void)
+{
+
+	if (gpio_request(OMAP4_CMA3000ACCL_GPIO, "Accelerometer") < 0) {
+		pr_err("Accelerometer GPIO request failed\n");
+		return;
+	}
+	gpio_direction_input(OMAP4_CMA3000ACCL_GPIO);
+
+}
 static void __init omap_4430sdp_init(void)
 {
 	omap4_i2c_init();
@@ -591,6 +626,7 @@ static void __init omap_4430sdp_init(void)
 	sdp4430_spi_board_info[0].irq = gpio_to_irq(34);
 	spi_register_board_info(sdp4430_spi_board_info,
 			ARRAY_SIZE(sdp4430_spi_board_info));
+	omap_cma3000accl_init();

 }

-- 
1.5.6.3




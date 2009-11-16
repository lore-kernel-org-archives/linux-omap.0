From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] omap3: zoom: rename zoom2 name to generic zoom
Date: Mon, 16 Nov 2009 15:28:32 -0800
Message-ID: <20091116232832.24892.64724.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56554 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbZKPX21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:28:27 -0500
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: vikram pandita <vikram.pandita@ti.com>

Replace zoom2 with zoom name in board-zoom-peripherals.c file
and board-zoom-debugboard.c. Create mach/board-zoom.h.

This file has functions reused for boards: Zoom2/Zoom3/sdp3630.
Hence have all functions commonly named as zoom

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c   |   70 +++++++++++------------
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   77 ++++++++++++-------------
 arch/arm/mach-omap2/board-zoom2.c             |    7 +-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    5 ++
 4 files changed, 81 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-zoom.h

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 91ecddc..bb4018b 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -16,18 +16,18 @@
 
 #include <plat/gpmc.h>
 
-#define ZOOM2_SMSC911X_CS	7
-#define ZOOM2_SMSC911X_GPIO	158
-#define ZOOM2_QUADUART_CS	3
-#define ZOOM2_QUADUART_GPIO	102
+#define ZOOM_SMSC911X_CS	7
+#define ZOOM_SMSC911X_GPIO	158
+#define ZOOM_QUADUART_CS	3
+#define ZOOM_QUADUART_GPIO	102
 #define QUART_CLK		1843200
 #define DEBUG_BASE		0x08000000
-#define ZOOM2_ETHR_START	DEBUG_BASE
+#define ZOOM_ETHR_START	DEBUG_BASE
 
-static struct resource zoom2_smsc911x_resources[] = {
+static struct resource zoom_smsc911x_resources[] = {
 	[0] = {
-		.start	= ZOOM2_ETHR_START,
-		.end	= ZOOM2_ETHR_START + SZ_4K,
+		.start	= ZOOM_ETHR_START,
+		.end	= ZOOM_ETHR_START + SZ_4K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -35,42 +35,42 @@ static struct resource zoom2_smsc911x_resources[] = {
 	},
 };
 
-static struct smsc911x_platform_config zoom2_smsc911x_config = {
+static struct smsc911x_platform_config zoom_smsc911x_config = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
 	.flags		= SMSC911X_USE_32BIT,
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 };
 
-static struct platform_device zoom2_smsc911x_device = {
+static struct platform_device zoom_smsc911x_device = {
 	.name		= "smsc911x",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(zoom2_smsc911x_resources),
-	.resource	= zoom2_smsc911x_resources,
+	.num_resources	= ARRAY_SIZE(zoom_smsc911x_resources),
+	.resource	= zoom_smsc911x_resources,
 	.dev		= {
-		.platform_data = &zoom2_smsc911x_config,
+		.platform_data = &zoom_smsc911x_config,
 	},
 };
 
-static inline void __init zoom2_init_smsc911x(void)
+static inline void __init zoom_init_smsc911x(void)
 {
 	int eth_cs;
 	unsigned long cs_mem_base;
 	int eth_gpio = 0;
 
-	eth_cs = ZOOM2_SMSC911X_CS;
+	eth_cs = ZOOM_SMSC911X_CS;
 
 	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
 		printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
 		return;
 	}
 
-	zoom2_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	zoom2_smsc911x_resources[0].end   = cs_mem_base + 0xff;
+	zoom_smsc911x_resources[0].start = cs_mem_base + 0x0;
+	zoom_smsc911x_resources[0].end   = cs_mem_base + 0xff;
 
-	eth_gpio = ZOOM2_SMSC911X_GPIO;
+	eth_gpio = ZOOM_SMSC911X_GPIO;
 
-	zoom2_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
+	zoom_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
 
 	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
@@ -94,7 +94,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}
 };
 
-static struct platform_device zoom2_debugboard_serial_device = {
+static struct platform_device zoom_debugboard_serial_device = {
 	.name			= "serial8250",
 	.id			= 3,
 	.dev			= {
@@ -102,13 +102,13 @@ static struct platform_device zoom2_debugboard_serial_device = {
 	},
 };
 
-static inline void __init zoom2_init_quaduart(void)
+static inline void __init zoom_init_quaduart(void)
 {
 	int quart_cs;
 	unsigned long cs_mem_base;
 	int quart_gpio = 0;
 
-	quart_cs = ZOOM2_QUADUART_CS;
+	quart_cs = ZOOM_QUADUART_CS;
 
 	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
 		printk(KERN_ERR "Failed to request GPMC mem"
@@ -116,7 +116,7 @@ static inline void __init zoom2_init_quaduart(void)
 		return;
 	}
 
-	quart_gpio = ZOOM2_QUADUART_GPIO;
+	quart_gpio = ZOOM_QUADUART_GPIO;
 
 	if (gpio_request(quart_gpio, "TL16CP754C GPIO") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
@@ -126,15 +126,15 @@ static inline void __init zoom2_init_quaduart(void)
 	gpio_direction_input(quart_gpio);
 }
 
-static inline int omap_zoom2_debugboard_detect(void)
+static inline int omap_zoom_debugboard_detect(void)
 {
 	int debug_board_detect = 0;
 	int ret = 1;
 
-	debug_board_detect = ZOOM2_SMSC911X_GPIO;
+	debug_board_detect = ZOOM_SMSC911X_GPIO;
 
-	if (gpio_request(debug_board_detect, "Zoom2 debug board detect") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for Zoom2 debug"
+	if (gpio_request(debug_board_detect, "Zoom debug board detect") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for Zoom debug"
 		"board detect\n", debug_board_detect);
 		return 0;
 	}
@@ -147,17 +147,17 @@ static inline int omap_zoom2_debugboard_detect(void)
 	return ret;
 }
 
-static struct platform_device *zoom2_devices[] __initdata = {
-	&zoom2_smsc911x_device,
-	&zoom2_debugboard_serial_device,
+static struct platform_device *zoom_devices[] __initdata = {
+	&zoom_smsc911x_device,
+	&zoom_debugboard_serial_device,
 };
 
-int __init omap_zoom2_debugboard_init(void)
+int __init zoom_debugboard_init(void)
 {
-	if (!omap_zoom2_debugboard_detect())
+	if (!omap_zoom_debugboard_detect())
 		return 0;
 
-	zoom2_init_smsc911x();
-	zoom2_init_quaduart();
-	return platform_add_devices(zoom2_devices, ARRAY_SIZE(zoom2_devices));
+	zoom_init_smsc911x();
+	zoom_init_quaduart();
+	return platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
 }
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 75cbbe7..3535b7a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -86,27 +86,27 @@ static struct matrix_keymap_data board_map_data = {
 	.keymap_size		= ARRAY_SIZE(board_keymap),
 };
 
-static struct twl4030_keypad_data zoom2_kp_twl4030_data = {
+static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.keymap_data	= &board_map_data,
 	.rows		= 8,
 	.cols		= 8,
 	.rep		= 1,
 };
 
-static struct regulator_consumer_supply zoom2_vmmc1_supply = {
+static struct regulator_consumer_supply zoom_vmmc1_supply = {
 	.supply		= "vmmc",
 };
 
-static struct regulator_consumer_supply zoom2_vsim_supply = {
+static struct regulator_consumer_supply zoom_vsim_supply = {
 	.supply		= "vmmc_aux",
 };
 
-static struct regulator_consumer_supply zoom2_vmmc2_supply = {
+static struct regulator_consumer_supply zoom_vmmc2_supply = {
 	.supply		= "vmmc",
 };
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data zoom2_vmmc1 = {
+static struct regulator_init_data zoom_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
@@ -117,11 +117,11 @@ static struct regulator_init_data zoom2_vmmc1 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vmmc1_supply,
+	.consumer_supplies      = &zoom_vmmc1_supply,
 };
 
 /* VMMC2 for MMC2 card */
-static struct regulator_init_data zoom2_vmmc2 = {
+static struct regulator_init_data zoom_vmmc2 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 1850000,
@@ -132,11 +132,11 @@ static struct regulator_init_data zoom2_vmmc2 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vmmc2_supply,
+	.consumer_supplies      = &zoom_vmmc2_supply,
 };
 
 /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data zoom2_vsim = {
+static struct regulator_init_data zoom_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
@@ -147,7 +147,7 @@ static struct regulator_init_data zoom2_vsim = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &zoom2_vsim_supply,
+	.consumer_supplies      = &zoom_vsim_supply,
 };
 
 static struct twl4030_hsmmc_info mmc[] __initdata = {
@@ -164,7 +164,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{}      /* Terminator */
 };
 
-static int zoom2_twl_gpio_setup(struct device *dev,
+static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ),
@@ -177,15 +177,15 @@ static int zoom2_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	zoom2_vmmc1_supply.dev = mmc[0].dev;
-	zoom2_vsim_supply.dev = mmc[0].dev;
-	zoom2_vmmc2_supply.dev = mmc[1].dev;
+	zoom_vmmc1_supply.dev = mmc[0].dev;
+	zoom_vsim_supply.dev = mmc[0].dev;
+	zoom_vmmc2_supply.dev = mmc[1].dev;
 
 	return 0;
 }
 
 
-static int zoom2_batt_table[] = {
+static int zoom_batt_table[] = {
 /* 0 C*/
 30800, 29500, 28300, 27100,
 26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
@@ -196,65 +196,64 @@ static int zoom2_batt_table[] = {
 4040,  3910,  3790,  3670,  3550
 };
 
-static struct twl4030_bci_platform_data zoom2_bci_data = {
-	.battery_tmp_tbl	= zoom2_batt_table,
-	.tblsize		= ARRAY_SIZE(zoom2_batt_table),
+static struct twl4030_bci_platform_data zoom_bci_data = {
+	.battery_tmp_tbl	= zoom_batt_table,
+	.tblsize		= ARRAY_SIZE(zoom_batt_table),
 };
 
-static struct twl4030_usb_data zoom2_usb_data = {
+static struct twl4030_usb_data zoom_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_gpio_platform_data zoom2_gpio_data = {
+static struct twl4030_gpio_platform_data zoom_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
-	.setup		= zoom2_twl_gpio_setup,
+	.setup		= zoom_twl_gpio_setup,
 };
 
-static struct twl4030_madc_platform_data zoom2_madc_data = {
+static struct twl4030_madc_platform_data zoom_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_codec_audio_data zoom2_audio_data = {
+static struct twl4030_codec_audio_data zoom_audio_data = {
 	.audio_mclk = 26000000,
 };
 
-static struct twl4030_codec_data zoom2_codec_data = {
+static struct twl4030_codec_data zoom_codec_data = {
 	.audio_mclk = 26000000,
-	.audio = &zoom2_audio_data,
+	.audio = &zoom_audio_data,
 };
 
-static struct twl4030_platform_data zoom2_twldata = {
+static struct twl4030_platform_data zoom_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
-	.bci		= &zoom2_bci_data,
-	.madc		= &zoom2_madc_data,
-	.usb		= &zoom2_usb_data,
-	.gpio		= &zoom2_gpio_data,
-	.keypad		= &zoom2_kp_twl4030_data,
-	.codec		= &zoom2_codec_data,
-	.vmmc1          = &zoom2_vmmc1,
-	.vmmc2          = &zoom2_vmmc2,
-	.vsim           = &zoom2_vsim,
+	.bci		= &zoom_bci_data,
+	.madc		= &zoom_madc_data,
+	.usb		= &zoom_usb_data,
+	.gpio		= &zoom_gpio_data,
+	.keypad		= &zoom_kp_twl4030_data,
+	.codec		= &zoom_codec_data,
+	.vmmc2          = &zoom_vmmc2,
+	.vsim           = &zoom_vsim,
 
 };
 
-static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
 		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &zoom2_twldata,
+		.platform_data	= &zoom_twldata,
 	},
 };
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
-			ARRAY_SIZE(zoom2_i2c_boardinfo));
+	omap_register_i2c_bus(1, 2600, zoom_i2c_boardinfo,
+			ARRAY_SIZE(zoom_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 31d485b..2f980e3 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -21,6 +21,8 @@
 #include <plat/common.h>
 #include <plat/board.h>
 
+#include <mach/board-zoom.h>
+
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static void __init omap_zoom2_init_irq(void)
@@ -56,13 +58,10 @@ static struct twl4030_platform_data zoom2_twldata = {
 
 #endif
 
-extern int __init omap_zoom2_debugboard_init(void);
-extern void __init zoom_peripherals_init(void);
-
 static void __init omap_zoom2_init(void)
 {
 	zoom_peripherals_init();
-	omap_zoom2_debugboard_init();
+	zoom_debugboard_init();
 }
 
 static void __init omap_zoom2_map_io(void)
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
new file mode 100644
index 0000000..c93b29e
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -0,0 +1,5 @@
+/*
+ * Defines for zoom boards
+ */
+extern int __init zoom_debugboard_init(void);
+extern void __init zoom_peripherals_init(void);


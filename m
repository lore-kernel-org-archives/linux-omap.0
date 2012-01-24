From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/16] OMAP1: pass LCD config with omapfb_set_lcd_config()
Date: Tue, 24 Jan 2012 12:00:28 +0200
Message-ID: <1327399231-20826-14-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53466 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755883Ab2AXKBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:10 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

LCD config for old omapfb driver is passed with OMAP_TAG_LCD from board
files or from the bootloader. In an effort to remove OMAP_TAG_LCD, this
patch adds omapfb_set_lcd_config() function that the board files can
call to set the LCD config.

This has the drawback that configuration can no longer come from the
bootloader. Of the boards supported by the kernel, this should only
affect N770 which depends on the data from the bootloader. This patch
adds an LCD config for N770 to its board files, but that is most
probably broken. Fixing this would need information about the HW setup
in N770 boards.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    9 +++------
 arch/arm/mach-omap1/board-fsample.c   |    9 +++------
 arch/arm/mach-omap1/board-h2.c        |    9 +++------
 arch/arm/mach-omap1/board-h3.c        |    9 +++------
 arch/arm/mach-omap1/board-htcherald.c |    9 +++------
 arch/arm/mach-omap1/board-innovator.c |   11 +++--------
 arch/arm/mach-omap1/board-nokia770.c  |   13 +++++++------
 arch/arm/mach-omap1/board-osk.c       |   14 ++++++--------
 arch/arm/mach-omap1/board-palmte.c    |   10 +++-------
 arch/arm/mach-omap1/board-palmtt.c    |   10 +++-------
 arch/arm/mach-omap1/board-palmz71.c   |   10 +++-------
 arch/arm/mach-omap1/board-perseus2.c  |    9 +++------
 arch/arm/mach-omap1/board-sx1.c       |   10 +++-------
 arch/arm/plat-omap/fb.c               |   22 ++++++++++++++++------
 include/linux/omapfb.h                |    2 ++
 15 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 88909cc..e0e8245 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/export.h>
+#include <linux/omapfb.h>
 
 #include <media/soc_camera.h>
 
@@ -169,10 +170,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_board_config_kernel ams_delta_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
-};
-
 static struct resource ams_delta_nand_resources[] = {
 	[0] = {
 		.start	= OMAP1_MPUIO_BASE,
@@ -302,8 +299,6 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
-	omap_board_config = ams_delta_config;
-	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
@@ -321,6 +316,8 @@ static void __init ams_delta_init(void)
 	ams_delta_init_fiq();
 
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
+
+	omapfb_set_lcd_config(&ams_delta_lcd_config);
 }
 
 static struct plat_serial8250_port ams_delta_modem_ports[] = {
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0b9464b..b00844f 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -290,10 +291,6 @@ static struct omap_lcd_config fsample_lcd_config = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel fsample_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&fsample_lcd_config },
-};
-
 static void __init omap_fsample_init(void)
 {
 	/* Early, board-dependent init */
@@ -352,10 +349,10 @@ static void __init omap_fsample_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	omap_board_config = fsample_config;
-	omap_board_config_size = ARRAY_SIZE(fsample_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+
+	omapfb_set_lcd_config(&fsample_lcd_config);
 }
 
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 00ad6b22..471233f 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -30,6 +30,7 @@
 #include <linux/input.h>
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 
@@ -391,10 +392,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&h2_lcd_config },
-};
-
 static void __init h2_init(void)
 {
 	h2_init_smc91x();
@@ -438,13 +435,13 @@ static void __init h2_init(void)
 	omap_cfg_reg(N19_1610_KBR5);
 
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
-	omap_board_config = h2_config;
-	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
 	omap1_usb_init(&h2_usb_config);
 	h2_mmc_init();
+
+	omapfb_set_lcd_config(&h2_lcd_config);
 }
 
 MACHINE_START(OMAP_H2, "TI-H2")
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4a7f251..7cfd25b 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -370,10 +371,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel h3_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&h3_lcd_config },
-};
-
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        {
 		I2C_BOARD_INFO("tps65013", 0x48),
@@ -426,13 +423,13 @@ static void __init h3_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	spi_register_board_info(h3_spi_board_info,
 				ARRAY_SIZE(h3_spi_board_info));
-	omap_board_config = h3_config;
-	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
 	omap1_usb_init(&h3_usb_config);
 	h3_mmc_init();
+
+	omapfb_set_lcd_config(&h3_lcd_config);
 }
 
 MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 731cc3d..af2afcf 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -36,6 +36,7 @@
 #include <linux/leds.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/omapfb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -398,10 +399,6 @@ static struct omap_lcd_config htcherald_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel htcherald_config[] __initdata = {
-	{ OMAP_TAG_LCD, &htcherald_lcd_config },
-};
-
 static struct platform_device lcd_device = {
 	.name           = "lcd_htcherald",
 	.id             = -1,
@@ -580,8 +577,6 @@ static void __init htcherald_init(void)
 	printk(KERN_INFO "HTC Herald init.\n");
 
 	/* Do board initialization before we register all the devices */
-	omap_board_config = htcherald_config;
-	omap_board_config_size = ARRAY_SIZE(htcherald_config);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	htcherald_disable_watchdog();
@@ -598,6 +593,8 @@ static void __init htcherald_init(void)
 	htc_mmc_data[0] = &htc_mmc1_data;
 	omap1_init_mmc(htc_mmc_data, 1);
 #endif
+
+	omapfb_set_lcd_config(&htcherald_lcd_config);
 }
 
 MACHINE_START(HERALD, "HTC Herald")
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 309369e..1d5ab66 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -370,10 +371,6 @@ static inline void innovator_mmc_init(void)
 }
 #endif
 
-static struct omap_board_config_kernel innovator_config[] = {
-	{ OMAP_TAG_LCD,		NULL },
-};
-
 static void __init innovator_init(void)
 {
 	if (cpu_is_omap1510())
@@ -416,17 +413,15 @@ static void __init innovator_init(void)
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		omap1_usb_init(&innovator1510_usb_config);
-		innovator_config[1].data = &innovator1510_lcd_config;
+		omapfb_set_lcd_config(&innovator1510_lcd_config);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (cpu_is_omap1610()) {
 		omap1_usb_init(&h2_usb_config);
-		innovator_config[1].data = &innovator1610_lcd_config;
+		omapfb_set_lcd_config(&innovator1610_lcd_config);
 	}
 #endif
-	omap_board_config = innovator_config;
-	omap_board_config_size = ARRAY_SIZE(innovator_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	innovator_mmc_init();
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7155d8c..5ddb5a8 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -98,15 +98,16 @@ static struct mipid_platform_data nokia770_mipid_platform_data = {
 	.shutdown = mipid_shutdown,
 };
 
+static struct omap_lcd_config nokia770_lcd_config __initdata = {
+	.ctrl_name	= "hwa742",
+};
+
 static void __init mipid_dev_init(void)
 {
-	const struct omap_lcd_config *conf;
+	nokia770_mipid_platform_data.nreset_gpio = -1;
+	nokia770_mipid_platform_data.data_lines = 16;
 
-	conf = omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
-	if (conf != NULL) {
-		nokia770_mipid_platform_data.nreset_gpio = conf->nreset_gpio;
-		nokia770_mipid_platform_data.data_lines = conf->data_lines;
-	}
+	omapfb_set_lcd_config(&nokia770_lcd_config);
 }
 
 static void __init ads7846_dev_init(void)
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 675de06..ef87465 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -34,6 +34,7 @@
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -300,12 +301,6 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 };
 #endif
 
-static struct omap_board_config_kernel osk_config[] __initdata = {
-#ifdef	CONFIG_OMAP_OSK_MISTRAL
-	{ OMAP_TAG_LCD,			&osk_lcd_config },
-#endif
-};
-
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
 #include <linux/input.h>
@@ -549,8 +544,6 @@ static void __init osk_init(void)
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
 	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
-	omap_board_config = osk_config;
-	omap_board_config_size = ARRAY_SIZE(osk_config);
 
 	l = omap_readl(USB_TRANSCEIVER_CTRL);
 	l |= (3 << 1);
@@ -567,6 +560,11 @@ static void __init osk_init(void)
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 	osk_mistral_init();
+
+#ifdef	CONFIG_OMAP_OSK_MISTRAL
+	omapfb_set_lcd_config(&osk_lcd_config);
+#endif
+
 }
 
 MACHINE_START(OMAP_OSK, "TI-OSK")
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 81fa27f..612342c 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -27,6 +27,7 @@
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/apm-emulation.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -209,10 +210,6 @@ static struct omap_lcd_config palmte_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel palmte_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&palmte_lcd_config },
-};
-
 static struct spi_board_info palmte_spi_info[] __initdata = {
 	{
 		.modalias	= "tsc2102",
@@ -250,9 +247,6 @@ static void __init omap_palmte_init(void)
 	omap_cfg_reg(UART3_TX);
 	omap_cfg_reg(UART3_RX);
 
-	omap_board_config = palmte_config;
-	omap_board_config_size = ARRAY_SIZE(palmte_config);
-
 	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
@@ -260,6 +254,8 @@ static void __init omap_palmte_init(void)
 	omap_serial_init();
 	omap1_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
+
+	omapfb_set_lcd_config(&palmte_lcd_config);
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 81cb821..b63350b 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/leds.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -273,10 +274,6 @@ static struct omap_lcd_config palmtt_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel palmtt_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
-};
-
 static void __init omap_mpu_wdt_mode(int mode) {
 	if (mode)
 		omap_writew(0x8000, OMAP_WDT_TIMER_MODE);
@@ -298,15 +295,14 @@ static void __init omap_palmtt_init(void)
 
 	omap_mpu_wdt_mode(0);
 
-	omap_board_config = palmtt_config;
-	omap_board_config_size = ARRAY_SIZE(palmtt_config);
-
 	platform_add_devices(palmtt_devices, ARRAY_SIZE(palmtt_devices));
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
 	omap1_usb_init(&palmtt_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
+
+	omapfb_set_lcd_config(&palmtt_lcd_config);
 }
 
 MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e881945..9924c70 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -239,10 +240,6 @@ static struct omap_lcd_config palmz71_lcd_config __initdata = {
 	.ctrl_name = "internal",
 };
 
-static struct omap_board_config_kernel palmz71_config[] __initdata = {
-	{OMAP_TAG_LCD,	&palmz71_lcd_config},
-};
-
 static irqreturn_t
 palmz71_powercable(int irq, void *dev_id)
 {
@@ -313,9 +310,6 @@ omap_palmz71_init(void)
 	palmz71_gpio_setup(1);
 	omap_mpu_wdt_mode(0);
 
-	omap_board_config = palmz71_config;
-	omap_board_config_size = ARRAY_SIZE(palmz71_config);
-
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	spi_register_board_info(palmz71_boardinfo,
@@ -324,6 +318,8 @@ omap_palmz71_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
+
+	omapfb_set_lcd_config(&palmz71_lcd_config);
 }
 
 MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index c000bed..44df931 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -249,10 +250,6 @@ static struct omap_lcd_config perseus2_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel perseus2_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&perseus2_lcd_config },
-};
-
 static void __init perseus2_init_smc91x(void)
 {
 	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
@@ -320,10 +317,10 @@ static void __init omap_perseus2_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	omap_board_config = perseus2_config;
-	omap_board_config_size = ARRAY_SIZE(perseus2_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+
+	omapfb_set_lcd_config(&perseus2_lcd_config);
 }
 
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 7bcd82a..0c880be 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -371,11 +372,6 @@ static struct platform_device *sx1_devices[] __initdata = {
 	&sx1_lcd_device,
 	&sx1_irda_device,
 };
-/*-----------------------------------------*/
-
-static struct omap_board_config_kernel sx1_config[] __initdata = {
-	{ OMAP_TAG_LCD,	&sx1_lcd_config },
-};
 
 /*-----------------------------------------*/
 
@@ -391,8 +387,6 @@ static void __init omap_sx1_init(void)
 
 	platform_add_devices(sx1_devices, ARRAY_SIZE(sx1_devices));
 
-	omap_board_config = sx1_config;
-	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap1_usb_init(&sx1_usb_config);
@@ -406,6 +400,8 @@ static void __init omap_sx1_init(void)
 	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
 	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
 	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
+
+	omapfb_set_lcd_config(&sx1_lcd_config);
 }
 
 MACHINE_START(SX1, "OMAP310 based Siemens SX1")
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 45f35c9..24e6269 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -37,6 +37,7 @@
 
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
+static bool omapfb_lcd_configured;
 static struct omapfb_platform_data omapfb_config;
 
 static u64 omap_fb_dma_mask = ~(u32)0;
@@ -52,16 +53,21 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-static int __init omap_init_fb(void)
+void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
 {
-	const struct omap_lcd_config *conf;
+	omapfb_config.lcd = *config;
+	omapfb_lcd_configured = true;
+}
 
-	conf = omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
-	if (conf == NULL)
+static int __init omap_init_fb(void)
+{
+	/*
+	 * If the board file has not set the lcd config with
+	 * omapfb_set_lcd_config(), don't bother registering the omapfb device
+	 */
+	if (!omapfb_lcd_configured)
 		return 0;
 
-	omapfb_config.lcd = *conf;
-
 	return platform_device_register(&omap_fb_device);
 }
 
@@ -90,4 +96,8 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
+#else
+
+void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
+
 #endif
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index a575706..4ff57e8 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -226,6 +226,8 @@ struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 };
 
+void __init omapfb_set_lcd_config(const struct omap_lcd_config *config);
+
 #endif
 
 #endif /* __OMAPFB_H */
-- 
1.7.4.1


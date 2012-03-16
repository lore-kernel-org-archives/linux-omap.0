From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 1/2] omap1/board-files: fix OMAP_GPIO_IRQ usage with gpio_to_irq()
Date: Fri, 16 Mar 2012 17:54:06 +0530
Message-ID: <1331900647-3508-2-git-send-email-tarun.kanti@ti.com>
References: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422722Ab2CPMYV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 08:24:21 -0400
In-Reply-To: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

With dynamic allocation of IRQ the usage of OMAP_GPIO_IRQ
is no longer valid. We should be using gpio_to_irq() instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/board-h2.c        |    8 ++++----
 arch/arm/mach-omap1/board-h3.c        |    8 ++++----
 arch/arm/mach-omap1/board-htcherald.c |    6 +++---
 arch/arm/mach-omap1/board-innovator.c |    4 ++--
 arch/arm/mach-omap1/board-nokia770.c  |    1 +
 arch/arm/mach-omap1/board-osk.c       |   12 ++++++------
 arch/arm/mach-omap1/board-palmte.c    |    2 +-
 arch/arm/mach-omap1/board-palmtt.c    |    2 +-
 arch/arm/mach-omap1/board-palmz71.c   |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c |   16 +++++++---------
 10 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 00ad6b2..ad0eece 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -244,8 +244,6 @@ static struct resource h2_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(0),
-		.end	= OMAP_GPIO_IRQ(0),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -364,11 +362,9 @@ static struct tps65010_board tps_board = {
 static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.irq            = OMAP_GPIO_IRQ(58),
 		.platform_data	= &tps_board,
 	}, {
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
-		.irq		= OMAP_GPIO_IRQ(2),
 	},
 };
 
@@ -437,10 +433,14 @@ static void __init h2_init(void)
 	omap_cfg_reg(E19_1610_KBR4);
 	omap_cfg_reg(N19_1610_KBR5);
 
+	h2_devices[2]->resource[1].start = gpio_to_irq(0);
+	h2_devices[2]->resource[1].end = gpio_to_irq(0);
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
+	h2_i2c_board_info[0].irq = gpio_to_irq(58);
+	h2_i2c_board_info[1].irq = gpio_to_irq(2);
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
 	omap1_usb_init(&h2_usb_config);
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4a7f251..692b16d 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -246,8 +246,6 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(40),
-		.end	= OMAP_GPIO_IRQ(40),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -337,7 +335,6 @@ static struct spi_board_info h3_spi_board_info[] __initdata = {
 		.modalias	= "tsc2101",
 		.bus_num	= 2,
 		.chip_select	= 0,
-		.irq		= OMAP_GPIO_IRQ(H3_TS_GPIO),
 		.max_speed_hz	= 16000000,
 		/* .platform_data	= &tsc_platform_data, */
 	},
@@ -381,7 +378,6 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        },
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
-		.irq		= OMAP_GPIO_IRQ(14),
 	},
 };
 
@@ -423,12 +419,16 @@ static void __init h3_init(void)
 	omap_cfg_reg(E19_1610_KBR4);
 	omap_cfg_reg(N19_1610_KBR5);
 
+	devices[2]->resource[1].start = gpio_to_irq(40);
+	devices[2]->resource[1].end = gpio_to_irq(40);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	h3_spi_board_info[0].irq = gpio_to_irq(H3_TS_GPIO);
 	spi_register_board_info(h3_spi_board_info,
 				ARRAY_SIZE(h3_spi_board_info));
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
+	h3_i2c_board_info[1].irq = gpio_to_irq(14);
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
 	omap1_usb_init(&h3_usb_config);
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 731cc3d..766b1e3 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -324,8 +324,6 @@ static struct platform_device gpio_leds_device = {
 
 static struct resource htcpld_resources[] = {
 	[0] = {
-		.start  = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
-		.end    = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -454,7 +452,6 @@ static struct spi_board_info __initdata htcherald_spi_board_info[] = {
 	{
 		.modalias		= "ads7846",
 		.platform_data		= &htcherald_ts_platform_data,
-		.irq			= OMAP_GPIO_IRQ(HTCHERALD_GPIO_TS),
 		.max_speed_hz		= 2500000,
 		.bus_num		= 2,
 		.chip_select		= 1,
@@ -582,6 +579,8 @@ static void __init htcherald_init(void)
 	/* Do board initialization before we register all the devices */
 	omap_board_config = htcherald_config;
 	omap_board_config_size = ARRAY_SIZE(htcherald_config);
+	devices[2]->resource[0].start = gpio_to_irq(HTCHERALD_GIRQ_BTNS);
+	devices[2]->resource[0].end = gpio_to_irq(HTCHERALD_GIRQ_BTNS);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	htcherald_disable_watchdog();
@@ -589,6 +588,7 @@ static void __init htcherald_init(void)
 	htcherald_usb_enable();
 	omap1_usb_init(&htcherald_usb_config);
 
+	htcherald_spi_board_info[0].irq = gpio_to_irq(HTCHERALD_GPIO_TS);
 	spi_register_board_info(htcherald_spi_board_info,
 		ARRAY_SIZE(htcherald_spi_board_info));
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index be2002f..965f3d7 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -244,8 +244,6 @@ static struct resource innovator1610_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(0),
-		.end	= OMAP_GPIO_IRQ(0),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -409,6 +407,8 @@ static void __init innovator_init(void)
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (!cpu_is_omap1510()) {
+		innovator1610_devices[1]->resource[1].start = gpio_to_irq(0);
+		innovator1610_devices[1]->resource[1].end = gpio_to_irq(0);
 		platform_add_devices(innovator1610_devices, ARRAY_SIZE(innovator1610_devices));
 	}
 #endif
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index f9efc03..c0b3ce7 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -240,6 +240,7 @@ static void __init omap_nokia770_init(void)
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
+	nokia770_spi_board_info[1].irq = gpio_to_irq(15);
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 675de06..6791887 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -129,8 +129,6 @@ static struct resource osk5912_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(0),
-		.end	= OMAP_GPIO_IRQ(0),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -147,8 +145,6 @@ static struct platform_device osk5912_smc91x_device = {
 
 static struct resource osk5912_cf_resources[] = {
 	[0] = {
-		.start	= OMAP_GPIO_IRQ(62),
-		.end	= OMAP_GPIO_IRQ(62),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -240,7 +236,6 @@ static struct tps65010_board tps_board = {
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.irq		= OMAP_GPIO_IRQ(OMAP_MPUIO(1)),
 		.platform_data	= &tps_board,
 
 	},
@@ -414,7 +409,6 @@ static struct spi_board_info __initdata mistral_boardinfo[] = { {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias		= "ads7846",
 	.platform_data		= &mistral_ts_info,
-	.irq			= OMAP_GPIO_IRQ(4),
 	.max_speed_hz		= 120000 /* max sample rate at 3V */
 					* 26 /* command + data + overhead */,
 	.bus_num		= 2,
@@ -477,6 +471,7 @@ static void __init osk_mistral_init(void)
 	gpio_direction_input(4);
 	irq_set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
+	mistral_boardinfo[0].irq = gpio_to_irq(4);
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
 
@@ -548,6 +543,10 @@ static void __init osk_init(void)
 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
+	osk5912_devices[1]->resource[1].start = gpio_to_irq(0);
+	osk5912_devices[1]->resource[1].end = gpio_to_irq(0);
+	osk5912_devices[2]->resource[0].start = gpio_to_irq(62);
+	osk5912_devices[2]->resource[0].end = gpio_to_irq(62);
 	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
 	omap_board_config = osk_config;
 	omap_board_config_size = ARRAY_SIZE(osk_config);
@@ -564,6 +563,7 @@ static void __init osk_init(void)
 		gpio_direction_input(OMAP_MPUIO(1));
 
 	omap_serial_init();
+	osk_i2c_board_info[0].irq = gpio_to_irq(OMAP_MPUIO(1));
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 	osk_mistral_init();
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 81fa27f..108c7d1 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -218,7 +218,6 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
 		.modalias	= "tsc2102",
 		.bus_num	= 2,	/* uWire (officially) */
 		.chip_select	= 0,	/* As opposed to 3 */
-		.irq		= OMAP_GPIO_IRQ(PALMTE_PINTDAV_GPIO),
 		.max_speed_hz	= 8000000,
 	},
 };
@@ -255,6 +254,7 @@ static void __init omap_palmte_init(void)
 
 	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
+	palmte_spi_info[0].irq = gpio_to_irq(PALMTE_PINTDAV_GPIO);
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
 	palmte_misc_gpio_setup();
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 81cb821..b87a92f 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -255,7 +255,6 @@ static struct spi_board_info __initdata palmtt_boardinfo[] = {
 		/* MicroWire (bus 2) CS0 has an ads7846e */
 		.modalias	= "ads7846",
 		.platform_data	= &palmtt_ts_info,
-		.irq		= OMAP_GPIO_IRQ(6),
 		.max_speed_hz	= 120000	/* max sample rate at 3V */
 					* 26	/* command + data + overhead */,
 		.bus_num	= 2,
@@ -303,6 +302,7 @@ static void __init omap_palmtt_init(void)
 
 	platform_add_devices(palmtt_devices, ARRAY_SIZE(palmtt_devices));
 
+	palmtt_boardinfo[0].irq = gpio_to_irq(6);
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
 	omap1_usb_init(&palmtt_usb_config);
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e881945..0ff25fa 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -222,7 +222,6 @@ static struct spi_board_info __initdata palmz71_boardinfo[] = { {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias	= "ads7846",
 	.platform_data	= &palmz71_ts_info,
-	.irq		= OMAP_GPIO_IRQ(PALMZ71_PENIRQ_GPIO),
 	.max_speed_hz	= 120000	/* max sample rate at 3V */
 				* 26	/* command + data + overhead */,
 	.bus_num	= 2,
@@ -318,6 +317,7 @@ omap_palmz71_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	palmz71_boardinfo[0].irq = gpio_to_irq(PALMZ71_PENIRQ_GPIO);
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap1_usb_init(&palmz71_usb_config);
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index f83a502..63732fe 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -42,7 +42,6 @@
 static struct plat_serial8250_port voiceblue_ports[] = {
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x40000),
-		.irq		= OMAP_GPIO_IRQ(12),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -50,7 +49,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x50000),
-		.irq		= OMAP_GPIO_IRQ(13),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -58,7 +56,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x60000),
-		.irq		= OMAP_GPIO_IRQ(14),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -66,7 +63,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x70000),
-		.irq		= OMAP_GPIO_IRQ(15),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -78,9 +74,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 static struct platform_device serial_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_PLATFORM1,
-	.dev			= {
-		.platform_data	= voiceblue_ports,
-	},
 };
 
 static int __init ext_uart_init(void)
@@ -88,6 +81,11 @@ static int __init ext_uart_init(void)
 	if (!machine_is_voiceblue())
 		return -ENODEV;
 
+	voiceblue_ports[0].irq = gpio_to_irq(12);
+	voiceblue_ports[1].irq = gpio_to_irq(13);
+	voiceblue_ports[2].irq = gpio_to_irq(14);
+	voiceblue_ports[3].irq = gpio_to_irq(15);
+	serial_device.dev.platform_data = voiceblue_ports;
 	return platform_device_register(&serial_device);
 }
 arch_initcall(ext_uart_init);
@@ -126,8 +124,6 @@ static struct resource voiceblue_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(8),
-		.end	= OMAP_GPIO_IRQ(8),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -273,6 +269,8 @@ static void __init voiceblue_init(void)
 	irq_set_irq_type(gpio_to_irq(14), IRQ_TYPE_EDGE_RISING);
 	irq_set_irq_type(gpio_to_irq(15), IRQ_TYPE_EDGE_RISING);
 
+	voiceblue_devices[1]->resource[1].start = gpio_to_irq(8);
+	voiceblue_devices[1]->resource[1].end = gpio_to_irq(8);
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
-- 
1.7.0.4


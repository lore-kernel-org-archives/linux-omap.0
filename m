From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
Date: Thu, 29 Mar 2012 09:03:45 -0700
Message-ID: <20120329160344.GV9859@atomide.com>
References: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58377 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933597Ab2C2QDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 12:03:48 -0400
Content-Disposition: inline
In-Reply-To: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, olof@lixom.net, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120329 03:05]:
> These four patches incorporate changes to OMAP1 and OMAP2 platforms
> board files whereby older references to OMAP_GPIO_IRQ macro are
> now replaced with gpio_to_irq(), thereby getting rid of static
> irq references.

Thanks, I'll take your updated patches 1/4 and 2/4 combined
into one. And I'll use my earlier updated comments to mention
the breaking commits. As 3/4 and 4/4 have not changed, I'll
use the earlier ones with an ack from Dmitry.

Updated combined 1/4 and 2/4 below.

Tony


From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Thu, 29 Mar 2012 08:41:01 -0700
Subject: [PATCH] ARM: OMAP: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()

The following commits change gpio-omap to use dynamic
IRQ allocation:

25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
384ebe1 gpio/omap: Add DT support to GPIO driver

With dynamic allocation of IRQ the usage of OMAP_GPIO_IRQ
is no longer valid. We must be using gpio_to_irq() instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 03e0050..3768088 100644
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
 
+	h2_smc91x_resources[1].start = gpio_to_irq(0);
+	h2_smc91x_resources[1].end = gpio_to_irq(0);
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
index f304fe2..09e8582 100644
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
@@ -377,11 +374,9 @@ static struct omap_board_config_kernel h3_config[] __initdata = {
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        {
 		I2C_BOARD_INFO("tps65013", 0x48),
-               /* .irq         = OMAP_GPIO_IRQ(??), */
        },
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
-		.irq		= OMAP_GPIO_IRQ(14),
 	},
 };
 
@@ -423,12 +418,16 @@ static void __init h3_init(void)
 	omap_cfg_reg(E19_1610_KBR4);
 	omap_cfg_reg(N19_1610_KBR5);
 
+	smc91x_resources[1].start = gpio_to_irq(40);
+	smc91x_resources[1].end = gpio_to_irq(40);
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
index fa52d14..797bbd6 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -323,8 +323,6 @@ static struct platform_device gpio_leds_device = {
 
 static struct resource htcpld_resources[] = {
 	[0] = {
-		.start  = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
-		.end    = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -453,7 +451,6 @@ static struct spi_board_info __initdata htcherald_spi_board_info[] = {
 	{
 		.modalias		= "ads7846",
 		.platform_data		= &htcherald_ts_platform_data,
-		.irq			= OMAP_GPIO_IRQ(HTCHERALD_GPIO_TS),
 		.max_speed_hz		= 2500000,
 		.bus_num		= 2,
 		.chip_select		= 1,
@@ -581,6 +578,8 @@ static void __init htcherald_init(void)
 	/* Do board initialization before we register all the devices */
 	omap_board_config = htcherald_config;
 	omap_board_config_size = ARRAY_SIZE(htcherald_config);
+	htcpld_resources[0].start = gpio_to_irq(HTCHERALD_GIRQ_BTNS);
+	htcpld_resources[0].end = gpio_to_irq(HTCHERALD_GIRQ_BTNS);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	htcherald_disable_watchdog();
@@ -588,6 +587,7 @@ static void __init htcherald_init(void)
 	htcherald_usb_enable();
 	omap1_usb_init(&htcherald_usb_config);
 
+	htcherald_spi_board_info[0].irq = gpio_to_irq(HTCHERALD_GPIO_TS);
 	spi_register_board_info(htcherald_spi_board_info,
 		ARRAY_SIZE(htcherald_spi_board_info));
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 289a6b8..315c021 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -247,8 +247,6 @@ static struct resource innovator1610_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(0),
-		.end	= OMAP_GPIO_IRQ(0),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -412,6 +410,8 @@ static void __init innovator_init(void)
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (!cpu_is_omap1510()) {
+		innovator1610_smc91x_resources[1].start = gpio_to_irq(0);
+		innovator1610_smc91x_resources[1].end = gpio_to_irq(0);
 		platform_add_devices(innovator1610_devices, ARRAY_SIZE(innovator1610_devices));
 	}
 #endif
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index abdbdb0..1d87332 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -147,7 +147,6 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 		.bus_num        = 2,
 		.chip_select    = 0,
 		.max_speed_hz   = 2500000,
-		.irq		= OMAP_GPIO_IRQ(15),
 		.platform_data	= &nokia770_ads7846_platform_data,
 	},
 };
@@ -242,6 +241,7 @@ static void __init omap_nokia770_init(void)
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
+	nokia770_spi_board_info[1].irq = gpio_to_irq(15);
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e2d7ae4..a0c1a1c 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -128,8 +128,6 @@ static struct resource osk5912_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(0),
-		.end	= OMAP_GPIO_IRQ(0),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -146,8 +144,6 @@ static struct platform_device osk5912_smc91x_device = {
 
 static struct resource osk5912_cf_resources[] = {
 	[0] = {
-		.start	= OMAP_GPIO_IRQ(62),
-		.end	= OMAP_GPIO_IRQ(62),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -239,7 +235,6 @@ static struct tps65010_board tps_board = {
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.irq		= OMAP_GPIO_IRQ(OMAP_MPUIO(1)),
 		.platform_data	= &tps_board,
 
 	},
@@ -413,7 +408,6 @@ static struct spi_board_info __initdata mistral_boardinfo[] = { {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias		= "ads7846",
 	.platform_data		= &mistral_ts_info,
-	.irq			= OMAP_GPIO_IRQ(4),
 	.max_speed_hz		= 120000 /* max sample rate at 3V */
 					* 26 /* command + data + overhead */,
 	.bus_num		= 2,
@@ -476,6 +470,7 @@ static void __init osk_mistral_init(void)
 	gpio_direction_input(4);
 	irq_set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
+	mistral_boardinfo[0].irq = gpio_to_irq(4);
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
 
@@ -547,6 +542,10 @@ static void __init osk_init(void)
 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
+	osk5912_smc91x_resources[1].start = gpio_to_irq(0);
+	osk5912_smc91x_resources[1].end = gpio_to_irq(0);
+	osk5912_cf_resources[0].start = gpio_to_irq(62);
+	osk5912_cf_resources[0].end = gpio_to_irq(62);
 	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
 	omap_board_config = osk_config;
 	omap_board_config_size = ARRAY_SIZE(osk_config);
@@ -563,6 +562,7 @@ static void __init osk_init(void)
 		gpio_direction_input(OMAP_MPUIO(1));
 
 	omap_serial_init();
+	osk_i2c_board_info[0].irq = gpio_to_irq(OMAP_MPUIO(1));
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 	osk_mistral_init();
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 04efa7e..66e2a74 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -220,7 +220,6 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
 		.modalias	= "tsc2102",
 		.bus_num	= 2,	/* uWire (officially) */
 		.chip_select	= 0,	/* As opposed to 3 */
-		.irq		= OMAP_GPIO_IRQ(PALMTE_PINTDAV_GPIO),
 		.max_speed_hz	= 8000000,
 	},
 };
@@ -257,6 +256,7 @@ static void __init omap_palmte_init(void)
 
 	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
+	palmte_spi_info[0].irq = gpio_to_irq(PALMTE_PINTDAV_GPIO);
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
 	palmte_misc_gpio_setup();
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index acd1f36..fa9ce9c 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -256,7 +256,6 @@ static struct spi_board_info __initdata palmtt_boardinfo[] = {
 		/* MicroWire (bus 2) CS0 has an ads7846e */
 		.modalias	= "ads7846",
 		.platform_data	= &palmtt_ts_info,
-		.irq		= OMAP_GPIO_IRQ(6),
 		.max_speed_hz	= 120000	/* max sample rate at 3V */
 					* 26	/* command + data + overhead */,
 		.bus_num	= 2,
@@ -304,6 +303,7 @@ static void __init omap_palmtt_init(void)
 
 	platform_add_devices(palmtt_devices, ARRAY_SIZE(palmtt_devices));
 
+	palmtt_boardinfo[0].irq = gpio_to_irq(6);
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
 	omap1_usb_init(&palmtt_usb_config);
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index c1cd0f2..b21df2f 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -223,7 +223,6 @@ static struct spi_board_info __initdata palmz71_boardinfo[] = { {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias	= "ads7846",
 	.platform_data	= &palmz71_ts_info,
-	.irq		= OMAP_GPIO_IRQ(PALMZ71_PENIRQ_GPIO),
 	.max_speed_hz	= 120000	/* max sample rate at 3V */
 				* 26	/* command + data + overhead */,
 	.bus_num	= 2,
@@ -319,6 +318,7 @@ omap_palmz71_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	palmz71_boardinfo[0].irq = gpio_to_irq(PALMZ71_PENIRQ_GPIO);
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap1_usb_init(&palmz71_usb_config);
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 659d0f7..37232d0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -44,7 +44,6 @@
 static struct plat_serial8250_port voiceblue_ports[] = {
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x40000),
-		.irq		= OMAP_GPIO_IRQ(12),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -52,7 +51,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x50000),
-		.irq		= OMAP_GPIO_IRQ(13),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -60,7 +58,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x60000),
-		.irq		= OMAP_GPIO_IRQ(14),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -68,7 +65,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 	},
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x70000),
-		.irq		= OMAP_GPIO_IRQ(15),
 		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
@@ -80,9 +76,6 @@ static struct plat_serial8250_port voiceblue_ports[] = {
 static struct platform_device serial_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_PLATFORM1,
-	.dev			= {
-		.platform_data	= voiceblue_ports,
-	},
 };
 
 static int __init ext_uart_init(void)
@@ -90,6 +83,11 @@ static int __init ext_uart_init(void)
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
@@ -128,8 +126,6 @@ static struct resource voiceblue_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(8),
-		.end	= OMAP_GPIO_IRQ(8),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -275,6 +271,8 @@ static void __init voiceblue_init(void)
 	irq_set_irq_type(gpio_to_irq(14), IRQ_TYPE_EDGE_RISING);
 	irq_set_irq_type(gpio_to_irq(15), IRQ_TYPE_EDGE_RISING);
 
+	voiceblue_smc91x_resources[1].start = gpio_to_irq(8);
+	voiceblue_smc91x_resources[1].end = gpio_to_irq(8);
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 7370983..5a1b6af 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -230,12 +230,12 @@ static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2D),
 		.flags = I2C_CLIENT_WAKE,
-		.irq = OMAP_GPIO_IRQ(78),
 	},
 };
 
 static int __init omap2430_i2c_init(void)
 {
+	sdp2430_i2c1_boardinfo[0].irq = gpio_to_irq(78);
 	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
 	omap_pmic_init(2, 100, "twl4030", INT_24XX_SYS_NIRQ,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4e90715..a09c699 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -873,7 +873,6 @@ static void __init omap4_sdp4430_wifi_mux_init(void)
 }
 
 static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata = {
-	.irq = OMAP_GPIO_IRQ(GPIO_WIFI_IRQ),
 	.board_ref_clock = WL12XX_REFCLOCK_26,
 	.board_tcxo_clock = WL12XX_TCXOCLOCK_26,
 };
@@ -883,6 +882,7 @@ static void __init omap4_sdp4430_wifi_init(void)
 	int ret;
 
 	omap4_sdp4430_wifi_mux_init();
+	omap4_sdp4430_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
 	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
 	if (ret)
 		pr_err("Error setting wl12xx data: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index ac77382..768ece2 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -136,8 +136,6 @@ static struct resource apollon_smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(APOLLON_ETHR_GPIO_IRQ),
-		.end	= OMAP_GPIO_IRQ(APOLLON_ETHR_GPIO_IRQ),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -341,6 +339,8 @@ static void __init omap_apollon_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
+	apollon_smc91x_resources[1].start = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
+	apollon_smc91x_resources[1].end = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e873063..87cdb86 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -410,7 +410,6 @@ static struct resource omap_dm9000_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[2] = {
-		.start		= OMAP_GPIO_IRQ(OMAP_DM9000_GPIO_IRQ),
 		.flags		= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };
@@ -637,6 +636,7 @@ static void __init devkit8000_init(void)
 	omap_dm9000_init();
 
 	devkit8000_i2c_init();
+	omap_dm9000_resources[2].start = gpio_to_irq(OMAP_DM9000_GPIO_IRQ);
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 54af800..0bbbabe 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -348,7 +348,6 @@ static struct at24_platform_data m24c01 = {
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
-		.irq		= OMAP_GPIO_IRQ(125),
 	},
 	{	/* EEPROM on mainboard */
 		I2C_BOARD_INFO("24c01", 0x52),
@@ -377,6 +376,7 @@ static void __init omap_h4_init(void)
 	 */
 
 	board_mkp_init();
+	h4_i2c_board_info[0].irq = gpio_to_irq(125);
 	i2c_register_board_info(1, h4_i2c_board_info,
 			ARRAY_SIZE(h4_i2c_board_info));
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c775bea..20a4743 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -487,7 +487,6 @@ static struct platform_device omap3evm_wlan_regulator = {
 };
 
 struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
-	.irq = OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
 	.board_ref_clock = WL12XX_REFCLOCK_38, /* 38.4 MHz */
 };
 #endif
@@ -623,6 +622,7 @@ static void __init omap3_evm_wl12xx_init(void)
 	int ret;
 
 	/* WL12xx WLAN Init */
+	omap3evm_wlan_data.irq = gpio_to_irq(OMAP3EVM_WLAN_IRQ_GPIO);
 	ret = wl12xx_set_platform_data(&omap3evm_wlan_data);
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..4496007 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -199,7 +199,6 @@ static struct platform_device omap_vwlan_device = {
 };
 
 struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
-	.irq = OMAP_GPIO_IRQ(GPIO_WIFI_IRQ),
 	/* PANDA ref clock is 38.4 MHz */
 	.board_ref_clock = 2,
 };
@@ -494,6 +493,7 @@ static void __init omap4_panda_init(void)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);
 
+	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
 	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 0a66891..2b6db67 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -169,7 +169,6 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.modalias		= "tsc2005",
 		.bus_num		= 1,
 		.chip_select		= 0,
-		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
 		.max_speed_hz		= 6000000,
 		.controller_data	= &tsc2005_mcspi_config,
 		.platform_data		= &tsc2005_pdata,
@@ -1121,6 +1120,8 @@ static void __init rx51_init_tsc2005(void)
 		"tsc2005 reset");
 	if (r >= 0) {
 		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
+		rx51_peripherals_spi_board_info[RX51_SPI_TSC2005].irq =
+					gpio_to_irq(RX51_TSC2005_IRQ_GPIO);
 	} else {
 		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
 		tsc2005_pdata.esd_timeout_ms = 0;
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 369c2eb..1e8540e 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -43,7 +43,6 @@ static inline void __init zoom_init_smsc911x(void)
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase	= ZOOM_UART_BASE,
-		.irq		= OMAP_GPIO_IRQ(102),
 		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
 		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
 		.iotype		= UPIO_MEM,
@@ -89,6 +88,8 @@ static inline void __init zoom_init_quaduart(void)
 	if (gpio_request_one(quart_gpio, GPIOF_IN, "TL16CP754C GPIO") < 0)
 		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
 								quart_gpio);
+
+	serial_platform_data[0].irq = gpio_to_irq(102);
 }
 
 static inline int omap_zoom_debugboard_detect(void)
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index c126461..a489f82 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -193,7 +193,6 @@ static struct platform_device omap_vwlan_device = {
 };
 
 static struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
-	.irq = OMAP_GPIO_IRQ(OMAP_ZOOM_WLAN_IRQ_GPIO),
 	/* ZOOM ref clock is 26 MHz */
 	.board_ref_clock = 1,
 };
@@ -296,7 +295,10 @@ static void enable_board_wakeup_source(void)
 
 void __init zoom_peripherals_init(void)
 {
-	int ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
+	int ret;
+
+	omap_zoom_wlan_data.irq = gpio_to_irq(OMAP_ZOOM_WLAN_IRQ_GPIO);
+	ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
 
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 2d1d775..9238ce0 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -78,7 +78,7 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	ads7846_config.gpio_pendown = gpio_pendown;
 
 	spi_bi->bus_num	= bus_num;
-	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
+	spi_bi->irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata)
 		spi_bi->platform_data = board_pdata;

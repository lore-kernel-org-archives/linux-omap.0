From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 2/4] ARM: OMAP2+: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
Date: Mon, 19 Mar 2012 17:36:55 +0530
Message-ID: <1332158817-26311-3-git-send-email-tarun.kanti@ti.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758730Ab2CSMHO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 08:07:14 -0400
In-Reply-To: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

With dynamic allocation of IRQ the usage of OMAP_GPIO_IRQ
is no longer valid. We should be using gpio_to_irq() instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    6 ++++--
 arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 11 files changed, 20 insertions(+), 13 deletions(-)

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
index ac77382..7dd9d4d 100644
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
@@ -341,6 +339,10 @@ static void __init omap_apollon_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
+	apollon_devices[1]->resource[1].start =
+					gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
+	apollon_devices[1]->resource[1].end =
+					gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e873063..e947dc7 100644
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
@@ -637,6 +636,8 @@ static void __init devkit8000_init(void)
 	omap_dm9000_init();
 
 	devkit8000_i2c_init();
+	devkit8000_devices[2]->resource[2].start =
+					gpio_to_irq(OMAP_DM9000_GPIO_IRQ);
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
index c877236..eed88a4 100644
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
index acb4e77..1cec076 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -172,7 +172,6 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.modalias		= "tsc2005",
 		.bus_num		= 1,
 		.chip_select		= 0,
-		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
 		.max_speed_hz		= 6000000,
 		.controller_data	= &tsc2005_mcspi_config,
 		.platform_data		= &tsc2005_pdata,
@@ -1124,6 +1123,8 @@ static void __init rx51_init_tsc2005(void)
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
index bcb0c58..4cb17b4 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -79,7 +79,7 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	ads7846_config.gpio_pendown = gpio_pendown;
 
 	spi_bi->bus_num	= bus_num;
-	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
+	spi_bi->irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata)
 		spi_bi->platform_data = board_pdata;
-- 
1.7.0.4


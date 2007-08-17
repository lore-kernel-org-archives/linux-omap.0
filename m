From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Enable TSC2101 on apollon
Date: Fri, 17 Aug 2007 16:47:00 +0900
Message-ID: <003801c7e0a2$cd420c10$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ARM: OMAP: Enable TSC2101 on Apollon

Now it enables the touchscreen.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
diff --git a/arch/arm/mach-omap2/board-apollon.c
b/arch/arm/mach-omap2/board-apollon.c
index 059ff93..ff8459c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -26,6 +26,8 @@
 #include <linux/leds.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc210x.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -259,6 +261,24 @@ static void __init omap_apollon_init_irq(void)
 	apollon_init_smc91x();
 }
 
+static struct tsc210x_config tsc_platform_data = {
+	.use_internal		= 1,
+	.monitor		= TSC_TEMP,
+	.mclk			= "sys_clkout",
+};
+
+static struct spi_board_info apollon_spi_board_info[] = {
+	[0] = {
+		.modalias	= "tsc2101",
+		.irq		= OMAP_GPIO_IRQ(85),
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_1,
+		.max_speed_hz	= 6000000,
+		.platform_data	= &tsc_platform_data,
+	},
+};
+
 static struct omap_uart_config apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
@@ -335,11 +355,22 @@ static void __init apollon_usb_init(void)
 	omap_set_gpio_dataout(12, 0);
 }
 
+static void __init apollon_tsc_init(void)
+{
+	/* TSC2101 */
+	omap_cfg_reg(N15_24XX_GPIO85);
+	omap_request_gpio(85);
+	omap_set_gpio_direction(85, 1);
+
+	omap_cfg_reg(W14_24XX_SYS_CLKOUT);	/* mclk */
+}
+
 static void __init omap_apollon_init(void)
 {
 	apollon_led_init();
 	apollon_flash_init();
 	apollon_usb_init();
+	apollon_tsc_init();
 
 	/*
  	 * Make sure the serial ports are muxed on at this point.
@@ -350,6 +381,9 @@ static void __init omap_apollon_init(void)
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap_serial_init();
+
+	spi_register_board_info(apollon_spi_board_info,
+				ARRAY_SIZE(apollon_spi_board_info));
 }
 
 static void __init omap_apollon_map_io(void)
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 17ed177..cf4720f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -77,6 +77,7 @@ MUX_CFG_24XX("AA12_242X_GPIO17",	0x0e9,	3,	0,
0,	1)
 MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea,	3,	0,	0,
1)
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,
1)
 MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,	3,	0,	0,
1)
+MUX_CFG_24XX("N15_24XX_GPIO85",		0x103,	3,	0,	0,
1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,
1)
 MUX_CFG_24XX("P20_24XX_GPIO93",		0x10b,	3,	0,	0,
1)
 MUX_CFG_24XX("P18_24XX_GPIO95",		0x10d,	3,	0,	0,
1)
diff --git a/include/asm-arm/arch-omap/mux.h
b/include/asm-arm/arch-omap/mux.h
index 6e53212..317ea60 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -469,6 +469,7 @@ enum omap24xx_index {
 	AA8_242X_GPIO58,
 	Y20_24XX_GPIO60,
 	W4__24XX_GPIO74,
+	N15_24XX_GPIO85,
 	M15_24XX_GPIO92,
 	P20_24XX_GPIO93,
 	P18_24XX_GPIO95,

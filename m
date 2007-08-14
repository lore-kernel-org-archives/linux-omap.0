From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc2-omap1] H4 support for tsc210x
Date: Mon, 13 Aug 2007 22:40:03 -0700
Message-ID: <200708132240.03264.david-b@pacbell.net>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200708102004.59747.david-b@pacbell.net>
	<20070813070512.GC13948@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070813070512.GC13948@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

H4 board support now lists its tsc210x touchscreen/sensor/codec chip.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
 
--- h4.orig/arch/arm/mach-omap2/board-h4.c	2007-08-13 12:32:12.000000000 -0700
+++ h4/arch/arm/mach-omap2/board-h4.c	2007-08-13 15:07:22.000000000 -0700
@@ -22,6 +22,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc210x.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -418,6 +420,33 @@ static struct omap_usb_config h4_usb_con
 #endif
 };
 
+/* ----------------------------------------------------------------------- */
+
+static struct tsc210x_config tsc_platform_data = {
+	.use_internal		= 1,
+	.monitor		= TSC_VBAT | TSC_TEMP,
+	/* REVISIT temp calibration data -- board-specific; from EEPROM? */
+	.mclk			= "sys_clkout",
+};
+
+static struct spi_board_info h4_spi_board_info[] __initdata = {
+	{
+		.modalias	= "tsc2101",
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_1,
+		.irq		= OMAP_GPIO_IRQ(93),
+		.max_speed_hz	= 16000000,
+		.platform_data	= &tsc_platform_data,
+	},
+
+	/* nCS1 -- to lcd board, but unused
+	 * nCS2 -- to WLAN/miniPCI
+	 */
+};
+
+/* ----------------------------------------------------------------------- */
+
 static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_MMC,		&h4_mmc_config },
@@ -550,6 +579,28 @@ static void __init omap_h4_init(void)
 	tusb_evm_setup();
 #endif
 
+	/* defaults seem ok for:
+	 * omap_cfg_reg(U18_24XX_SPI1_SCK);
+	 * omap_cfg_reg(V20_24XX_SPI1_MOSI);
+	 * omap_cfg_reg(T18_24XX_SPI1_MISO);
+	 * omap_cfg_reg(U19_24XX_SPI1_NCS0);
+	 */
+
+	/* TSC2101 */
+	omap_cfg_reg(P20_24XX_GPIO93);
+	gpio_request(93, "tsc_irq");
+	gpio_direction_input(93);
+
+	omap_cfg_reg(W14_24XX_SYS_CLKOUT);	/* mclk */
+	/* defaults seem ok for:
+	 * omap_cfg_reg(Y15_EAC_AC_SCLK);	// bclk
+	 * omap_cfg_reg(R14_EAC_AC_FS);
+	 * omap_cfg_reg(V15_EAC_AC_DOUT);
+	 * omap_cfg_reg(W15_EAC_AC_DIN);
+	 */
+
+	spi_register_board_info(h4_spi_board_info,
+				ARRAY_SIZE(h4_spi_board_info));
 }
 
 static int gpio_exp_init(void)

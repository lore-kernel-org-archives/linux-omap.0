From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 2/2] ARM: OMAP: Add LCD support for Amstrad Delta
Date: Sat, 27 May 2006 16:06:11 +0100
Message-ID: <20060527150611.GB3864@earth.li>
References: <20060527150425.GA3864@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060527150425.GA3864@earth.li>
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

The patch below adds the hooks to the arch/arm/ tree for the Amstrad
Delta to use the LCD driver submitted in my previous mail.

Patch is against current linux-omap git.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 664c3e2..2f3d853 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -76,6 +76,10 @@ static struct map_desc ams_delta_io_desc
 	}
 };
 
+static struct omap_lcd_config ams_delta_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct omap_uart_config ams_delta_uart_config __initdata = {
 	.enabled_uarts = 1,
 };
@@ -87,10 +91,20 @@ static struct omap_usb_config ams_delta_
 };
 
 static struct omap_board_config_kernel ams_delta_config[] = {
+	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 	{ OMAP_TAG_USB,		&ams_delta_usb_config },
 };
 
+static struct platform_device ams_delta_lcd_device = {
+	.name	= "lcd_ams_delta",
+	.id	= "-1",
+};
+
+static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_lcd_device,
+};
+
 static void __init ams_delta_init(void)
 {
 	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
@@ -101,6 +115,8 @@ static void __init ams_delta_init(void)
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
+
+	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
 static void __init ams_delta_map_io(void)
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index f1958e8..b4dab21 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -20,6 +20,7 @@ #include <linux/err.h>
 #include <linux/clk.h>
 
 #include <asm/io.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/cpu.h>
 #include <asm/arch/usb.h>
@@ -772,6 +773,14 @@ #if defined(CONFIG_MACH_OMAP_PERSEUS2) |
 	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
 #endif
 
+#ifdef CONFIG_MACH_AMS_DELTA
+	/* Amstrad Delta wants BCLK high when inactive */
+	if (machine_is_ams_delta())
+		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
+				(1 << SDW_MCLK_INV_BIT),
+				ULPD_CLOCK_CTRL);
+#endif
+
 	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
 	/* (on 730, bit 13 must not be cleared) */
 	if (cpu_is_omap730())
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 0b125c3..f7df002 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -89,6 +89,7 @@ #define EN_TC2_CK	4
 #define EN_DSPTIMCK	5
 
 /* Various register defines for clock controls scattered around OMAP chip */
+#define SDW_MCLK_INV_BIT	2	/* In ULPD_CLKC_CTRL */
 #define USB_MCLK_EN_BIT		4	/* In ULPD_CLKC_CTRL */
 #define USB_HOST_HHC_UHOST_EN	9	/* In MOD_CONF_CTRL_0 */
 #define SWD_ULPD_PLL_CLK_REQ	1	/* In SWD_CLK_DIV_CTRL_SEL */
-----

J.

-- 
I get the feeling that I've been cheated.

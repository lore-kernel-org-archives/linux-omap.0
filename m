From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Add Amstrad Delta platform bits for framebuffer.
Date: Mon, 14 Aug 2006 19:31:19 +0100
Message-ID: <20060814183119.GN27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

This patch adds the platform file components for the Amstrad Delta LCD
framebuffer. I have confirmed it works with latest git. The patch to
clock.c /is/ needed for this to work.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 8437d06..1389799 100644
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
@@ -87,16 +91,23 @@ static struct omap_usb_config ams_delta_
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
 static struct platform_device ams_delta_led_device = {
 	.name	= "ams-delta-led",
 	.id	= -1
 };
 
 static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_lcd_device,
 	&ams_delta_led_device,
 };
 
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index cc08775..70a5d50 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -20,6 +20,7 @@ #include <linux/err.h>
 #include <linux/clk.h>
 
 #include <asm/io.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/cpu.h>
 #include <asm/arch/usb.h>
@@ -756,6 +757,14 @@ #if defined(CONFIG_MACH_OMAP_PERSEUS2) |
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
      Are you threatening me?      |  .''`.  Debian GNU/Linux Developer
                                   | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA +
                                   |   `-    DSA keys on the keyservers.

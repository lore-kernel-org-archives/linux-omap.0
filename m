From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/5 v3] ARM: mach-shmobile: add framebuffer support for ap4evb
Date: Sun, 23 May 2010 16:04:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231602040.3571@axis700.grange>
References: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
 <Pine.LNX.4.64.1005211712130.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005211712130.8450@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lin, ux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-omap@vger.kernel.org

ap4evb uses an LCD, connected to the SoC over the MIPI bus. This patch adds
platform data to configure this display and a static clock activation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---

v2 -> v3:

1. updated to the current genesis tree
2. changed clock names to match the new implementation
3. adjusted the subject line

 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c |  121 +++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a8bd47f..368e41d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -40,6 +40,7 @@ config MACH_AP4EVB
 	bool "AP4EVB board"
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
+	select SH_LCD_MIPI_DSI
 
 comment "SH-Mobile System Configuration"
 
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 6905ec4..e02e09a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -17,6 +17,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -35,8 +36,14 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
+
+#include <video/sh_mobile_lcdc.h>
+#include <video/sh_mipi_dsi.h>
+
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/sh7372.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -294,12 +301,87 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
+	.clock_source = LCDC_CLK_PERIPHERAL, /* One of interface clocks */
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = RGB24,
+		.clock_divider = 1,
+		.flags = LCDC_FLAGS_DWPOL,
+		.lcd_cfg = {
+			.name = "R63302(QHD)",
+			.xres = 544,
+			.yres = 961,
+			.left_margin = 72,
+			.right_margin = 600,
+			.hsync_len = 16,
+			.upper_margin = 8,
+			.lower_margin = 8,
+			.vsync_len = 2,
+			.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+		},
+		.lcd_size_cfg = {
+			.width = 44,
+			.height = 79,
+		},
+	}
+};
+
+static struct resource lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe943fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc_resources),
+	.resource	= lcdc_resources,
+	.dev	= {
+		.platform_data	= &sh_mobile_lcdc_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+static struct resource mipidsi0_resources[] = {
+	[0] = {
+		.start  = 0xffc60000,
+		.end    = 0xffc68fff,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct sh_mipi_dsi_info mipidsi0_info = {
+	.data_format	= MIPI_RGB888,
+	.lcd_chan	= &sh_mobile_lcdc_info.ch[0],
+};
+
+static struct platform_device mipidsi0_device = {
+	.name           = "sh-mipi-dsi",
+	.num_resources  = ARRAY_SIZE(mipidsi0_resources),
+	.resource       = mipidsi0_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &mipidsi0_info,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&keysc_device,
 	&sdhi0_device,
 	&usb1_host_device,
+	&lcdc_device,
+	&mipidsi0_device,
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -343,6 +425,45 @@ static void __init ap4evb_map_io(void)
 	shmobile_setup_console();
 }
 
+/* This function will disappear when we switch to (runtime) PM */
+static int __init ap4evb_init_display_clk(void)
+{
+	struct clk *lcdc_clk;
+	struct clk *dsitx_clk;
+	int ret;
+
+	lcdc_clk = clk_get(&lcdc_device.dev, "sh_mobile_lcdc_fb.0");
+	if (IS_ERR(lcdc_clk))
+		return PTR_ERR(lcdc_clk);
+
+	dsitx_clk = clk_get(&mipidsi0_device.dev, "sh-mipi-dsi.0");
+	if (IS_ERR(dsitx_clk)) {
+		ret = PTR_ERR(dsitx_clk);
+		goto eclkdsitxget;
+	}
+
+	ret = clk_enable(lcdc_clk);
+	if (ret < 0)
+		goto eclklcdcon;
+
+	ret = clk_enable(dsitx_clk);
+	if (ret < 0)
+		goto eclkdsitxon;
+
+	return 0;
+
+eclkdsitxon:
+	clk_disable(lcdc_clk);
+eclklcdcon:
+	clk_put(dsitx_clk);
+eclkdsitxget:
+	clk_put(lcdc_clk);
+
+	return ret;
+}
+
+device_initcall(ap4evb_init_display_clk);
+
 static void __init ap4evb_init(void)
 {
 	sh7372_pinmux_init();
-- 
1.6.2.4


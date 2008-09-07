From: sakoman@gmail.com
Subject: [PATCH 2/5] ARM: OMAP2: Add video driver the Gumstix
	Overo board (rev 3)
Date: Sat,  6 Sep 2008 23:41:41 -0700
Message-ID: <1220769704-16705-3-git-send-email-sakoman@gmail.com>
References: <1220769704-16705-1-git-send-email-sakoman@gmail.com>
	<1220769704-16705-2-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220769704-16705-2-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |   11 +++
 drivers/video/omap/Kconfig        |   21 +++++
 drivers/video/omap/Makefile       |    1 +
 drivers/video/omap/lcd_overo.c    |  179 +++++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_overo.c

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 5510049..175a444 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -174,12 +174,23 @@ static struct platform_device overo_twl4030rtc_device = {
 	.id             = -1,
 };
 
+static struct platform_device overo_lcd_device = {
+	.name		= "overo_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config overo_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct omap_board_config_kernel overo_config[] __initdata = {
 	{ OMAP_TAG_UART,	&overo_uart_config },
 	{ OMAP_TAG_MMC,		&overo_mmc_config },
+	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
 static struct platform_device *overo_devices[] __initdata = {
+	&overo_lcd_device,
 #ifdef CONFIG_RTC_DRV_TWL4030
 	&overo_twl4030rtc_device,
 #endif
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index bdeb8fb..5ebd591 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -7,6 +7,27 @@ config FB_OMAP
 	help
           Frame buffer driver for OMAP based boards.
 
+choice
+	depends on FB_OMAP && MACH_OVERO
+	prompt "Screen resolution"
+	default FB_OMAP_079M3R
+	help
+	  Selected desired screen resolution
+
+config FB_OMAP_031M3R
+	boolean "640 x 480 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_048M3R
+	boolean "800 x 600 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_079M3R
+	boolean "1024 x 768 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_092M9R
+	boolean "1280 x 720 @ 60 Hz Reduced blanking"
+
+endchoice
+
 config FB_OMAP_LCDC_EXTERNAL
 	bool "External LCD controller support"
 	depends on FB_OMAP
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index f9b5cd4..291c46e 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -35,6 +35,7 @@ objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
+objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
 
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
new file mode 100644
index 0000000..2bc5c92
--- /dev/null
+++ b/drivers/video/omap/lcd_overo.c
@@ -0,0 +1,179 @@
+/*
+ * LCD panel support for the Gumstix Overo
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_ENABLE       144
+
+static int overo_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	if ((gpio_request(LCD_ENABLE, "LCD_ENABLE") == 0) &&
+	    (gpio_direction_output(LCD_ENABLE, 1) == 0))
+		gpio_export(LCD_ENABLE, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for LCD_ENABLE\n");
+
+	return 0;
+}
+
+static void overo_panel_cleanup(struct lcd_panel *panel)
+{
+	gpio_free(LCD_ENABLE);
+}
+
+static int overo_panel_enable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_ENABLE, 1);
+	return 0;
+}
+
+static void overo_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_ENABLE, 0);
+}
+
+static unsigned long overo_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel overo_panel = {
+	.name		= "overo",
+	.config		= OMAP_LCDC_PANEL_TFT,
+	.bpp		= 16,
+	.data_lines	= 24,
+
+#if defined CONFIG_FB_OMAP_031M3R
+
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#elif defined CONFIG_FB_OMAP_048M3R
+
+	/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R */
+	.x_res		= 800,
+	.y_res		= 600,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 11,
+	.pixel_clock	= 35500,
+
+#elif defined CONFIG_FB_OMAP_079M3R
+
+	/* 1024 x 768 @ 60 Hz  Reduced blanking VESA CVT 0.79M3-R */
+	.x_res		= 1024,
+	.y_res		= 768,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 15,
+	.pixel_clock	= 56000,
+
+#elif defined CONFIG_FB_OMAP_092M9R
+
+	/* 1280 x 720 @ 60 Hz  Reduced blanking VESA CVT 0.92M9-R */
+	.x_res		= 1280,
+	.y_res		= 720,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 5,
+	.vbp		= 13,
+	.pixel_clock	= 64000,
+
+#else
+
+	/* use 640 x 480 if no config option */
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#endif
+
+	.init		= overo_panel_init,
+	.cleanup	= overo_panel_cleanup,
+	.enable		= overo_panel_enable,
+	.disable	= overo_panel_disable,
+	.get_caps	= overo_panel_get_caps,
+};
+
+static int overo_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&overo_panel);
+	return 0;
+}
+
+static int overo_panel_remove(struct platform_device *pdev)
+{
+	/* omapfb does not have unregister_panel */
+	return 0;
+}
+
+static struct platform_driver overo_panel_driver = {
+	.probe		= overo_panel_probe,
+	.remove		= overo_panel_remove,
+	.driver		= {
+		.name	= "overo_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init overo_panel_drv_init(void)
+{
+	return platform_driver_register(&overo_panel_driver);
+}
+
+static void __exit overo_panel_drv_exit(void)
+{
+	platform_driver_unregister(&overo_panel_driver);
+}
+
+module_init(overo_panel_drv_init);
+module_exit(overo_panel_drv_exit);
-- 
1.5.4.5

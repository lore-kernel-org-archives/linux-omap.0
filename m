From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 06/20] omapfb: Add support for the
 OMAP2EVM LCD
Date: Sun, 14 Jun 2009 23:30:27 +0200
Message-ID: <20090614233027.c70b1c53.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
	<e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
	<e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
	<833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
	<5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
	<646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:35157 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbZFNVWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:22:44 -0400
In-Reply-To: <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Tony Lindgren <tony@atomide.com>, Arun C <arunedarath@mistralsolutions.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, linux-omap@vger.kernel.org

On Thu,  4 Jun 2009 20:52:31 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> From: arun c <arun.edarath@gmail.com>
> 
> omap2evm LCD supports VGA and QVGA resolution, by default its in VGA mode.
> 
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Fixed-by: Jarkko Nikula <jarkko.nikula@gmail.com>
> Fixed-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Imre Deak <imre.deak@nokia.com>
> ---
>  drivers/video/omap/Makefile       |    1 +
>  drivers/video/omap/lcd_omap2evm.c |  189 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 190 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_omap2evm.c
> 
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index 7a37b03..c2475e3 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -27,6 +27,7 @@ objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
>  
>  objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
>  objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> +objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
>  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
>  
>  omapfb-objs := $(objs-yy)
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
new file mode 100644
index 0000000..2fc46c2
--- /dev/null
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -0,0 +1,189 @@
+/*
+ * LCD panel support for the MISTRAL OMAP2EVM board
+ *
+ * Author: Arun C <arunedarath@mistralsolutions.com>
+ *
+ * Derived from drivers/video/omap/lcd_omap3evm.c
+ * Derived from drivers/video/omap/lcd-apollon.c
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
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO	154
+#define LCD_PANEL_LR		128
+#define LCD_PANEL_UD		129
+#define LCD_PANEL_INI		152
+#define LCD_PANEL_QVGA		148
+#define LCD_PANEL_RESB		153
+
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK_MAX	20000 /* in kHz */

You can drop defines used only once. There are no such defines for some other panels
in your patches.

+
+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
+static int omap2evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+	gpio_request(LCD_PANEL_LR, "LCD lr");
+	gpio_request(LCD_PANEL_UD, "LCD ud");
+	gpio_request(LCD_PANEL_INI, "LCD ini");
+	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
+	gpio_request(LCD_PANEL_RESB, "LCD resb");
+
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_RESB, 1);
+	gpio_direction_output(LCD_PANEL_INI, 1);
+	gpio_direction_output(LCD_PANEL_QVGA, 0);
+	gpio_direction_output(LCD_PANEL_LR, 1);
+	gpio_direction_output(LCD_PANEL_UD, 1);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;
+
+	return 0;
+}
+
+static void omap2evm_panel_cleanup(struct lcd_panel *panel)
+{

Should the requested gpios be freed?

+}
+
+static int omap2evm_panel_enable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap2evm_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
+						unsigned int level)
+{
+	u8 c;
+	if ((level >= 0) && (level <= 100)) {
+		c = (125 * (100 - level)) / 100 + 2;
+		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		bklight_level = level;
+	}
+	return 0;
+}
+
+static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
+}
+
+struct lcd_panel omap2evm_panel = {
+	.name		= "omap2evm",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,
+	.hfp		= 0,
+	.hbp		= 28,
+	.vsw		= 2,
+	.vfp		= 1,
+	.vbp		= 0,
+
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
+
+	.init		= omap2evm_panel_init,
+	.cleanup	= omap2evm_panel_cleanup,
+	.enable		= omap2evm_panel_enable,
+	.disable	= omap2evm_panel_disable,
+	.get_caps	= omap2evm_panel_get_caps,
+	.set_bklight_level      = omap2evm_bklight_setlevel,
+	.get_bklight_level      = omap2evm_bklight_getlevel,
+	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
+};
+
+static int omap2evm_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap2evm_panel);
+	return 0;
+}
+
+static int omap2evm_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap2evm_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap2evm_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap2evm_panel_driver = {
+	.probe		= omap2evm_panel_probe,
+	.remove		= omap2evm_panel_remove,
+	.suspend	= omap2evm_panel_suspend,
+	.resume		= omap2evm_panel_resume,
+	.driver		= {
+		.name	= "omap2evm_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap2evm_panel_drv_init(void)
+{
+	return platform_driver_register(&omap2evm_panel_driver);
+}
+
+static void __exit omap2evm_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap2evm_panel_driver);
+}
+
+module_init(omap2evm_panel_drv_init);
+module_exit(omap2evm_panel_drv_exit);
-- 
1.6.3.1




----------------------------------------------------------------------
Interia.pl w Twojej kieszeni!
Kliknij >>>http://link.interia.pl/f21b8




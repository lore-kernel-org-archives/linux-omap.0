From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 9/12] Add support for HTC Typhoon and Hurricane/Tornado LCD
 panels.
Date: Sat, 09 Jun 2007 19:32:50 +0200
Message-ID: <466AE442.6090703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This patch add support for the various LCD panels used on the HTC 
Typhoon, Hurricane and Tornado smartphones. Backlight support is also 
implemented.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 drivers/video/omap/Makefile      |    1 +
 drivers/video/omap/lcd_typhoon.c |  294 
++++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_typhoon.c

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 0166e03..f7572d8 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -29,6 +29,7 @@ objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 objs-y$(CONFIG_MACH_OMAP_PERSEUS2) += lcd_p2.o
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_TYPHOON) += lcd_typhoon.o
 
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 
diff --git a/drivers/video/omap/lcd_typhoon.c 
b/drivers/video/omap/lcd_typhoon.c
new file mode 100644
index 0000000..08adb15
--- /dev/null
+++ b/drivers/video/omap/lcd_typhoon.c
@@ -0,0 +1,294 @@
+/*
+ * File: drivers/video/omap_new/lcd-typhoon.c
+ *
+ * LCD panel support for the HTC Typhoon phone
+ *
+ * Authors:
+ *   Thomas Cougnard <tgnard@free.fr>
+ *   Vivien Chappelier <vivien.chappelier@free.fr>
+ *
+ *   Based on the lcd_p2.c file
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
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/mux.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/omapfb.h>
+#include <asm/arch/board-typhoon.h>
+
+/* Typhoon panels */
+#define TYPHOON_LCD_ID_TOPPOLY 0
+#define TYPHOON_LCD_ID_HUNDAI  2
+#define TYPHOON_LCD_ID_SONY    3
+
+/* Tornado panels */
+#define TORNADO_LCD_ID_SONY    1
+#define TORNADO_LCD_ID_TOPPOLY 3
+
+/* Backlight */
+#define BKLIGHT_OFF  0
+#define BKLIGHT_DIM  1
+#define BKLIGHT_FULL 2
+
+static int bklight_level = BKLIGHT_FULL;
+
+static int typhoon_panel_init(struct lcd_panel *panel,
+                struct omapfb_device *fbdev)
+{
+    return 0;
+}
+
+static void typhoon_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int typhoon_panel_enable(struct lcd_panel *panel)
+{
+    return 0;
+}
+
+static void typhoon_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long typhoon_panel_get_caps(struct lcd_panel *panel)
+{
+    return 0;
+}
+
+static int typhoon_set_bklight_level(struct lcd_panel *panel,
+                    unsigned int level)
+{
+    if(level > 2)
+        return(-EINVAL);
+
+    bklight_level = level;
+
+    omap_set_gpio_direction(TYPHOON_GPIO_LCD_BACKLIGHT_ON, 0);
+    omap_set_gpio_direction(TYPHOON_GPIO_LCD_BACKLIGHT_INTENSITY, 0);
+
+    if(level > 0)
+        omap_set_gpio_dataout(TYPHOON_GPIO_LCD_BACKLIGHT_ON, 1);
+    else
+        omap_set_gpio_dataout(TYPHOON_GPIO_LCD_BACKLIGHT_ON, 0);
+    if(level > 1)
+        omap_set_gpio_dataout(TYPHOON_GPIO_LCD_BACKLIGHT_INTENSITY, 1);
+    else
+        omap_set_gpio_dataout(TYPHOON_GPIO_LCD_BACKLIGHT_INTENSITY, 0);
+    return(0);
+}
+
+static unsigned int typhoon_get_bklight_level(struct lcd_panel *panel)
+{
+    return(bklight_level);
+}
+
+static unsigned int typhoon_get_bklight_max(struct lcd_panel *panel)
+{
+    return(BKLIGHT_FULL);
+}
+
+/* Typhoon panels */
+static struct lcd_panel typhoon_toppoly_panel = {
+    .name        = "typhoon-toppoly",
+    .x_res        = 176,
+    .y_res        = 220,
+    .config        = OMAP_LCDC_PANEL_TFT |
+                OMAP_LCDC_INV_VSYNC |
+                OMAP_LCDC_INV_HSYNC |
+                OMAP_LCDC_HSVS_RISING_EDGE |
+                OMAP_LCDC_HSVS_OPPOSITE,
+    .pixel_clock    = 3900,
+    .hsw        = 6,
+    .hfp        = 27,
+    .hbp        = 34,
+    .vsw        = 1,
+    .vfp        = 3,
+    .vbp        = 5,
+};
+
+static struct lcd_panel typhoon_sony_panel = {
+    .name        = "typhoon-sony",
+    .x_res        = 176,
+    .y_res        = 220,
+    .config        = OMAP_LCDC_PANEL_TFT |
+                OMAP_LCDC_INV_VSYNC |
+                OMAP_LCDC_INV_HSYNC |
+                OMAP_LCDC_INV_PIX_CLOCK |
+                OMAP_LCDC_HSVS_OPPOSITE,
+    .pixel_clock    = 2250,
+    .hsw        = 1,
+    .hfp        = 2,
+    .hbp        = 1,
+    .vsw        = 1,
+    .vfp        = 2,
+    .vbp        = 6,
+};
+
+/* Tornado panels */
+static struct lcd_panel tornado_toppoly_panel = {
+    .name        = "tornado-toppoly",
+    .x_res        = 240,
+    .y_res        = 320,
+    .config        = OMAP_LCDC_PANEL_TFT |
+                OMAP_LCDC_INV_VSYNC |
+                OMAP_LCDC_INV_HSYNC |
+                OMAP_LCDC_HSVS_OPPOSITE,
+    .pixel_clock    = 5500,
+    .hsw        = 10,
+    .hfp        = 10,
+    .hbp        = 20,
+    .vsw        = 2,
+    .vfp        = 2,
+    .vbp        = 3,
+};
+
+static struct lcd_panel tornado_sony_panel = {
+    .name        = "tornado-sony",
+    .x_res        = 240,
+    .y_res        = 320,
+    .config        = OMAP_LCDC_PANEL_TFT |
+                OMAP_LCDC_INV_VSYNC |
+                OMAP_LCDC_INV_HSYNC |
+                OMAP_LCDC_HSVS_RISING_EDGE |
+                OMAP_LCDC_HSVS_OPPOSITE,
+    .pixel_clock    = 5000,
+    .hsw        = 2,
+    .hfp        = 8,
+    .hbp        = 14,
+    .vsw        = 2,
+    .vfp        = 4,
+    .vbp        = 2,
+};
+
+/* get the panel identifier */
+static unsigned int typhoon_lcd_identify(void)
+{
+    omap_set_gpio_direction(TYPHOON_GPIO_PANEL_ID0, 1);
+    omap_set_gpio_direction(TYPHOON_GPIO_PANEL_ID1, 1);
+
+    return (omap_get_gpio_datain(TYPHOON_GPIO_PANEL_ID1) << 1) |
+        omap_get_gpio_datain(TYPHOON_GPIO_PANEL_ID0);
+}
+
+struct panel_id {
+    unsigned int model;
+    unsigned int lcd_id;
+    struct lcd_panel *panel;
+};
+
+struct panel_id typhoon_lcd_panel[] = {
+    { TYPHOON_MODEL_TYPHOON, TYPHOON_LCD_ID_TOPPOLY,
+      &typhoon_toppoly_panel },
+    { TYPHOON_MODEL_TYPHOON, TYPHOON_LCD_ID_SONY,
+      &typhoon_sony_panel },
+    { TYPHOON_MODEL_TORNADO, TORNADO_LCD_ID_TOPPOLY,
+      &tornado_toppoly_panel },
+    { TYPHOON_MODEL_TORNADO, TORNADO_LCD_ID_SONY,
+      &tornado_sony_panel },
+};
+
+static struct lcd_panel *typhoon_lcd_find_panel(struct platform_device 
*pdev)
+{
+    struct lcd_panel *panel;
+    unsigned int lcd_id;
+    int i;
+
+    lcd_id = typhoon_lcd_identify();
+
+    panel = NULL;
+    for (i = 0; i < ARRAY_SIZE(typhoon_lcd_panel); i++) {
+        if (typhoon_lcd_panel[i].model == typhoon_model &&
+            typhoon_lcd_panel[i].lcd_id == lcd_id)
+            return typhoon_lcd_panel[i].panel;
+    }
+
+    printk(KERN_ERR "lcd-typhoon: unknown model/panel %d/%d\n",
+           typhoon_model, lcd_id);
+
+    return NULL;
+}
+
+static int typhoon_panel_probe(struct platform_device *pdev)
+{
+    struct lcd_panel *panel;
+
+    /* set the timings according to the panel type */
+    if ((panel = typhoon_lcd_find_panel(pdev)) == NULL) {
+        return -ENODEV;
+    }
+
+    panel->bpp = 16;
+    panel->data_lines = 16;
+
+    /* common callbacks */
+    panel->init = typhoon_panel_init;
+    panel->cleanup = typhoon_panel_cleanup;
+    panel->enable  = typhoon_panel_enable;
+    panel->disable = typhoon_panel_disable;
+    panel->get_caps= typhoon_panel_get_caps;
+    panel->set_bklight_level = typhoon_set_bklight_level;
+    panel->get_bklight_level = typhoon_get_bklight_level;
+    panel->get_bklight_max   = typhoon_get_bklight_max;
+
+    omapfb_register_panel(panel);
+    return 0;
+}
+
+static int typhoon_panel_remove(struct platform_device *pdev)
+{
+    return 0;
+}
+
+static int typhoon_panel_suspend(struct platform_device *pdev,
+                 pm_message_t mesg)
+{
+    return 0;
+}
+
+static int typhoon_panel_resume(struct platform_device *pdev)
+{
+    return 0;
+}
+
+struct platform_driver typhoon_panel_driver = {
+    .probe        = typhoon_panel_probe,
+    .remove        = typhoon_panel_remove,
+    .suspend    = typhoon_panel_suspend,
+    .resume        = typhoon_panel_resume,
+    .driver        = {
+        .name    = "lcd_typhoon",
+        .owner    = THIS_MODULE,
+    },
+};
+
+static int typhoon_panel_drv_init(void)
+{
+    return platform_driver_register(&typhoon_panel_driver);
+}
+
+static void typhoon_panel_drv_cleanup(void)
+{
+    platform_driver_unregister(&typhoon_panel_driver);
+}
+
+module_init(typhoon_panel_drv_init);
+module_exit(typhoon_panel_drv_cleanup);
+
-- 
1.5.1.3

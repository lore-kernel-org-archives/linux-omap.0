From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH 2/3] Palm Tungsten|T LCD
Date: Sun, 29 Oct 2006 00:58:33 +0200
Message-ID: <200610290058.33774.marek.vasut@gmail.com>
References: <200610290055.45962.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZC+QF0IXIqassQE"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200610290055.45962.marek.vasut@gmail.com>
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

--Boundary-00=_ZC+QF0IXIqassQE
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch adds LCD support for Palm Tungsten|T.

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_ZC+QF0IXIqassQE
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="palmtt-lcd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmtt-lcd.patch"

diff -Naur linux-omap-dev/drivers/video/omap/lcd_palmtt.c linux-omap/drivers/video/omap/lcd_palmtt.c
--- linux-omap-dev/drivers/video/omap/lcd_palmtt.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap/drivers/video/omap/lcd_palmtt.c	2006-10-28 21:44:34.000000000 +0200
@@ -0,0 +1,129 @@
+/*
+ * File: drivers/video/omap/lcd_palmtt.c
+ *
+ * LCD panel support for Palm Tungsten|T
+ * Current version : Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Modified from lcd_inn1510.c
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
+/*
+GPIO11 - backlight
+GPIO12 - screen blanking
+GPIO13 - screen blanking
+*/
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+
+#include <asm/arch/gpio.h>
+#include "asm/arch/omapfb.h"
+
+static int palmtt_panel_init(struct lcd_panel *panel,
+			     struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void palmtt_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int palmtt_panel_enable(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static void palmtt_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long palmtt_panel_get_caps(struct lcd_panel *panel)
+{
+	return OMAPFB_CAPS_SET_BACKLIGHT;
+}
+
+struct lcd_panel palmtt_panel = {
+	.name       = "palmtt",
+	.config	    = OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC | OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE | OMAP_LCDC_HSVS_OPPOSITE,
+	.bpp = 16,
+	.data_lines = 16,
+	.x_res = 320,
+	.y_res = 320,
+	.pixel_clock = 10000,
+	.hsw = 4,
+	.hfp = 8,
+	.hbp = 28,
+	.vsw = 1,
+	.vfp = 8,
+	.vbp = 7,
+	.pcd = 0,
+
+	.init	 = palmtt_panel_init,
+	.cleanup = palmtt_panel_cleanup,
+	.enable  = palmtt_panel_enable,
+	.disable = palmtt_panel_disable,
+	.get_caps= palmtt_panel_get_caps,
+};
+
+static int palmtt_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&palmtt_panel);
+	return 0;
+}
+
+static int palmtt_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int palmtt_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int palmtt_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver palmtt_panel_driver = {
+	.probe		= palmtt_panel_probe,
+	.remove		= palmtt_panel_remove,
+	.suspend	= palmtt_panel_suspend,
+	.resume		= palmtt_panel_resume,
+	.driver		= {
+		.name	= "lcd_palmtt",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int palmtt_panel_drv_init(void)
+{
+	return platform_driver_register(&palmtt_panel_driver);
+}
+
+static void palmtt_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&palmtt_panel_driver);
+}
+
+module_init(palmtt_panel_drv_init);
+module_exit(palmtt_panel_drv_cleanup);
+
diff -Naur linux-omap-dev/drivers/video/omap/Makefile linux-omap/drivers/video/omap/Makefile
--- linux-omap-dev/drivers/video/omap/Makefile	2006-10-28 01:38:33.000000000 +0200
+++ linux-omap/drivers/video/omap/Makefile	2006-10-28 21:32:26.000000000 +0200
@@ -20,6 +20,7 @@
 objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o
 objs-y$(CONFIG_MACH_OMAP_PALMTE) += lcd_palmte.o
 objs-y$(CONFIG_MACH_OMAP_PALMZ71) += lcd_palmz71.o
+objs-y$(CONFIG_MACH_OMAP_PALMTT) += lcd_palmtt.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o

--Boundary-00=_ZC+QF0IXIqassQE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_ZC+QF0IXIqassQE--

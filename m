From: zmc@lurian.net
Subject: HTC Wizard Framebuffer Support (OMAP850)
Date: Tue, 27 Jan 2009 20:47:55 -0400
Message-ID: <20090128004755.GB13303@polaris.lurian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lurian.net ([64.209.10.12]:40365 "EHLO polaris.lurian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZA1A6y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2009 19:58:54 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fb-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: multipart/mixed; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

	I've been working on supporting the omap850 / HTC Wizard
platform.  This is what I am using currently for FB support.

Any comments, suggestions, or direction as to where this code
should go would be appreciated.

Thanks,

Zebediah C. McClure

--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0009--HTCWIZARD-LCD-Support.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 993df2d5d18132b5cd0ddb72de219e386e70dd64 Mon Sep 17 00:00:00 2001
In-Reply-To: <20081018131951.GN18573@atoide.com>
References: <20081018131951.GN18573@atoide.com>
=46rom: Zebediah C. McClure <zmc@lurian.net>
Date: Sat, 24 Jan 2009 14:32:23 -0400
Subject: [PATCH] [HTCWIZARD] LCD Support.

This is required for output on wizard.
---
 drivers/video/omap/Makefile        |    1 +
 drivers/video/omap/lcd_htcwizard.c |  195 ++++++++++++++++++++++++++++++++=
++++
 2 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_htcwizard.c

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index ed13889..498e3b0 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -23,6 +23,7 @@ objs-y$(CONFIG_MACH_OMAP_PALMZ71) +=3D lcd_palmz71.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) +=3D lcd_inn1610=
=2Eo
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) +=3D lcd_inn1510=
=2Eo
 objs-y$(CONFIG_MACH_OMAP_OSK) +=3D lcd_osk.o
+objs-y$(CONFIG_MACH_OMAP_HTCWIZARD) +=3D lcd_htcwizard.o
=20
 omapfb-objs :=3D $(objs-yy)
=20
diff --git a/drivers/video/omap/lcd_htcwizard.c b/drivers/video/omap/lcd_ht=
cwizard.c
new file mode 100644
index 0000000..1205c1c
--- /dev/null
+++ b/drivers/video/omap/lcd_htcwizard.c
@@ -0,0 +1,195 @@
+/*
+ * File: drivers/video/omap/lcd-wizard.c
+ *
+ * LCD panel support for the HTC Wizard
+ *
+ * Copyright (C) linwizard.sourceforge.net
+ * Author: Angelo Arrifano <miknix@gmail.com>
+ * Based on lcd_h4 by Imre Deak <imre.deak@nokia.com>
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
+
+#include <mach/omapfb.h>
+
+#define OMAP_LCDC_SUBPANEL 0xfffec014=20
+
+static int htcwizard_panel_init(struct lcd_panel *panel,
+                                struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void htcwizard_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int htcwizard_panel_enable(struct lcd_panel *panel)
+{
+
+	return 0;
+}
+
+static void htcwizard_panel_disable(struct lcd_panel *panel)
+{
+}
+
+static unsigned long htcwizard_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+/* Not sure */
+struct lcd_panel htcwizard_panel1 =3D {
+	.name		=3D "lcd1",
+	.config		=3D OMAP_LCDC_PANEL_TFT |
+	              OMAP_LCDC_INV_VSYNC |
+	              OMAP_LCDC_INV_HSYNC |
+	              OMAP_LCDC_HSVS_OPPOSITE,
+
+	.bpp		=3D 16,
+	.data_lines	=3D 16,
+	.x_res		=3D 240,
+	.y_res		=3D 320,
+	.pixel_clock	=3D 5500,
+	.hsw		=3D 10,
+	.hfp		=3D 10,
+	.hbp		=3D 20,
+	.vsw		=3D 2,
+	.vfp		=3D 2,
+	.vbp		=3D 3,
+
+	.init		=3D htcwizard_panel_init,
+	.cleanup	=3D htcwizard_panel_cleanup,
+	.enable		=3D htcwizard_panel_enable,
+	.disable	=3D htcwizard_panel_disable,
+	.get_caps	=3D htcwizard_panel_get_caps,
+};
+
+/* Found on HTC Wizards */
+struct lcd_panel htcwizard_panel2 =3D {
+	.name		=3D "lcd2",
+	.config		=3D OMAP_LCDC_PANEL_TFT |
+	              OMAP_LCDC_INV_HSYNC |
+					  OMAP_LCDC_INV_PIX_CLOCK,
+	.bpp		=3D 16,
+	.data_lines	=3D 16,
+	.x_res		=3D 240,
+	.y_res		=3D 320,
+	.pixel_clock =3D 6093,
+	.hsw		=3D 10,
+	.hfp		=3D 10,
+	.hbp		=3D 20,
+	.vsw		=3D 3,
+	.vfp		=3D 2,
+	.vbp		=3D 2,
+
+	.init		=3D htcwizard_panel_init,
+	.cleanup	=3D htcwizard_panel_cleanup,
+	.enable		=3D htcwizard_panel_enable,
+	.disable	=3D htcwizard_panel_disable,
+	.get_caps	=3D htcwizard_panel_get_caps,
+};
+
+/* Found on HTC Elfs */
+struct lcd_panel htcwizard_panel3 =3D {
+	.name		=3D "lcd3",
+	.config		=3D OMAP_LCDC_PANEL_TFT |
+	              OMAP_LCDC_INV_HSYNC |
+					  OMAP_LCDC_INV_PIX_CLOCK,
+	.bpp		=3D 16,
+	.data_lines	=3D 16,
+	.x_res		=3D 240,
+	.y_res		=3D 320,
+	.pcd =3D 18,
+	.hsw		=3D 4,
+	.hfp		=3D 8,
+	.hbp		=3D 4,
+	.vsw		=3D 3,
+	.vfp		=3D 8,
+	.vbp		=3D 5,
+
+	.init		=3D htcwizard_panel_init,
+	.cleanup	=3D htcwizard_panel_cleanup,
+	.enable		=3D htcwizard_panel_enable,
+	.disable	=3D htcwizard_panel_disable,
+	.get_caps	=3D htcwizard_panel_get_caps,
+};
+
+
+static int htcwizard_panel_probe(struct platform_device *pdev)
+{
+	u32 type;
+=09
+	type =3D omap_readl(OMAP_LCDC_SUBPANEL);
+	switch(type){
+	case 0x5c00f000:
+		printk("LCD: Panel type 2\n");
+		omapfb_register_panel(&htcwizard_panel2);
+		break;
+	case 0x5c000000:
+		printk("LCD: Panel type 1\n");
+		omapfb_register_panel(&htcwizard_panel3);
+		break;
+	default:
+		printk("LCD: Unknown Panel type\n");
+		omapfb_register_panel(&htcwizard_panel1);
+	}
+
+	return 0;
+}
+
+static int htcwizard_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int htcwizard_panel_suspend(struct platform_device *pdev, pm_messag=
e_t mesg)
+{
+	return 0;
+}
+
+static int htcwizard_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver htcwizard_panel_driver =3D {
+	.probe		=3D htcwizard_panel_probe,
+	.remove		=3D htcwizard_panel_remove,
+	.suspend	=3D htcwizard_panel_suspend,
+	.resume		=3D htcwizard_panel_resume,
+	.driver		=3D {
+		.name	=3D "lcd_htcwizard",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int htcwizard_panel_drv_init(void)
+{
+	return platform_driver_register(&htcwizard_panel_driver);
+}
+
+static void htcwizard_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&htcwizard_panel_driver);
+}
+
+module_init(htcwizard_panel_drv_init);
+module_exit(htcwizard_panel_drv_cleanup);
+
--=20
1.6.0.6


--+B+y8wtTXqdUj1xM--

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkl/qzsACgkQZhRzv0gWXLkhdACcDJ3pkbGgKBW0QusDo2lvXFgJ
ZyEAn2+LDq10IDBhd3zaI3fuzJZTEKeh
=0vJz
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

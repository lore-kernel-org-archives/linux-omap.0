From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Overo expansion board selection with Kconfig (Was: Re: Display related
 board specific boot args)
Date: Mon, 25 Mar 2013 12:16:59 +0200
Message-ID: <5150241B.3090402@ti.com>
References: <514C1599.7080803@ti.com> <20130322151838.GB25575@atomide.com> <514C78F7.5050906@ti.com> <20130322153614.GC25575@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB9C7165E2FB990C4BF0F5584"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43458 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182Ab3CYKRG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:17:06 -0400
In-Reply-To: <20130322153614.GC25575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andy Gross <andy.gross@ti.com>

--------------enigB9C7165E2FB990C4BF0F5584
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-22 17:36, Tony Lindgren wrote:

>> Would the Kconfig option be acceptable?
>=20
> Yes I think that's better than cmdline option in this case considering =
that
> the cmdline option won't be needed at some point in the future.

Here's a diff for the changes for Overo. This is not a real patch yet,
just an RFC for the naming of the Kconfig options, and if this approach
is generally ok. Some other boards need similar setup also, but I think
Overo is the most complex case.

I only handle the displays here, and only three overo expansion boards.
I didn't find any of the expansion boards having analog TV out, so I remo=
ved
it.

I'm not sure if MACH_XXX style options should be reserved for boards only=
=2E It
just seemed like a logical way to extend the MACH_OVERO with
MACH_OVERO_EXPANSION_XXX.

 Tomi


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8111cd9..f30aadb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -238,6 +238,28 @@ config MACH_OVERO
 	default y
 	select OMAP_PACKAGE_CBB
=20
+choice
+	depends on MACH_OVERO
+	default MACH_OVERO_EXPANSION_PALO43
+	prompt "Overo Expansion Board"
+
+config MACH_OVERO_EXPANSION_PALO43
+	bool "Gumstix Overo Palo43 Expansion Board"
+	help
+	  Palo43 Expansion board with Samsung 4.3" 480x272 LCD.
+
+config MACH_OVERO_EXPANSION_PALO35
+	bool "Gumstix Overo Palo35 Expansion Board"
+	help
+	  Palo35 Expansion board with LG 3.5" 320x240 LCD.
+
+config MACH_OVERO_EXPANSION_SUMMIT
+	bool "Gumstix Overo Summit Expansion Board"
+	help
+	  Summit expansion board with DVI output.
+
+endchoice
+
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/boar=
d-overo.c
index 86bab51..d9df651 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -145,9 +145,6 @@ static void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
=20
-/* DSS */
-static int lcd_enabled;
-static int dvi_enabled;
=20
 #define OVERO_GPIO_LCD_EN 144
 #define OVERO_GPIO_LCD_BL 145
@@ -168,6 +165,8 @@ static void __init overo_display_init(void)
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
 }
=20
+#if defined(CONFIG_MACH_OVERO_EXPANSION_SUMMIT)
+
 static struct tfp410_platform_data dvi_panel =3D {
 	.i2c_bus_num		=3D 3,
 	.power_down_gpio	=3D -1,
@@ -181,23 +180,56 @@ static struct omap_dss_device overo_dvi_device =3D =
{
 	.phy.dpi.data_lines	=3D 24,
 };
=20
-static struct omap_dss_device overo_tv_device =3D {
-	.name =3D "tv",
-	.driver_name =3D "venc",
-	.type =3D OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type =3D OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct omap_dss_device *overo_dss_devices[] =3D {
+	&overo_dvi_device,
 };
=20
+static struct omap_dss_board_info overo_dss_data =3D {
+	.num_devices	=3D ARRAY_SIZE(overo_dss_devices),
+	.devices	=3D overo_dss_devices,
+	.default_device	=3D &overo_dvi_device,
+};
+
+#elif defined(CONFIG_MACH_OVERO_EXPANSION_PALO35)
+
 static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
+	return 0;
+}
+
+static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
+}
+
+static struct omap_dss_device overo_lcd35_device =3D {
+	.type			=3D OMAP_DISPLAY_TYPE_DPI,
+	.name			=3D "lcd35",
+	.driver_name		=3D "lgphilips_lb035q02_panel",
+	.phy.dpi.data_lines	=3D 24,
+	.platform_enable	=3D overo_panel_enable_lcd,
+	.platform_disable	=3D overo_panel_disable_lcd,
+};
+
+static struct omap_dss_device *overo_dss_devices[] =3D {
+	&overo_lcd35_device,
+};
=20
+static struct omap_dss_board_info overo_dss_data =3D {
+	.num_devices	=3D ARRAY_SIZE(overo_dss_devices),
+	.devices	=3D overo_dss_devices,
+	.default_device	=3D &overo_lcd35_device,
+};
+
+#elif defined(CONFIG_MACH_OVERO_EXPANSION_PALO43)
+
+static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
 	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
 	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
-	lcd_enabled =3D 1;
 	return 0;
 }
=20
@@ -205,7 +237,6 @@ static void overo_panel_disable_lcd(struct omap_dss_d=
evice *dssdev)
 {
 	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
 	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
-	lcd_enabled =3D 0;
 }
=20
 static struct panel_generic_dpi_data lcd43_panel =3D {
@@ -222,34 +253,18 @@ static struct omap_dss_device overo_lcd43_device =3D=
 {
 	.phy.dpi.data_lines	=3D 24,
 };
=20
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
-static struct omap_dss_device overo_lcd35_device =3D {
-	.type			=3D OMAP_DISPLAY_TYPE_DPI,
-	.name			=3D "lcd35",
-	.driver_name		=3D "lgphilips_lb035q02_panel",
-	.phy.dpi.data_lines	=3D 24,
-	.platform_enable	=3D overo_panel_enable_lcd,
-	.platform_disable	=3D overo_panel_disable_lcd,
-};
-#endif
-
 static struct omap_dss_device *overo_dss_devices[] =3D {
-	&overo_dvi_device,
-	&overo_tv_device,
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
-	&overo_lcd35_device,
-#endif
 	&overo_lcd43_device,
 };
=20
 static struct omap_dss_board_info overo_dss_data =3D {
 	.num_devices	=3D ARRAY_SIZE(overo_dss_devices),
 	.devices	=3D overo_dss_devices,
-	.default_device	=3D &overo_dvi_device,
+	.default_device	=3D &overo_lcd43_device,
 };
=20
+#endif
+
 static struct mtd_partition overo_nand_partitions[] =3D {
 	{
 		.name           =3D "xloader",
@@ -438,8 +453,7 @@ static int __init overo_i2c_init(void)
 }
=20
 static struct spi_board_info overo_spi_board_info[] __initdata =3D {
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+#ifdef MACH_OVERO_EXPANSION_PALO35
 	{
 		.modalias		=3D "lgphilips_lb035q02_panel-spi",
 		.bus_num		=3D 1,



--------------enigB9C7165E2FB990C4BF0F5584
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUCQfAAoJEPo9qoy8lh711RcQAITXnmhxL+ZaKJIp4JMxjRp2
/UINsEO33uZpnBm0c6HTQfsf2Ix6Sv7SbaK5QFoVhreB3H86h84jApOrRDlVdC2x
3zLDhKpHcAfCIn7CvjkD9b+/k5w+PNhtaQNopRL4t82xv+eU0XxBSkGpF25UZjJ5
CSWuK8jh0za0+rCr9ZQFRZ1TL1e4FyTmZ2714M1sN4vtt/a/qxoUJDjCzD2EmQl4
wEH8XDTMPrUyJ6CdbAXlSAZbQ5tqo7Bf8PVHujTSQeh4pIDug+4yOHeZI2S2R69E
4gw5rnaIZi6/YZCyEN9p27Yg969TZOQD9dB763K7e1/lDquHYY9Kw8+Ua9sXwaHX
To076a7Xdxj2FaALPC8udkj7vJB4dcainW3QRwPwT9j4u9J2iYGd36YBmo4+WQr9
Aza7kj4954NCskQmrMjV2sMfsTJtCdu5ZUO6lu8guiH53/r8A0yXkc0R3CulHPhN
nLI0wh3c99veKTNmzUIoNuHk8lfyZcr5Ed8bN6uNxT0MUtC0osK2jlmhEqNQdq+W
hwBhGH3dLD3NvdFHrHkFiojs+2ElPty7opmvKGZmVdWjx4Ji4lRke6rjv4FLN/Pw
Goz2BeTYM1PVW4hasEFQNTjZyKoR//6ksZOsS0Ki7K7EL4MsYGBRpUTLqY7HF3uk
Hh6x0HlvoY60Jx64AlM7
=Jooy
-----END PGP SIGNATURE-----

--------------enigB9C7165E2FB990C4BF0F5584--

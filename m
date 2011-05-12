From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 20:06:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679@dbde02.ent.ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari> <4DCB80DD.5090408@compulab.co.il>
	 <4DCB8937.2060101@compulab.co.il> <4DCB9C71.2020503@compulab.co.il>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC13C0@dbde02.ent.ti.com>
	 <4DCBC273.9030807@compulab.co.il> <1305200857.2062.24.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43732 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805Ab1ELOhH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 10:37:07 -0400
In-Reply-To: <1305200857.2062.24.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Igor Grinberg <grinberg@compulab.co.il>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, May 12, 2011 5:18 PM
> To: Igor Grinberg
> Cc: Janorkar, Mayuresh; tony@atomide.com; linux-omap@vger.kernel.org;
> Stanley Miao
> Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
>=20
> On Thu, 2011-05-12 at 14:20 +0300, Igor Grinberg wrote:
>=20
> > Right. Do both fixes make it work?
> >
> > If it is, then Tomi,
> > will you add both fixes to the patch set with our SOBs?
> > or do you want this to be sent properly as a follow up?
>=20
> Yes, I can add these all to the same patch and handle it through DSS
> tree. Although due to the reluctance to make changes to arch/arm/*omap*,
> I guess we'll pass these patches in this merge window.
>=20
> Mayuresh, if you're able to test this and it works, can you send me the
> full diff so that I don't make any mistakes combining the code?
>=20
>  Tomi
>=20

Please find the patch below.
I have also attached the same.

There are formatting problems with this patch. But this can be used as a re=
ference.

I have verified bootup with Penguins on LDP board.

>From 1f3470d3d792721bf5aa4d060c1cf79f5a587497 Mon Sep 17 00:00:00 2001
From: Mayuresh Janorkar <mayur@ti.com>
Date: Thu, 12 May 2011 18:53:46 +0530
Subject: [PATCH] LDP Tomi patch

---
 arch/arm/mach-omap2/board-ldp.c          |   87 ++++++++++--
 drivers/video/omap2/displays/Kconfig     |    5 +
 drivers/video/omap2/displays/Makefile    |    1 +
 drivers/video/omap2/displays/panel-ldp.c |  223 ++++++++++++++++++++++++++=
++++
 4 files changed, 305 insertions(+), 11 deletions(-)
 mode change 100644 =3D> 100755 arch/arm/mach-omap2/board-ldp.c
 create mode 100755 drivers/video/omap2/displays/panel-ldp.c

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ld=
p.c
old mode 100644
new mode 100755
index e2ba779..fa6327a
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,7 @@
=20
 #include <asm/delay.h>
 #include <plat/usb.h>
+#include <plat/display.h>
=20
 #include "board-flash.h"
 #include "mux.h"
@@ -53,6 +54,11 @@
 #define LDP_SMSC911X_GPIO	152
 #define DEBUG_BASE		0x08000000
 #define LDP_ETHR_START		DEBUG_BASE
+#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
=20
 static struct resource ldp_smsc911x_resources[] =3D {
 	[0] =3D {
@@ -275,19 +281,78 @@ static inline void __init ldp_init_smsc911x(void)
 	gpio_direction_input(eth_gpio);
 }
=20
-static struct platform_device ldp_lcd_device =3D {
-	.name		=3D "ldp_lcd",
-	.id		=3D -1,
+#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
+#define SDP3430_LCD_PANEL_ENABLE_GPIO		5
+
+static unsigned backlight_gpio;
+static unsigned enable_gpio;
+static int lcd_enabled;
+
+static void __init sdp3430_display_init(void)
+{
+	printk(KERN_INFO "\n LDP:: sdp3430_display_init ");
+        return;
+}
+
+static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	int status;
+	return 0;
+}
+
+static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	lcd_enabled =3D 0;
+
+	gpio_direction_output(enable_gpio, 0);
+	gpio_direction_output(backlight_gpio, 0);
+
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+}
+
+static struct omap_dss_device sdp3430_lcd_device =3D {
+	.name			=3D "lcd",
+	.driver_name		=3D "ldp_panel",
+	.type			=3D OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	=3D 16,
+	.platform_enable	=3D sdp3430_panel_enable_lcd,
+	.platform_disable	=3D sdp3430_panel_disable_lcd,
 };
=20
-static struct omap_lcd_config ldp_lcd_config __initdata =3D {
-	.ctrl_name	=3D "internal",
+static struct omap_dss_device *sdp3430_dss_devices[] =3D {
+	&sdp3430_lcd_device,
 };
=20
-static struct omap_board_config_kernel ldp_config[] __initdata =3D {
-	{ OMAP_TAG_LCD,		&ldp_lcd_config },
+static struct omap_dss_board_info sdp3430_dss_data =3D {
+	.num_devices	=3D ARRAY_SIZE(sdp3430_dss_devices),
+	.devices	=3D sdp3430_dss_devices,
+	.default_device	=3D &sdp3430_lcd_device,
 };
=20
+/* VPLL2 for digital video outputs */
+static struct regulator_consumer_supply sdp3430_vpll2_supplies[] =3D {
+        REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+        REGULATOR_SUPPLY("vdds_dsi", "omap_dsi1"),
+};
+
+static struct regulator_init_data sdp3430_vpll2 =3D {
+        .constraints =3D {
+                .name                   =3D "VDVI",
+                .min_uV                 =3D 1800000,
+                .max_uV                 =3D 1800000,
+                .apply_uV               =3D true,
+                .valid_modes_mask       =3D REGULATOR_MODE_NORMAL
+                                        | REGULATOR_MODE_STANDBY,
+                .valid_ops_mask         =3D REGULATOR_CHANGE_MODE
+                                        | REGULATOR_CHANGE_STATUS,
+        },
+        .num_consumer_supplies  =3D ARRAY_SIZE(sdp3430_vpll2_supplies),
+        .consumer_supplies      =3D sdp3430_vpll2_supplies,
+};
+
+
 static void __init omap_ldp_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -358,6 +423,7 @@ static struct twl4030_platform_data ldp_twldata =3D {
 	.vaux1		=3D &ldp_vaux1,
 	.gpio		=3D &ldp_gpio_data,
 	.keypad		=3D &ldp_kp_twl4030_data,
+	.vpll2          =3D &sdp3430_vpll2,
 };
=20
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] =3D {
@@ -390,7 +456,6 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D {
=20
 static struct platform_device *ldp_devices[] __initdata =3D {
 	&ldp_smsc911x_device,
-	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
 };
=20
@@ -441,10 +506,8 @@ static struct mtd_partition ldp_nand_partitions[] =3D =
{
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config =3D ldp_config;
-	omap_board_config_size =3D ARRAY_SIZE(ldp_config);
-	ldp_init_smsc911x();
 	omap_i2c_init();
+//	sdp3430_display_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	ts_gpio =3D 54;
 	ldp_spi_board_info[0].irq =3D gpio_to_irq(ts_gpio);
@@ -459,6 +522,8 @@ static void __init omap_ldp_init(void)
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev =3D mmc[0].dev;
+	sdp3430_display_init();
+	omap_display_init(&sdp3430_dss_data);
 }
=20
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/dis=
plays/Kconfig
index 0b05593..3f4488b 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -55,4 +55,9 @@ config PANEL_ACX565AKM
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900
+config PANEL_LDP
+	tristate "LDP PANEL"
+	help
+		This is the LCD panel used on LDP
+
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/di=
splays/Makefile
index d90f73c..9d7235c 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PANEL_TAAL) +=3D panel-taal.o
 obj-$(CONFIG_PANEL_PICODLP) +=3D  panel-picodlp.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) +=3D panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) +=3D panel-acx565akm.o
+obj-$(CONFIG_PANEL_LDP) +=3D panel-ldp.o
diff --git a/drivers/video/omap2/displays/panel-ldp.c b/drivers/video/omap2=
/displays/panel-ldp.c
new file mode 100755
index 0000000..3f9bfd1
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-ldp.c
@@ -0,0 +1,223 @@
+/*
+ * Generic DPI Panels support
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/i2c/twl.h>
+#include <mach/gpio.h>
+#include <plat/mux.h>
+#include <asm/mach-types.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <plat/panel-generic-dpi.h>
+#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK_MAX	41700
+#else
+#define LCD_XRES		240
+#define LCD_YRES		320
+#define LCD_PIXCLOCK_MAX	185186
+#endif
+
+#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
+#define ENABLE_VAUX2_DEDICATED  0x09
+#define ENABLE_VAUX2_DEV_GRP    0x20
+#define ENABLE_VAUX3_DEDICATED	0x03
+#define ENABLE_VAUX3_DEV_GRP	0x20
+
+#define ENABLE_VPLL2_DEDICATED          0x05
+#define ENABLE_VPLL2_DEV_GRP            0xE0
+#define TWL4030_VPLL2_DEV_GRP           0x33
+#define TWL4030_VPLL2_DEDICATED         0x36
+
+#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
+
+static struct omap_video_timings ldp_timings =3D {
+        .x_res =3D 480,
+        .y_res =3D 640,
+
+        .hsw            =3D 3,
+        .hfp            =3D 3,
+        .hbp            =3D 39,
+
+        .vsw            =3D 1,
+        .vfp            =3D 2,
+        .vbp            =3D 7,
+        .pixel_clock    =3D 41700,
+};
+
+static void ldp_panel_cleanup(void)
+{
+	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+	gpio_free(LCD_PANEL_QVGA_GPIO);
+	gpio_free(LCD_PANEL_RESET_GPIO);
+}
+
+static int panel_ldp_probe(struct omap_dss_device *dssdev)
+{
+	dssdev->panel.timings =3D ldp_timings;
+	dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+				OMAP_DSS_LCD_IHS;
+	dssdev->panel.acb =3D 0x28;
+
+	return 0;
+}
+
+static void panel_ldp_remove(struct omap_dss_device *dssdev)
+{
+	return;
+}
+
+static int panel_ldp_power_on(struct omap_dss_device *dssdev)
+{
+        int r =3D 0;
+
+        if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
+                return 0;
+        r =3D omapdss_dpi_display_enable(dssdev);
+        if (r)
+                goto err0;
+
+        /* wait couple of vsyncs until enabling the LCD */
+        msleep(50);
+        if (dssdev->platform_enable) {
+                r =3D dssdev->platform_enable(dssdev);
+                if (r)
+                        goto err1;
+        }
+        return 0;
+err1:
+        omapdss_dpi_display_disable(dssdev);
+err0:
+        return r;
+}
+
+static void panel_ldp_power_off(struct omap_dss_device *dssdev)
+{
+        if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
+                return;
+
+        if (dssdev->platform_disable)
+                dssdev->platform_disable(dssdev);
+
+        /* wait at least 5 vsyncs after disabling the LCD */
+
+        msleep(100);
+
+        omapdss_dpi_display_disable(dssdev);
+}
+static int panel_ldp_enable(struct omap_dss_device *dssdev)
+{
+        gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
+        gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+        gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+        gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+
+        gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
+        gpio_direction_output(LCD_PANEL_RESET_GPIO, 0);
+        gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+        gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+#ifdef CONFIG_FB_OMAP_LCD_VGA
+        gpio_set_value(LCD_PANEL_QVGA_GPIO, 0);
+#else
+        gpio_set_value(LCD_PANEL_QVGA_GPIO, 1);
+#endif
+        gpio_set_value(LCD_PANEL_RESET_GPIO, 1);
+
+	if (0 !=3D t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
+			TWL4030_VPLL2_DEDICATED))
+		return -EIO;
+
+	if (0 !=3D t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
+			TWL4030_VPLL2_DEV_GRP))
+		return -EIO;
+
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	int r =3D panel_ldp_power_on(dssdev);
+
+	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
+	if (0 !=3D t2_out(PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
+				TWL4030_VAUX3_DEDICATED))
+		return -EIO;
+
+	if (0 !=3D t2_out(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
+				TWL4030_VAUX3_DEV_GRP))
+		return -EIO;
+
+	return r;
+}
+
+static void panel_ldp_disable(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+	t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+	msleep(4);
+	panel_ldp_power_off(dssdev);
+	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static void panel_ldp_get_resolution(struct omap_dss_device *dssdev, int *=
w, int *h)
+{
+	*w =3D ldp_timings.x_res;
+	*h =3D ldp_timings.y_res;
+	if (*w =3D=3D 0)
+		*w =3D 320;
+}
+
+static struct omap_dss_driver ldp_panel =3D {
+	.probe		=3D panel_ldp_probe,
+	.remove		=3D panel_ldp_remove,
+
+	.enable		=3D panel_ldp_enable,
+	.disable	=3D panel_ldp_disable,
+
+	.get_resolution	=3D panel_ldp_get_resolution,
+
+	.driver         =3D {
+		.name   =3D "ldp_panel",
+		.owner  =3D THIS_MODULE,
+	},
+};
+
+static int __init panel_ldp_drv_init(void)
+{
+	return omap_dss_register_driver(&ldp_panel);
+}
+
+static void __exit panel_ldp_drv_exit(void)
+{
+	omap_dss_unregister_driver(&ldp_panel);
+}
+
+module_init(panel_ldp_drv_init);
+module_exit(panel_ldp_drv_exit);
+MODULE_LICENSE("GPL");
--=20
1.7.1


--_002_EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679dbde02enttico_
Content-Type: application/octet-stream; name="0001-LDP-Tomi-patch.patch"
Content-Description: 0001-LDP-Tomi-patch.patch
Content-Disposition: attachment; filename="0001-LDP-Tomi-patch.patch";
	size=12355; creation-date="Thu, 12 May 2011 18:54:09 GMT";
	modification-date="Thu, 12 May 2011 18:54:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZjM0NzBkM2Q3OTI3MjFiZjVhYTRkMDYwYzFjZjc5ZjVhNTg3NDk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXl1cmVzaCBKYW5vcmthciA8bWF5dXJAdGkuY29tPgpEYXRl
OiBUaHUsIDEyIE1heSAyMDExIDE4OjUzOjQ2ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gTERQIFRv
bWkgcGF0Y2gKCi0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1sZHAuYyAgICAgICAgICB8
ICAgODcgKysrKysrKysrKy0tCiBkcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL0tjb25maWcg
ICAgIHwgICAgNSArCiBkcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL01ha2VmaWxlICAgIHwg
ICAgMSArCiBkcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL3BhbmVsLWxkcC5jIHwgIDIyMyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgMzA1IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQogbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSBh
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxkcC5jCiBjcmVhdGUgbW9kZSAxMDA3NTUgZHJpdmVy
cy92aWRlby9vbWFwMi9kaXNwbGF5cy9wYW5lbC1sZHAuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtbGRwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxkcC5j
Cm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKaW5kZXggZTJiYTc3OS4uZmE2MzI3YQot
LS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxkcC5jCisrKyBiL2FyY2gvYXJtL21hY2gt
b21hcDIvYm9hcmQtbGRwLmMKQEAgLTQzLDYgKzQzLDcgQEAKIAogI2luY2x1ZGUgPGFzbS9kZWxh
eS5oPgogI2luY2x1ZGUgPHBsYXQvdXNiLmg+CisjaW5jbHVkZSA8cGxhdC9kaXNwbGF5Lmg+CiAK
ICNpbmNsdWRlICJib2FyZC1mbGFzaC5oIgogI2luY2x1ZGUgIm11eC5oIgpAQCAtNTMsNiArNTQs
MTEgQEAKICNkZWZpbmUgTERQX1NNU0M5MTFYX0dQSU8JMTUyCiAjZGVmaW5lIERFQlVHX0JBU0UJ
CTB4MDgwMDAwMDAKICNkZWZpbmUgTERQX0VUSFJfU1RBUlQJCURFQlVHX0JBU0UKKyNkZWZpbmUg
TENEX1BBTkVMX0JBQ0tMSUdIVF9HUElPCSgxNSArIE9NQVBfTUFYX0dQSU9fTElORVMpCisjZGVm
aW5lIExDRF9QQU5FTF9FTkFCTEVfR1BJTwkJKDcgKyBPTUFQX01BWF9HUElPX0xJTkVTKQorCisj
ZGVmaW5lIExDRF9QQU5FTF9SRVNFVF9HUElPCQk1NQorI2RlZmluZSBMQ0RfUEFORUxfUVZHQV9H
UElPCQk1NgogCiBzdGF0aWMgc3RydWN0IHJlc291cmNlIGxkcF9zbXNjOTExeF9yZXNvdXJjZXNb
XSA9IHsKIAlbMF0gPSB7CkBAIC0yNzUsMTkgKzI4MSw3OCBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
X19pbml0IGxkcF9pbml0X3Ntc2M5MTF4KHZvaWQpCiAJZ3Bpb19kaXJlY3Rpb25faW5wdXQoZXRo
X2dwaW8pOwogfQogCi1zdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBsZHBfbGNkX2Rldmlj
ZSA9IHsKLQkubmFtZQkJPSAibGRwX2xjZCIsCi0JLmlkCQk9IC0xLAorI2RlZmluZSBTRFAzNDMw
X0xDRF9QQU5FTF9CQUNLTElHSFRfR1BJTwk4CisjZGVmaW5lIFNEUDM0MzBfTENEX1BBTkVMX0VO
QUJMRV9HUElPCQk1CisKK3N0YXRpYyB1bnNpZ25lZCBiYWNrbGlnaHRfZ3BpbzsKK3N0YXRpYyB1
bnNpZ25lZCBlbmFibGVfZ3BpbzsKK3N0YXRpYyBpbnQgbGNkX2VuYWJsZWQ7CisKK3N0YXRpYyB2
b2lkIF9faW5pdCBzZHAzNDMwX2Rpc3BsYXlfaW5pdCh2b2lkKQoreworCXByaW50ayhLRVJOX0lO
Rk8gIlxuIExEUDo6IHNkcDM0MzBfZGlzcGxheV9pbml0ICIpOworICAgICAgICByZXR1cm47Cit9
CisKK3N0YXRpYyBpbnQgc2RwMzQzMF9wYW5lbF9lbmFibGVfbGNkKHN0cnVjdCBvbWFwX2Rzc19k
ZXZpY2UgKmRzc2RldikKK3sKKwlpbnQgc3RhdHVzOworCXJldHVybiAwOworfQorCitzdGF0aWMg
dm9pZCBzZHAzNDMwX3BhbmVsX2Rpc2FibGVfbGNkKHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmRz
c2RldikKK3sKKwlsY2RfZW5hYmxlZCA9IDA7CisKKwlncGlvX2RpcmVjdGlvbl9vdXRwdXQoZW5h
YmxlX2dwaW8sIDApOworCWdwaW9fZGlyZWN0aW9uX291dHB1dChiYWNrbGlnaHRfZ3BpbywgMCk7
CisKKwlncGlvX2RpcmVjdGlvbl9vdXRwdXQoTENEX1BBTkVMX0VOQUJMRV9HUElPLCAwKTsKKwln
cGlvX2RpcmVjdGlvbl9vdXRwdXQoTENEX1BBTkVMX0JBQ0tMSUdIVF9HUElPLCAwKTsKKworfQor
CitzdGF0aWMgc3RydWN0IG9tYXBfZHNzX2RldmljZSBzZHAzNDMwX2xjZF9kZXZpY2UgPSB7CisJ
Lm5hbWUJCQk9ICJsY2QiLAorCS5kcml2ZXJfbmFtZQkJPSAibGRwX3BhbmVsIiwKKwkudHlwZQkJ
CT0gT01BUF9ESVNQTEFZX1RZUEVfRFBJLAorCS5waHkuZHBpLmRhdGFfbGluZXMJPSAxNiwKKwku
cGxhdGZvcm1fZW5hYmxlCT0gc2RwMzQzMF9wYW5lbF9lbmFibGVfbGNkLAorCS5wbGF0Zm9ybV9k
aXNhYmxlCT0gc2RwMzQzMF9wYW5lbF9kaXNhYmxlX2xjZCwKIH07CiAKLXN0YXRpYyBzdHJ1Y3Qg
b21hcF9sY2RfY29uZmlnIGxkcF9sY2RfY29uZmlnIF9faW5pdGRhdGEgPSB7Ci0JLmN0cmxfbmFt
ZQk9ICJpbnRlcm5hbCIsCitzdGF0aWMgc3RydWN0IG9tYXBfZHNzX2RldmljZSAqc2RwMzQzMF9k
c3NfZGV2aWNlc1tdID0geworCSZzZHAzNDMwX2xjZF9kZXZpY2UsCiB9OwogCi1zdGF0aWMgc3Ry
dWN0IG9tYXBfYm9hcmRfY29uZmlnX2tlcm5lbCBsZHBfY29uZmlnW10gX19pbml0ZGF0YSA9IHsK
LQl7IE9NQVBfVEFHX0xDRCwJCSZsZHBfbGNkX2NvbmZpZyB9LAorc3RhdGljIHN0cnVjdCBvbWFw
X2Rzc19ib2FyZF9pbmZvIHNkcDM0MzBfZHNzX2RhdGEgPSB7CisJLm51bV9kZXZpY2VzCT0gQVJS
QVlfU0laRShzZHAzNDMwX2Rzc19kZXZpY2VzKSwKKwkuZGV2aWNlcwk9IHNkcDM0MzBfZHNzX2Rl
dmljZXMsCisJLmRlZmF1bHRfZGV2aWNlCT0gJnNkcDM0MzBfbGNkX2RldmljZSwKIH07CiAKKy8q
IFZQTEwyIGZvciBkaWdpdGFsIHZpZGVvIG91dHB1dHMgKi8KK3N0YXRpYyBzdHJ1Y3QgcmVndWxh
dG9yX2NvbnN1bWVyX3N1cHBseSBzZHAzNDMwX3ZwbGwyX3N1cHBsaWVzW10gPSB7CisgICAgICAg
IFJFR1VMQVRPUl9TVVBQTFkoInZkZHNfZHNpIiwgIm9tYXBkc3MiKSwKKyAgICAgICAgUkVHVUxB
VE9SX1NVUFBMWSgidmRkc19kc2kiLCAib21hcF9kc2kxIiksCit9OworCitzdGF0aWMgc3RydWN0
IHJlZ3VsYXRvcl9pbml0X2RhdGEgc2RwMzQzMF92cGxsMiA9IHsKKyAgICAgICAgLmNvbnN0cmFp
bnRzID0geworICAgICAgICAgICAgICAgIC5uYW1lICAgICAgICAgICAgICAgICAgID0gIlZEVkki
LAorICAgICAgICAgICAgICAgIC5taW5fdVYgICAgICAgICAgICAgICAgID0gMTgwMDAwMCwKKyAg
ICAgICAgICAgICAgICAubWF4X3VWICAgICAgICAgICAgICAgICA9IDE4MDAwMDAsCisgICAgICAg
ICAgICAgICAgLmFwcGx5X3VWICAgICAgICAgICAgICAgPSB0cnVlLAorICAgICAgICAgICAgICAg
IC52YWxpZF9tb2Rlc19tYXNrICAgICAgID0gUkVHVUxBVE9SX01PREVfTk9STUFMCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBSRUdVTEFUT1JfTU9ERV9TVEFOREJZ
LAorICAgICAgICAgICAgICAgIC52YWxpZF9vcHNfbWFzayAgICAgICAgID0gUkVHVUxBVE9SX0NI
QU5HRV9NT0RFCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBSRUdV
TEFUT1JfQ0hBTkdFX1NUQVRVUywKKyAgICAgICAgfSwKKyAgICAgICAgLm51bV9jb25zdW1lcl9z
dXBwbGllcyAgPSBBUlJBWV9TSVpFKHNkcDM0MzBfdnBsbDJfc3VwcGxpZXMpLAorICAgICAgICAu
Y29uc3VtZXJfc3VwcGxpZXMgICAgICA9IHNkcDM0MzBfdnBsbDJfc3VwcGxpZXMsCit9OworCisK
IHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwX2xkcF9pbml0X2Vhcmx5KHZvaWQpCiB7CiAJb21hcDJf
aW5pdF9jb21tb25faW5mcmFzdHJ1Y3R1cmUoKTsKQEAgLTM1OCw2ICs0MjMsNyBAQCBzdGF0aWMg
c3RydWN0IHR3bDQwMzBfcGxhdGZvcm1fZGF0YSBsZHBfdHdsZGF0YSA9IHsKIAkudmF1eDEJCT0g
JmxkcF92YXV4MSwKIAkuZ3BpbwkJPSAmbGRwX2dwaW9fZGF0YSwKIAkua2V5cGFkCQk9ICZsZHBf
a3BfdHdsNDAzMF9kYXRhLAorCS52cGxsMiAgICAgICAgICA9ICZzZHAzNDMwX3ZwbGwyLAogfTsK
IAogc3RhdGljIHN0cnVjdCBpMmNfYm9hcmRfaW5mbyBfX2luaXRkYXRhIGxkcF9pMmNfYm9hcmRp
bmZvW10gPSB7CkBAIC0zOTAsNyArNDU2LDYgQEAgc3RhdGljIHN0cnVjdCBvbWFwMl9oc21tY19p
bmZvIG1tY1tdIF9faW5pdGRhdGEgPSB7CiAKIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpsZHBfZGV2aWNlc1tdIF9faW5pdGRhdGEgPSB7CiAJJmxkcF9zbXNjOTExeF9kZXZpY2UsCi0J
JmxkcF9sY2RfZGV2aWNlLAogCSZsZHBfZ3Bpb19rZXlzX2RldmljZSwKIH07CiAKQEAgLTQ0MSwx
MCArNTA2LDggQEAgc3RhdGljIHN0cnVjdCBtdGRfcGFydGl0aW9uIGxkcF9uYW5kX3BhcnRpdGlv
bnNbXSA9IHsKIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwX2xkcF9pbml0KHZvaWQpCiB7CiAJb21h
cDNfbXV4X2luaXQoYm9hcmRfbXV4LCBPTUFQX1BBQ0tBR0VfQ0JCKTsKLQlvbWFwX2JvYXJkX2Nv
bmZpZyA9IGxkcF9jb25maWc7Ci0Jb21hcF9ib2FyZF9jb25maWdfc2l6ZSA9IEFSUkFZX1NJWkUo
bGRwX2NvbmZpZyk7Ci0JbGRwX2luaXRfc21zYzkxMXgoKTsKIAlvbWFwX2kyY19pbml0KCk7Cisv
LwlzZHAzNDMwX2Rpc3BsYXlfaW5pdCgpOwogCXBsYXRmb3JtX2FkZF9kZXZpY2VzKGxkcF9kZXZp
Y2VzLCBBUlJBWV9TSVpFKGxkcF9kZXZpY2VzKSk7CiAJdHNfZ3BpbyA9IDU0OwogCWxkcF9zcGlf
Ym9hcmRfaW5mb1swXS5pcnEgPSBncGlvX3RvX2lycSh0c19ncGlvKTsKQEAgLTQ1OSw2ICs1MjIs
OCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcF9sZHBfaW5pdCh2b2lkKQogCW9tYXAyX2hzbW1j
X2luaXQobW1jKTsKIAkvKiBsaW5rIHJlZ3VsYXRvcnMgdG8gTU1DIGFkYXB0ZXJzICovCiAJbGRw
X3ZtbWMxX3N1cHBseS5kZXYgPSBtbWNbMF0uZGV2OworCXNkcDM0MzBfZGlzcGxheV9pbml0KCk7
CisJb21hcF9kaXNwbGF5X2luaXQoJnNkcDM0MzBfZHNzX2RhdGEpOwogfQogCiBNQUNISU5FX1NU
QVJUKE9NQVBfTERQLCAiT01BUCBMRFAgYm9hcmQiKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRl
by9vbWFwMi9kaXNwbGF5cy9LY29uZmlnIGIvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9L
Y29uZmlnCmluZGV4IDBiMDU1OTMuLjNmNDQ4OGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8v
b21hcDIvZGlzcGxheXMvS2NvbmZpZworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlz
L0tjb25maWcKQEAgLTU1LDQgKzU1LDkgQEAgY29uZmlnIFBBTkVMX0FDWDU2NUFLTQogCXNlbGVj
dCBCQUNLTElHSFRfQ0xBU1NfREVWSUNFCiAJaGVscAogCSAgVGhpcyBpcyB0aGUgTENEIHBhbmVs
IHVzZWQgb24gTm9raWEgTjkwMAorY29uZmlnIFBBTkVMX0xEUAorCXRyaXN0YXRlICJMRFAgUEFO
RUwiCisJaGVscAorCQlUaGlzIGlzIHRoZSBMQ0QgcGFuZWwgdXNlZCBvbiBMRFAKKwogZW5kbWVu
dQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9NYWtlZmlsZSBiL2Ry
aXZlcnMvdmlkZW8vb21hcDIvZGlzcGxheXMvTWFrZWZpbGUKaW5kZXggZDkwZjczYy4uOWQ3MjM1
YyAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9NYWtlZmlsZQorKysg
Yi9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL01ha2VmaWxlCkBAIC03LDMgKzcsNCBAQCBv
YmotJChDT05GSUdfUEFORUxfVEFBTCkgKz0gcGFuZWwtdGFhbC5vCiBvYmotJChDT05GSUdfUEFO
RUxfUElDT0RMUCkgKz0gIHBhbmVsLXBpY29kbHAubwogb2JqLSQoQ09ORklHX1BBTkVMX1RQT19U
RDA0M01URUExKSArPSBwYW5lbC10cG8tdGQwNDNtdGVhMS5vCiBvYmotJChDT05GSUdfUEFORUxf
QUNYNTY1QUtNKSArPSBwYW5lbC1hY3g1NjVha20ubworb2JqLSQoQ09ORklHX1BBTkVMX0xEUCkg
Kz0gcGFuZWwtbGRwLm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcDIvZGlzcGxheXMv
cGFuZWwtbGRwLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL3BhbmVsLWxkcC5jCm5l
dyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAuLjNmOWJmZDEKLS0tIC9kZXYvbnVsbAor
KysgYi9kcml2ZXJzL3ZpZGVvL29tYXAyL2Rpc3BsYXlzL3BhbmVsLWxkcC5jCkBAIC0wLDAgKzEs
MjIzIEBACisvKgorICogR2VuZXJpYyBEUEkgUGFuZWxzIHN1cHBvcnQKKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeSBpdAorICogdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSB2ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5CisgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQgV0lUSE9VVAorICogQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YgTUVSQ0hBTlRBQklMSVRZIG9yCisgKiBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgZm9yCisgKiBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZl
IHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcg
d2l0aAorICogdGhpcyBwcm9ncmFtLiAgSWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9s
aWNlbnNlcy8+LgorICovCisKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1
ZGUgPGxpbnV4L2kyYy90d2wuaD4KKyNpbmNsdWRlIDxtYWNoL2dwaW8uaD4KKyNpbmNsdWRlIDxw
bGF0L211eC5oPgorI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CisjaW5jbHVkZSA8bGludXgv
c2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisKKyNpbmNsdWRlIDxwbGF0L3BhbmVs
LWdlbmVyaWMtZHBpLmg+CisjZGVmaW5lIExDRF9QQU5FTF9CQUNLTElHSFRfR1BJTwkoMTUgKyBP
TUFQX01BWF9HUElPX0xJTkVTKQorI2RlZmluZSBMQ0RfUEFORUxfRU5BQkxFX0dQSU8JCSg3ICsg
T01BUF9NQVhfR1BJT19MSU5FUykKKworI2RlZmluZSBMQ0RfUEFORUxfUkVTRVRfR1BJTwkJNTUK
KyNkZWZpbmUgTENEX1BBTkVMX1FWR0FfR1BJTwkJNTYKKworI2lmZGVmIENPTkZJR19GQl9PTUFQ
X0xDRF9WR0EKKyNkZWZpbmUgTENEX1hSRVMJCTQ4MAorI2RlZmluZSBMQ0RfWVJFUwkJNjQwCisj
ZGVmaW5lIExDRF9QSVhDTE9DS19NQVgJNDE3MDAKKyNlbHNlCisjZGVmaW5lIExDRF9YUkVTCQky
NDAKKyNkZWZpbmUgTENEX1lSRVMJCTMyMAorI2RlZmluZSBMQ0RfUElYQ0xPQ0tfTUFYCTE4NTE4
NgorI2VuZGlmCisKKyNkZWZpbmUgUE1fUkVDRUlWRVIgICAgICAgICAgICAgVFdMNDAzMF9NT0RV
TEVfUE1fUkVDRUlWRVIKKyNkZWZpbmUgRU5BQkxFX1ZBVVgyX0RFRElDQVRFRCAgMHgwOQorI2Rl
ZmluZSBFTkFCTEVfVkFVWDJfREVWX0dSUCAgICAweDIwCisjZGVmaW5lIEVOQUJMRV9WQVVYM19E
RURJQ0FURUQJMHgwMworI2RlZmluZSBFTkFCTEVfVkFVWDNfREVWX0dSUAkweDIwCisKKyNkZWZp
bmUgRU5BQkxFX1ZQTEwyX0RFRElDQVRFRCAgICAgICAgICAweDA1CisjZGVmaW5lIEVOQUJMRV9W
UExMMl9ERVZfR1JQICAgICAgICAgICAgMHhFMAorI2RlZmluZSBUV0w0MDMwX1ZQTEwyX0RFVl9H
UlAgICAgICAgICAgIDB4MzMKKyNkZWZpbmUgVFdMNDAzMF9WUExMMl9ERURJQ0FURUQgICAgICAg
ICAweDM2CisKKyNkZWZpbmUgdDJfb3V0KGMsIHIsIHYpIHR3bF9pMmNfd3JpdGVfdTgoYywgciwg
dikKKworc3RhdGljIHN0cnVjdCBvbWFwX3ZpZGVvX3RpbWluZ3MgbGRwX3RpbWluZ3MgPSB7Cisg
ICAgICAgIC54X3JlcyA9IDQ4MCwKKyAgICAgICAgLnlfcmVzID0gNjQwLAorCisgICAgICAgIC5o
c3cgICAgICAgICAgICA9IDMsCisgICAgICAgIC5oZnAgICAgICAgICAgICA9IDMsCisgICAgICAg
IC5oYnAgICAgICAgICAgICA9IDM5LAorCisgICAgICAgIC52c3cgICAgICAgICAgICA9IDEsCisg
ICAgICAgIC52ZnAgICAgICAgICAgICA9IDIsCisgICAgICAgIC52YnAgICAgICAgICAgICA9IDcs
CisgICAgICAgIC5waXhlbF9jbG9jayAgICA9IDQxNzAwLAorfTsKKworc3RhdGljIHZvaWQgbGRw
X3BhbmVsX2NsZWFudXAodm9pZCkKK3sKKwlncGlvX2ZyZWUoTENEX1BBTkVMX0JBQ0tMSUdIVF9H
UElPKTsKKwlncGlvX2ZyZWUoTENEX1BBTkVMX0VOQUJMRV9HUElPKTsKKwlncGlvX2ZyZWUoTENE
X1BBTkVMX1FWR0FfR1BJTyk7CisJZ3Bpb19mcmVlKExDRF9QQU5FTF9SRVNFVF9HUElPKTsKK30K
Kworc3RhdGljIGludCBwYW5lbF9sZHBfcHJvYmUoc3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNz
ZGV2KQoreworCWRzc2Rldi0+cGFuZWwudGltaW5ncyA9IGxkcF90aW1pbmdzOworCWRzc2Rldi0+
cGFuZWwuY29uZmlnID0gT01BUF9EU1NfTENEX1RGVCB8IE9NQVBfRFNTX0xDRF9JVlMgfAorCQkJ
CU9NQVBfRFNTX0xDRF9JSFM7CisJZHNzZGV2LT5wYW5lbC5hY2IgPSAweDI4OworCisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyB2b2lkIHBhbmVsX2xkcF9yZW1vdmUoc3RydWN0IG9tYXBfZHNzX2Rl
dmljZSAqZHNzZGV2KQoreworCXJldHVybjsKK30KKworc3RhdGljIGludCBwYW5lbF9sZHBfcG93
ZXJfb24oc3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNzZGV2KQoreworICAgICAgICBpbnQgciA9
IDA7CisKKyAgICAgICAgaWYgKGRzc2Rldi0+c3RhdGUgPT0gT01BUF9EU1NfRElTUExBWV9BQ1RJ
VkUpCisgICAgICAgICAgICAgICAgcmV0dXJuIDA7CisgICAgICAgIHIgPSBvbWFwZHNzX2RwaV9k
aXNwbGF5X2VuYWJsZShkc3NkZXYpOworICAgICAgICBpZiAocikKKyAgICAgICAgICAgICAgICBn
b3RvIGVycjA7CisKKyAgICAgICAgLyogd2FpdCBjb3VwbGUgb2YgdnN5bmNzIHVudGlsIGVuYWJs
aW5nIHRoZSBMQ0QgKi8KKyAgICAgICAgbXNsZWVwKDUwKTsKKyAgICAgICAgaWYgKGRzc2Rldi0+
cGxhdGZvcm1fZW5hYmxlKSB7CisgICAgICAgICAgICAgICAgciA9IGRzc2Rldi0+cGxhdGZvcm1f
ZW5hYmxlKGRzc2Rldik7CisgICAgICAgICAgICAgICAgaWYgKHIpCisgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycjE7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJuIDA7CitlcnIxOgor
ICAgICAgICBvbWFwZHNzX2RwaV9kaXNwbGF5X2Rpc2FibGUoZHNzZGV2KTsKK2VycjA6CisgICAg
ICAgIHJldHVybiByOworfQorCitzdGF0aWMgdm9pZCBwYW5lbF9sZHBfcG93ZXJfb2ZmKHN0cnVj
dCBvbWFwX2Rzc19kZXZpY2UgKmRzc2RldikKK3sKKyAgICAgICAgaWYgKGRzc2Rldi0+c3RhdGUg
IT0gT01BUF9EU1NfRElTUExBWV9BQ1RJVkUpCisgICAgICAgICAgICAgICAgcmV0dXJuOworCisg
ICAgICAgIGlmIChkc3NkZXYtPnBsYXRmb3JtX2Rpc2FibGUpCisgICAgICAgICAgICAgICAgZHNz
ZGV2LT5wbGF0Zm9ybV9kaXNhYmxlKGRzc2Rldik7CisKKyAgICAgICAgLyogd2FpdCBhdCBsZWFz
dCA1IHZzeW5jcyBhZnRlciBkaXNhYmxpbmcgdGhlIExDRCAqLworCisgICAgICAgIG1zbGVlcCgx
MDApOworCisgICAgICAgIG9tYXBkc3NfZHBpX2Rpc3BsYXlfZGlzYWJsZShkc3NkZXYpOworfQor
c3RhdGljIGludCBwYW5lbF9sZHBfZW5hYmxlKHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmRzc2Rl
dikKK3sKKyAgICAgICAgZ3Bpb19yZXF1ZXN0KExDRF9QQU5FTF9SRVNFVF9HUElPLCAibGNkIHJl
c2V0Iik7CisgICAgICAgIGdwaW9fcmVxdWVzdChMQ0RfUEFORUxfUVZHQV9HUElPLCAibGNkIHF2
Z2EiKTsKKyAgICAgICAgZ3Bpb19yZXF1ZXN0KExDRF9QQU5FTF9FTkFCTEVfR1BJTywgImxjZCBw
YW5lbCIpOworICAgICAgICBncGlvX3JlcXVlc3QoTENEX1BBTkVMX0JBQ0tMSUdIVF9HUElPLCAi
bGNkIGJhY2tsaWdodCIpOworCisgICAgICAgIGdwaW9fZGlyZWN0aW9uX291dHB1dChMQ0RfUEFO
RUxfUVZHQV9HUElPLCAwKTsKKyAgICAgICAgZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KExDRF9QQU5F
TF9SRVNFVF9HUElPLCAwKTsKKyAgICAgICAgZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KExDRF9QQU5F
TF9FTkFCTEVfR1BJTywgMCk7CisgICAgICAgIGdwaW9fZGlyZWN0aW9uX291dHB1dChMQ0RfUEFO
RUxfQkFDS0xJR0hUX0dQSU8sIDApOworCisjaWZkZWYgQ09ORklHX0ZCX09NQVBfTENEX1ZHQQor
ICAgICAgICBncGlvX3NldF92YWx1ZShMQ0RfUEFORUxfUVZHQV9HUElPLCAwKTsKKyNlbHNlCisg
ICAgICAgIGdwaW9fc2V0X3ZhbHVlKExDRF9QQU5FTF9RVkdBX0dQSU8sIDEpOworI2VuZGlmCisg
ICAgICAgIGdwaW9fc2V0X3ZhbHVlKExDRF9QQU5FTF9SRVNFVF9HUElPLCAxKTsKKworCWlmICgw
ICE9IHQyX291dChQTV9SRUNFSVZFUiwgRU5BQkxFX1ZQTEwyX0RFRElDQVRFRCwKKwkJCVRXTDQw
MzBfVlBMTDJfREVESUNBVEVEKSkKKwkJcmV0dXJuIC1FSU87CisKKwlpZiAoMCAhPSB0Ml9vdXQo
UE1fUkVDRUlWRVIsIEVOQUJMRV9WUExMMl9ERVZfR1JQLAorCQkJVFdMNDAzMF9WUExMMl9ERVZf
R1JQKSkKKwkJcmV0dXJuIC1FSU87CisKKwlncGlvX2RpcmVjdGlvbl9vdXRwdXQoTENEX1BBTkVM
X0VOQUJMRV9HUElPLCAxKTsKKwlncGlvX2RpcmVjdGlvbl9vdXRwdXQoTENEX1BBTkVMX0JBQ0tM
SUdIVF9HUElPLCAxKTsKKworCWludCByID0gcGFuZWxfbGRwX3Bvd2VyX29uKGRzc2Rldik7CisK
Kwlkc3NkZXYtPnN0YXRlID0gT01BUF9EU1NfRElTUExBWV9BQ1RJVkU7CisJaWYgKDAgIT0gdDJf
b3V0KFBNX1JFQ0VJVkVSLCBFTkFCTEVfVkFVWDNfREVESUNBVEVELAorCQkJCVRXTDQwMzBfVkFV
WDNfREVESUNBVEVEKSkKKwkJcmV0dXJuIC1FSU87CisKKwlpZiAoMCAhPSB0Ml9vdXQoUE1fUkVD
RUlWRVIsIEVOQUJMRV9WQVVYM19ERVZfR1JQLAorCQkJCVRXTDQwMzBfVkFVWDNfREVWX0dSUCkp
CisJCXJldHVybiAtRUlPOworCisJcmV0dXJuIHI7Cit9CisKK3N0YXRpYyB2b2lkIHBhbmVsX2xk
cF9kaXNhYmxlKHN0cnVjdCBvbWFwX2Rzc19kZXZpY2UgKmRzc2RldikKK3sKKwlncGlvX2RpcmVj
dGlvbl9vdXRwdXQoTENEX1BBTkVMX0VOQUJMRV9HUElPLCAwKTsKKwlncGlvX2RpcmVjdGlvbl9v
dXRwdXQoTENEX1BBTkVMX0JBQ0tMSUdIVF9HUElPLCAwKTsKKworCXQyX291dChQTV9SRUNFSVZF
UiwgMHgwLCBUV0w0MDMwX1ZQTEwyX0RFRElDQVRFRCk7CisJdDJfb3V0KFBNX1JFQ0VJVkVSLCAw
eDAsIFRXTDQwMzBfVlBMTDJfREVWX0dSUCk7CisJbXNsZWVwKDQpOworCXBhbmVsX2xkcF9wb3dl
cl9vZmYoZHNzZGV2KTsKKwlkc3NkZXYtPnN0YXRlID0gT01BUF9EU1NfRElTUExBWV9ESVNBQkxF
RDsKK30KKworc3RhdGljIHZvaWQgcGFuZWxfbGRwX2dldF9yZXNvbHV0aW9uKHN0cnVjdCBvbWFw
X2Rzc19kZXZpY2UgKmRzc2RldiwgaW50ICp3LCBpbnQgKmgpCit7CisJKncgPSBsZHBfdGltaW5n
cy54X3JlczsKKwkqaCA9IGxkcF90aW1pbmdzLnlfcmVzOworCWlmICgqdyA9PSAwKQorCQkqdyA9
IDMyMDsKK30KKworc3RhdGljIHN0cnVjdCBvbWFwX2Rzc19kcml2ZXIgbGRwX3BhbmVsID0gewor
CS5wcm9iZQkJPSBwYW5lbF9sZHBfcHJvYmUsCisJLnJlbW92ZQkJPSBwYW5lbF9sZHBfcmVtb3Zl
LAorCisJLmVuYWJsZQkJPSBwYW5lbF9sZHBfZW5hYmxlLAorCS5kaXNhYmxlCT0gcGFuZWxfbGRw
X2Rpc2FibGUsCisKKwkuZ2V0X3Jlc29sdXRpb24JPSBwYW5lbF9sZHBfZ2V0X3Jlc29sdXRpb24s
CisKKwkuZHJpdmVyICAgICAgICAgPSB7CisJCS5uYW1lICAgPSAibGRwX3BhbmVsIiwKKwkJLm93
bmVyICA9IFRISVNfTU9EVUxFLAorCX0sCit9OworCitzdGF0aWMgaW50IF9faW5pdCBwYW5lbF9s
ZHBfZHJ2X2luaXQodm9pZCkKK3sKKwlyZXR1cm4gb21hcF9kc3NfcmVnaXN0ZXJfZHJpdmVyKCZs
ZHBfcGFuZWwpOworfQorCitzdGF0aWMgdm9pZCBfX2V4aXQgcGFuZWxfbGRwX2Rydl9leGl0KHZv
aWQpCit7CisJb21hcF9kc3NfdW5yZWdpc3Rlcl9kcml2ZXIoJmxkcF9wYW5lbCk7Cit9CisKK21v
ZHVsZV9pbml0KHBhbmVsX2xkcF9kcnZfaW5pdCk7Cittb2R1bGVfZXhpdChwYW5lbF9sZHBfZHJ2
X2V4aXQpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwotLSAKMS43LjEKCg==

--_002_EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679dbde02enttico_--

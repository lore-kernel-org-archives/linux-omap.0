From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] [Resend] omapfb: lcd_ams_delta: add support for contrast control
Date: Fri, 11 Dec 2009 14:21:46 +0100
Message-ID: <200912111421.47664.jkrzyszt@tis.icnet.pl>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl> <200912111255.48176.jkrzyszt@tis.icnet.pl> <1260533259.10417.3.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49997 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbZLKNVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:21:37 -0500
In-Reply-To: <1260533259.10417.3.camel@tubuntu.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The patch extends the Amstrad Delta LCD panel driver with optional supp=
ort for
changing contrast using standard LCD class device API instead of settin=
g it
silently to a default value at panel enable. It also allows for lowerin=
g power
consumption by turning off OMAP_PWL_CLK_ENABLE via lcd_ops.set_power ca=
llback.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
=46riday 11 December 2009 13:07:39 Tomi Valkeinen napisa=C5=82(a):
> On Fri, 2009-12-11 at 12:55 +0100, ext Janusz Krzysztofik wrote:
> >
> > Am I supposed to do anything about this series[1]? Resend to you?
>
> Yes, please resend to me. I don't seem to have the patches in my mail=
box
> anymore.

Tomi,

I tested it on top of l-o commit 82f1d8f22f2c65e70206e40a6f17688bf64a89=
2c that
already had your DSS2 merged. I'll refresh it against your tree if requ=
ired,
or when submitting a new version if changes requested.

Thanks,
Janusz=20

--- a/drivers/video/omap/lcd_ams_delta.c	2009-11-14 23:49:16.000000000 =
+0100
+++ b/drivers/video/omap/lcd_ams_delta.c	2009-11-16 01:32:19.000000000 =
+0100
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/lcd.h>
=20
 #include <plat/board-ams-delta.h>
 #include <mach/hardware.h>
@@ -31,6 +32,71 @@
=20
 #define AMS_DELTA_DEFAULT_CONTRAST	112
=20
+#define AMS_DELTA_MAX_CONTRAST		0x00FF
+#define AMS_DELTA_LCD_POWER		0x0100
+
+
+/* LCD class device section */
+
+static int ams_delta_lcd;
+
+static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
+{
+	if (power =3D=3D FB_BLANK_UNBLANK) {
+		if (!(ams_delta_lcd & AMS_DELTA_LCD_POWER)) {
+			omap_writeb(ams_delta_lcd & AMS_DELTA_MAX_CONTRAST,
+					OMAP_PWL_ENABLE);
+			omap_writeb(1, OMAP_PWL_CLK_ENABLE);
+			ams_delta_lcd |=3D AMS_DELTA_LCD_POWER;
+		}
+	} else {
+		if (ams_delta_lcd & AMS_DELTA_LCD_POWER) {
+			omap_writeb(0, OMAP_PWL_ENABLE);
+			omap_writeb(0, OMAP_PWL_CLK_ENABLE);
+			ams_delta_lcd &=3D ~AMS_DELTA_LCD_POWER;
+		}
+	}
+	return 0;
+}
+
+static int ams_delta_lcd_set_contrast(struct lcd_device *dev, int valu=
e)
+{
+	if ((value >=3D 0) && (value <=3D AMS_DELTA_MAX_CONTRAST)) {
+		omap_writeb(value, OMAP_PWL_ENABLE);
+		ams_delta_lcd &=3D ~AMS_DELTA_MAX_CONTRAST;
+		ams_delta_lcd |=3D value;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_LCD_CLASS_DEVICE
+static int ams_delta_lcd_get_power(struct lcd_device *dev)
+{
+	if (ams_delta_lcd & AMS_DELTA_LCD_POWER)
+		return FB_BLANK_UNBLANK;
+	else
+		return FB_BLANK_POWERDOWN;
+}
+
+static int ams_delta_lcd_get_contrast(struct lcd_device *dev)
+{
+	if (!(ams_delta_lcd & AMS_DELTA_LCD_POWER))
+		return 0;
+
+	return ams_delta_lcd & AMS_DELTA_MAX_CONTRAST;
+}
+
+static struct lcd_ops ams_delta_lcd_ops =3D {
+	.get_power =3D ams_delta_lcd_get_power,
+	.set_power =3D ams_delta_lcd_set_power,
+	.get_contrast =3D ams_delta_lcd_get_contrast,
+	.set_contrast =3D ams_delta_lcd_set_contrast,
+};
+#endif
+
+
+/* omapfb panel section */
+
 static int ams_delta_panel_init(struct lcd_panel *panel,
 		struct omapfb_device *fbdev)
 {
@@ -47,10 +113,6 @@ static int ams_delta_panel_enable(struct
 			AMS_DELTA_LATCH2_LCD_NDISP);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
 			AMS_DELTA_LATCH2_LCD_VBLEN);
-
-	omap_writeb(1, OMAP_PWL_CLK_ENABLE);
-	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP_PWL_ENABLE);
-
 	return 0;
 }
=20
@@ -90,8 +152,31 @@ static struct lcd_panel ams_delta_panel=20
 	.get_caps	=3D ams_delta_panel_get_caps,
 };
=20
+
+/* platform driver section */
+
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
+	struct lcd_device *lcd_device =3D NULL;
+#ifdef CONFIG_LCD_CLASS_DEVICE
+	int ret;
+
+	lcd_device =3D lcd_device_register("omapfb", &pdev->dev, NULL,
+						&ams_delta_lcd_ops);
+
+	if (IS_ERR(lcd_device)) {
+		ret =3D PTR_ERR(lcd_device);
+		dev_err(&pdev->dev, "failed to register device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, lcd_device);
+	lcd_device->props.max_contrast =3D AMS_DELTA_MAX_CONTRAST;
+#endif
+
+	ams_delta_lcd_set_contrast(lcd_device, AMS_DELTA_DEFAULT_CONTRAST);
+	ams_delta_lcd_set_power(lcd_device, FB_BLANK_UNBLANK);
+
 	omapfb_register_panel(&ams_delta_panel);
 	return 0;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 9 May 2014 11:31:10 +0300
Message-ID: <536C924E.5000307@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Jb7IK3tOp3n3WPSCdjqKiKvXing8HJhMK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46905 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbaEIIbg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 04:31:36 -0400
In-Reply-To: <20140508233300.GI2198@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--Jb7IK3tOp3n3WPSCdjqKiKvXing8HJhMK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 02:33, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140507 11:00]:
>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
>>> On 07/05/14 18:03, Tony Lindgren wrote:
>>>>
>>>> BTW, I'm also personally fine with all five gpios showing in a singl=
e
>>>> gpios property, I'm not too exited about naming anything in DT..
>>>
>>> I don't have a strong opinion here. I don't have much experience with=

>>> DT, especially with making bindings compatible with other ones.
>>>
>>> I'd just forget the simple-panel, and have single gpio array.
>>
>> Well if it's a don't care flag for both of us, let's try to use
>> the existing standard for simple-panel.txt and add mode-gpios
>> property. I'll post a patch for that.
>=20
> Here's an updated version using enable-gpios, reset-gpios and
> mode-gpios. So it follows simple-panel.txt and adds mode-gpios
> that's currently specific to this panel only.
>=20
> Also updated for -EPROBE_DEFER handling, tested that by changing
> one of the GPIOs to be a twl4030 GPIO.

To speed things up a bit, I made the changes I suggested. Compile tested
only.


=46rom f8360778e8bc96096cbb1793a18a8c240376ca09 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2014 20:22:21 -0700
Subject: [PATCH] OMAPDSS: panel-sharp-ls037v7dw01: add device tree suppor=
t

Add device tree support for sharp-ls037v7dw01 panel.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../bindings/video/sharp,ls037v7dw01.txt           | 44 ++++++++++
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 95 ++++++++++++++++=
+++++-
 2 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/sharp,ls037v7=
dw01.txt

diff --git a/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.tx=
t b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
new file mode 100644
index 000000000000..2a60fd9a2607
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
@@ -0,0 +1,44 @@
+SHARP LS037V7DW01 TFT-LCD panel
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Required properties:
+- compatible: "sharp,ls037v7dw01"
+
+Optional properties:
+- label: a symbolic name for the panel
+- enable-gpios: a GPIO spec for the optional enable pin
+  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
+- reset-gpios: a GPIO spec for the optional reset pin
+  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
+- mode-gpios: a GPIO
+  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
+
+Required nodes:
+- Video port for DPI input
+
+This panel can have zero to five GPIOs to configure
+to change configuration between QVGA and VGA mode
+and the scan direction. As these pins can be also
+configured with external pulls, all the GPIOs are
+considered optional with holes in the array.
+
+Example
+-------
+
+Example when connected to a omap2+ based device:
+
+lcd0: display {
+	compatible =3D "sharp,ls037v7dw01";
+	power-supply =3D <&lcd_3v3>;
+	enable-gpios =3D <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	mode-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint =3D <&dpi_out>;
+		};
+	};
+};
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw=
01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
index 8adde628ad38..91eeb2ec93a8 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -12,15 +12,18 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
=20
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
+	struct regulator *vcc;
=20
 	int data_lines;
=20
@@ -95,12 +98,21 @@ static int sharp_ls_enable(struct omap_dss_device *ds=
sdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
=20
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
=20
+	if (ddata->vcc) {
+		r =3D regulator_enable(ddata->vcc);
+		if (r !=3D 0)
+			return r;
+	}
+
 	r =3D in->ops.dpi->enable(in);
-	if (r)
+	if (r) {
+		regulator_disable(ddata->vcc);
 		return r;
+	}
=20
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
@@ -136,6 +148,9 @@ static void sharp_ls_disable(struct omap_dss_device *=
dssdev)
=20
 	in->ops.dpi->disable(in);
=20
+	if (ddata->vcc)
+		regulator_disable(ddata->vcc);
+
 	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
 }
=20
@@ -243,6 +258,68 @@ static int sharp_ls_probe_pdata(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
+static struct gpio_desc *
+sharp_ls_get_gpio_of(struct device *dev, int index, int val, char *desc)=

+{
+	struct gpio_desc *gpio;
+
+	gpio =3D devm_gpiod_get_index(dev, desc, index);
+	if (IS_ERR(gpio))
+		return gpio;
+
+	gpiod_direction_output(gpio, val);
+
+	return gpio;
+}
+
+static int sharp_ls_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
+	struct device_node *node =3D pdev->dev.of_node;
+	struct omap_dss_device *in;
+
+	ddata->vcc =3D devm_regulator_get(&pdev->dev, "envdd");
+	if (IS_ERR(ddata->vcc)) {
+		dev_err(&pdev->dev, "failed to get regulator\n");
+		return PTR_ERR(ddata->vcc);
+	}
+
+	/* lcd INI */
+	ddata->ini_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 3, 0, "enable");
+	if (PTR_ERR(ddata->ini_gpio) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd RESB */
+	ddata->resb_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "reset");
+	if (PTR_ERR(ddata->resb_gpio) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd MO */
+	ddata->mo_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "mode");
+	if (PTR_ERR(ddata->mo_gpio) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd LR */
+	ddata->lr_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 1, 1, "mode");
+	if (PTR_ERR(ddata->lr_gpio) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd UD */
+	ddata->ud_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 2, 1, "mode");
+	if (PTR_ERR(ddata->ud_gpio) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	in =3D omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in =3D in;
+
+	return 0;
+}
+
 static int sharp_ls_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -259,6 +336,10 @@ static int sharp_ls_probe(struct platform_device *pd=
ev)
 		r =3D sharp_ls_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r =3D sharp_ls_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -302,12 +383,20 @@ static int __exit sharp_ls_remove(struct platform_d=
evice *pdev)
 	return 0;
 }
=20
+static const struct of_device_id sharp_ls_of_match[] =3D {
+	{ .compatible =3D "omapdss,sharp,ls037v7dw01", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sharp_ls_of_match);
+
 static struct platform_driver sharp_ls_driver =3D {
 	.probe =3D sharp_ls_probe,
 	.remove =3D __exit_p(sharp_ls_remove),
 	.driver =3D {
 		.name =3D "panel-sharp-ls037v7dw01",
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D sharp_ls_of_match,
 	},
 };
=20
--=20
1.9.1



--Jb7IK3tOp3n3WPSCdjqKiKvXing8HJhMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbJJOAAoJEPo9qoy8lh71uX8QAK5kJK6tK6ml1JkMr3d3N/91
eZhkAJyfTR4/BhPanGV0kdUXWSc7e5HCskfWU4kpSz2k0Pfcoz01TJ9Cg4FcnEl3
1f0rEThtg4zAk9nV9ZJrnrp2oIM6Q5HL/qUS21rzZymBWjOxcnNNt66AmcCt+MTw
yHnK87Q5e2SXZbwUoeBkrFJ1c1zXwJoG/ipk8wc+PZWnjz/zzNq/FlqpRrvsECBb
bydhpXSplcetnHxlhDDqRyc22ddWtDrFI/uhKG8VVIOVFINflNlliBGlzYCIi+2c
w8Q8CDe+py531Upwa5TvrAnPAjAyUvxQICGTnPREq70GopQDzxahfmgSqNL3FQ7T
pmVFIV2Iwa3wb0LX7RH7hGnKMWDDt8RFMS8lOewnsvgXQfEbZfufyPwkuVXEFF6k
PPaHP0geVQJRhMXqycl0uj55lY/dnTIJVnMJiA+CNTtwzM+dPcZM6vqapwDh/Uvl
lK1/KTgHw+9+dL4lqDAHX2duvrB3qmT6TSQW3T5vZc/pbeq0VDAI0ss2Szd22qmh
TsmkQTMA/Q5oPmojlOjIs5swxImmCEA7RFekZbRffsCs6Tqly4oLHSbq7yAJn93D
K15EXVFf6a7g0ZoOWXQiqHqg+V3z4EkH2rHC3NkinvSbssHlRBsUPRrTIafUldTP
2qq0go9Fv5wfOwHxe7Ti
=sbsY
-----END PGP SIGNATURE-----

--Jb7IK3tOp3n3WPSCdjqKiKvXing8HJhMK--

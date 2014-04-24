From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Thu, 24 Apr 2014 12:52:42 +0300
Message-ID: <5358DEEA.1000506@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com> <20140418155107.GB5354@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FfmEg9E7tL9JeBu8jCgEM6uOUI9u8uE2M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57838 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbaDXJxe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 05:53:34 -0400
In-Reply-To: <20140418155107.GB5354@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joachim Eastwood <manabian@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--FfmEg9E7tL9JeBu8jCgEM6uOUI9u8uE2M
Content-Type: multipart/mixed;
 boundary="------------000606020709000307030805"

This is a multi-part message in MIME format.
--------------000606020709000307030805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/04/14 18:51, Tony Lindgren wrote:

>> +	gpio =3D of_get_gpio(node, 0);
>> +	if (gpio_is_valid(gpio) || gpio =3D=3D -ENOENT) {
>> +		ddata->enable_gpio =3D gpio;
>> +	} else {
>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
>> +		return gpio;
>> +	}
>=20
> We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
> gpio_backlight_probe_dt is doing.=20

Instead of doing it with the old gpio API, and checking the 'active'
flag everywhere, I think we can use the new gpiod API which handles the
polarity automatically.

I attached prototype patches (based on -rc2) for panel dpi using that
approach. It's a bit messier than I'd like, because for non-DT boot we
need to request the gpio using the old API, and then convert it to
gpio_desc. We can remove that code when all the boards use DT.

I've compiled tested this only, as I don't have DPI panels I could use.
I did try similar approach for TFP410, and it seemed to work fine.

 Tomi


--------------000606020709000307030805
Content-Type: text/x-patch;
 name="0001-panel-dpi-use-gpiod-for-enable-gpio.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-panel-dpi-use-gpiod-for-enable-gpio.patch"

=46rom f2280114f0eb814370664f24eba8ffee8280c840 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 12:36:52 +0300
Subject: [PATCH 1/3] panel-dpi: use gpiod for enable gpio

---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 32 +++++++++++++---=
------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers=
/video/fbdev/omap2/displays-new/panel-dpi.c
index 5f8f7e7c81ef..d379dec3bd4a 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -25,8 +25,10 @@ struct panel_drv_data {
=20
 	struct omap_video_timings videomode;
=20
+	/* used for non-DT boot, to be removed */
 	int backlight_gpio;
-	int enable_gpio;
+
+	struct gpio_desc *enable_gpio;
 };
=20
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
@@ -77,8 +79,8 @@ static int panel_dpi_enable(struct omap_dss_device *dss=
dev)
 	if (r)
 		return r;
=20
-	if (gpio_is_valid(ddata->enable_gpio))
-		gpio_set_value_cansleep(ddata->enable_gpio, 1);
+	if (ddata->enable_gpio)
+		gpiod_set_value_cansleep(ddata->enable_gpio, 1);
=20
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
@@ -96,8 +98,8 @@ static void panel_dpi_disable(struct omap_dss_device *d=
ssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
=20
-	if (gpio_is_valid(ddata->enable_gpio))
-		gpio_set_value_cansleep(ddata->enable_gpio, 0);
+	if (ddata->enable_gpio)
+		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
=20
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
@@ -156,6 +158,7 @@ static int panel_dpi_probe_pdata(struct platform_devi=
ce *pdev)
 	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
 	struct omap_dss_device *dssdev, *in;
 	struct videomode vm;
+	int r;
=20
 	pdata =3D dev_get_platdata(&pdev->dev);
=20
@@ -176,10 +179,20 @@ static int panel_dpi_probe_pdata(struct platform_de=
vice *pdev)
 	dssdev =3D &ddata->dssdev;
 	dssdev->name =3D pdata->name;
=20
-	ddata->enable_gpio =3D pdata->enable_gpio;
+	r =3D devm_gpio_request_one(&pdev->dev, pdata->enable_gpio,
+					GPIOF_OUT_INIT_LOW, "panel enable");
+	if (r)
+		goto err_gpio;
+
+	ddata->enable_gpio =3D gpio_to_desc(pdata->enable_gpio);
+
 	ddata->backlight_gpio =3D pdata->backlight_gpio;
=20
 	return 0;
+
+err_gpio:
+	omap_dss_put_device(ddata->in);
+	return r;
 }
=20
 static int panel_dpi_probe(struct platform_device *pdev)
@@ -202,13 +215,6 @@ static int panel_dpi_probe(struct platform_device *p=
dev)
 		return -ENODEV;
 	}
=20
-	if (gpio_is_valid(ddata->enable_gpio)) {
-		r =3D devm_gpio_request_one(&pdev->dev, ddata->enable_gpio,
-				GPIOF_OUT_INIT_LOW, "panel enable");
-		if (r)
-			goto err_gpio;
-	}
-
 	if (gpio_is_valid(ddata->backlight_gpio)) {
 		r =3D devm_gpio_request_one(&pdev->dev, ddata->backlight_gpio,
 				GPIOF_OUT_INIT_LOW, "panel backlight");
--=20
1.9.1


--------------000606020709000307030805
Content-Type: text/x-patch;
 name="0002-OMAPDSS-panel-dpi-Add-DT-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0002-OMAPDSS-panel-dpi-Add-DT-support.patch"

=46rom fe2a85da34499fab70212c4cc5870378678da709 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 May 2013 15:14:16 +0300
Subject: [PATCH 2/3] OMAPDSS: panel-dpi: Add DT support

Add DT support for panel-dpi.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 59 ++++++++++++++++=
+++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers=
/video/fbdev/omap2/displays-new/panel-dpi.c
index d379dec3bd4a..dca6b10d1157 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -13,9 +13,12 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
=20
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
+#include <video/of_display_timing.h>
=20
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
@@ -72,7 +75,8 @@ static int panel_dpi_enable(struct omap_dss_device *dss=
dev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
=20
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
=20
 	r =3D in->ops.dpi->enable(in);
@@ -195,6 +199,47 @@ err_gpio:
 	return r;
 }
=20
+static int panel_dpi_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
+	struct device_node *node =3D pdev->dev.of_node;
+	struct omap_dss_device *in;
+	int r;
+	struct display_timing timing;
+	struct videomode vm;
+	struct gpio_desc *gpio;
+
+	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
+	if (IS_ERR(gpio)) {
+		dev_err(&pdev->dev, "failed to parse enable gpio\n");
+		return PTR_ERR(gpio);
+	} else {
+		gpiod_direction_output(gpio, 0);
+		ddata->enable_gpio =3D gpio;
+	}
+
+	ddata->backlight_gpio =3D -ENOENT;
+
+	r =3D of_get_display_timing(node, "panel-timing", &timing);
+	if (r) {
+		dev_err(&pdev->dev, "failed to get video timing\n");
+		return r;
+	}
+
+	videomode_from_timing(&timing, &vm);
+	videomode_to_omap_video_timings(&vm, &ddata->videomode);
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
 static int panel_dpi_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -211,6 +256,10 @@ static int panel_dpi_probe(struct platform_device *p=
dev)
 		r =3D panel_dpi_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r =3D panel_dpi_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -260,12 +309,20 @@ static int __exit panel_dpi_remove(struct platform_=
device *pdev)
 	return 0;
 }
=20
+static const struct of_device_id panel_dpi_of_match[] =3D {
+	{ .compatible =3D "omapdss,panel-dpi", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, panel_dpi_of_match);
+
 static struct platform_driver panel_dpi_driver =3D {
 	.probe =3D panel_dpi_probe,
 	.remove =3D __exit_p(panel_dpi_remove),
 	.driver =3D {
 		.name =3D "panel-dpi",
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D panel_dpi_of_match,
 	},
 };
=20
--=20
1.9.1


--------------000606020709000307030805--

--FfmEg9E7tL9JeBu8jCgEM6uOUI9u8uE2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWN7qAAoJEPo9qoy8lh71lOYQAJbE9JjJdSePx69ww0lV8EDL
bH6RquyxyzrcI7wkMZVAMlt0SG0NwfXuhJRN4NsHZGbBncgpTq0Qdng74aFyxrd/
aR3zhogE+EJdRlQxXJvn0mPbeHWJHel+omiA3YkgScvxos9pbVzAGnCAeD/iVVVp
0sOqJuTn/v5b6K9DVDkNmRfFK/V0udMo84qzW1HkkdgeYti/NPUs1rmYTMmprvA4
mpyhVm8WAyuqaVyBuMFyyInYFhOHHo71SS8uyuprEF/2suylWkDQjt5HkO7lBFEg
u5tsyINbGjO2hMUcpkRzJ9Azc9o1rfYsyFYIBKbsgIwGBwT+hLCBH/nkpx1+mGy3
xFxZ9zjpuskidY3AeaILJ5E0MnIvcFzsJh0RydLMaEwqbAAlFoXBdjsSXH8N6Lia
ZXHvxDLzHxQH949l7/urQMM44gUk5DoxyeCUVIodCS3/cz0RJO5EBKRKYqkT0GeE
XtvyhR72VCLoYlB/6sMkwT/UrJUUU81OJM6LxFcNwrTUAVNYh8L6dAO9OA2/nDgN
yQ+/5lpHJ7GlAKwhY15Zjim1yBzZ8uJLn72vUDYpNEJ6tuevsNCKlV0lrNpg05Fy
1Jtnpdrkm4ar6fcLr7ho9YMeG+dgBRTiL2Ngw2v2BC3VdMmcu3sVR8+T9HAQxSB1
oXcMMg2ZDqSjokAGf49N
=pLc5
-----END PGP SIGNATURE-----

--FfmEg9E7tL9JeBu8jCgEM6uOUI9u8uE2M--

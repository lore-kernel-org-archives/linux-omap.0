From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] fbdev: omap2: improve usage of gpiod API
Date: Thu, 28 May 2015 10:05:15 +0200
Message-ID: <1432800315-25972-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57376 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbE1IFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 04:05:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, kernel@pengutronix.de

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Also make use of gpiod_get*_optional where applicable.

Apart from simplification of the affected drivers this is another step
towards making the flags argument to gpiod_get*() mandatory.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/omap2/displays-new/encoder-opa362.c     | 12 +++--=
-------
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c          | 13 +++--=
--------
 .../fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c     |  7 +++--=
--
 .../fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c      |  9 ++---=
----
 4 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c b/=
drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
index 84a6b3367124..a14d993f719d 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
@@ -201,15 +201,9 @@ static int opa362_probe(struct platform_device *pd=
ev)
=20
 	platform_set_drvdata(pdev, ddata);
=20
-	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
-	if (IS_ERR(gpio)) {
-		if (PTR_ERR(gpio) !=3D -ENOENT)
-			return PTR_ERR(gpio);
-
-		gpio =3D NULL;
-	} else {
-		gpiod_direction_output(gpio, 0);
-	}
+	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW)=
;
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
=20
 	ddata->enable_gpio =3D gpio;
=20
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
index eb8fd8140ad0..f7be3489f744 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -209,16 +209,9 @@ static int panel_dpi_probe_of(struct platform_devi=
ce *pdev)
 	struct videomode vm;
 	struct gpio_desc *gpio;
=20
-	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
-
-	if (IS_ERR(gpio)) {
-		if (PTR_ERR(gpio) !=3D -ENOENT)
-			return PTR_ERR(gpio);
-		else
-			gpio =3D NULL;
-	} else {
-		gpiod_direction_output(gpio, 0);
-	}
+	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW)=
;
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
=20
 	ddata->enable_gpio =3D gpio;
=20
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb0=
35q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q=
02.c
index 9974a37a11af..6a1b6a89a928 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
@@ -285,15 +285,14 @@ static int lb035q02_probe_of(struct spi_device *s=
pi)
 	struct omap_dss_device *in;
 	struct gpio_desc *gpio;
=20
-	gpio =3D devm_gpiod_get(&spi->dev, "enable");
+	gpio =3D devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio)) {
 		dev_err(&spi->dev, "failed to parse enable gpio\n");
 		return PTR_ERR(gpio);
-	} else {
-		gpiod_direction_output(gpio, 0);
-		ddata->enable_gpio =3D gpio;
 	}
=20
+	ddata->enable_gpio =3D gpio;
+
 	ddata->backlight_gpio =3D -ENOENT;
=20
 	in =3D omapdss_of_find_source_for_first_ep(node);
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7=
dw01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01=
=2Ec
index eae263702964..abfd1f6e3327 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -268,17 +268,12 @@ static  int sharp_ls_get_gpio_of(struct device *d=
ev, int index, int val,
 	const char *desc, struct gpio_desc **gpiod)
 {
 	struct gpio_desc *gd;
-	int r;
=20
 	*gpiod =3D NULL;
=20
-	gd =3D devm_gpiod_get_index(dev, desc, index);
+	gd =3D devm_gpiod_get_index(dev, desc, index, GPIOD_OUT_LOW);
 	if (IS_ERR(gd))
-		return PTR_ERR(gd) =3D=3D -ENOENT ? 0 : PTR_ERR(gd);
-
-	r =3D gpiod_direction_output(gd, val);
-	if (r)
-		return r;
+		return PTR_ERR(gd);
=20
 	*gpiod =3D gd;
 	return 0;
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

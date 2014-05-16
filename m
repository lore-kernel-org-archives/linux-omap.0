From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] OMAPDSS: Panel TPO-TD043MTEA1 DT support
Date: Fri, 16 May 2014 12:55:10 +0300
Message-ID: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580AbaEPJzZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 05:55:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Add DT support for panel TPO-TD043MTEA1.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>
---
 .../omap2/displays-new/panel-tpo-td043mtea1.c      | 41 ++++++++++++++=
+++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea=
1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
index 875b40263b33..ce509fbd235d 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/of_gpio.h>
=20
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -376,7 +377,8 @@ static int tpo_td043_enable(struct omap_dss_device =
*dssdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
=20
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
=20
 	r =3D in->ops.dpi->enable(in);
@@ -489,6 +491,31 @@ static int tpo_td043_probe_pdata(struct spi_device=
 *spi)
 	return 0;
 }
=20
+static int tpo_td043_probe_of(struct spi_device *spi)
+{
+	struct device_node *node =3D spi->dev.of_node;
+	struct panel_drv_data *ddata =3D dev_get_drvdata(&spi->dev);
+	struct omap_dss_device *in;
+	int gpio;
+
+	gpio =3D of_get_named_gpio(node, "reset-gpios", 0);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&spi->dev, "failed to parse enable gpio\n");
+		return gpio;
+	}
+	ddata->nreset_gpio =3D gpio;
+
+	in =3D omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&spi->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in =3D in;
+
+	return 0;
+}
+
 static int tpo_td043_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -518,6 +545,10 @@ static int tpo_td043_probe(struct spi_device *spi)
 		r =3D tpo_td043_probe_pdata(spi);
 		if (r)
 			return r;
+	} else if (spi->dev.of_node) {
+		r =3D tpo_td043_probe_of(spi);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -629,6 +660,13 @@ static int tpo_td043_spi_resume(struct device *dev=
)
 static SIMPLE_DEV_PM_OPS(tpo_td043_spi_pm,
 	tpo_td043_spi_suspend, tpo_td043_spi_resume);
=20
+static const struct of_device_id tpo_td043_of_match[] =3D {
+	{ .compatible =3D "omapdss,tpo,td043mtea1", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, tpo_td043_of_match);
+
 static struct spi_driver tpo_td043_spi_driver =3D {
 	.driver =3D {
 		.name	=3D "panel-tpo-td043mtea1",
@@ -641,6 +679,7 @@ static struct spi_driver tpo_td043_spi_driver =3D {
=20
 module_spi_driver(tpo_td043_spi_driver);
=20
+MODULE_ALIAS("spi:tpo,td043mtea1");
 MODULE_AUTHOR("Gra=C5=BEvydas Ignotas <notasas@gmail.com>");
 MODULE_DESCRIPTION("TPO TD043MTEA1 LCD Driver");
 MODULE_LICENSE("GPL");
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

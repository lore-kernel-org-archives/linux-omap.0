From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 05/14] OMAPDSS: Add DT support to HDMI
Date: Wed, 27 Mar 2013 10:45:12 +0200
Message-ID: <1364373921-7599-6-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47678 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab3C0Iq1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:27 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make the HDMI driver work with device tree.

The OMAP SoC HDMI (hdmi.c) change is simple, just add of_match_table.

The hdmi_panel.c is a bit more complex. We model both the TPD12S015 chip
and the HDMI connector, and handle both in the same driver. In the
future those should be separate drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c       |    7 +++
 drivers/video/omap2/dss/hdmi_panel.c |   86 +++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index f9e38c4..e7a18d3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -34,6 +34,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_gpio.h>
 #include <video/omapdss.h>
 
 #include "ti_hdmi.h"
@@ -1202,12 +1203,18 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 	.runtime_resume = hdmi_runtime_resume,
 };
 
+static const struct of_device_id hdmi_of_match[] = {
+	{ .compatible = "ti,omap4-hdmi", },
+	{},
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.remove         = __exit_p(omapdss_hdmihw_remove),
 	.driver         = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index bc4dea3..8dffd5d 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -27,12 +27,16 @@
 #include <video/omapdss.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include "dss.h"
 
 static struct {
 	struct omap_dss_device dssdev;
 
+	struct omap_dss_hdmi_data pdata;
+
 	/* This protects the panel ops, mainly when accessing the HDMI IP. */
 	struct mutex lock;
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
@@ -43,6 +47,62 @@ static struct {
 
 static struct omap_dss_driver hdmi_driver;
 
+static int hdmi_panel_probe_pdata(struct platform_device *pdev)
+{
+	const struct omap_dss_hdmi_data *pdata = dev_get_platdata(&pdev->dev);
+
+	hdmi.pdata = *pdata;
+
+	return 0;
+}
+
+static int hdmi_parse_tpd12s015_of(struct device_node *node,
+		struct omap_dss_hdmi_data *pdata)
+{
+	int gpio;
+
+	gpio = of_get_gpio(node, 0);	/* CT CP HPD */
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+	pdata->ct_cp_hpd_gpio = gpio;
+
+	gpio = of_get_gpio(node, 1);	/* LS OE */
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+	pdata->ls_oe_gpio = gpio;
+
+	gpio = of_get_gpio(node, 2);	/* HPD */
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+	pdata->hpd_gpio = gpio;
+
+	return 0;
+}
+
+static int hdmi_panel_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *src_node;
+	int r;
+
+	/*
+	 * We don't have a real driver for the TPD12S015 chip, but it is
+	 * modeled right in the DT data. So we need to parse the TPD12S015 data
+	 * here.
+	 */
+	src_node = of_parse_phandle(node, "video-source", 0);
+	if (!src_node) {
+		dev_err(&pdev->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	r = hdmi_parse_tpd12s015_of(src_node, &hdmi.pdata);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 static int hdmi_panel_probe(struct platform_device *pdev)
 {
 	/* Initialize default timings to VGA in DVI mode */
@@ -63,12 +123,28 @@ static int hdmi_panel_probe(struct platform_device *pdev)
 		.interlace	= false,
 	};
 
-	struct omap_dss_hdmi_data *pdata = dev_get_platdata(&pdev->dev);
 	struct omap_dss_device *dssdev = &hdmi.dssdev;
 	int r;
 
 	DSSDBG("ENTER hdmi_panel_probe\n");
 
+	if (dev_get_platdata(&pdev->dev)) {
+		r = hdmi_panel_probe_pdata(pdev);
+		if (r) {
+			dev_err(&pdev->dev, "failed to read platform data\n");
+			return r;
+		}
+	} else if (pdev->dev.of_node) {
+		r = hdmi_panel_probe_of(pdev);
+		if (r) {
+			dev_err(&pdev->dev, "failed to parse OF data\n");
+			return r;
+		}
+	} else {
+		return -ENODEV;
+	}
+
+
 	dssdev->panel.timings = default_timings;
 	dssdev->driver = &hdmi_driver;
 	dssdev->name = "hdmi";
@@ -78,7 +154,7 @@ static int hdmi_panel_probe(struct platform_device *pdev)
 	 * XXX for now, the hdmi panel's platform data contains the gpios for
 	 * the tpd level shifter chip, so we pass this data to the hdmi driver.
 	 */
-	dssdev->data = pdata;
+	dssdev->data = &hdmi.pdata;
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
 		dssdev->panel.timings.x_res,
@@ -415,12 +491,18 @@ static struct omap_dss_driver hdmi_driver = {
 	.audio_config	= hdmi_panel_audio_config,
 };
 
+static const struct of_device_id hdmi_panel_of_match[] = {
+	{ .compatible = "ti,hdmi_connector", },
+	{},
+};
+
 static struct platform_driver hdmi_panel_platform_driver = {
 	.probe	= hdmi_panel_probe,
 	.remove	= hdmi_panel_remove,
 	.driver	= {
 		.name	= "hdmi_panel",
 		.owner	= THIS_MODULE,
+		.of_match_table = hdmi_panel_of_match,
 	},
 };
 
-- 
1.7.10.4


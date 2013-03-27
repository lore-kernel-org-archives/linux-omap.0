From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [RFC 08/14] OMAPDSS: panel-generic-dpi: add DT support
Date: Wed, 27 Mar 2013 10:45:15 +0200
Message-ID: <1364373921-7599-9-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Andy Gross <andy.gross-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index cc49c48..a00c942 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <video/omapdss.h>
 
 #include <video/omap-panel-generic-dpi.h>
@@ -618,6 +619,42 @@ static int generic_dpi_panel_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int generic_dpi_panel_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct panel_drv_data *drv_data = dev_get_drvdata(&pdev->dev);
+	struct panel_config *panel_config = NULL;
+	int r, i;
+	int datalines;
+	const char *panel_name;
+
+	r = of_property_read_string(node, "panel-name", &panel_name);
+	if (r)
+		return r;
+
+	for (i = 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
+		if (strcmp(panel_name, generic_dpi_panels[i].name) == 0) {
+			panel_config = &generic_dpi_panels[i];
+			break;
+		}
+	}
+
+	if (!panel_config)
+		return -EINVAL;
+
+	r = of_property_read_u32(node, "data-lines", &datalines);
+	if (r) {
+		dev_err(&pdev->dev, "failed to parse datalines");
+		return r;
+	}
+
+	drv_data->panel_config = panel_config;
+	drv_data->name = node->name;
+	drv_data->data_lines = datalines;
+
+	return 0;
+}
+
 static int generic_dpi_panel_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *drv_data;
@@ -636,6 +673,10 @@ static int generic_dpi_panel_probe(struct platform_device *pdev)
 		r = generic_dpi_panel_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = generic_dpi_panel_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -EINVAL;
 	}
@@ -754,12 +795,18 @@ static struct omap_dss_driver generic_dpi_panel_driver = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
+static const struct of_device_id generic_dpi_panel_of_match[] = {
+	{ .compatible = "ti,dpi_panel", },
+	{},
+};
+
 static struct platform_driver generic_dpi_panel_platform_driver = {
 	.probe	= generic_dpi_panel_probe,
 	.remove	= __exit_p(generic_dpi_panel_remove),
 	.driver	= {
 		.name	= "generic_dpi_panel",
 		.owner	= THIS_MODULE,
+		.of_match_table = generic_dpi_panel_of_match,
 	},
 };
 
-- 
1.7.10.4

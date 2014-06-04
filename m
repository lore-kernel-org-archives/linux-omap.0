From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 6/7] OMAPDSS: DPI: Add support for multiple instances
Date: Wed, 4 Jun 2014 12:11:02 +0530
Message-ID: <1401864063-19196-7-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57915 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbaFDGml (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:41 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Register DPI outputs, and assign the port_num to them as specified by the
'reg' property in the DPI ports in DT.

To support multiple DPI instances, dpi_get_channel needs to take the DPI
instance's reg-id to get the corresponding channel. Make it take this
argument.We just pass 0 in the non-DT path, since we don't support multiple
instances in the non-DT case.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index b579022..3e204a8 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -616,7 +616,7 @@ static void dpi_init_pll(struct dpi_data *dpi)
  * the channel in some more dynamic manner, or get the channel as a user
  * parameter.
  */
-static enum omap_channel dpi_get_channel(void)
+static enum omap_channel dpi_get_channel(int reg)
 {
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
@@ -710,7 +710,7 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi.0";
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(0);
 	out->ops.dpi = &dpi_ops;
 	out->owner = THIS_MODULE;
 
@@ -730,11 +730,31 @@ static void dpi_init_output_port(struct platform_device *pdev,
 {
 	struct dpi_data *dpi = port->data;
 	struct omap_dss_device *out = &dpi->output;
+	int r;
+	u32 reg;
+
+	r = of_property_read_u32(port, "reg", &reg);
+	if (r)
+		reg = 0;
+
+	switch (reg) {
+	case 2:
+		out->name = "dpi.2";
+		break;
+	case 1:
+		out->name = "dpi.1";
+		break;
+	case 0:
+	default:
+		out->name = "dpi.0";
+		break;
+	}
 
 	out->dev = &pdev->dev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(reg);
+	out->port_num = reg;
 	out->ops.dpi = &dpi_ops;
 	out->owner = THIS_MODULE;
 
-- 
1.8.3.2


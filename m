From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 4/5] OMAPDSS: DPI: make dpi_get_channel take DPI reg-id
Date: Mon, 26 May 2014 14:58:11 +0530
Message-ID: <1401096492-1405-4-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
 <1401096492-1405-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbaEZJ3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 May 2014 05:29:43 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4Q9ThRn024838
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:43 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4Q9Thhr014398
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:43 -0500
In-Reply-To: <1401096492-1405-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

To support multiple DPI instances, dpi_get_channel needs to take the DPI
instance's reg-id to get the corresponding channel. Make it take this
argument.

We just pass 0 in the non-DT path, since we don't support multiple instances
in the non-DT case.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 43966a7..962c722 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -625,7 +625,7 @@ static void dpi_init_pll(struct dpi_data *dpi)
  * the channel in some more dynamic manner, or get the channel as a user
  * parameter.
  */
-static enum omap_channel dpi_get_channel(void)
+static enum omap_channel dpi_get_channel(int reg)
 {
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
@@ -719,7 +719,7 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi.0";
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(0);
 	out->ops.dpi = &dpi_ops;
 	out->owner = THIS_MODULE;
 
@@ -754,7 +754,7 @@ static void dpi_init_output_port(struct platform_device *pdev,
 	out->dev = &pdev->dev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
-	out->dispc_channel = dpi_get_channel();
+	out->dispc_channel = dpi_get_channel(reg);
 	out->ops.dpi = &dpi_ops;
 	out->port_num = reg;
 	out->owner = THIS_MODULE;
-- 
1.8.3.2


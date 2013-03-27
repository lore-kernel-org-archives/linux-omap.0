From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 03/14] OMAPDSS: Add DT support to DSS, DISPC, DPI
Date: Wed, 27 Mar 2013 10:45:10 +0200
Message-ID: <1364373921-7599-4-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761Ab3C0IqV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:21 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make DSS, DISPC and DPI drivers work with device tree on
OMAP3 and OMAP4. The only change is adding the of_match_tables.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 +++++++
 drivers/video/omap2/dss/dpi.c   |    8 ++++++++
 drivers/video/omap2/dss/dss.c   |    7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8cfa27b..be53d64 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3705,12 +3705,19 @@ static const struct dev_pm_ops dispc_pm_ops = {
 	.runtime_resume = dispc_runtime_resume,
 };
 
+static const struct of_device_id dispc_of_match[] = {
+	{ .compatible = "ti,omap3-dispc", },
+	{ .compatible = "ti,omap4-dispc", },
+	{},
+};
+
 static struct platform_driver omap_dispchw_driver = {
 	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
 		.pm	= &dispc_pm_ops,
+		.of_match_table = dispc_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e7beea2..dc7e324 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -765,11 +766,18 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dpi_of_match[] = {
+	{ .compatible = "ti,omap3-dpi", },
+	{ .compatible = "ti,omap4-dpi", },
+	{},
+};
+
 static struct platform_driver omap_dpi_driver = {
 	.remove         = __exit_p(omap_dpi_remove),
 	.driver         = {
 		.name   = "omapdss_dpi",
 		.owner  = THIS_MODULE,
+		.of_match_table = dpi_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 62db201..dc721f4 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -962,12 +962,19 @@ static const struct dev_pm_ops dss_pm_ops = {
 	.runtime_resume = dss_runtime_resume,
 };
 
+static const struct of_device_id dss_of_match[] = {
+	{ .compatible = "ti,omap3-dss", },
+	{ .compatible = "ti,omap4-dss", },
+	{},
+};
+
 static struct platform_driver omap_dsshw_driver = {
 	.remove         = __exit_p(omap_dsshw_remove),
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
 		.pm	= &dss_pm_ops,
+		.of_match_table = dss_of_match,
 	},
 };
 
-- 
1.7.10.4


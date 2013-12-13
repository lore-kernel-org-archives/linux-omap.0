From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 1/4] OMAPDSS: Add DT support to SDI
Date: Fri, 13 Dec 2013 19:17:27 +0100
Message-ID: <1386958650-2404-2-git-send-email-sre@debian.org>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:59909 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab3LMSSM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 13:18:12 -0500
In-Reply-To: <1386958650-2404-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add the code to make the SDI driver work with device tree on OMAP3.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/video/omap2/dss/sdi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ccc569a..bdc6a68 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -26,6 +26,8 @@
 #include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -333,6 +335,9 @@ static const struct omapdss_sdi_ops sdi_ops = {
 
 static void sdi_init_output(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *ep;
+
 	struct omap_dss_device *out = &sdi.output;
 
 	out->dev = &pdev->dev;
@@ -344,6 +349,15 @@ static void sdi_init_output(struct platform_device *pdev)
 	out->owner = THIS_MODULE;
 
 	omapdss_register_output(out);
+
+	if (!pdev->dev.of_node)
+		return;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return;
+
+	of_property_read_u32(ep, "data-lines", &sdi.datapairs);
 }
 
 static void __exit sdi_uninit_output(struct platform_device *pdev)
@@ -369,12 +383,18 @@ static int __exit omap_sdi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sdi_of_match[] = {
+	{ .compatible = "ti,omap3-sdi" },
+	{},
+};
+
 static struct platform_driver omap_sdi_driver = {
 	.probe		= omap_sdi_probe,
 	.remove         = __exit_p(omap_sdi_remove),
 	.driver         = {
 		.name   = "omapdss_sdi",
 		.owner  = THIS_MODULE,
+		.of_match_table = sdi_of_match,
 	},
 };
 
-- 
1.8.5.1


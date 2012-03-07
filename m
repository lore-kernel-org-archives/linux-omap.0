From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/21] OMAPDSS: create custom pdevs for DSS omap_devices
Date: Wed,  7 Mar 2012 14:44:41 +0200
Message-ID: <1331124290-6285-13-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55568 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758507Ab2CGMpg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:36 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so10333662lag.34
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:35 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using omap_device_build() to create the omap_devices for DSS
hwmods, create them with a custom function. This will allow us to create
a parent-child hierarchy for the devices so that the omapdss_core device
is parent for the rest of the dss hwmod devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   88 ++++++++++++++++++++++++++++++++++------
 1 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 279c124..3227eca 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -179,13 +179,71 @@ static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 		omap4_dsi_mux_pads(dsi_id, 0);
 }
 
+static struct platform_device *create_dss_pdev(const char *pdev_name,
+		int pdev_id, const char *oh_name, void *pdata, int pdata_len,
+		struct platform_device *parent)
+{
+	struct platform_device *pdev;
+	struct omap_device *od;
+	struct omap_hwmod *ohs[1];
+	struct omap_hwmod *oh;
+	int r;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		r = -ENODEV;
+		goto err;
+	}
+
+	pdev = platform_device_alloc(pdev_name, pdev_id);
+	if (!pdev) {
+		pr_err("Could not create pdev for %s\n", pdev_name);
+		r = -ENOMEM;
+		goto err;
+	}
+
+	if (parent != NULL)
+		pdev->dev.parent = &parent->dev;
+
+	if (pdev->id != -1)
+		dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
+	else
+		dev_set_name(&pdev->dev, "%s", pdev->name);
+
+	ohs[0] = oh;
+	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
+	if (!od) {
+		pr_err("Could not alloc omap_device for %s\n", pdev_name);
+		r = -ENOMEM;
+		goto err;
+	}
+
+	r = platform_device_add_data(pdev, pdata, pdata_len);
+	if (r) {
+		pr_err("Could not set pdata for %s\n", pdev_name);
+		goto err;
+	}
+
+	r = omap_device_register(pdev);
+	if (r) {
+		pr_err("Could not register omap_device for %s\n", pdev_name);
+		goto err;
+	}
+
+	return pdev;
+
+err:
+	return ERR_PTR(r);
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
-	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 	int i, oh_count;
 	const struct omap_dss_hwmod_data *curr_dss_hwmod;
+	struct platform_device *dss_pdev;
 
 	/* create omapdss device */
 
@@ -214,22 +272,24 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
 	}
 
-	for (i = 0; i < oh_count; i++) {
-		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
-		if (!oh) {
-			pr_err("Could not look up %s\n",
-				curr_dss_hwmod[i].oh_name);
-			return -ENODEV;
-		}
+	dss_pdev = NULL;
 
-		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
-				curr_dss_hwmod[i].id, oh,
+	for (i = 0; i < oh_count; i++) {
+		pdev = create_dss_pdev(curr_dss_hwmod[i].dev_name,
+				curr_dss_hwmod[i].id,
+				curr_dss_hwmod[i].oh_name,
 				NULL, 0,
-				NULL, 0, 0);
+				dss_pdev);
+
+		if (IS_ERR(pdev)) {
+			pr_err("Could not build omap_device for %s\n",
+					curr_dss_hwmod[i].oh_name);
+
+			return PTR_ERR(pdev);
+		}
 
-		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
-				curr_dss_hwmod[i].oh_name))
-			return -ENODEV;
+		if (i == 0)
+			dss_pdev = pdev;
 	}
 
 	return 0;
-- 
1.7.4.1


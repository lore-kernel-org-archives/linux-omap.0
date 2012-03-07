From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/21] OMAPDSS: create DPI & SDI devices
Date: Wed,  7 Mar 2012 14:44:42 +0200
Message-ID: <1331124290-6285-14-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42693 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758517Ab2CGMpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:38 -0500
Received: by mail-lpp01m020-f178.google.com with SMTP id gi11so119886lbb.23
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:37 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently have separate device/driver for each DSS HW module. The DPI
and SDI outputs are more or less parts of the DSS or DISPC hardware
modules, but in SW it makes sense to represent them as device/driver
pairs similarly to all the other outputs. This also makes sense for
device tree, as each node under dss will be a platform device, and
handling DPI & SDI somehow differently than the rest would just make the
code more complex.

This patch modifies arch/arm/mach-omap2/display.c to create platform
devices for DPI and SDI, and later patches will implement driver for
them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   57 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3227eca..f102d1f 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -237,6 +237,46 @@ err:
 	return ERR_PTR(r);
 }
 
+static struct platform_device *create_simple_dss_pdev(const char *pdev_name,
+		int pdev_id, void *pdata, int pdata_len,
+		struct platform_device *parent)
+{
+	struct platform_device *pdev;
+	int r;
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
@@ -292,6 +332,23 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 			dss_pdev = pdev;
 	}
 
+	/* Create devices for DPI and SDI */
+
+	pdev = create_simple_dss_pdev("omapdss_dpi", -1, NULL, 0, dss_pdev);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build platform_device for omapdss_dpi\n");
+		return PTR_ERR(pdev);
+	}
+
+	if (cpu_is_omap34xx()) {
+		pdev = create_simple_dss_pdev("omapdss_sdi", -1, NULL, 0,
+				dss_pdev);
+		if (IS_ERR(pdev)) {
+			pr_err("Could not build platform_device for omapdss_sdi\n");
+			return PTR_ERR(pdev);
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.4.1


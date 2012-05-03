From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/25] OMAPDSS: create DPI & SDI devices
Date: Thu,  3 May 2012 16:57:48 +0300
Message-ID: <1336053481-25433-13-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42173 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755730Ab2ECN6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:39 -0400
Received: by lagu2 with SMTP id u2so1275700lag.7
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:36 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
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
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 46d2a98..2c05a60 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -243,6 +243,46 @@ err:
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
@@ -299,6 +339,23 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
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
1.7.9.5


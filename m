From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 2/8] ARM OMAP2+ GPMC: add bus children
Date: Thu, 26 Feb 2015 15:45:50 +0100
Message-ID: <1424961956-29353-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

This patch adds support for spawning buses as children of the GPMC.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 5cabac8..74a8c52 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/omap-gpmc.h>
 #include <linux/mtd/nand.h>
 #include <linux/pm_runtime.h>
@@ -1800,8 +1801,20 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	gpmc_cs_enable_mem(cs);
 
 no_timings:
-	if (of_platform_device_create(child, NULL, &pdev->dev))
-		return 0;
+
+	/* create platform device, NULL on error or when disabled */
+	if (!of_platform_device_create(child, NULL, &pdev->dev))
+		goto err_child_fail;
+
+	/* is child a common bus? */
+	if (of_match_node(of_default_bus_match_table, child))
+		/* create children and other common bus children */
+		if (of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev))
+			goto err_child_fail;
+
+	return 0;
+
+err_child_fail:
 
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
 	ret = -ENODEV;
-- 
2.3.0

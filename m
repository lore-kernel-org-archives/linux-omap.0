From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 3/8 v2] ARM OMAP2+ GPMC: add bus children
Date: Tue, 24 Feb 2015 21:05:25 +0100
Message-ID: <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

This patch adds support for spawning busses as children of the GPMC.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 5cabac8..78b78a64 100644
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
@@ -1800,7 +1801,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	gpmc_cs_enable_mem(cs);
 
 no_timings:
-	if (of_platform_device_create(child, NULL, &pdev->dev))
+	if (!of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev))
 		return 0;
 
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
-- 
2.3.0

From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 4/4] ARM OMAP2+ GPMC: add bus children
Date: Mon, 16 Feb 2015 16:49:01 +0100
Message-ID: <1424101741-24152-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

This patch adds support for spawning busses as children of the GPMC.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4fa5ff1..c6c8543 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/pm_runtime.h>
 
@@ -1589,9 +1590,20 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	gpmc_cs_set_timings(cs, &gpmc_t);
 
 no_timings:
-	if (of_platform_device_create(child, NULL, &pdev->dev))
+
+	if (of_match_node(of_default_bus_match_table, child)) {
+
+		/* ignore return code, because 0 is ambiguous */
+		of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev);
 		return 0;
 
+	} else {
+
+		if (of_platform_device_create(child, NULL, &pdev->dev))
+			return 0;
+
+	}
+
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
 	ret = -ENODEV;
 
-- 
2.3.0

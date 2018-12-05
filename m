From: Rob Herring <robh@kernel.org>
Subject: [PATCH] memory: omap-gpmc: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:30 -0600
Message-ID: <20181205195050.4759-14-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which this is.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/memory/omap-gpmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 8abb9e94916a..ab5925c6d012 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2060,7 +2060,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	 * timings.
 	 */
 	name = gpmc_cs_get_name(cs);
-	if (name && of_node_cmp(child->name, name) == 0)
+	if (name && of_node_name_eq(child, name))
 		goto no_timings;
 
 	ret = gpmc_cs_request(cs, resource_size(&res), &base);
@@ -2068,7 +2068,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
 		return ret;
 	}
-	gpmc_cs_set_name(cs, child->name);
+	gpmc_cs_set_name(cs, child->full_name);
 
 	gpmc_read_settings_dt(child, &gpmc_s);
 	gpmc_read_timings_dt(child, &gpmc_t);
@@ -2113,7 +2113,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (of_node_cmp(child->name, "nand") == 0) {
+	if (of_node_name_eq(child, "nand")) {
 		/* Warn about older DT blobs with no compatible property */
 		if (!of_property_read_bool(child, "compatible")) {
 			dev_warn(&pdev->dev,
@@ -2123,7 +2123,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
-	if (of_node_cmp(child->name, "onenand") == 0) {
+	if (of_node_name_eq(child, "onenand")) {
 		/* Warn about older DT blobs with no compatible property */
 		if (!of_property_read_bool(child, "compatible")) {
 			dev_warn(&pdev->dev,
-- 
2.19.1

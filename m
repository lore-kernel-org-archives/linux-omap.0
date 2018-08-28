From: Rob Herring <robh@kernel.org>
Subject: [PATCH] memory: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:30 -0500
Message-ID: <20180828015252.28511-29-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/memory/omap-gpmc.c           | 18 +++++++-----------
 drivers/memory/samsung/exynos-srom.c |  4 ++--
 drivers/memory/tegra/mc.c            |  6 +++---
 drivers/memory/tegra/tegra124-emc.c  | 12 ++++++------
 4 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c215287e80cf..8abb9e94916a 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2145,8 +2145,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
 			break;
 		default:
-			dev_err(&pdev->dev, "%s: invalid 'nand-bus-width'\n",
-				child->name);
+			dev_err(&pdev->dev, "%pOFn: invalid 'nand-bus-width'\n",
+				child);
 			ret = -EINVAL;
 			goto err;
 		}
@@ -2186,8 +2186,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 
 	ret = gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to set gpmc timings for: %s\n",
-			child->name);
+		dev_err(&pdev->dev, "failed to set gpmc timings for: %pOFn\n",
+			child);
 		goto err_cs;
 	}
 
@@ -2215,7 +2215,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 
 err_child_fail:
 
-	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+	dev_err(&pdev->dev, "failed to create gpmc child %pOFn\n", child);
 	ret = -ENODEV;
 
 err_cs:
@@ -2265,14 +2265,10 @@ static void gpmc_probe_dt_children(struct platform_device *pdev)
 	struct device_node *child;
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-
-		if (!child->name)
-			continue;
-
 		ret = gpmc_probe_generic_child(pdev, child);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to probe DT child '%s': %d\n",
-				child->name, ret);
+			dev_err(&pdev->dev, "failed to probe DT child '%pOFn': %d\n",
+				child, ret);
 		}
 	}
 }
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 7edd7fb540f2..c27c6105c66d 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -139,8 +139,8 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	for_each_child_of_node(np, child) {
 		if (exynos_srom_configure_bank(srom, child)) {
 			dev_err(dev,
-				"Could not decode bank configuration for %s\n",
-				child->name);
+				"Could not decode bank configuration for %pOFn\n",
+				child);
 			bad_bank_config = true;
 		}
 	}
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd25faf6d13d..24afc36833bf 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -345,7 +345,7 @@ static int load_one_timing(struct tegra_mc *mc,
 	err = of_property_read_u32(node, "clock-frequency", &tmp);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read rate\n", node->name);
+			"timing %pOFn: failed to read rate\n", node);
 		return err;
 	}
 
@@ -360,8 +360,8 @@ static int load_one_timing(struct tegra_mc *mc,
 					 mc->soc->num_emem_regs);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read EMEM configuration\n",
-			node->name);
+			"timing %pOFn: failed to read EMEM configuration\n",
+			node);
 		return err;
 	}
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 392dc8dd481f..eedb7d48e2ea 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -888,8 +888,8 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 
 	err = of_property_read_u32(node, "clock-frequency", &value);
 	if (err) {
-		dev_err(emc->dev, "timing %s: failed to read rate: %d\n",
-			node->name, err);
+		dev_err(emc->dev, "timing %pOFn: failed to read rate: %d\n",
+			node, err);
 		return err;
 	}
 
@@ -900,16 +900,16 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 					 ARRAY_SIZE(timing->emc_burst_data));
 	if (err) {
 		dev_err(emc->dev,
-			"timing %s: failed to read emc burst data: %d\n",
-			node->name, err);
+			"timing %pOFn: failed to read emc burst data: %d\n",
+			node, err);
 		return err;
 	}
 
 #define EMC_READ_PROP(prop, dtprop) { \
 	err = of_property_read_u32(node, dtprop, &timing->prop); \
 	if (err) { \
-		dev_err(emc->dev, "timing %s: failed to read " #prop ": %d\n", \
-			node->name, err); \
+		dev_err(emc->dev, "timing %pOFn: failed to read " #prop ": %d\n", \
+			node, err); \
 		return err; \
 	} \
 }
-- 
2.17.1

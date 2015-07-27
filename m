From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] regulator: pbias: use untranslated address to program pbias regulator
Date: Mon, 27 Jul 2015 16:54:09 +0530
Message-ID: <1437996250-2913-2-git-send-email-kishon@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437996250-2913-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

vsel_reg and enable_reg of the pbias regulator descriptor should actually
have the offset from syscon. However after the pbias device tree node
is moved as a child node of syscon, vsel_reg and enable_reg has the
absolute address because of the address translation that happens while
creating device from device tree node.
So avoid using platform_get_resource and use of_get_address in order to
get only the offset (untranslated address) and populate these in
vsel_reg and enable_reg.

Cc: <stable@vger.kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/regulator/pbias-regulator.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index bd2b75c..a24cb43 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
+#include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -108,12 +109,14 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct pbias_regulator_data *drvdata;
-	struct resource *res;
 	struct regulator_config cfg = { };
 	struct regmap *syscon;
 	const struct pbias_reg_info *info;
 	int ret = 0;
 	int count, idx, data_idx = 0;
+	const __be32 *addrp;
+	int ns;
+	unsigned int reg;
 
 	count = of_regulator_match(&pdev->dev, np, pbias_matches,
 						PBIAS_NUM_REGS);
@@ -141,10 +144,13 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		if (!info)
 			return -ENODEV;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
+		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
 			return -EINVAL;
 
+		ns = of_n_size_cells(np);
+		reg = of_read_number(addrp, ns);
+
 		drvdata[data_idx].syscon = syscon;
 		drvdata[data_idx].info = info;
 		drvdata[data_idx].desc.name = info->name;
@@ -154,9 +160,9 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		drvdata[data_idx].desc.volt_table = pbias_volt_table;
 		drvdata[data_idx].desc.n_voltages = 2;
 		drvdata[data_idx].desc.enable_time = info->enable_time;
-		drvdata[data_idx].desc.vsel_reg = res->start;
+		drvdata[data_idx].desc.vsel_reg = reg;
 		drvdata[data_idx].desc.vsel_mask = info->vmode;
-		drvdata[data_idx].desc.enable_reg = res->start;
+		drvdata[data_idx].desc.enable_reg = reg;
 		drvdata[data_idx].desc.enable_mask = info->enable_mask;
 		drvdata[data_idx].desc.enable_val = info->enable;
 
-- 
1.7.9.5

From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] regulator: pbias: Fix broken pbias disable functionality
Date: Mon, 27 Jul 2015 16:54:10 +0530
Message-ID: <1437996250-2913-3-git-send-email-kishon@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437996250-2913-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

regulator_disable of pbias always writes '0' to the enable_reg.
However actual disable value of pbias regulator is not always '0'.
Fix it by populating the disable_val in pbias_reg_info for the
various platforms and assign it to the disable_val of
pbias regulator descriptor. This will be used by
regulator_disable_regmap while disabling pbias regulator.

Cc: <stable@vger.kernel.org> # 3.18+
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/regulator/pbias-regulator.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index a24cb43..ddf2c8e 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -31,6 +31,7 @@
 struct pbias_reg_info {
 	u32 enable;
 	u32 enable_mask;
+	u32 disable_val;
 	u32 vmode;
 	unsigned int enable_time;
 	char *name;
@@ -63,6 +64,7 @@ static const struct pbias_reg_info pbias_mmc_omap2430 = {
 	.enable = BIT(1),
 	.enable_mask = BIT(1),
 	.vmode = BIT(0),
+	.disable_val = 0,
 	.enable_time = 100,
 	.name = "pbias_mmc_omap2430"
 };
@@ -78,6 +80,7 @@ static const struct pbias_reg_info pbias_sim_omap3 = {
 static const struct pbias_reg_info pbias_mmc_omap4 = {
 	.enable = BIT(26) | BIT(22),
 	.enable_mask = BIT(26) | BIT(25) | BIT(22),
+	.disable_val = BIT(25),
 	.vmode = BIT(21),
 	.enable_time = 100,
 	.name = "pbias_mmc_omap4"
@@ -86,6 +89,7 @@ static const struct pbias_reg_info pbias_mmc_omap4 = {
 static const struct pbias_reg_info pbias_mmc_omap5 = {
 	.enable = BIT(27) | BIT(26),
 	.enable_mask = BIT(27) | BIT(25) | BIT(26),
+	.disable_val = BIT(25),
 	.vmode = BIT(21),
 	.enable_time = 100,
 	.name = "pbias_mmc_omap5"
@@ -165,6 +169,7 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		drvdata[data_idx].desc.enable_reg = reg;
 		drvdata[data_idx].desc.enable_mask = info->enable_mask;
 		drvdata[data_idx].desc.enable_val = info->enable;
+		drvdata[data_idx].desc.disable_val = info->disable_val;
 
 		cfg.init_data = pbias_matches[idx].init_data;
 		cfg.driver_data = &drvdata[data_idx];
-- 
1.7.9.5

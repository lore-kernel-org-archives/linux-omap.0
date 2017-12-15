From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/4] cpufreq: ti-cpufreq: Add support for multiple regulators
Date: Thu, 14 Dec 2017 22:25:26 -0600
Message-ID: <20171215042528.28715-3-d-gerlach@ti.com>
References: <20171215042528.28715-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171215042528.28715-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some platforms, like those in the DRA7 and AM57 families, require the
scaling of multiple regulators in order to properly support higher OPPs.
Let the ti-cpufreq driver determine when this is required and pass the
appropriate regulator names to the OPP core so that they can be properly
managed.

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 drivers/cpufreq/ti-cpufreq.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index b1c230a1e2aa..a099b7bf74cd 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -51,6 +51,7 @@ struct ti_cpufreq_soc_data {
 	unsigned long efuse_mask;
 	unsigned long efuse_shift;
 	unsigned long rev_offset;
+	bool multi_regulator;
 };
 
 struct ti_cpufreq_data {
@@ -58,6 +59,7 @@ struct ti_cpufreq_data {
 	struct device_node *opp_node;
 	struct regmap *syscon;
 	const struct ti_cpufreq_soc_data *soc_data;
+	struct opp_table *opp_table;
 };
 
 static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
@@ -96,6 +98,7 @@ static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_offset = 0x07fc,
 	.efuse_mask = 0x1fff,
 	.rev_offset = 0x600,
+	.multi_regulator = false,
 };
 
 static struct ti_cpufreq_soc_data am4x_soc_data = {
@@ -104,6 +107,7 @@ static struct ti_cpufreq_soc_data am4x_soc_data = {
 	.efuse_offset = 0x0610,
 	.efuse_mask = 0x3f,
 	.rev_offset = 0x600,
+	.multi_regulator = false,
 };
 
 static struct ti_cpufreq_soc_data dra7_soc_data = {
@@ -112,6 +116,7 @@ static struct ti_cpufreq_soc_data dra7_soc_data = {
 	.efuse_mask = 0xf80000,
 	.efuse_shift = 19,
 	.rev_offset = 0x204,
+	.multi_regulator = true,
 };
 
 /**
@@ -201,7 +206,9 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	u32 version[VERSION_COUNT];
 	struct device_node *np;
 	const struct of_device_id *match;
+	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
+	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
 	np = of_find_node_by_path("/");
@@ -248,16 +255,29 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_put_node;
 
-	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
-							  version, VERSION_COUNT));
-	if (ret) {
+	ti_opp_table = dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
+						   version, VERSION_COUNT);
+	if (IS_ERR(ti_opp_table)) {
 		dev_err(opp_data->cpu_dev,
 			"Failed to set supported hardware\n");
+		ret = PTR_ERR(ti_opp_table);
 		goto fail_put_node;
 	}
 
-	of_node_put(opp_data->opp_node);
+	opp_data->opp_table = ti_opp_table;
+
+	if (opp_data->soc_data->multi_regulator) {
+		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
+							 reg_names,
+							 ARRAY_SIZE(reg_names));
+		if (IS_ERR(ti_opp_table)) {
+			dev_pm_opp_put_supported_hw(opp_data->opp_table);
+			ret =  PTR_ERR(ti_opp_table);
+			goto fail_put_node;
+		}
+	}
 
+	of_node_put(opp_data->opp_node);
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

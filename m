From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] cpufreq: ti-cpufreq: Only register platform_device when supported
Date: Wed, 22 Aug 2018 21:44:32 -0500
Message-ID: <20180823024432.7000-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
the driver to probe on any platforms where the driver is built in.
However, this should only happen on platforms that actually can make use
of the driver. There is already functionality in place to match the
SoC compatible so let's factor this out into a separate call and
make sure we find a match before creating the ti-cpufreq driver device.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..541fdcf17b57 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -201,19 +201,31 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{},
 };
 
+static const struct of_device_id *ti_cpufreq_match_node(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(ti_cpufreq_of_match, np);
+	of_node_put(np);
+
+	if (!match)
+		return NULL;
+	else
+		return match;
+}
+
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
-	struct device_node *np;
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
-	np = of_find_node_by_path("/");
-	match = of_match_node(ti_cpufreq_of_match, np);
-	of_node_put(np);
+	match = ti_cpufreq_match_node();
 	if (!match)
 		return -ENODEV;
 
@@ -290,7 +302,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 static int ti_cpufreq_init(void)
 {
-	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+	/* Check to ensure we are on a compatible platform */
+	if (ti_cpufreq_match_node())
+		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+
 	return 0;
 }
 module_init(ti_cpufreq_init);
-- 
2.16.1

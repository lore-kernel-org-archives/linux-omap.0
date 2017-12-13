From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] cpufreq: ti-cpufreq: Convert to module_platform_driver
Date: Wed, 13 Dec 2017 14:33:55 -0600
Message-ID: <20171213203358.20839-2-d-gerlach@ti.com>
References: <20171213203358.20839-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171213203358.20839-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ti-cpufreq will be responsible for calling dev_pm_opp_set_regulators on
platforms that require AVS and ABB regulator support so we must be
able to defer probe if regulators are not yet available, so change
ti-cpufreq to be a module_platform_driver to allow for probe defer.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 drivers/cpufreq/ti-cpufreq.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 923317f03b4b..b1c230a1e2aa 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -195,7 +196,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{},
 };
 
-static int ti_cpufreq_init(void)
+static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	struct device_node *np;
@@ -269,4 +270,22 @@ static int ti_cpufreq_init(void)
 
 	return ret;
 }
-device_initcall(ti_cpufreq_init);
+
+static int ti_cpufreq_init(void)
+{
+	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+	return 0;
+}
+module_init(ti_cpufreq_init);
+
+static struct platform_driver ti_cpufreq_driver = {
+	.probe = ti_cpufreq_probe,
+	.driver = {
+		.name = "ti-cpufreq",
+	},
+};
+module_platform_driver(ti_cpufreq_driver);
+
+MODULE_DESCRIPTION("TI CPUFreq/OPP hw-supported driver");
+MODULE_AUTHOR("Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

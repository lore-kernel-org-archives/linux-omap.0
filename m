From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 3/9] PM / OPP: Add hook to modify OPPs after they are loaded.
Date: Fri, 14 Mar 2014 14:25:29 -0500
Message-ID: <1394825135-60110-4-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a hook inside opp_init_cpufreq_table to allow all cpufreq drivers
to utilize OPP modifier functionality. Hook will return success if no
phandle is present for devices that do not use opp-modifier.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/opp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index fa41874..eaedc6b 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -24,6 +24,7 @@
 #include <linux/pm_opp.h>
 #include <linux/of.h>
 #include <linux/export.h>
+#include <linux/opp-modifier.h>
 
 /*
  * Internal data structure organization with the OPP layer library is as
@@ -629,6 +630,13 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	struct dev_pm_opp *opp;
 	struct cpufreq_frequency_table *freq_table;
 	int i = 0;
+	int ret;
+
+	ret = opp_modify_dev_table(dev);
+	if (ret) {
+		pr_err("failed to modify OPP table: %d\n", ret);
+		return ret;
+	}
 
 	/* Pretend as if I am an updater */
 	mutex_lock(&dev_opp_list_lock);
-- 
1.9.0


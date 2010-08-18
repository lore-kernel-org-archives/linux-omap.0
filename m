From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage domain
Date: Wed, 18 Aug 2010 16:50:03 +0530
Message-ID: <1282130412-12027-5-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41229 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab0HRLUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:24 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch adds an API in the opp layer that
can be used by the voltage layer to get a list of all the
scalable devices belonging to a particular voltage domain.
This API is to be typically called only once by the voltage
layer per voltage domain instance and the device list should
be stored. This approach makes it easy during dvfs to scale
all the devices associated with a voltage domain and then
scale the voltage domain.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    9 +++++++++
 arch/arm/plat-omap/opp.c              |   28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 0e580ed..a4c1669 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 /**
  * struct omap_opp_def - OMAP OPP Definition
@@ -86,6 +87,9 @@ int opp_disable(struct omap_opp *opp);
 
 void opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
+
+struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
+					int *dev_count);
 #else
 static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
 {
@@ -149,5 +153,10 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
 {
 }
 
+static inline struct device **opp_init_voltage_params(
+			struct voltagedomain *voltdm, int *dev_count)
+{
+}
+
 #endif		/* CONFIG_PM */
 #endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index a3dea82..72dd62a 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -502,3 +502,31 @@ void opp_init_cpufreq_table(struct device *dev,
 
 	*table = &freq_table[0];
 }
+
+struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
+					int *dev_count)
+{
+	struct device_opp *dev_opp;
+	struct device **dev_list;
+	int count = 0, i = 0;
+
+	list_for_each_entry(dev_opp, &dev_opp_list, node) {
+		if (!dev_opp->oh->vdd_name)
+			continue;
+
+		if (!strcmp(dev_opp->oh->vdd_name, voltdm->name)) {
+			dev_opp->oh->voltdm = voltdm;
+			count++;
+		}
+	}
+
+	dev_list = kzalloc(sizeof(struct device *) * count, GFP_KERNEL);
+
+	list_for_each_entry(dev_opp, &dev_opp_list, node) {
+		if (dev_opp->oh->voltdm == voltdm)
+			dev_list[i++] = dev_opp->dev;
+	}
+
+	*dev_count = count;
+	return dev_list;
+}
-- 
1.7.1.GIT


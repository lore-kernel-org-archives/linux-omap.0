From: Thara Gopinath <thara@ti.com>
Subject: [RFC 3/7] OMAP: Introduce voltage domain pointer and device specific set rate and get rate in device opp structures.
Date: Fri,  2 Jul 2010 15:48:25 +0530
Message-ID: <1278065909-32148-4-git-send-email-thara@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38687 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0GBKSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 06:18:40 -0400
In-Reply-To: <1278065909-32148-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the device opp structure to contain
info about the voltage domain to which the device belongs to
and to contain pointers to scale the operating rate of the
device. This patch also adds an API in the opp layer that
can be used by the voltage layer to get a list of all the
scalable devices belonging to a particular voltage domain.
This API is to be typically called only once by the voltage
layer per voltage domain instance and the device list should
be stored. This approach makes it easy during dvfs to scale
all the devices associated with a voltage domain and then
scale the voltage domain.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |   37 +++++++++++++++++++++++++-
 arch/arm/plat-omap/opp.c              |   47 +++++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 893731f..15e1e70 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -16,6 +16,7 @@
 
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/clk.h>
 
 #include <plat/common.h>
 
@@ -38,21 +39,45 @@
  */
 struct omap_opp_def {
 	char *hwmod_name;
+	char *vdd_name;
 
 	unsigned long freq;
 	unsigned long u_volt;
 
+	int (*set_rate)(struct device *dev, unsigned long rate);
+	unsigned long (*get_rate) (struct device *dev);
+
 	bool enabled;
 };
 
+struct device_opp {
+	struct list_head node;
+	char *vdd_name;
+
+	struct omap_hwmod *oh;
+	struct device *dev;
+	struct omap_volt_domain *volt_domain;
+
+	struct list_head opp_list;
+	u32 opp_count;
+	u32 enabled_opp_count;
+
+	int (*set_rate)(struct device *dev, unsigned long rate);
+	unsigned long (*get_rate) (struct device *dev);
+};
+
 /*
  * Initialization wrapper used to define an OPP.
  * To point at the end of a terminator of a list of OPPs,
  * use OMAP_OPP_DEF(0, 0, 0)
  */
-#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv)	\
+#define OMAP_OPP_DEF(_hwmod_name, _vdd_name, _set_rate, _get_rate, \
+			_enabled, _freq, _uv)	\
 {						\
 	.hwmod_name	= _hwmod_name,		\
+	.vdd_name	= _vdd_name,		\
+	.set_rate	= _set_rate,		\
+	.get_rate	= _get_rate,		\
 	.enabled	= _enabled,		\
 	.freq		= _freq,		\
 	.u_volt		= _uv,			\
@@ -77,6 +102,8 @@ struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
 struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt);
 
+struct device_opp *opp_find_dev_opp(struct device *dev);
+
 int opp_add(const struct omap_opp_def *opp_def);
 
 int opp_enable(struct omap_opp *opp);
@@ -89,6 +116,9 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
 
 void opp_init_cpufreq_table(struct device *dev,
 			    struct cpufreq_frequency_table **table);
+
+struct device **opp_init_voltage_params(struct omap_volt_domain *volt_domain,
+		int *dev_count);
 #else
 static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
 {
@@ -124,6 +154,11 @@ static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct device_opp *opp_find_dev_opp(struct device *dev)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline struct omap_opp *opp_add(struct omap_opp *oppl,
 				       const struct omap_opp_def *opp_def)
 {
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 070ff5b..9bc53e8 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -22,6 +22,7 @@
 #include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
 #include <plat/omap_device.h>
+#include <plat/voltage.h>
 
 /**
  * struct omap_opp - OMAP OPP description structure
@@ -43,17 +44,6 @@ struct omap_opp {
 	struct device_opp *dev_opp;  /* containing device_opp struct */
 };
 
-struct device_opp {
-	struct list_head node;
-
-	struct omap_hwmod *oh;
-	struct device *dev;
-
-	struct list_head opp_list;
-	u32 opp_count;
-	u32 enabled_opp_count;
-};
-
 static LIST_HEAD(dev_opp_list);
 
 /**
@@ -330,6 +320,11 @@ struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt)
 	return opp;
 }
 
+struct device_opp *opp_find_dev_opp(struct device *dev)
+{
+	return find_device_opp(dev);
+}
+
 /* wrapper to reuse converting opp_def to opp struct */
 static void omap_opp_populate(struct omap_opp *opp,
 			      const struct omap_opp_def *opp_def)
@@ -385,6 +380,11 @@ int opp_add(const struct omap_opp_def *opp_def)
 
 		dev_opp->oh = oh;
 		dev_opp->dev = &oh->od->pdev.dev;
+		dev_opp->vdd_name = kzalloc(strlen(opp_def->vdd_name) + 1,
+				GFP_KERNEL);
+		strcpy(dev_opp->vdd_name, opp_def->vdd_name);
+		dev_opp->set_rate = opp_def->set_rate;
+		dev_opp->get_rate = opp_def->get_rate;
 		INIT_LIST_HEAD(&dev_opp->opp_list);
 
 		list_add(&dev_opp->node, &dev_opp_list);
@@ -511,3 +511,28 @@ void opp_init_cpufreq_table(struct device *dev,
 
 	*table = &freq_table[0];
 }
+
+struct device **opp_init_voltage_params(struct omap_volt_domain *volt_domain,
+		int *dev_count)
+{
+	struct device_opp *dev_opp;
+	struct device **dev_list;
+	int count = 0, i = 0;
+
+	list_for_each_entry(dev_opp, &dev_opp_list, node) {
+		if (!strcmp(dev_opp->vdd_name, volt_domain->name)) {
+			dev_opp->volt_domain = volt_domain;
+			count++;
+		}
+	}
+
+	dev_list = kzalloc(sizeof(struct device *) * count, GFP_KERNEL);
+
+	list_for_each_entry(dev_opp, &dev_opp_list, node) {
+		if (dev_opp->volt_domain == volt_domain)
+			dev_list[i++] = dev_opp->dev;
+	}
+
+	*dev_count = count;
+	return dev_list;
+}
-- 
1.7.0.rc1.33.g07cf0f


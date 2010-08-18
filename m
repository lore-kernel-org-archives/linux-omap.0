From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 05/13] OMAP: Introduce device specific set rate and get rate in device opp structures.
Date: Wed, 18 Aug 2010 16:50:04 +0530
Message-ID: <1282130412-12027-6-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab0HRLUZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:25 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the device opp structure to contain
pointers to scale the operating rate of the
device and to retrieve the operating rate of the device.
This patch also adds the three new APIs in the opp layer
namely opp_set_rate that can be called to set a new operating
rate for a device, opp_get_rate that can be called to retrieve
the operating frequency for a device and opp_populate_rate_fns
to populte the device specific set_rate and get_rate API's.
The opp_set_rate and opp_get_rate does some routine error
checks and finally calls into the device specific set_rate
and get_rate APIs populated through opp_populate_rate_fns.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/opp.h |   28 +++++++++-
 arch/arm/plat-omap/opp.c              |  103 +++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index a4c1669..604914d 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -16,6 +16,7 @@
 
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/clk.h>
 
 #include <plat/common.h>
 #include <plat/voltage.h>
@@ -52,7 +53,7 @@ struct omap_opp_def {
  * To point at the end of a terminator of a list of OPPs,
  * use OMAP_OPP_DEF(NULL, 0, 0, 0)
  */
-#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv)	\
+#define OMAP_OPP_DEF(_hwmod_name, _enabled, _freq, _uv) \
 {						\
 	.hwmod_name	= _hwmod_name,		\
 	.enabled	= _enabled,		\
@@ -79,6 +80,14 @@ struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *freq);
 
 struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt);
 
+int opp_set_rate(struct device *dev, unsigned long freq);
+
+unsigned long opp_get_rate(struct device *dev);
+
+void opp_populate_rate_fns(struct device *dev,
+		int (*set_rate)(struct device *dev, unsigned long rate),
+		unsigned long (*get_rate) (struct device *dev));
+
 int opp_add(const struct omap_opp_def *opp_def);
 
 int opp_enable(struct omap_opp *opp);
@@ -131,6 +140,23 @@ static inline struct omap_opp *opp_find_voltage(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline int opp_set_rate(struct device *dev, unsigned long freq)
+{
+	return -EINVAL;
+}
+
+static inline unsigned long opp_get_rate(struct device *dev)
+{
+	return 0;
+}
+
+static inline void opp_populate_rate_fns(struct device *dev,
+		int (*set_rate)(struct device *dev, unsigned long rate)
+		unsigned long (*get_rate) (struct device *dev))
+{
+	return;
+}
+
 static inline struct omap_opp *opp_add(struct omap_opp *oppl,
 				       const struct omap_opp_def *opp_def)
 {
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 72dd62a..3b5a581 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -21,6 +21,7 @@
 
 #include <plat/opp.h>
 #include <plat/omap_device.h>
+#include <plat/voltage.h>
 
 /**
  * struct omap_opp - OMAP OPP description structure
@@ -63,6 +64,9 @@ struct device_opp {
 	struct list_head opp_list;
 	u32 opp_count;
 	u32 enabled_opp_count;
+
+	int (*set_rate)(struct device *dev, unsigned long rate);
+	unsigned long (*get_rate) (struct device *dev);
 };
 
 static LIST_HEAD(dev_opp_list);
@@ -318,6 +322,105 @@ struct omap_opp *opp_find_voltage(struct device *dev, unsigned long volt)
 	return opp;
 }
 
+/**
+ * opp_set_rate() - Change the operating frequency of the device
+ * @dev:	device pointer associated with the opp type
+ * @freq:	new frequency at which the device is to be operated.
+ *
+ * This API calls into the custom specified set rate API mentioned
+ * in the device opp table to change the operating frequency of the
+ * device. Returns error values in case of no device opp table for the
+ * device or missing set_rate API in the device opp table.
+ */
+int opp_set_rate(struct device *dev, unsigned long freq)
+{
+	struct device_opp *dev_opp;
+
+	if (!dev) {
+		pr_err("%s: Invalid device\n", __func__);
+		return -EINVAL;
+	}
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: No device opp table\n", __func__);
+		return -ENODEV;
+	}
+
+	if (!dev_opp->set_rate) {
+		dev_err(dev, "%s: No set_rate API for scaling opp\n",
+			__func__);
+		return -ENODATA;
+	}
+
+	return dev_opp->set_rate(dev, freq);
+}
+
+/**
+ * opp_get_rate() - Get the operating frequency of the device
+ * @dev:	device pointer associated with the opp type
+ *
+ * This API calls into the custom specified get rate API mentioned
+ * in the device opp table to retrieve the operating frequency of the
+ * device. Returns 0 in case of no device opp table for the
+ * device or missing get_rate API in the device opp table else
+ * returns the rate at which the device is operating.
+ */
+unsigned long opp_get_rate(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	if (!dev) {
+		pr_err("%s: Invalid device\n", __func__);
+		return 0;
+	}
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: No device opp table\n", __func__);
+		return 0;
+	}
+
+	if (!dev_opp->get_rate) {
+		dev_err(dev, "%s: No set_rate API for scaling opp\n",
+			__func__);
+		return 0;
+	}
+
+	return dev_opp->get_rate(dev);
+}
+
+/**
+ * opp_populate_rate_fns() - Populates the device opp tables with set_rate
+ *				and get_rate API's
+ * @dev:	device pointer whose device opp table is to be populated.
+ * @set_rate:	the set_rate API
+ * @get_rate:	the get_rate API
+ *
+ * This API populates the device opp table corresponding to device <dev>
+ * with the specified set_rate and get_rate APIs passed as parameters.
+ */
+void opp_populate_rate_fns(struct device *dev,
+		int (*set_rate)(struct device *dev, unsigned long rate),
+		unsigned long (*get_rate) (struct device *dev))
+{
+	struct device_opp *dev_opp;
+
+	if (!dev || !set_rate || !get_rate) {
+		pr_err("%s: Invalid device or parameters\n", __func__);
+		return;
+	}
+
+	dev_opp = find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "%s: No device opp table\n", __func__);
+		return;
+	}
+
+	dev_opp->set_rate = set_rate;
+	dev_opp->get_rate = get_rate;
+}
+
 /* wrapper to reuse converting opp_def to opp struct */
 static void omap_opp_populate(struct omap_opp *opp,
 			      const struct omap_opp_def *opp_def)
-- 
1.7.1.GIT


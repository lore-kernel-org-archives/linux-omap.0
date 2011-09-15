From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 09/11] DT: regulator: Helper to extract regulator node based on supply name
Date: Thu, 15 Sep 2011 16:52:05 +0530
Message-ID: <1316085727-15023-10-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933301Ab1IOLWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 07:22:41 -0400
In-Reply-To: <1316085727-15023-9-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Device nodes in DT can associate themselves with one or more
regulators by providing a list of phandles (to regulator nodes)
and corresponding supply names.

For Example:
	devicenode: node@0x0 {
		...
		...
		regulator = <&regulator1>,<&regulator2>;
		regulator-names = "supply1","supply2";
	};

of_get_regulator() extracts the regulator node for a given
device, based on the supply name.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/of/of_regulator.c    |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/of_regulator.h |    7 +++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
index 4d7a49d..6f8fd4e 100644
--- a/drivers/of/of_regulator.c
+++ b/drivers/of/of_regulator.c
@@ -114,3 +114,40 @@ struct fixed_voltage_config *of_get_fixed_voltage_config(struct device_node *np)
 	return config;
 }
 EXPORT_SYMBOL(of_get_fixed_voltage_config);
+
+/**
+ * of_get_regulator - get a regulator device node based on supply name
+ * @dev: Device pointer for the consumer (of regulator) device
+ * @supply: regulator supply name
+ *
+ * Extract the regulator device node corresponding to the supply name.
+ * retruns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+struct device_node *of_get_regulator(struct device *dev, const char *supply)
+{
+	struct device_node *regnode = NULL;
+	u32 reghandle;
+	int regsz, namesz;
+	const void *regprop;
+	const char *namesprop;
+
+	regprop = of_get_property(dev->of_node, "regulator", &regsz);
+	namesprop = of_get_property(dev->of_node, "regulator-names", &namesz);
+	if (!regprop || !namesprop)
+		return NULL;
+
+	while (regsz && namesz) {
+		if (!strcmp(namesprop, supply)) {
+			reghandle = be32_to_cpup(regprop);
+			regnode = of_find_node_by_phandle(reghandle);
+			break;
+		}
+		regsz -= 4;
+		regprop += 4;
+		namesz -= strlen(namesprop) + 1;
+		namesprop += strlen(namesprop) + 1;
+	}
+	return regnode;
+}
+EXPORT_SYMBOL(of_get_regulator);
diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
index 39860c5..5fc7329 100644
--- a/include/linux/of_regulator.h
+++ b/include/linux/of_regulator.h
@@ -13,6 +13,8 @@ extern struct regulator_init_data
 	*of_get_regulator_init_data(struct device_node *np);
 extern struct fixed_voltage_config
 	*of_get_fixed_voltage_config(struct device_node *np);
+extern struct device_node *of_get_regulator(struct device *dev,
+	const char *id);
 #else
 static inline struct regulator_init_data
 	*of_get_regulator_init_data(struct device_node *np)
@@ -24,6 +26,11 @@ static inline struct fixed_voltage_config
 {
 	return NULL;
 }
+static inline struct device_node *of_get_regulator(struct device *dev,
+	const char *id)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_REGULATOR */
 
 #endif /* __LINUX_OF_REG_H */
-- 
1.7.1


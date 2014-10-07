From: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH v2 1/4] regulator: Add helper function to get "poweroff-source" property
Date: Tue,  7 Oct 2014 19:45:01 +0000
Message-ID: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Several drivers create their own devicetree property when they register
poweroff capabilities. This is for example the case for mfd, regulator
or power drivers which define "vendor,system-power-controller" property.
This patch adds support for a standard property "poweroff-source"
which marks the device as able to shutdown the system.

Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/regulator/of_regulator.c       | 12 ++++++++++++
 include/linux/regulator/of_regulator.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 7a51814..8b898e6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -240,3 +240,15 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 
 	return init_data;
 }
+
+/**
+ * is_system_poweroff_source - Tells if poweroff-source is found for device_node
+ * @np: Pointer to the given device_node
+ *
+ * return true if present false otherwise
+ */
+bool is_system_poweroff_source(const struct device_node *np)
+{
+	return of_property_read_bool(np, "poweroff-source");
+}
+EXPORT_SYMBOL_GPL(is_system_poweroff_source);
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
index f921796..9d8fbb2 100644
--- a/include/linux/regulator/of_regulator.h
+++ b/include/linux/regulator/of_regulator.h
@@ -20,6 +20,7 @@ extern struct regulator_init_data
 extern int of_regulator_match(struct device *dev, struct device_node *node,
 			      struct of_regulator_match *matches,
 			      unsigned int num_matches);
+extern bool is_system_poweroff_source(const struct device_node *np);
 #else
 static inline struct regulator_init_data
 	*of_get_regulator_init_data(struct device *dev,
@@ -35,6 +36,11 @@ static inline int of_regulator_match(struct device *dev,
 {
 	return 0;
 }
+
+static inline bool is_system_poweroff_source(const struct device_node *np)
+{
+	return false;
+}
 #endif /* CONFIG_OF */
 
 #endif /* __LINUX_OF_REG_H */
-- 
1.9.1

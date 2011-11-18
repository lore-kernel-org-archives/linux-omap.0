From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 4/4] regulator: map consumer regulator based on device tree
Date: Fri, 18 Nov 2011 16:47:20 +0530
Message-ID: <1321615040-13257-5-git-send-email-rnayak@ti.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321615040-13257-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Device nodes in DT can associate themselves with one or more
regulators/supply by providing a list of phandles (to regulator nodes)
and corresponding supply names.

For Example:
	devicenode: node@0x0 {
		...
		...
		vmmc-supply = <&regulator1>;
		vpll-supply = <&regulator2>;
	};

The driver would then do a regulator_get(dev, "vmmc"); to get
regulator1 and do a regulator_get(dev, "vpll"); to get
regulator2.

of_get_regulator() extracts the regulator node for a given
device, based on the supply name.

Use it to look up the regulator for a given consumer from device tree, during
a regulator_get(). If not found fallback and lookup through
the regulator_map_list instead.

Also, since the regulator dt nodes can use the same binding to
associate with a parent regulator/supply, allow the drivers to
specify a supply_name, which can then be used to lookup dt
to find the parent phandle.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/regulator/core.c         |   79 ++++++++++++++++++++++++++++++++------
 include/linux/regulator/driver.h |    2 +
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8b01eb0..9867ebc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -25,6 +25,8 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -132,6 +134,33 @@ static struct regulator *get_device_regulator(struct device *dev)
 	return NULL;
 }
 
+/**
+ * of_get_regulator - get a regulator device node based on supply name
+ * @dev: Device pointer for the consumer (of regulator) device
+ * @supply: regulator supply name
+ *
+ * Extract the regulator device node corresponding to the supply name.
+ * retruns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+static struct device_node *of_get_regulator(struct device *dev, const char *supply)
+{
+	struct device_node *regnode = NULL;
+	char prop_name[32]; /* 32 is max size of property name */
+
+	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
+
+	snprintf(prop_name, 32, "%s-supply", supply);
+	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
+
+	if (!regnode) {
+		dev_warn(dev, "%s property in node %s references invalid phandle",
+				prop_name, dev->of_node->full_name);
+		return NULL;
+	}
+	return regnode;
+}
+
 /* Platform voltage constraint check */
 static int regulator_check_voltage(struct regulator_dev *rdev,
 				   int *min_uV, int *max_uV)
@@ -1148,6 +1177,30 @@ static int _regulator_get_enable_time(struct regulator_dev *rdev)
 	return rdev->desc->ops->enable_time(rdev);
 }
 
+static struct regulator_dev *regulator_dev_lookup(struct device *dev,
+							 const char *supply)
+{
+	struct regulator_dev *r;
+	struct device_node *node;
+
+	/* first do a dt based lookup */
+	if (dev && dev->of_node) {
+		node = of_get_regulator(dev, supply);
+		if (node)
+			list_for_each_entry(r, &regulator_list, list)
+				if (r->dev.parent &&
+					node == r->dev.of_node)
+					return r;
+	}
+
+	/* if not found, try doing it non-dt way */
+	list_for_each_entry(r, &regulator_list, list)
+		if (strcmp(rdev_get_name(r), supply) == 0)
+			return r;
+
+	return NULL;
+}
+
 /* Internal regulator request function */
 static struct regulator *_regulator_get(struct device *dev, const char *id,
 					int exclusive)
@@ -1168,6 +1221,10 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 	mutex_lock(&regulator_list_mutex);
 
+	rdev = regulator_dev_lookup(dev, id);
+	if (rdev)
+		goto found;
+
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
 		if (map->dev_name &&
@@ -2642,6 +2699,7 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 	static atomic_t regulator_no = ATOMIC_INIT(0);
 	struct regulator_dev *rdev;
 	int ret, i;
+	const char *supply = NULL;
 
 	if (regulator_desc == NULL)
 		return ERR_PTR(-EINVAL);
@@ -2718,21 +2776,18 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto scrub;
 
-	if (init_data->supply_regulator) {
+	if (init_data->supply_regulator)
+		supply = init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		supply = regulator_desc->supply_name;
+
+	if (supply) {
 		struct regulator_dev *r;
-		int found = 0;
 
-		list_for_each_entry(r, &regulator_list, list) {
-			if (strcmp(rdev_get_name(r),
-				   init_data->supply_regulator) == 0) {
-				found = 1;
-				break;
-			}
-		}
+		r = regulator_dev_lookup(dev, supply);
 
-		if (!found) {
-			dev_err(dev, "Failed to find supply %s\n",
-				init_data->supply_regulator);
+		if (!r) {
+			dev_err(dev, "Failed to find supply %s\n", supply);
 			ret = -ENODEV;
 			goto scrub;
 		}
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 8fbb696..4214b9a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -154,6 +154,7 @@ enum regulator_type {
  * this type.
  *
  * @name: Identifying name for the regulator.
+ * @supply_name: Identifying the regulator supply
  * @id: Numerical identifier for the regulator.
  * @n_voltages: Number of selectors available for ops.list_voltage().
  * @ops: Regulator operations table.
@@ -163,6 +164,7 @@ enum regulator_type {
  */
 struct regulator_desc {
 	const char *name;
+	const char *supply_name;
 	int id;
 	unsigned n_voltages;
 	struct regulator_ops *ops;
-- 
1.7.1

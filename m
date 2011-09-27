From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 9/9] regulator: map consumer regulator based on device tree
Date: Tue, 27 Sep 2011 15:42:52 +0530
Message-ID: <1317118372-17052-10-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1I0KNn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 06:13:43 -0400
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

Look up the regulator for a given consumer from device tree, during
a regulator_get(). If not found fallback and lookup through
the regulator_map_list instead.

Devices can associate with one or more regulators by providing a
list of phandles and supply names.

For Example:
        devicenode: node@0x0 {
                ...
                ...
                vmmc-supply = <&regulator1>;
                vpll-supply = <&regulator2>;
        };

When a device driver calls a regulator_get, specifying the
supply name, the phandle and eventually the regulator node
is extracted from the device node.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/core.c         |   14 ++++++++++++++
 include/linux/regulator/driver.h |    3 +++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e6a42..47b851c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -25,9 +25,11 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/regulator.h>
@@ -1155,6 +1157,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 	struct regulator_map *map;
 	struct regulator *regulator = ERR_PTR(-ENODEV);
 	const char *devname = NULL;
+	struct device_node *node;
 	int ret;
 
 	if (id == NULL) {
@@ -1167,6 +1170,15 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 	mutex_lock(&regulator_list_mutex);
 
+	if (dev->of_node) {
+		node = of_get_regulator(dev, id);
+		if (!node)
+			goto retry; /* fallback and chk regulator_map_list */
+		list_for_each_entry(rdev, &regulator_list, list)
+			if (node == rdev->node)
+				goto found;
+	}
+retry:
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
 		if (map->dev_name &&
@@ -2619,6 +2631,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 	rdev->reg_data = driver_data;
 	rdev->owner = regulator_desc->owner;
 	rdev->desc = regulator_desc;
+	if (dev && dev->of_node)
+		rdev->node = dev->of_node;
 	INIT_LIST_HEAD(&rdev->consumer_list);
 	INIT_LIST_HEAD(&rdev->list);
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 1a80bc7..4aebbf5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -196,6 +196,9 @@ struct regulator_dev {
 	struct mutex mutex; /* consumer lock */
 	struct module *owner;
 	struct device dev;
+#ifdef CONFIG_OF
+	struct device_node *node;
+#endif
 	struct regulation_constraints *constraints;
 	struct regulator *supply;	/* for tree */
 
-- 
1.7.1


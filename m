From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 10/11] regulator: Implement consumer regulator mapping from device tree
Date: Thu, 15 Sep 2011 16:52:06 +0530
Message-ID: <1316085727-15023-11-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345Ab1IOLWj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:39 -0400
In-Reply-To: <1316085727-15023-10-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

With device tree, the consumer regulator mapping is deferred till
a regulator_get is called from the corresponding device driver,
instead of being done during regulator_register.
This avoids a complete scan of all DT nodes to identify consumers
for all regulators.

Devices can assocaite with one or more regulators by providing a
list of phandles and supply names.

For Example:
        devicenode: node@0x0 {
                ...
                ...
                regulator = <&regulator1>,<&regulator2>;
                regulator-names = "supply1","supply2";
        };

When a device driver calls a regulator_get, specifying the
supply name, the phandle and eventually the regulator node
is extracted from the device and a mapping created by calling
set_consumer_device_supply().

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/core.c         |   23 +++++++++++++++++++++++
 include/linux/regulator/driver.h |    3 +++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9365359..61da2e7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -25,6 +25,8 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_regulator.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -1167,6 +1169,15 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 	mutex_lock(&regulator_list_mutex);
 
+#ifdef CONFIG_OF
+	struct device_node *node;
+	node = of_get_regulator(dev, id);
+	if (!node)
+		goto out;
+	list_for_each_entry(rdev, &regulator_list, list)
+		if (node == rdev->node)
+			goto found;
+#else
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
 		if (map->dev_name &&
@@ -1178,6 +1189,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 			goto found;
 		}
 	}
+#endif
 
 	if (board_wants_dummy_regulator) {
 		rdev = dummy_regulator_rdev;
@@ -1216,6 +1228,15 @@ found:
 	if (!try_module_get(rdev->owner))
 		goto out;
 
+#ifdef CONFIG_OF
+	ret = set_consumer_device_supply(rdev, dev, devname, id);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set supply %d\n", ret);
+		unset_regulator_supplies(rdev);
+		goto out;
+	}
+#endif
+
 	regulator = create_regulator(rdev, dev, id);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
@@ -2619,6 +2640,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
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


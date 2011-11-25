From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 1/6] regulator: core: add support for external get/set_voltage
Date: Fri, 25 Nov 2011 18:29:17 +0200
Message-ID: <1322238562-19943-2-git-send-email-t-kristo@ti.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab1KYQ3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 11:29:46 -0500
In-Reply-To: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

Regulator users can now set override functions for get_voltage and
set_voltage. This is required by some regulators, which have two
alternate control paths. E.g., OMAP SMPS regulators can be controlled
either through the I2C interface or voltage processor control path,
which uses specialized hardware.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/regulator/core.c           |   61 ++++++++++++++++++++++++++++++++++-
 include/linux/regulator/consumer.h |   20 ++++++++++++
 include/linux/regulator/driver.h   |   17 ++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e6a42..d70dd7a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1676,7 +1676,11 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	min_uV += rdev->constraints->uV_offset;
 	max_uV += rdev->constraints->uV_offset;
 
-	if (rdev->desc->ops->set_voltage) {
+	if (rdev->desc->ext_ctrl && rdev->desc->ext_ctrl->ops->set_voltage) {
+		ret = rdev->desc->ext_ctrl->ops->
+			set_voltage(rdev->desc->ext_ctrl->data, min_uV, max_uV);
+		selector = -1;
+	} else if (rdev->desc->ops->set_voltage) {
 		ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV,
 						   &selector);
 
@@ -1902,7 +1906,10 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 {
 	int sel, ret;
 
-	if (rdev->desc->ops->get_voltage_sel) {
+	if (rdev->desc->ext_ctrl && rdev->desc->ext_ctrl->ops->get_voltage) {
+		ret = rdev->desc->ext_ctrl->ops->
+			get_voltage(rdev->desc->ext_ctrl->data);
+	} else if (rdev->desc->ops->get_voltage_sel) {
 		sel = rdev->desc->ops->get_voltage_sel(rdev);
 		if (sel < 0)
 			return sel;
@@ -2886,6 +2893,56 @@ void regulator_set_drvdata(struct regulator *regulator, void *data)
 EXPORT_SYMBOL_GPL(regulator_set_drvdata);
 
 /**
+ * regulator_set_external_ctrl - set external controller for a regulator
+ * @devname: device for regulator "consumer"
+ * @id: Supply name or regulator ID 
+ * @ops: external controller operations table
+ * @data: user data
+ */
+void regulator_set_external_ctrl(const char *devname, const char *id,
+				 struct regulator_ext_ops *ops, void *data)
+{
+	struct regulator_map *map;
+	struct regulator_dev *rdev;
+
+	/* Look for the regulator device */
+	list_for_each_entry(map, &regulator_map_list, list) {
+		/* If the mapping has a device set up it must match */
+		if (map->dev_name &&
+		    (!devname || strcmp(map->dev_name, devname)))
+			continue;
+
+		if (strcmp(map->supply, id) == 0) {
+			rdev = map->regulator;
+			goto found;
+		}
+	}
+
+	return;
+
+found:
+	/* If no ops defined, disable external controller and return */
+	if (ops == NULL) {
+		kfree(rdev->desc->ext_ctrl);
+		rdev->desc->ext_ctrl = NULL;
+		return;
+	}
+
+	/* Alloc memory if needed */
+	if (!rdev->desc->ext_ctrl)
+		rdev->desc->ext_ctrl =
+			kzalloc(sizeof(struct regulator_ext_ctrl), GFP_KERNEL);
+
+	if (!rdev->desc->ext_ctrl) {
+		pr_warning("%s: kzalloc failed\n", __func__);
+		return;
+	}
+
+	rdev->desc->ext_ctrl->ops = ops;
+	rdev->desc->ext_ctrl->data = data;
+}
+
+/**
  * regulator_get_id - get regulator ID
  * @rdev: regulator
  */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 26f6ea4..abd271e 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -127,6 +127,17 @@ struct regulator_bulk_data {
 	int ret;
 };
 
+/**
+ * struct regulator_ext_ops - Override operations for a regulator.
+ *
+ * @set_voltage: External override for the set_voltage operation for regulator.
+ * @get_voltage: External override for the get_voltage operation for regulator.
+ */
+struct regulator_ext_ops {
+	int (*set_voltage) (void *data, int min_uV, int max_uV);
+	int (*get_voltage) (void *data);
+};
+
 #if defined(CONFIG_REGULATOR)
 
 /* regulator get and put */
@@ -177,6 +188,8 @@ int regulator_unregister_notifier(struct regulator *regulator,
 /* driver data - core doesn't touch */
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
+void regulator_set_external_ctrl(const char *devname, const char *id,
+				 struct regulator_ext_ops *ops, void *data);
 
 #else
 
@@ -301,6 +314,13 @@ static inline void regulator_set_drvdata(struct regulator *regulator,
 {
 }
 
+static inline void regulator_set_external_ctrl(const char *devname,
+					       const char *id,
+					       struct regulator_ext_ops *ops,
+					       void *data)
+{
+}
+
 #endif
 
 #endif
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 1a80bc7..b77bf69 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -147,6 +147,21 @@ enum regulator_type {
 };
 
 /**
+ * struct regulator_ext_ctrl - External controller for regulator
+ *
+ * If regulator is using external controller, i.e. control mechanism
+ * provided by some other driver, this defines the linking between the
+ * regulator and the external driver.
+ *
+ * @ops: External operations table
+ * @data: User data
+ */
+struct regulator_ext_ctrl {
+	struct regulator_ext_ops *ops;
+	void *data;
+};
+
+/**
  * struct regulator_desc - Regulator descriptor
  *
  * Each regulator registered with the core is described with a structure of
@@ -156,6 +171,7 @@ enum regulator_type {
  * @id: Numerical identifier for the regulator.
  * @n_voltages: Number of selectors available for ops.list_voltage().
  * @ops: Regulator operations table.
+ * @ext_ctrl: Optional external controller.
  * @irq: Interrupt number for the regulator.
  * @type: Indicates if the regulator is a voltage or current regulator.
  * @owner: Module providing the regulator, used for refcounting.
@@ -165,6 +181,7 @@ struct regulator_desc {
 	int id;
 	unsigned n_voltages;
 	struct regulator_ops *ops;
+	struct regulator_ext_ctrl *ext_ctrl;
 	int irq;
 	enum regulator_type type;
 	struct module *owner;
-- 
1.7.4.1


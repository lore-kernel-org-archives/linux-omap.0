From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 04/14] OMAP: Introduce API to register a device with a voltagedomain
Date: Fri, 29 Oct 2010 21:08:18 +0530
Message-ID: <1288366708-32302-5-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab0J2Pij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:39 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds an API in the voltage layer that
can be used  during omap_device_build to register the built
device with the voltage domain. This API is to be typically called
only once per device during the device registeration. This approach
makes it easy during dvfs to scale all the devices associated with
a voltage domain and then scale the voltage domain.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |   45 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/voltage.h |    7 ++++
 arch/arm/plat-omap/omap_device.c          |   12 ++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index f0ecc30..6c2e4ef 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -101,6 +101,11 @@ struct omap_vdd_user_list {
 	u32 volt;
 };
 
+struct omap_vdd_dev_list {
+	struct device *dev;
+	struct list_head node;
+};
+
 /**
  * omap_vdd_info - Per Voltage Domain info
  *
@@ -116,6 +121,7 @@ struct omap_vdd_user_list {
  * @user_list		: the list head maintaining the various users.
  * @scaling_mutex	: the dvfs muutex.
  *			  of this vdd with the voltage requested by each user.
+ * @dev_list		: list of devices bwlonging to this voltage domain.
  * @volt_data_count	: number of distinct voltages supported by this vdd.
  * @nominal_volt	: nominal voltage for this vdd.
  * @curr_volt		: current voltage for this vdd.
@@ -131,6 +137,7 @@ struct omap_vdd_info{
 	spinlock_t user_lock;
 	struct plist_head user_list;
 	struct mutex scaling_mutex;
+	struct list_head dev_list;
 	int volt_data_count;
 	u32 nominal_volt;
 	u32 curr_volt;
@@ -621,6 +628,8 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	plist_head_init(&vdd->user_list, &vdd->user_lock);
 	/* Init the DVFS mutex */
 	mutex_init(&vdd->scaling_mutex);
+	/* Init the device list */
+	INIT_LIST_HEAD(&vdd->dev_list);
 }
 
 /* OMAP4 specific voltage init functions */
@@ -751,6 +760,8 @@ static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	plist_head_init(&vdd->user_list, &vdd->user_lock);
 	/* Init the DVFS mutex */
 	mutex_init(&vdd->scaling_mutex);
+	/* Init the device list */
+	INIT_LIST_HEAD(&vdd->dev_list);
 }
 
 /* Generic voltage init functions */
@@ -1240,6 +1251,40 @@ int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
 	return 0;
 }
 
+int omap_voltage_add_dev(struct voltagedomain *voltdm, struct device *dev)
+{
+	struct omap_vdd_info *vdd;
+	struct omap_vdd_dev_list *temp_dev;
+
+	if (!voltdm || IS_ERR(voltdm)) {
+		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		return -EINVAL;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+
+	list_for_each_entry(temp_dev, &vdd->dev_list, node) {
+		if (temp_dev->dev == dev) {
+			dev_warn(dev, "%s: Device already added to vdee_%s\n",
+				__func__, voltdm->name);
+			return -EINVAL;
+		}
+	}
+
+	temp_dev = kzalloc(sizeof(struct omap_vdd_dev_list), GFP_KERNEL);
+	if (!temp_dev) {
+		dev_err(dev, "%s: Unable to creat a new device for vdd_%s\n",
+			__func__, voltdm->name);
+		return -ENOMEM;
+	}
+
+	temp_dev->dev = dev;
+
+	list_add(&temp_dev->node, &vdd->dev_list);
+
+	return 0;
+}
+
 /**
  * omap_vp_enable() - API to enable a particular VP
  * @voltdm:	pointer to the VDD whose VP is to be enabled.
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index c226b6d..dc64a9a 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -152,6 +152,7 @@ void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
 void omap_change_voltscale_method(int voltscale_method);
 int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
 		unsigned long *volt);
+int omap_voltage_add_dev(struct voltagedomain *voltdm, struct device *dev);
 #else
 static inline void omap_voltage_register_pmic
 			(struct omap_volt_pmic_info *pmic_info) {}
@@ -162,6 +163,12 @@ static inline int omap_voltage_add_request(struct voltagedomain *voltdm,
 {
 	return -EINVAL;
 }
+
+static inline int omap_voltage_add_dev(struct voltagedomain *voltdm,
+		struct device *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index abe933c..7c902a6 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -86,6 +86,7 @@
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
+#include <plat/voltage.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0
@@ -453,6 +454,17 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
 		_add_optional_clock_alias(od, hwmods[i]);
+		if (hwmods[i]->vdd_name) {
+			struct omap_hwmod *oh = hwmods[i];
+			struct voltagedomain *voltdm;
+
+			if (is_early_device)
+				continue;
+
+			voltdm = omap_voltage_domain_lookup(oh->vdd_name);
+			if (!omap_voltage_add_dev(voltdm, &od->pdev.dev))
+				oh->voltdm = voltdm;
+		}
 	}
 
 	if (ret)
-- 
1.7.0.4


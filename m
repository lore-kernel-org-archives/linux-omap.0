From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 01/14] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Fri, 29 Oct 2010 21:08:15 +0530
Message-ID: <1288366708-32302-2-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40341 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682Ab0J2Pij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 11:38:39 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces a user list of devices associated with each
voltage domain instance. The user list is implemented using plist
structure with priority node populated with the voltage values.
This patch also adds an API which will take in a device and
requested voltage as parameters, adds the info to the user list
and returns back the maximum voltage requested by all the user
devices. This can be used anytime to get the voltage that the
voltage domain instance can be transitioned into.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |  101 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |    7 ++
 2 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 45b0958..f0ecc30 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -24,6 +24,9 @@
 #include <linux/err.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/plist.h>
+#include <linux/slab.h>
 
 #include <plat/common.h>
 #include <plat/voltage.h>
@@ -85,6 +88,20 @@ struct vp_reg_val {
 };
 
 /**
+ * struct omap_vdd_user_list - The per vdd user list
+ *
+ * @dev:	The device asking for the vdd to be set at a particular
+ *		voltage
+ * @node:	The list head entry
+ * @volt:	The voltage requested by the device <dev>
+ */
+struct omap_vdd_user_list {
+	struct device *dev;
+	struct plist_node node;
+	u32 volt;
+};
+
+/**
  * omap_vdd_info - Per Voltage Domain info
  *
  * @volt_data		: voltage table having the distinct voltages supported
@@ -95,9 +112,13 @@ struct vp_reg_val {
  *			  vp registers
  * @voltdm		: pointer to the voltage domain structure
  * @debug_dir		: debug directory for this voltage domain.
+ * @user_lock		: the lock to be used by the plist user_list
+ * @user_list		: the list head maintaining the various users.
+ * @scaling_mutex	: the dvfs muutex.
+ *			  of this vdd with the voltage requested by each user.
  * @volt_data_count	: number of distinct voltages supported by this vdd.
  * @nominal_volt	: nominal voltage for this vdd.
- * @curr_volt		: current voltage for this vdd;
+ * @curr_volt		: current voltage for this vdd.
  * cmdval_reg		: voltage controller cmdval register.
  * @vdd_sr_reg		: the smartreflex register associated with this VDD.
  */
@@ -107,6 +128,9 @@ struct omap_vdd_info{
 	struct vp_reg_val vp_reg;
 	struct voltagedomain voltdm;
 	struct dentry *debug_dir;
+	spinlock_t user_lock;
+	struct plist_head user_list;
+	struct mutex scaling_mutex;
 	int volt_data_count;
 	u32 nominal_volt;
 	u32 curr_volt;
@@ -591,6 +615,12 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	vdd->vp_reg.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT;
 	vdd->vp_reg.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT;
 	vdd->vp_reg.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT;
+
+	/* Init the plist */
+	spin_lock_init(&vdd->user_lock);
+	plist_head_init(&vdd->user_list, &vdd->user_lock);
+	/* Init the DVFS mutex */
+	mutex_init(&vdd->scaling_mutex);
 }
 
 /* OMAP4 specific voltage init functions */
@@ -715,6 +745,12 @@ static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	vdd->vp_reg.vlimitto_vddmin_shift = OMAP4430_VDDMIN_SHIFT;
 	vdd->vp_reg.vlimitto_vddmax_shift = OMAP4430_VDDMAX_SHIFT;
 	vdd->vp_reg.vlimitto_timeout_shift = OMAP4430_TIMEOUT_SHIFT;
+
+	/* Init the plist */
+	spin_lock_init(&vdd->user_lock);
+	plist_head_init(&vdd->user_list, &vdd->user_lock);
+	/* Init the DVFS mutex */
+	mutex_init(&vdd->scaling_mutex);
 }
 
 /* Generic voltage init functions */
@@ -1140,6 +1176,69 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 
 	return volt_pmic_info.vsel_to_uv(curr_vsel);
 }
+/**
+ * omap_voltage_add_request() - API to keep track of various requests to
+ *				scale the VDD and returns the best possible
+ *				voltage the VDD can be put to.
+ * @volt_domain:	pointer to the voltage domain.
+ * @dev:		the device pointer.
+ * @volt:		the voltage which is requested by the device.
+ *
+ * This API is to be called before the actual voltage scaling is
+ * done to determine what is the best possible voltage the VDD can
+ * be put to. This API adds the device <dev> in the user list of the
+ * vdd <volt_domain> with <volt> as the requested voltage. The user list
+ * is a plist with the priority element absolute voltage values.
+ * The API then finds the maximum of all the requested voltages for
+ * the VDD and returns it back through <volt> pointer itself.
+ * Returns error value in case of any errors.
+ */
+int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
+		unsigned long *volt)
+{
+	struct omap_vdd_info *vdd;
+	struct omap_vdd_user_list *user;
+	struct plist_node *node;
+	int found = 0;
+
+	if (!voltdm || IS_ERR(voltdm)) {
+		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		return -EINVAL;
+	}
+
+	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
+
+	mutex_lock(&vdd->scaling_mutex);
+
+	plist_for_each_entry(user, &vdd->user_list, node) {
+		if (user->dev == dev) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
+		if (!user) {
+			pr_err("%s: Unable to creat a new user for vdd_%s\n",
+				__func__, voltdm->name);
+			mutex_unlock(&vdd->scaling_mutex);
+			return -ENOMEM;
+		}
+		user->dev = dev;
+	} else {
+		plist_del(&user->node, &vdd->user_list);
+	}
+
+	plist_node_init(&user->node, *volt);
+	plist_add(&user->node, &vdd->user_list);
+	node = plist_last(&vdd->user_list);
+	*volt = user->volt = node->prio;
+
+	mutex_unlock(&vdd->scaling_mutex);
+
+	return 0;
+}
 
 /**
  * omap_vp_enable() - API to enable a particular VP
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 812266e..c226b6d 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -150,11 +150,18 @@ bool omap_voltage_override_params(struct voltagedomain *voltdm);
 void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
 void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
 void omap_change_voltscale_method(int voltscale_method);
+int omap_voltage_add_request(struct voltagedomain *voltdm, struct device *dev,
+		unsigned long *volt);
 #else
 static inline void omap_voltage_register_pmic
 			(struct omap_volt_pmic_info *pmic_info) {}
 static inline void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc) {}
 static inline  void omap_change_voltscale_method(int voltscale_method) {}
+static inline int omap_voltage_add_request(struct voltagedomain *voltdm,
+		struct device *dev, unsigned long *volt)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
1.7.0.4


From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Wed, 18 Aug 2010 16:50:00 +0530
Message-ID: <1282130412-12027-2-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41226 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab0HRLUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:24 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

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
 arch/arm/mach-omap2/voltage.c             |   94 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/voltage.h |    2 +
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 6a07fe9..4624250 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -24,6 +24,9 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/debugfs.h>
+#include <linux/spinlock.h>
+#include <linux/plist.h>
+#include <linux/slab.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap34xx.h>
@@ -95,6 +98,20 @@ struct vp_reg_val {
 };
 
 /**
+ * omap_vdd_user_list	- The per vdd user list
+ *
+ * @dev		: The device asking for the vdd to be set at a particular
+ *		  voltage
+ * @node	: The list head entry
+ * @volt	: The voltage requested by the device <dev>
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
@@ -105,6 +122,9 @@ struct vp_reg_val {
  *			  vp registers
  * @volt_clk		: the clock associated with the vdd.
  * @opp_dev		: the 'struct device' associated with this vdd.
+ * @user_lock		: the lock to be used by the plist user_list
+ * @user_list		: the list head maintaining the various users
+ *			  of this vdd with the voltage requested by each user.
  * @volt_data_count	: Number of distinct voltages supported by this vdd.
  * @nominal_volt	: Nominal voltaged for this vdd.
  * cmdval_reg		: Voltage controller cmdval register.
@@ -117,6 +137,9 @@ struct omap_vdd_info{
 	struct clk *volt_clk;
 	struct device *opp_dev;
 	struct voltagedomain voltdm;
+	spinlock_t user_lock;
+	struct plist_head user_list;
+	struct mutex scaling_mutex;
 	int volt_data_count;
 	unsigned long nominal_volt;
 	u8 cmdval_reg;
@@ -785,11 +808,18 @@ static void __init vdd_data_configure(struct omap_vdd_info *vdd)
 	struct dentry *vdd_debug;
 	char name[16];
 #endif
+
 	if (cpu_is_omap34xx())
 		omap3_vdd_data_configure(vdd);
 	else if (cpu_is_omap44xx())
 		omap4_vdd_data_configure(vdd);
 
+	/* Init the plist */
+	spin_lock_init(&vdd->user_lock);
+	plist_head_init(&vdd->user_list, &vdd->user_lock);
+	/* Init the DVFS mutex */
+	mutex_init(&vdd->scaling_mutex);
+
 #ifdef CONFIG_PM_DEBUG
 	strcpy(name, "vdd_");
 	strcat(name, vdd->voltdm.name);
@@ -1142,6 +1172,70 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 }
 
 /**
+ * omap_voltage_add_userreq : API to keep track of various requests to
+ *			    scale the VDD and returns the best possible
+ *			    voltage the VDD can be put to.
+ * @volt_domain: pointer to the voltage domain.
+ * @dev : the device pointer.
+ * @volt : the voltage which is requested by the device.
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
+int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
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
+	node = plist_first(&vdd->user_list);
+	*volt = node->prio;
+
+	mutex_unlock(&vdd->scaling_mutex);
+
+	return 0;
+}
+
+/**
  * omap_vp_enable : API to enable a particular VP
  * @voltdm: pointer to the VDD whose VP is to be enabled.
  *
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 3e8cf03..fffd086 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -144,6 +144,8 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
 void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
 unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
+		unsigned long *volt);
 #ifdef CONFIG_PM
 void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
 void omap_change_voltscale_method(int voltscale_method);
-- 
1.7.1.GIT


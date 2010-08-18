From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 07/13] OMAP: Introduce dependent voltage domain support.
Date: Wed, 18 Aug 2010 16:50:06 +0530
Message-ID: <1282130412-12027-8-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45576 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798Ab0HRLUZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:25 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

There could be dependencies between various voltage domains for
maintaining system performance or hardware limitation reasons
like VDD<X> should be at voltage v1 when VDD<Y> is at voltage v2.
This patch introduce dependent vdd information structures in the
voltage layer which can be used to populate these dependencies
for a voltage domain. This patch also adds support to scale
the dependent vdd and the scalable devices belonging to it
during the scaling of a main vdd through omap_voltage_scale.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |  122 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 3332123..1a46eb0 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -98,6 +98,36 @@ struct vp_reg_val {
 };
 
 /**
+ * omap_vdd_dep_volt - Table containing the parent vdd voltage and the
+ *			dependent vdd voltage corresponding to it.
+ *
+ * @main_vdd_volt	: The main vdd voltage
+ * @dep_vdd_volt	: The voltage at which the dependent vdd should be
+ *			  when the main vdd is at <main_vdd_volt> voltage
+ */
+struct omap_vdd_dep_volt {
+	u32 main_vdd_volt;
+	u32 dep_vdd_volt;
+};
+
+/**
+ * omap_vdd_dep_info - Dependent vdd info
+ *
+ * @name		: Dependent vdd name
+ * @voltdm		: Dependent vdd pointer
+ * @dep_table		: Table containing the dependent vdd voltage
+ *			  corresponding to every main vdd voltage.
+ * @cur_dep_volt	: The voltage to which dependent vdd should be put
+ *			  to for the current main vdd voltage.
+ */
+struct omap_vdd_dep_info{
+	char *name;
+	struct voltagedomain *voltdm;
+	struct omap_vdd_dep_volt *dep_table;
+	unsigned long cur_dep_volt;
+};
+
+/**
  * omap_vdd_user_list	- The per vdd user list
  *
  * @dev		: The device asking for the vdd to be set at a particular
@@ -137,10 +167,12 @@ struct omap_vdd_info{
 	struct clk *volt_clk;
 	struct device *opp_dev;
 	struct voltagedomain voltdm;
+	struct omap_vdd_dep_info *dep_vdd_info;
 	spinlock_t user_lock;
 	struct plist_head user_list;
 	struct mutex scaling_mutex;
 	int volt_data_count;
+	int nr_dep_vdd;
 	struct device **dev_list;
 	int dev_count;
 	unsigned long nominal_volt;
@@ -1114,6 +1146,80 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	return 0;
 }
 
+static int calc_dep_vdd_volt(struct device *dev,
+		struct omap_vdd_info *main_vdd, unsigned long main_volt)
+{
+	struct omap_vdd_dep_info *dep_vdds;
+	int i, ret = 0;
+
+	if (!main_vdd->dep_vdd_info) {
+		pr_debug("%s: No dependent VDD's for vdd_%s\n",
+			__func__, main_vdd->voltdm.name);
+		return 0;
+	}
+
+	dep_vdds = main_vdd->dep_vdd_info;
+
+	for (i = 0; i < main_vdd->nr_dep_vdd; i++) {
+		struct omap_vdd_dep_volt *volt_table = dep_vdds[i].dep_table;
+		int nr_volt = 0;
+		unsigned long dep_volt = 0, act_volt = 0;
+
+		while (volt_table[nr_volt].main_vdd_volt != 0) {
+			if (volt_table[nr_volt].main_vdd_volt == main_volt) {
+				dep_volt = volt_table[nr_volt].dep_vdd_volt;
+				break;
+			}
+			nr_volt++;
+		}
+		if (!dep_volt) {
+			pr_warning("%s: Not able to find a matching volt for"
+				"vdd_%s corresponding to vdd_%s %ld volt\n",
+				__func__, dep_vdds[i].name,
+				main_vdd->voltdm.name, main_volt);
+			ret = -EINVAL;
+			continue;
+		}
+
+		if (!dep_vdds[i].voltdm)
+			dep_vdds[i].voltdm =
+				omap_voltage_domain_get(dep_vdds[i].name);
+
+		act_volt = dep_volt;
+
+		/* See if dep_volt is possible for the vdd*/
+		ret = omap_voltage_add_userreq(dep_vdds[i].voltdm, dev,
+				&act_volt);
+
+		/*
+		 * Currently we do not bother if the dep volt and act volt are
+		 * different. We could add a check if needed.
+		 */
+		dep_vdds[i].cur_dep_volt = act_volt;
+	}
+
+	return ret;
+}
+
+static int scale_dep_vdd(struct omap_vdd_info *main_vdd)
+{
+	struct omap_vdd_dep_info *dep_vdds;
+	int i;
+
+	if (!main_vdd->dep_vdd_info) {
+		pr_debug("%s: No dependent VDD's for vdd_%s\n",
+			__func__, main_vdd->voltdm.name);
+		return 0;
+	}
+
+	dep_vdds = main_vdd->dep_vdd_info;
+
+	for (i = 0; i < main_vdd->nr_dep_vdd; i++)
+		omap_voltage_scale(dep_vdds[i].voltdm,
+				dep_vdds[i].cur_dep_volt);
+	return 0;
+}
+
 /* Public functions */
 /**
  * omap_voltage_get_nom_volt : Gets the current non-auto-compensated voltage
@@ -1599,6 +1705,8 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 	unsigned long curr_volt;
 	int is_volt_scaled = 0, i;
 	struct omap_vdd_info *vdd;
+	struct plist_node *node;
+	struct omap_vdd_user_list *user;
 
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
@@ -1611,6 +1719,17 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 
 	curr_volt = omap_voltage_get_nom_volt(voltdm);
 
+	/* Find the device requesting the voltage scaling */
+	node = plist_first(&vdd->user_list);
+	user = container_of(node, struct omap_vdd_user_list, node);
+
+	/* calculate the voltages for dependent vdd's */
+	if (calc_dep_vdd_volt(user->dev, vdd, volt)) {
+		pr_warning("%s: Error in calculating dependent vdd voltages"
+			"for vdd_%s\n", __func__, voltdm->name);
+		return -EINVAL;
+	}
+
 	if (curr_volt == volt) {
 		is_volt_scaled = 1;
 	} else if (curr_volt < volt) {
@@ -1645,6 +1764,9 @@ int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
 
 	mutex_unlock(&vdd->scaling_mutex);
 
+	/* Scale dependent vdds */
+	scale_dep_vdd(vdd);
+
 	return 0;
 }
 
-- 
1.7.1.GIT


From: Thara Gopinath <thara@ti.com>
Subject: [RFC 4/7] OMAP: Voltage layer changes to support DVFS.
Date: Fri,  2 Jul 2010 15:48:26 +0530
Message-ID: <1278065909-32148-5-git-send-email-thara@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab0GBKSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 06:18:40 -0400
In-Reply-To: <1278065909-32148-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces a list of scalable devices associated with
a particular voltage domain instance. This list is obtained from
the opp layer during init. This patch also introduces an API
to take in the voltage domain and the new voltage as parameter
and to scale all the scalable devices associated with the the
voltage domain to the rate corresponding to the new voltage and
scale the voltage domain to the new voltage.

This patch renames the previous omap_voltage_scale API to
omap_voltage_scale_vdd.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |   89 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |    4 +-
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index a2f30a4..1e6712e 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -137,6 +137,8 @@ struct omap_vdd_info{
 	struct omap_volt_domain volt_domain;
 	spinlock_t user_lock;
 	struct plist_head user_list;
+	struct device **dev_list;
+	int dev_count;
 	int volt_data_count;
 	unsigned long nominal_volt;
 	u8 cmdval_reg;
@@ -387,6 +389,10 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	spin_lock_init(&vdd->user_lock);
 	plist_head_init(&vdd->user_list, &vdd->user_lock);
 
+	/* Get the devices associated with this VDD */
+	vdd->dev_list = opp_init_voltage_params(&vdd->volt_domain,
+			&vdd->dev_count);
+
 	if (!strcmp(vdd->volt_domain.name, "mpu")) {
 		if (cpu_is_omap3630()) {
 			vdd->vp_reg.vlimitto_vddmin =
@@ -1073,7 +1079,8 @@ void omap_voltageprocessor_disable(struct omap_volt_domain *volt_domain)
 }
 
 /**
- * omap_voltage_scale : API to scale voltage of a particular voltage domain.
+ * omap_voltage_scale_vdd : API to scale voltage of a particular
+ *			    voltage domain.
  * @volt_domain: pointer to the VDD which is to be scaled.
  * @target_vsel : The target voltage of the voltage domain
  * @current_vsel : the current voltage of the voltage domain.
@@ -1081,7 +1088,7 @@ void omap_voltageprocessor_disable(struct omap_volt_domain *volt_domain)
  * This API should be called by the kernel to do the voltage scaling
  * for a particular voltage domain during dvfs or any other situation.
  */
-int omap_voltage_scale(struct omap_volt_domain *volt_domain,
+int omap_voltage_scale_vdd(struct omap_volt_domain *volt_domain,
 					unsigned long target_volt)
 {
 	struct omap_vdd_info *vdd;
@@ -1290,6 +1297,84 @@ struct omap_volt_domain *omap_volt_domain_get(char *name)
 }
 
 /**
+ * omap_voltage_scale : API to scale the devices associated with a
+ *			voltage domain vdd voltage.
+ * @volt_domain : the voltage domain to be scaled
+ * @volt : the new voltage for the voltage domain
+ *
+ * This API runs through the list of devices associated with the
+ * voltage domain and scales the device rates to those corresponding
+ * to the new voltage of the voltage domain. This API also scales
+ * the voltage domain voltage to the new value. Returns 0 on success
+ * else the error value.
+ */
+int omap_voltage_scale(struct omap_volt_domain *volt_domain,
+		unsigned long volt)
+{
+	unsigned long curr_volt;
+	int is_volt_scaled = 0, i;
+	struct omap_vdd_info *vdd;
+
+	if (!volt_domain || IS_ERR(volt_domain)) {
+		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		return -EINVAL;
+	}
+
+	vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
+	curr_volt = get_curr_voltage(volt_domain);
+
+	if (curr_volt == volt) {
+		is_volt_scaled = 1;
+	} else if (curr_volt < volt) {
+		omap_voltage_scale_vdd(volt_domain, volt);
+		is_volt_scaled = 1;
+	}
+
+	for (i = 0; i < vdd->dev_count; i++) {
+		struct device_opp *dev_opp;
+		struct omap_opp *opp;
+		unsigned long freq;
+
+		dev_opp = opp_find_dev_opp(vdd->dev_list[i]);
+		if (IS_ERR(dev_opp)) {
+			dev_err(vdd->dev_list[i], "%s: Unable to find device"
+				"opp table\n", __func__);
+			continue;
+		}
+		if (!dev_opp->set_rate) {
+			dev_err(vdd->dev_list[i], "%s: No set_rate API"
+				"for scaling opp\n", __func__);
+			continue;
+		}
+
+		opp = opp_find_voltage(vdd->dev_list[i], volt);
+		if (IS_ERR(opp)) {
+			dev_err(vdd->dev_list[i], "%s: Unable to find OPP for"
+				"volt%ld\n", __func__, volt);
+			continue;
+		}
+
+		freq = opp_get_freq(opp);
+
+		if (dev_opp->get_rate) {
+			if (freq == dev_opp->get_rate(vdd->dev_list[i])) {
+				dev_err(vdd->dev_list[i], "%s: Already at the"
+					"requested rate %ld\n",
+					__func__, freq);
+				continue;
+			}
+		}
+
+		dev_opp->set_rate(vdd->dev_list[i], freq);
+	}
+
+	if (!is_volt_scaled)
+		omap_voltage_scale_vdd(volt_domain, volt);
+
+	return 0;
+}
+
+/**
  * omap_voltage_init : Volatage init API which does VP and VC init.
  */
 static int __init omap_voltage_init(void)
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index bc1e4d3..072ee76 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -120,8 +120,10 @@ unsigned long omap_voltageprocessor_get_curr_volt(
 		struct omap_volt_domain *volt_domain);
 void omap_voltageprocessor_enable(struct omap_volt_domain *volt_domain);
 void omap_voltageprocessor_disable(struct omap_volt_domain *volt_domain);
-int omap_voltage_scale(struct omap_volt_domain *volt_domain,
+int omap_voltage_scale_vdd(struct omap_volt_domain *volt_domain,
 		unsigned long target_volt);
+int omap_voltage_scale(struct omap_volt_domain *volt_domain,
+		unsigned long volt);
 void omap_reset_voltage(struct omap_volt_domain *volt_domain);
 int omap_get_voltage_table(struct omap_volt_domain *volt_domain,
 					struct omap_volt_data **volt_data);
-- 
1.7.0.rc1.33.g07cf0f


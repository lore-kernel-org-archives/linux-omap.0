From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 06/13] OMAP: Voltage layer changes to support DVFS.
Date: Wed, 18 Aug 2010 16:50:05 +0530
Message-ID: <1282130412-12027-7-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45575 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab0HRLUZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:25 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces a list of scalable devices associated with
a particular voltage domain instance. This list is obtained from
the opp layer during init. This patch also introduces an API
to take in the voltage domain and the new voltage as parameter
and to scale all the scalable devices associated with the the
voltage domain to the rate corresponding to the new voltage and
scale the voltage domain to the new voltage.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c             |   71 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/voltage.h |    2 +
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4624250..3332123 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -141,6 +141,8 @@ struct omap_vdd_info{
 	struct plist_head user_list;
 	struct mutex scaling_mutex;
 	int volt_data_count;
+	struct device **dev_list;
+	int dev_count;
 	unsigned long nominal_volt;
 	u8 cmdval_reg;
 	u8 vdd_sr_reg;
@@ -820,6 +822,9 @@ static void __init vdd_data_configure(struct omap_vdd_info *vdd)
 	/* Init the DVFS mutex */
 	mutex_init(&vdd->scaling_mutex);
 
+	/* Get the devices associated with this VDD */
+	vdd->dev_list = opp_init_voltage_params(&vdd->voltdm, &vdd->dev_count);
+
 #ifdef CONFIG_PM_DEBUG
 	strcpy(name, "vdd_");
 	strcat(name, vdd->voltdm.name);
@@ -1578,6 +1583,72 @@ struct voltagedomain *omap_voltage_domain_get(char *name)
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
+int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
+{
+	unsigned long curr_volt;
+	int is_volt_scaled = 0, i;
+	struct omap_vdd_info *vdd;
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
+	curr_volt = omap_voltage_get_nom_volt(voltdm);
+
+	if (curr_volt == volt) {
+		is_volt_scaled = 1;
+	} else if (curr_volt < volt) {
+		omap_voltage_scale_vdd(voltdm, volt);
+		is_volt_scaled = 1;
+	}
+
+	for (i = 0; i < vdd->dev_count; i++) {
+		struct omap_opp *opp;
+		unsigned long freq;
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
+		if (freq == opp_get_rate(vdd->dev_list[i])) {
+			dev_warn(vdd->dev_list[i], "%s: Already at the"
+				"requested rate %ld\n", __func__, freq);
+			continue;
+		}
+
+		opp_set_rate(vdd->dev_list[i], freq);
+	}
+
+	if (!is_volt_scaled)
+		omap_voltage_scale_vdd(voltdm, volt);
+
+	mutex_unlock(&vdd->scaling_mutex);
+
+	return 0;
+}
+
+/**
  * omap_voltage_init : Volatage init API which does VP and VC init.
  */
 static int __init omap_voltage_init(void)
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index fffd086..4f8342a 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -146,6 +146,8 @@ void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
 unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
 		unsigned long *volt);
+int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt);
+
 #ifdef CONFIG_PM
 void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
 void omap_change_voltscale_method(int voltscale_method);
-- 
1.7.1.GIT


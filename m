From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/2] omap3: voltage: remove unnecessary param passing
Date: Thu, 17 Mar 2011 20:42:36 +0530
Message-ID: <1300374757-23010-2-git-send-email-premi@ti.com>
References: <1300374757-23010-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36495 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab1CQPMu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:12:50 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2HFClhp027478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:12:49 -0500
In-Reply-To: <1300374757-23010-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

It is not necessary to pass the params prm_mod and
prm_irqst_mod to omap_voltage_early_init().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/voltage.c                 |   18 ++++++++++++++----
 arch/arm/mach-omap2/voltage.h                 |    3 +--
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +----
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    6 +-----
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c6facf7..ce3098a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -1096,12 +1096,22 @@ int __init omap_voltage_late_init(void)
 }
 
 /* XXX document */
-int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_ocp_mod,
-				   struct omap_vdd_info *omap_vdd_array[],
+int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_array[],
 				   u8 omap_vdd_count)
 {
-	prm_mod_offs = prm_mod;
-	prm_irqst_ocp_mod_offs = prm_irqst_ocp_mod;
+	if (cpu_is_omap44xx()) {
+		prm_mod_offs = OMAP4430_PRM_DEVICE_INST;
+		prm_irqst_ocp_mod_offs = OMAP4430_PRM_OCP_SOCKET_INST;
+	} else if (cpu_is_omap34xx()) {
+		prm_mod_offs = OMAP3430_GR_MOD;
+		prm_irqst_ocp_mod_offs = OCP_MOD;
+	} else {
+		/* TODO:
+		 * What should be done for OMAP24xx?
+		 * Would we even reach here?
+		 */
+	}
+
 	vdd_info = omap_vdd_array;
 	nr_scalable_vdd = omap_vdd_count;
 	return 0;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index e9f5408..b56530e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -151,8 +151,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
 unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
 struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
-int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
-				   struct omap_vdd_info *omap_vdd_array[],
+int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_array[],
 				   u8 omap_vdd_count);
 #ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index def230f..6f6999d 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -70,8 +70,6 @@ static struct omap_vdd_info *omap3_vdd_info[] = {
 /* OMAP3 specific voltage init functions */
 static int __init omap3xxx_voltage_early_init(void)
 {
-	s16 prm_mod = OMAP3430_GR_MOD;
-	s16 prm_irqst_ocp_mod = OCP_MOD;
 
 	if (!cpu_is_omap34xx())
 		return 0;
@@ -88,8 +86,7 @@ static int __init omap3xxx_voltage_early_init(void)
 		omap3_vdd2_info.volt_data = omap34xx_vddcore_volt_data;
 	}
 
-	return omap_voltage_early_init(prm_mod, prm_irqst_ocp_mod,
-				       omap3_vdd_info,
+	return omap_voltage_early_init(omap3_vdd_info,
 				       ARRAY_SIZE(omap3_vdd_info));
 };
 core_initcall(omap3xxx_voltage_early_init);
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index cb64996..208a67d 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -81,9 +81,6 @@ static struct omap_vdd_info *omap4_vdd_info[] = {
 /* OMAP4 specific voltage init functions */
 static int __init omap44xx_voltage_early_init(void)
 {
-	s16 prm_mod = OMAP4430_PRM_DEVICE_INST;
-	s16 prm_irqst_ocp_mod = OMAP4430_PRM_OCP_SOCKET_INST;
-
 	if (!cpu_is_omap44xx())
 		return 0;
 
@@ -95,8 +92,7 @@ static int __init omap44xx_voltage_early_init(void)
 	omap4_vdd_iva_info.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_vdd_core_info.volt_data = omap44xx_vdd_core_volt_data;
 
-	return omap_voltage_early_init(prm_mod, prm_irqst_ocp_mod,
-				       omap4_vdd_info,
+	return omap_voltage_early_init(omap4_vdd_info,
 				       ARRAY_SIZE(omap4_vdd_info));
 };
 core_initcall(omap44xx_voltage_early_init);
-- 
1.7.2.2


From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [RFC][PATCH 2/3] OMAP PM: Add support for bypassing VP/VC in Voltage layer
Date: Tue, 15 Mar 2011 20:03:41 +0530
Message-ID: <1300199622-32500-3-git-send-email-vishwanath.bs@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44171 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757820Ab1COO37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 10:29:59 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2FETuNM023038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 09:29:58 -0500
In-Reply-To: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

Currently Voltage layer assumes that all PMICs use VP/VC for Voltage scaling.
There can be some instances where PMIC would want to bypass VP/VC for voltage
scaling. So make VOltage layer flexible enough to handle this.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    5 +++++
 arch/arm/mach-omap2/voltage.c  |   12 +++++++-----
 arch/arm/mach-omap2/voltage.h  |    6 ++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f96d4b2..42f66c6 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -157,6 +157,7 @@ static struct omap_volt_pmic_info omap3_mpu_volt_info = {
 	.onlp_cmd		= twl4030_uv_to_vsel,
 	.ret_cmd		= twl4030_uv_to_vsel,
 	.off_cmd		= twl4030_uv_to_vsel,
+	.voltage_class	= VP_VC_CLASS,
 };
 
 static struct omap_volt_pmic_info omap3_core_volt_info = {
@@ -176,6 +177,7 @@ static struct omap_volt_pmic_info omap3_core_volt_info = {
 	.onlp_cmd		= twl4030_uv_to_vsel,
 	.ret_cmd		= twl4030_uv_to_vsel,
 	.off_cmd		= twl4030_uv_to_vsel,
+	.voltage_class	= VP_VC_CLASS,
 };
 
 static struct omap_volt_pmic_info omap4_mpu_volt_info = {
@@ -195,6 +197,7 @@ static struct omap_volt_pmic_info omap4_mpu_volt_info = {
 	.onlp_cmd		= twl4030_uv_to_vsel,
 	.ret_cmd		= twl4030_uv_to_vsel,
 	.off_cmd		= twl4030_uv_to_vsel,
+	.voltage_class	= VP_VC_CLASS,
 };
 
 static struct omap_volt_pmic_info omap4_iva_volt_info = {
@@ -214,6 +217,7 @@ static struct omap_volt_pmic_info omap4_iva_volt_info = {
 	.onlp_cmd		= twl4030_uv_to_vsel,
 	.ret_cmd		= twl4030_uv_to_vsel,
 	.off_cmd		= twl4030_uv_to_vsel,
+	.voltage_class	= VP_VC_CLASS,
 };
 
 static struct omap_volt_pmic_info omap4_core_volt_info = {
@@ -233,6 +237,7 @@ static struct omap_volt_pmic_info omap4_core_volt_info = {
 	.onlp_cmd		= twl4030_uv_to_vsel,
 	.ret_cmd		= twl4030_uv_to_vsel,
 	.off_cmd		= twl4030_uv_to_vsel,
+	.voltage_class	= VP_VC_CLASS,
 };
 
 int __init omap4_twl_init(void)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 2ac990f..73fa3ee 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -1194,11 +1194,13 @@ int __init omap_voltage_late_init(void)
 		pr_err("%s: Unable to create voltage debugfs main dir\n",
 			__func__);
 	for (i = 0; i < nr_scalable_vdd; i++) {
-		if (omap_vdd_data_configure(vdd_info[i]))
-			continue;
-		omap_vc_init(vdd_info[i]);
-		vp_init(vdd_info[i]);
-		vdd_debugfs_init(vdd_info[i]);
+		if (vdd_info[i]->pmic_info->voltage_class == VP_VC_CLASS) {
+			if (omap_vdd_data_configure(vdd_info[i]))
+				continue;
+			omap_vc_init(vdd_info[i]);
+			vp_init(vdd_info[i]);
+			vdd_debugfs_init(vdd_info[i]);
+		}
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index de4e09b..17b1e10
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -23,6 +23,9 @@
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
+#define VP_VC_CLASS 0
+#define REGULATOR_CLASS 1
+
 /**
  * struct omap_vfsm_instance_data - per-voltage manager FSM register/bitfield
  * data
@@ -87,6 +90,8 @@ struct omap_volt_data {
  * @onlp_cmd:	PMIC API to send onlp command instruction
  * @ret_cmd:	PMIC API to send ret command instruction
  * @off_cmd:	PMIC API to send off command instruction
+ * @voltage_class: Voltage class used for voltage scaling (can be VP/VC method
+ * 				or regulator based method for now).
  */
 struct omap_volt_pmic_info {
 	int slew_rate;
@@ -105,6 +110,7 @@ struct omap_volt_pmic_info {
 	unsigned char (*onlp_cmd)(unsigned long uV);
 	unsigned char (*ret_cmd)(unsigned long uV);
 	unsigned char (*off_cmd)(unsigned long uV);
+	u8 voltage_class;
 };
 
 /**
-- 
1.7.0.4


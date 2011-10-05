From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 04/11] omap4: add vp and vc parameter data
Date: Wed, 5 Oct 2011 20:17:04 +0300
Message-ID: <1317835031-8201-5-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935085Ab1JERRf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:35 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHY3X003792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:35 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHYDH019454
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:34 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHYmo001705
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:34 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |    6 ++++
 arch/arm/mach-omap2/opp4xxx_data.c            |   40 +++++++++++++++++++++++++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    8 +++++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index b940a09..b5fe711 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -101,5 +101,11 @@ extern struct omap_vc_param omap36xx_core_vc_data;
 extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
+extern struct omap_vp_param omap44xx_mpu_vp_data;
+extern struct omap_vp_param omap44xx_iva_vp_data;
+extern struct omap_vp_param omap44xx_core_vp_data;
+extern struct omap_vc_param omap44xx_mpu_vc_data;
+extern struct omap_vc_param omap44xx_iva_vc_data;
+extern struct omap_vc_param omap44xx_core_vc_data;
 
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..bf37279 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -31,6 +31,11 @@
  * voltage dependent data for each VDD.
  */
 
+#define OMAP4_ON_VOLTAGE_UV			1350000
+#define OMAP4_ONLP_VOLTAGE_UV			1350000
+#define OMAP4_RET_VOLTAGE_UV			837500
+#define OMAP4_OFF_VOLTAGE_UV			600000
+
 #define OMAP4430_VDD_MPU_OPP50_UV		1025000
 #define OMAP4430_VDD_MPU_OPP100_UV		1200000
 #define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
@@ -44,6 +49,18 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_mpu_vp_data = {
+	.vddmin			= OMAP4_VP_MPU_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_MPU_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_mpu_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
 #define OMAP4430_VDD_IVA_OPP50_UV		1013000
 #define OMAP4430_VDD_IVA_OPP100_UV		1188000
 #define OMAP4430_VDD_IVA_OPPTURBO_UV		1300000
@@ -55,6 +72,18 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_iva_vp_data = {
+	.vddmin			= OMAP4_VP_IVA_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_IVA_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_iva_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
+
 #define OMAP4430_VDD_CORE_OPP50_UV		1025000
 #define OMAP4430_VDD_CORE_OPP100_UV		1200000
 
@@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap44xx_core_vp_data = {
+	.vddmin			= OMAP4_VP_CORE_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP4_VP_CORE_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap44xx_core_vc_data = {
+	.on			= OMAP4_ON_VOLTAGE_UV,
+	.onlp			= OMAP4_ONLP_VOLTAGE_UV,
+	.ret			= OMAP4_RET_VOLTAGE_UV,
+	.off			= OMAP4_OFF_VOLTAGE_UV,
+};
 
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c4584e9..0a22960 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
 	omap4_voltdm_iva.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_voltdm_core.volt_data = omap44xx_vdd_core_volt_data;
 
+	omap4_voltdm_mpu.vp_param = &omap44xx_mpu_vp_data;
+	omap4_voltdm_iva.vp_param = &omap44xx_iva_vp_data;
+	omap4_voltdm_core.vp_param = &omap44xx_core_vp_data;
+
+	omap4_voltdm_mpu.vc_param = &omap44xx_mpu_vc_data;
+	omap4_voltdm_iva.vc_param = &omap44xx_iva_vc_data;
+	omap4_voltdm_core.vc_param = &omap44xx_core_vc_data;
+
 	for (i = 0; voltdm = voltagedomains_omap4[i], voltdm; i++)
 		voltdm->sys_clk.name = sys_clk_name;
 
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 


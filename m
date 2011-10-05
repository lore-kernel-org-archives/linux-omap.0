From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 03/11] omap3: add vp and vc parameter data
Date: Wed, 5 Oct 2011 20:17:03 +0300
Message-ID: <1317835031-8201-4-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42959 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934481Ab1JERRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:34 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHXCP021827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:33 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHXQX027572
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:33 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHXOV001693
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:33 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |    9 ++++
 arch/arm/mach-omap2/opp3xxx_data.c            |   52 +++++++++++++++++++++++++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    8 ++++
 3 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..b940a09 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -86,8 +86,17 @@ extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 
 extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap34xx_vddcore_volt_data[];
+extern struct omap_vp_param omap34xx_mpu_vp_data;
+extern struct omap_vp_param omap34xx_core_vp_data;
+extern struct omap_vc_param omap34xx_mpu_vc_data;
+extern struct omap_vc_param omap34xx_core_vc_data;
+
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap36xx_vddcore_volt_data[];
+extern struct omap_vp_param omap36xx_mpu_vp_data;
+extern struct omap_vp_param omap36xx_core_vp_data;
+extern struct omap_vc_param omap36xx_mpu_vc_data;
+extern struct omap_vc_param omap36xx_core_vc_data;
 
 extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
 extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..1d44df5 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -26,6 +26,10 @@
 #include "pm.h"
 
 /* 34xx */
+#define OMAP3_ON_VOLTAGE_UV		1200000
+#define OMAP3_ONLP_VOLTAGE_UV		1000000
+#define OMAP3_RET_VOLTAGE_UV		975000
+#define OMAP3_OFF_VOLTAGE_UV		600000
 
 /* VDD1 */
 
@@ -44,6 +48,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_mpu_vp_data = {
+	.vddmin			= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP1_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap34xx_mpu_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* VDD2 */
 
 #define OMAP3430_VDD_CORE_OPP1_UV		975000
@@ -57,6 +73,18 @@ struct omap_volt_data omap34xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap34xx_core_vp_data = {
+	.vddmin			= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3430_VP2_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap34xx_core_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* 36xx */
 
 /* VDD1 */
@@ -74,6 +102,18 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_mpu_vp_data = {
+	.vddmin			= OMAP3630_VP1_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3630_VP1_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap36xx_mpu_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* VDD2 */
 
 #define OMAP3630_VDD_CORE_OPP50_UV		1000000
@@ -85,6 +125,18 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
+struct omap_vp_param omap36xx_core_vp_data = {
+	.vddmin			= OMAP3630_VP2_VLIMITTO_VDDMIN,
+	.vddmax			= OMAP3630_VP2_VLIMITTO_VDDMAX,
+};
+
+struct omap_vc_param omap36xx_core_vc_data = {
+	.on		= OMAP3_ON_VOLTAGE_UV,
+	.onlp		= OMAP3_ONLP_VOLTAGE_UV,
+	.ret		= OMAP3_RET_VOLTAGE_UV,
+	.off		= OMAP3_OFF_VOLTAGE_UV,
+};
+
 /* OPP data */
 
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index b0d0ae1..9c907af 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -90,9 +90,17 @@ void __init omap3xxx_voltagedomains_init(void)
 	if (cpu_is_omap3630()) {
 		omap3_voltdm_mpu.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap36xx_vddcore_volt_data;
+		omap3_voltdm_mpu.vp_param = &omap36xx_mpu_vp_data;
+		omap3_voltdm_core.vp_param = &omap36xx_core_vp_data;
+		omap3_voltdm_mpu.vc_param = &omap36xx_mpu_vc_data;
+		omap3_voltdm_core.vc_param = &omap36xx_core_vc_data;
 	} else {
 		omap3_voltdm_mpu.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
+		omap3_voltdm_mpu.vp_param = &omap34xx_mpu_vp_data;
+		omap3_voltdm_core.vp_param = &omap34xx_core_vp_data;
+		omap3_voltdm_mpu.vc_param = &omap34xx_mpu_vc_data;
+		omap3_voltdm_core.vc_param = &omap34xx_core_vc_data;
 	}
 
 	for (i = 0; voltdm = voltagedomains_omap3[i], voltdm; i++)
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 


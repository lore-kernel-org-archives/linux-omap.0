From: Tero Kristo <t-kristo@ti.com>
Subject: [RFCv2 1/2] OMAP3+: voltage / oscillator parameter segregation
Date: Fri, 5 Aug 2011 16:27:22 +0300
Message-ID: <1312550842-32466-2-git-send-email-t-kristo@ti.com>
References: <1312550842-32466-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1HEN10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 09:27:26 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p75DRPJv030101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:26 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p75DRP2j029318
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p75DROvw022480
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1312550842-32466-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch separates board specific voltage and oscillator ramp / setup
times from the core code. Things changed:

- on/sleep/ret/off voltage setup moved from common twl code to
  VC / VP data (oppxxxx_data.c files)
- added board support for oscillator setup time declaration
- removed is_initialized static variable from vc_init_channel, as we
  have to set the setup times for each VDD channel, not only once

Todo:
- split patch into more easily manageable parts.
- figure out a way to configure setup times based on used sleep mode

Applies on top of pm/wip/voltdm branch, based on work done by Vishwanath
Sripathy.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |   15 ++
 arch/arm/mach-omap2/omap_twl.c                |   25 ----
 arch/arm/mach-omap2/opp3xxx_data.c            |   62 ++++++++
 arch/arm/mach-omap2/opp4xxx_data.c            |   47 ++++++
 arch/arm/mach-omap2/prcm.c                    |   11 ++
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |    6 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |    1 +
 arch/arm/mach-omap2/prm44xx.c                 |    7 +
 arch/arm/mach-omap2/prm44xx.h                 |    1 +
 arch/arm/mach-omap2/vc.c                      |  193 +++++++++++++++++++++----
 arch/arm/mach-omap2/vc.h                      |    1 -
 arch/arm/mach-omap2/voltage.h                 |   18 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    8 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    8 +
 arch/arm/mach-omap2/vp.c                      |    6 +-
 arch/arm/plat-omap/include/plat/prcm.h        |    7 +
 16 files changed, 356 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..b5fe711 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -86,11 +86,26 @@ extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 
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
 extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
+extern struct omap_vp_param omap44xx_mpu_vp_data;
+extern struct omap_vp_param omap44xx_iva_vp_data;
+extern struct omap_vp_param omap44xx_core_vp_data;
+extern struct omap_vc_param omap44xx_mpu_vc_data;
+extern struct omap_vc_param omap44xx_iva_vc_data;
+extern struct omap_vc_param omap44xx_core_vc_data;
 
 #endif		/* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index f515a1a..07ae785 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -158,11 +158,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -179,11 +174,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -200,11 +190,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1375000,
-	.onlp_volt		= 1375000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -222,11 +207,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1188000,
-	.onlp_volt		= 1188000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -244,11 +224,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1200000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..b5d8294 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -26,6 +26,16 @@
 #include "pm.h"
 
 /* 34xx */
+/* OMAP VP parameter values */
+#define OMAP3430_VP1_VLIMITTO_VDDMIN	0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX	0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3430_VP2_VLIMITTO_VDDMAX	0x2c
+
+#define OMAP3_ON_VOLTAGE_UV		1200000
+#define OMAP3_ONLP_VOLTAGE_UV		1000000
+#define OMAP3_RET_VOLTAGE_UV		975000
+#define OMAP3_OFF_VOLTAGE_UV		600000
 
 /* VDD1 */
 
@@ -44,6 +54,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
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
@@ -57,7 +79,23 @@ struct omap_volt_data omap34xx_vddcore_volt_data[] = {
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
+#define OMAP3630_VP1_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX	0x3c
+#define OMAP3630_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX	0x30
 
 /* VDD1 */
 
@@ -74,6 +112,18 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[] = {
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
@@ -85,6 +135,18 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
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
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..59f695b 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -31,6 +31,18 @@
  * voltage dependent data for each VDD.
  */
 
+#define OMAP4_VP_MPU_VLIMITTO_VDDMIN		0x0a
+#define OMAP4_VP_MPU_VLIMITTO_VDDMAX		0x39
+#define OMAP4_VP_IVA_VLIMITTO_VDDMIN		0x0a
+#define OMAP4_VP_IVA_VLIMITTO_VDDMAX		0x2d
+#define OMAP4_VP_CORE_VLIMITTO_VDDMIN		0x0a
+#define OMAP4_VP_CORE_VLIMITTO_VDDMAX		0x28
+
+#define OMAP4_ON_VOLTAGE_UV			1350000
+#define OMAP4_ONLP_VOLTAGE_UV			1350000
+#define OMAP4_RET_VOLTAGE_UV			837500
+#define OMAP4_OFF_VOLTAGE_UV			600000
+
 #define OMAP4430_VDD_MPU_OPP50_UV		1025000
 #define OMAP4430_VDD_MPU_OPP100_UV		1200000
 #define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
@@ -44,6 +56,18 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
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
@@ -55,6 +79,18 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
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
 
@@ -64,6 +100,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
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
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 2e40a5c..5d94e91 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -42,6 +42,7 @@
 void __iomem *prm_base;
 void __iomem *cm_base;
 void __iomem *cm2_base;
+static struct omap_osc_data *osc_setup;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
@@ -165,3 +166,13 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		WARN_ON(!cm2_base);
 	}
 }
+
+void __init omap_osc_register(struct omap_osc_data *osc)
+{
+	osc_setup = osc;
+}
+
+struct omap_osc_data *omap_osc_get(void)
+{
+	return osc_setup;
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 3b83763..2c678e9 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -212,3 +212,9 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
 {
 	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset);
 }
+
+void omap3_prm_set_clksetup(unsigned long clksetup)
+{
+	clksetup = clksetup * 32768 / (1000 * 1000) + 1;
+	omap3_prm_vcvp_write(clksetup, OMAP3_PRM_CLKSETUP_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index cef533d..32740a0 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -314,6 +314,7 @@ void omap3_prm_vp_clear_txdone(u8 vp_id);
 extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+extern void omap3_prm_set_clksetup(unsigned long clksetup);
 #endif	/* CONFIG_ARCH_OMAP4 */
 
 #endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 495a31a..c91c66f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -26,6 +26,7 @@
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx.h"
+#include "scrm44xx.h"
 
 /* PRM low-level functions */
 
@@ -121,3 +122,9 @@ u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
 					       OMAP4430_PRM_DEVICE_INST,
 					       offset);
 }
+
+void omap4_prm_set_clksetup(unsigned long clksetup)
+{
+	clksetup = clksetup * 32768 / (1000 * 1000) + 1;
+	__raw_writel(clksetup, OMAP4_SCRM_CLKSETUPTIME);
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3d66ccd..9b21f33 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
 extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+extern void omap4_prm_set_clksetup(unsigned long clksetup);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 16fa912..3bf4fae 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -1,14 +1,18 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
 #include <plat/cpu.h>
+#include <plat/prcm.h>
 
 #include "voltage.h"
 #include "vc.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "scrm44xx.h"
 
 /**
  * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
@@ -194,44 +198,183 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 	return 0;
 }
 
-static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
+static void omap3_set_ret_timings(struct voltagedomain *voltdm)
 {
-	/*
-	 * Voltage Manager FSM parameters init
-	 * XXX This data should be passed in from the board file
-	 */
-	voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET);
-	voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	unsigned long clksetup;
+	unsigned long voltsetup1;
+	struct omap_osc_data *osc;
+	struct clk *sys_ck;
+	u32 sys_clk_rate;
+
+	osc = omap_osc_get();
+	if (osc) {
+		clksetup = osc->clk_setup_off;
+		omap3_prm_set_clksetup(clksetup);
+	}
+	sys_ck = clk_get(NULL, "sys_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: unable to get sys_ck to calculate "
+			"vdd_%s timings\n", __func__, voltdm->name);
+		return;
+	}
+	sys_clk_rate = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
+
+	voltsetup1 = (voltdm->vc_param->on - voltdm->vc_param->ret) /
+			voltdm->pmic->slew_rate;
+
+	voltsetup1 = voltsetup1 * sys_clk_rate / 8 / 1000000 + 1;
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
+		voltsetup1 << __ffs(voltdm->vfsm->voltsetup_mask),
+		voltdm->vfsm->voltsetup_reg);
+
+	/* set voltsetup 2 to 0 */
+	voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
+}
+
+static void omap3_set_off_timings(struct voltagedomain *voltdm)
+{
+	unsigned long clksetup;
+	unsigned long voltsetup2;
+	struct omap_osc_data *osc;
+
+	osc = omap_osc_get();
+	if (osc) {
+		clksetup = osc->clk_setup_off;
+		omap3_prm_set_clksetup(clksetup);
+	}
+
+	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
+
+	/* voltsetup 2 in us */
+	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
+
+	/* convert to 32k clk cycles */
+	voltsetup2 = voltsetup2 * 32768 / 1000000 + 1;
+
+	voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
+
+	/* set voltsetup1 to 0 */
+	voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
+		voltdm->vfsm->voltsetup_reg);
+
+	/* set voltoffset */
+	voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
 static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
+	omap3_set_off_timings(voltdm);
+}
 
-	if (is_initialized)
-		return;
+static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
+		u32 clk_rate)
+{
+	u32 prescaler;
+	u32 cycles;
+	u32 time;
+
+	time = voltage_diff / voltdm->pmic->slew_rate;
+
+	cycles = clk_rate / 1000 * time;
+
+	cycles /= 64;
+	prescaler = 0;
+
+	/* shift to next prescaler until no overflow */
+
+	/* scale for div 256 = 64 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
 
-	omap3_vfsm_init(voltdm);
+	/* scale for div 512 = 256 * 2 */
+	if (cycles > 63) {
+		cycles /= 2;
+		prescaler++;
+	}
+
+	/* scale for div 2048 = 512 * 4 */
+	if (cycles > 63) {
+		cycles /= 4;
+		prescaler++;
+	}
+
+	/* check for overflow => invalid ramp time */
+	if (cycles > 63) {
+		pr_warning("%s: invalid setuptime for vdd_%s\n", __func__,
+			voltdm->name);
+		return 0;
+	}
+
+	cycles++;
 
-	is_initialized = true;
+	return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
+		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
 }
 
+static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
+{
+	struct clk *sys_ck;
+	u32 sys_clk_rate;
+	u32 val;
+	u32 ramp;
+	struct omap_osc_data *osc;
+
+	sys_ck = clk_get(NULL, "sys_clkin_ck");
+	if (IS_ERR(sys_ck)) {
+		pr_warning("%s: unable to get sys_ck to calculate "
+			"vdd_%s timings\n", __func__, voltdm->name);
+		return;
+	}
+	sys_clk_rate = clk_get_rate(sys_ck);
+	clk_put(sys_ck);
+
+	/* configure the setup times */
+	val = voltdm->read(voltdm->vfsm->voltsetup_reg);
+
+	if (off_mode)
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->off,
+			sys_clk_rate);
+	else
+		ramp = omap4_calc_volt_ramp(voltdm,
+			voltdm->vc_param->on - voltdm->vc_param->ret,
+			sys_clk_rate);
+
+	if (!ramp)
+		return;
+
+	val |= ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
+
+	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
+
+	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
+
+	osc = omap_osc_get();
+
+	if (!osc)
+		return;
+
+	if (off_mode)
+		omap4_prm_set_clksetup(osc->clk_setup_off);
+	else
+		omap4_prm_set_clksetup(osc->clk_setup_ret);
+}
 
 /* OMAP4 specific voltage init functions */
 static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 {
-	static bool is_initialized;
 	u32 vc_val;
 
-	if (is_initialized)
-		return;
+	omap4_set_timings(voltdm, true);
 
 	/* XXX These are magic numbers and do not belong! */
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
-
-	is_initialized = true;
 }
 
 /**
@@ -305,7 +448,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
 	vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
 	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
-	vc->setup_time = voltdm->pmic->volt_setup_time;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
@@ -329,10 +471,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
-	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
-	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
-	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
-	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
+	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->on);
+	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->onlp);
+	ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->ret);
+	off_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->off);
 	val = ((on_vsel << vc->common->cmd_on_shift) |
 	       (onlp_vsel << vc->common->cmd_onlp_shift) |
 	       (ret_vsel << vc->common->cmd_ret_shift) |
@@ -343,11 +485,6 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
 
-	/* Configure the setup times */
-	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
-		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
-		    voltdm->vfsm->voltsetup_reg);
-
 	omap_vc_i2c_init(voltdm);
 
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index ec50643..e6fdd23 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -80,7 +80,6 @@ struct omap_vc_channel {
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
 	u16 cmd_reg_addr;
-	u16 setup_time;
 	u8 cfg_channel;
 	bool i2c_high_speed;
 
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index b4c6259..e99bf77 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -70,6 +70,8 @@ struct voltagedomain {
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
 	struct omap_voltdm_pmic *pmic;
+	struct omap_vp_param *vp_param;
+	struct omap_vc_param *vc_param;
 
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
@@ -119,10 +121,6 @@ struct omap_volt_data {
 struct omap_voltdm_pmic {
 	int slew_rate;
 	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
 	u16 volt_setup_time;
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
@@ -139,6 +137,18 @@ struct omap_voltdm_pmic {
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
 
+struct omap_vp_param {
+	u8 vddmax;
+	u8 vddmin;
+};
+
+struct omap_vc_param {
+	u32 on;
+	u32 onlp;
+	u32 ret;
+	u32 off;
+};
+
 void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
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
 
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 66bd700..fc59e12 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -53,8 +53,10 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->vp_vddmin;
-	vddmax = voltdm->pmic->vp_vddmax;
+	vddmin = voltdm->vp_param->vddmin > voltdm->pmic->vp_vddmin ?
+		voltdm->vp_param->vddmin : voltdm->pmic->vp_vddmin;
+	vddmax = voltdm->vp_param->vddmax < voltdm->pmic->vp_vddmax ?
+		voltdm->vp_param->vddmax : voltdm->pmic->vp_vddmax;
 
 	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
 		    sys_clk_rate) / 1000;
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 267f43b..cc19997 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -27,9 +27,16 @@
 #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
 #define __ASM_ARM_ARCH_OMAP_PRCM_H
 
+struct omap_osc_data {
+	u32 clk_setup_ret;
+	u32 clk_setup_off;
+};
+
 u32 omap_prcm_get_reset_sources(void);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
+void omap_osc_register(struct omap_osc_data *osc);
+struct omap_osc_data *omap_osc_get(void);
 
 #endif
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 


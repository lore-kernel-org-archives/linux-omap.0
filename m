From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: [PATCH 1/2] Support OMAP3 VC adaptation with different Power IC
Date: Wed, 24 Jun 2009 08:15:04 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D542E07F@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail55.messagelabs.com ([216.82.241.163]:59610 "EHLO
	mail55.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZFXAP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 20:15:27 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n5O0FTUC011649
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 17:15:29 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n5O0FTsC005099
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 19:15:29 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n5O0FSEC005093
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 19:15:28 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From c1aba8ba7af3ddd16346d95795bda71e65baa4d0 Mon Sep 17 00:00:00 2001
From: Chunqiu Wang <cqwang@motorola.com>
Date: Wed, 24 Jun 2009 06:48:52 +0800
Subject: [PATCH] Support OMAP3 VC adaptation with different Power IC

Current OMAP SmartReflex driver only supports TI Triton
Power IC, add a callback to make it possible to use
different PowerIC and use different settings to
configure OMAP3 Voltage Controller for DVFS

Board file can setup a new function to have different settings
on SR to configure their Power IC for voltage scaling

Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
---
 arch/arm/mach-omap2/smartreflex.c |   13 +++++++++++++
 arch/arm/mach-omap2/smartreflex.h |    4 ++++
 arch/arm/plat-omap/Kconfig        |    2 +-
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c
b/arch/arm/mach-omap2/smartreflex.c
index 9d462e3..bacf602 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -52,6 +52,8 @@ struct omap_sr {
 
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
+static omap3_voltagescale_vcbypass_t omap3_volscale_vcbypass_fun;
+
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset,
u32 value)
 {
 	__raw_writel(value, SR_REGADDR(offset));
@@ -767,6 +769,11 @@ void disable_smartreflex(int srid)
 	}
 }
 
+void omap3_voltagescale_vcbypass_setup(omap3_voltagescale_vcbypass_t
fun)
+{
+	omap3_volscale_vcbypass_fun = fun;
+}
+
 /* Voltage Scaling using SR VCBYPASS */
 int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 					u8 target_vsel, u8 current_vsel)
@@ -779,6 +786,10 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32
current_opp,
 	u32 t2_smps_steps = 0;
 	u32 t2_smps_delay = 0;
 
+	if (omap3_volscale_vcbypass_fun)
+		return omap3_volscale_vcbypass_fun(target_opp,
current_opp,
+						target_vsel,
current_vsel);
+
 	vdd = get_vdd(target_opp);
 	target_opp_no = get_opp_no(target_opp);
 	current_opp_no = get_opp_no(current_opp);
@@ -940,6 +951,7 @@ static int __init omap3_sr_init(void)
 		return -ENODEV;
         }
 
+#ifdef CONFIG_TWL4030_CORE
 	/* Enable SR on T2 */
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 					R_DCDC_GLOBAL_CFG);
@@ -947,6 +959,7 @@ static int __init omap3_sr_init(void)
 	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
 	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
 					R_DCDC_GLOBAL_CFG);
+#endif
 
 	if (cpu_is_omap34xx()) {
 		sr1.clk = clk_get(NULL, "sr1_fck");
diff --git a/arch/arm/mach-omap2/smartreflex.h
b/arch/arm/mach-omap2/smartreflex.h
index 2a0e823..c4aca9d 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -248,9 +248,13 @@ void disable_smartreflex(int srid);
 int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8
c_vsel);
 void sr_start_vddautocomap(int srid, u32 target_opp_no);
 int sr_stop_vddautocomap(int srid);
+typedef int (*omap3_voltagescale_vcbypass_t)(u32 t_opp, u32 c_opp,
+						u8 t_vsel, u8 c_vsel); 
+void omap3_voltagescale_vcbypass_setup(omap3_voltagescale_vcbypass_t
fun);
 #else
 static inline void enable_smartreflex(int srid) {}
 static inline void disable_smartreflex(int srid) {}
+#define omap3_voltagescale_vcbypass_setup(fun) do {} while (0);
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c8ba1e2..8d2c607 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -68,7 +68,7 @@ config OMAP_DEBUG_CLOCKDOMAIN
 
 config OMAP_SMARTREFLEX
 	bool "SmartReflex support"
-	depends on ARCH_OMAP34XX && TWL4030_CORE && PM
+	depends on ARCH_OMAP34XX && PM
 	help
 	  Say Y if you want to enable SmartReflex.
 
-- 
1.5.4.3

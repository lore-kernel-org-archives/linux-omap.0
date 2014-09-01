From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/26] ARM: OMAP4/AM33xx: add cm_init / cm_exit calls for AM33xx and OMAP4+
Date: Mon, 1 Sep 2014 21:08:54 +0300
Message-ID: <1409594955-1476-6-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535AbaIASJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:50 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is needed for expanding the generic CM driver API to include
AM33xx and OMAP4 also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c     |   13 +++++++++++++
 arch/arm/mach-omap2/cm33xx.h     |    1 +
 arch/arm/mach-omap2/cminst44xx.c |   13 +++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/io.c         |    6 ++++++
 5 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index ef9e9018..e02988f 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -358,3 +358,16 @@ struct clkdm_ops am33xx_clkdm_operations = {
 	.clkdm_clk_enable	= am33xx_clkdm_clk_enable,
 	.clkdm_clk_disable	= am33xx_clkdm_clk_disable,
 };
+
+static struct cm_ll_data am33xx_cm_ll_data;
+
+int __init am33xx_cm_init(void)
+{
+	return cm_register(&am33xx_cm_ll_data);
+}
+
+static void __exit am33xx_cm_exit(void)
+{
+	cm_unregister(&am33xx_cm_ll_data);
+}
+__exitcall(am33xx_cm_exit);
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 1771fc1..1d3cde7 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -379,6 +379,7 @@ void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
+int am33xx_cm_init(void);
 
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs);
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 7e6970a..695e71e 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -505,3 +505,16 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
 };
+
+static struct cm_ll_data omap4xxx_cm_ll_data;
+
+int __init omap4_cm_init(void)
+{
+	return cm_register(&omap4xxx_cm_ll_data);
+}
+
+static void __exit omap4_cm_exit(void)
+{
+	cm_unregister(&omap4xxx_cm_ll_data);
+}
+__exitcall(omap4_cm_exit);
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 67a05f9..cc3c913 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -38,5 +38,6 @@ extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
 					   u32 mask);
 
 extern void omap_cm_base_init(void);
+int omap4_cm_init(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5c2c71a..26055d9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -45,6 +45,7 @@
 #include "sram.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
+#include "cm33xx.h"
 #include "prm.h"
 #include "cm.h"
 #include "prcm_mpu44xx.h"
@@ -582,6 +583,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
+	am33xx_cm_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
 	am33xx_hwmod_init();
@@ -609,6 +611,7 @@ void __init am43xx_init_early(void)
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
+	omap4_cm_init();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
@@ -638,6 +641,7 @@ void __init omap4430_init_early(void)
 	omap_cm_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
+	omap4_cm_init();
 	omap4_pm_init_early();
 	omap44xx_prm_init();
 	omap44xx_voltagedomains_init();
@@ -672,6 +676,7 @@ void __init omap5_init_early(void)
 	omap_cm_base_init();
 	omap44xx_prm_init();
 	omap5xxx_check_revision();
+	omap4_cm_init();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
 	omap54xx_clockdomains_init();
@@ -700,6 +705,7 @@ void __init dra7xx_init_early(void)
 	omap_cm_base_init();
 	omap44xx_prm_init();
 	dra7xxx_check_revision();
+	omap4_cm_init();
 	dra7xx_powerdomains_init();
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
-- 
1.7.9.5


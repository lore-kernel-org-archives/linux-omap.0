From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH 5/5] ARM: OMAP: TI81xx: add clockdomain data
Date: Tue, 04 Oct 2011 03:31:43 -0600
Message-ID: <20111004093136.9657.92040.stgit@dusk>
References: <20111004092947.9657.16166.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52227 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab1JDJcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 05:32:42 -0400
In-Reply-To: <20111004092947.9657.16166.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hemant Pedanekar <hemantp@ti.com>

From: Hemant Pedanekar <hemantp@ti.com>

Add clockdomain data for the TI816x and TI814x SoCs.

This patch is a collaboration between Hemant Pedanekar <hemantp@ti.com>
and Paul Walmsley <paul@pwsan.com>.
---
 arch/arm/mach-omap2/Makefile                |    3 
 arch/arm/mach-omap2/clockdomain.h           |    2 
 arch/arm/mach-omap2/clockdomains81xx_data.c |  223 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                    |    1 
 4 files changed, 228 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6962c5c..d0a66a2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -130,7 +130,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
 obj-$(CONFIG_SOC_OMAPTI81XX)		+= clockdomain.o \
-					   clockdomain81xx.o
+					   clockdomain81xx.o \
+					   clockdomains81xx_data.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 9c7c5e9..3f1b310 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -196,6 +196,8 @@ extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
+extern void __init ti81xx_clockdomains_init(void);
+
 extern void _clkdm_add_autodeps(struct clockdomain *clkdm);
 extern void _clkdm_del_autodeps(struct clockdomain *clkdm);
 
diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
new file mode 100644
index 0000000..53a95eb
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
@@ -0,0 +1,223 @@
+/*
+ * TI816X Clock Domain data.
+ *
+ * Copyright (C) 2010-2011 Texas Instruments, Inc. - http://www.ti.com/
+ * Hemant Pedanekar
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "cm.h"
+#include "prcm81xx.h"
+#include "prcm814x.h"
+#include "prcm816x.h"
+#include "prcm-regbits-81xx.h"
+
+static struct clockdomain alwon_mpu_81xx_clkdm = {
+	.name		= "alwon_mpu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI816X_CM_ALWON_MPU_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_l3_slow_814x_clkdm = {
+	.name		= "alwon_l3_slow_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI814X_CM_ALWON_L3_SLOW_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_l3_med_814x_clkdm = {
+	.name		= "alwon_l3_med_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI814X_CM_ALWON_L3_MED_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_l3_fast_81xx_clkdm = {
+	.name		= "alwon_l3_fast_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI81XX_CM_ALWON_L3_FAST_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_ethernet_81xx_clkdm = {
+	.name		= "alwon_ethernet_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI81XX_CM_ETHERNET_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain mmu_81xx_clkdm = {
+	.name		= "mmu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI81XX_CM_MMU_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain mmu_cfg_81xx_clkdm = {
+	.name		= "mmu_cfg_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_INST,
+	.clkdm_offs	= TI81XX_CM_MMUCFG_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain active_gem_81xx_clkdm = {
+	.name		= "active_gem_clkdm",
+	.pwrdm		= { .name = "active_pwrdm" },
+	.cm_inst	= TI81XX_CM_ACTIVE_INST,
+	.clkdm_offs	= TI81XX_CM_ACTIVE_GEM_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain hdvicp_814x_clkdm = {
+	.name		= "hdvicp_clkdm",
+	.pwrdm		= { .name = "hdvicp_pwrdm" },
+	.cm_inst	= TI814X_CM_HDVICP_INST,
+	.clkdm_offs	= TI814X_CM_HDVICP_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain isp_814x_clkdm = {
+	.name		= "isp_clkdm",
+	.pwrdm		= { .name = "isp_pwrdm" },
+	.cm_inst	= TI814X_CM_ISP_INST,
+	.clkdm_offs	= TI814X_CM_ISP_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain dss_814x_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm		= { .name = "dss_pwrdm" },
+	.cm_inst	= TI814X_CM_DSS_INST,
+	.clkdm_offs	= TI814X_CM_DSS_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain sgx_81xx_clkdm = {
+	.name		= "sgx_clkdm",
+	.pwrdm		= { .name = "sgx_pwrdm" },
+	.cm_inst	= TI81XX_CM_SGX_INST,
+	.clkdm_offs	= TI81XX_CM_SGX_SGX_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_l3_slow_816x_clkdm = {
+	.name		= "default_l3_slow_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_tppss_814x_clkdm = {
+	.name		= "default_tppss_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI814X_CM_DEFAULT_TPPSS_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_l3_med_816x_clkdm = {
+	.name		= "default_l3_med_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_ducati_814x_clkdm = {
+	.name		= "default_ducati_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI814X_CM_DEFAULT_DUCATI_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_ducati_816x_clkdm = {
+	.name		= "default_ducati_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_pcie_814x_clkdm = {
+	.name		= "default_pcie_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI814X_CM_DEFAULT_PCI_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_pcie_816x_clkdm = {
+	.name		= "default_pcie_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_INST,
+	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKSTCTRL_OFFSET,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain *clockdomains_ti81xx[] __initdata = {
+	&alwon_mpu_81xx_clkdm,
+	&alwon_l3_fast_81xx_clkdm,
+	&alwon_ethernet_81xx_clkdm,
+	&mmu_81xx_clkdm,
+	&mmu_cfg_81xx_clkdm,
+	&active_gem_81xx_clkdm,
+	&sgx_81xx_clkdm,
+	NULL,
+};
+
+static struct clockdomain *clockdomains_ti814x[] __initdata = {
+	&hdvicp_814x_clkdm,
+	&isp_814x_clkdm,
+	&dss_814x_clkdm,
+	&alwon_l3_med_814x_clkdm,
+	&alwon_l3_slow_814x_clkdm,
+	&default_tppss_814x_clkdm,
+	&default_ducati_814x_clkdm,
+	&default_pcie_814x_clkdm,
+	NULL,
+};
+
+static struct clockdomain *clockdomains_ti816x[] __initdata = {
+	&default_l3_med_816x_clkdm,
+	&default_l3_slow_816x_clkdm,
+	&default_ducati_816x_clkdm,
+	&default_pcie_816x_clkdm,
+	NULL,
+};
+
+void __init ti81xx_clockdomains_init(void)
+{
+	if (!cpu_is_ti81xx())
+		return;
+
+	clkdm_register_platform_funcs(&ti81xx_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_ti81xx);
+	if (cpu_is_ti814x())
+		clkdm_register_clkdms(clockdomains_ti814x);
+	if (cpu_is_ti816x())
+		clkdm_register_clkdms(clockdomains_ti816x);
+	clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index bad2edb..2d26820 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -352,6 +352,7 @@ void __init omap2_init_common_infrastructure(void)
 		omap3xxx_powerdomains_init();
 		ti81xx_powerdomains_init();
 		omap3xxx_clockdomains_init();
+		ti81xx_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();



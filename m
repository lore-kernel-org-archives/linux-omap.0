From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH 3/5] ARM: OMAP: TI81xx: add powerdomain data
Date: Tue, 04 Oct 2011 03:31:31 -0600
Message-ID: <20111004093126.9657.70654.stgit@dusk>
References: <20111004092947.9657.16166.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab1JDJcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 05:32:42 -0400
In-Reply-To: <20111004092947.9657.16166.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hemant Pedanekar <hemantp@ti.com>

From: Hemant Pedanekar <hemantp@ti.com>

Add powerdomain data for the TI81xx family of SoCs.

This patch is a collaboration between Hemant Pedanekar <hemantp@ti.com>
and Paul Walmsley <paul@pwsan.com>.
---
 arch/arm/mach-omap2/Makefile               |    3 +
 arch/arm/mach-omap2/io.c                   |    1 
 arch/arm/mach-omap2/powerdomain.h          |    1 
 arch/arm/mach-omap2/powerdomain81xx_data.c |   91 ++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain81xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 292941d..4f728a1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -113,7 +113,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
 obj-$(CONFIG_SOC_OMAPTI81XX)		+= $(powerdomain-common) \
-					   powerdomain81xx.o
+					   powerdomain81xx.o \
+					   powerdomain81xx_data.o \
 
 # PRCM clockdomain control
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d59feec..bad2edb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -350,6 +350,7 @@ void __init omap2_init_common_infrastructure(void)
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
+		ti81xx_powerdomains_init();
 		omap3xxx_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index b3d51f2..b9e7ab2 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -214,6 +214,7 @@ extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
+extern void ti81xx_powerdomains_init(void);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
diff --git a/arch/arm/mach-omap2/powerdomain81xx_data.c b/arch/arm/mach-omap2/powerdomain81xx_data.c
new file mode 100644
index 0000000..1b363ec
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain81xx_data.c
@@ -0,0 +1,91 @@
+/*
+ * TI81XX Power Domain data.
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
+
+#include "powerdomain.h"
+#include "prcm81xx.h"
+#include "prcm814x.h"
+#include "prcm816x.h"
+
+static struct powerdomain alwon_814x_pwrdm = {
+	.name		= "alwon_pwrdm",
+	.prcm_offs	= TI814X_PRM_ALWON_INST,
+};
+
+static struct powerdomain active_81xx_pwrdm = {
+	.name		= "active_pwrdm",
+	.prcm_offs	= TI81XX_PRM_ACTIVE_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain default_81xx_pwrdm = {
+	.name		= "default_pwrdm",
+	.prcm_offs	= TI81XX_PRM_DEFAULT_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain hdvicp_814x_pwrdm = {
+	.name		= "hdvicp_pwrdm",
+	.prcm_offs	= TI814X_PRM_HDVICP_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain isp_814x_pwrdm = {
+	.name		= "isp_pwrdm",
+	.prcm_offs	= TI814X_PRM_ISP_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain dss_814x_pwrdm = {
+	.name		= "dss_pwrdm",
+	.prcm_offs	= TI814X_PRM_DSS_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain sgx_81xx_pwrdm = {
+	.name		= "sgx_pwrdm",
+	.prcm_offs	= TI81XX_PRM_SGX_INST,
+	.pwrsts		= PWRSTS_OFF_ON,
+};
+
+static struct powerdomain *powerdomains_ti81xx[] __initdata = {
+	&active_81xx_pwrdm,
+	&default_81xx_pwrdm,
+	&sgx_81xx_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_ti814x[] __initdata = {
+	&alwon_814x_pwrdm,
+	&hdvicp_814x_pwrdm,
+	&isp_814x_pwrdm,
+	&dss_814x_pwrdm,
+	NULL
+};
+
+void __init ti81xx_powerdomains_init(void)
+{
+	if (!cpu_is_ti81xx())
+		return;
+
+	pwrdm_register_platform_funcs(&ti81xx_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_ti81xx);
+	if (cpu_is_ti814x())
+		pwrdm_register_pwrdms(powerdomains_ti814x);
+	pwrdm_complete_init();
+}



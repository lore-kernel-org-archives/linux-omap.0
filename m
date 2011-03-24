From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 09/19] OMAP2: add voltage domains and connect to powerdomains
Date: Wed, 23 Mar 2011 17:00:23 -0700
Message-ID: <1300924833-26745-10-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36446 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933023Ab1CXABC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:01:02 -0400
Received: by iwn34 with SMTP id 34so11843596iwn.5
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:28 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Create basic voltagedomains for OMAP2 and associate OMAP2 powerdomains
with the newly created voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    3 +-
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c   |    4 +++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains2xxx_data.c |   33 +++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 82b2a67..ce2105c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -91,7 +91,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 # OMAP voltage domains
 ifeq ($(CONFIG_PM),y)
 voltagedomain-common			:= voltage.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
+obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
+					   voltagedomains2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 44c2c3e..b5c8e80 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -356,10 +356,12 @@ void __init omap2_init_common_infrastructure(void)
 	u8 postsetup_state;
 
 	if (cpu_is_omap242x()) {
+		omap2xxx_voltagedomains_init();
 		omap2xxx_powerdomains_init();
 		omap2xxx_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
+		omap2xxx_voltagedomains_init();
 		omap2xxx_powerdomains_init();
 		omap2xxx_clockdomains_init();
 		omap2430_hwmod_init();
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index cc389fb..274f64c 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -38,6 +38,7 @@ static struct powerdomain dsp_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain mpu_24xx_pwrdm = {
@@ -53,6 +54,7 @@ static struct powerdomain mpu_24xx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain core_24xx_pwrdm = {
@@ -71,6 +73,7 @@ static struct powerdomain core_24xx_pwrdm = {
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 		[2] = PWRSTS_OFF_RET_ON, /* MEM3ONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 
@@ -95,6 +98,7 @@ static struct powerdomain mdm_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 #endif     /* CONFIG_SOC_OMAP2430 */
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 25cfb5c..cacd76e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -180,6 +180,7 @@ static inline int omap_voltage_late_init(void)
 }
 #endif
 
+extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
 extern void omap44xx_voltagedomains_init(void);
 
diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
new file mode 100644
index 0000000..4993bbe
--- /dev/null
+++ b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
@@ -0,0 +1,33 @@
+/*
+ * OMAP3 voltage domain data
+ *
+ * Copyright (C) 2007, 2010 Texas Instruments, Inc.
+
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "voltage.h"
+
+static struct voltagedomain omap2_voltdm_core = {
+	.name = "core",
+	.scalable = true,
+};
+
+static struct voltagedomain omap2_voltdm_wkup = {
+	.name = "wkup",
+};
+
+static struct voltagedomain *voltagedomains_omap2[] __initdata = {
+	&omap2_voltdm_core,
+	&omap2_voltdm_wkup,
+	NULL,
+};
+
+void __init omap2xxx_voltagedomains_init(void)
+{
+	voltdm_init(voltagedomains_omap2);
+}
-- 
1.7.4


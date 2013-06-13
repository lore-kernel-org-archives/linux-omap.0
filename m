From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] ARM: AM33xx: Remove the unused voltagedomain data
Date: Thu, 13 Jun 2013 15:38:44 +0530
Message-ID: <1371118124-15910-3-git-send-email-rnayak@ti.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758491Ab3FMKJd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 06:09:33 -0400
In-Reply-To: <1371118124-15910-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Now that there is a way to tell the powerdomain core about
missing voltage domain control in SoCs', get rid of the dummy
voltage domain data populated for AM33xx devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/io.c                      |    1 -
 arch/arm/mach-omap2/prm33xx.c                 |    7 ++++
 arch/arm/mach-omap2/voltage.h                 |    1 -
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 -------------------------
 5 files changed, 7 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..a4f1d2a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -125,7 +125,6 @@ obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
-obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 09abf99..50b93df 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -577,7 +577,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
 	am33xx_hwmod_init();
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 44c0d72..7204407 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -320,6 +320,12 @@ static int am33xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static int am33xx_check_vcvp(void)
+{
+	/* No VC/VP on am33xx devices */
+	return 0;
+}
+
 struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
@@ -335,4 +341,5 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_mem_onst		= am33xx_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst		= am33xx_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
+	.pwrdm_has_voltdm		= am33xx_check_vcvp,
 };
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index a0ce4f1..9bf796d 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -169,7 +169,6 @@ int omap_voltage_late_init(void);
 
 extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
-extern void am33xx_voltagedomains_init(void);
 extern void omap44xx_voltagedomains_init(void);
 
 struct voltagedomain *voltdm_lookup(const char *name);
diff --git a/arch/arm/mach-omap2/voltagedomains33xx_data.c b/arch/arm/mach-omap2/voltagedomains33xx_data.c
deleted file mode 100644
index 965458d..0000000
--- a/arch/arm/mach-omap2/voltagedomains33xx_data.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * AM33XX voltage domain data
- *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include "voltage.h"
-
-static struct voltagedomain am33xx_voltdm_mpu = {
-	.name		= "mpu",
-};
-
-static struct voltagedomain am33xx_voltdm_core = {
-	.name		= "core",
-};
-
-static struct voltagedomain am33xx_voltdm_rtc = {
-	.name		= "rtc",
-};
-
-static struct voltagedomain *voltagedomains_am33xx[] __initdata = {
-	&am33xx_voltdm_mpu,
-	&am33xx_voltdm_core,
-	&am33xx_voltdm_rtc,
-	NULL,
-};
-
-void __init am33xx_voltagedomains_init(void)
-{
-	voltdm_init(voltagedomains_am33xx);
-}
-- 
1.7.9.5


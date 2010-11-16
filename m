From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/6] OMAP: powerdomain: Arch specific funcs for state control
Date: Tue, 16 Nov 2010 21:08:03 +0530
Message-ID: <1289921886-5139-4-git-send-email-rnayak@ti.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
 <1289921886-5139-2-git-send-email-rnayak@ti.com>
 <1289921886-5139-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab0KPPiT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 10:38:19 -0500
In-Reply-To: <1289921886-5139-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.pwrdm_set_next_pwrst
.pwrdm_read_next_pwrst
.pwrdm_read_pwrst
.pwrdm_read_prev_pwrst

Convert the platform-independent framework to call these functions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile           |    5 +++
 arch/arm/mach-omap2/io.c               |    5 ++-
 arch/arm/mach-omap2/powerdomains.h     |    8 +++++
 arch/arm/mach-omap2/powerdomains2xxx.c |   53 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx.c |   53 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/powerdomain.c       |   33 ++++++++++++++------
 6 files changed, 146 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4bfadc5..5f843fc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -94,6 +94,11 @@ obj-$(CONFIG_ARCH_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
+#powerdomain framework
+obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx.o
+
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 76c531a..c68e989 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -316,7 +316,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 {
 	u8 skip_setup_idle = 0;
 
-	pwrdm_init(powerdomains_omap, NULL);
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		pwrdm_init(powerdomains_omap, &omap2_pwrdm_functions);
+	else if (cpu_is_omap44xx())
+		pwrdm_init(powerdomains_omap, &omap4_pwrdm_functions);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
 		omap2420_hwmod_init();
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 105cbca..b25b989 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -88,8 +88,16 @@ static struct powerdomain wkup_omap2_pwrdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
+extern struct pwrdm_functions omap2_pwrdm_functions;
+#else
+static struct pwrdm_functions omap2_pwrdm_functions;
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+extern struct pwrdm_functions omap4_pwrdm_functions;
+#else
+static struct pwrdm_functions omap4_pwrdm_functions;
+#endif
 
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap[] __initdata = {
diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
new file mode 100644
index 0000000..dfeb8af
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains2xxx.c
@@ -0,0 +1,53 @@
+/*
+ * OMAP2 and OMAP3 powerdomain control
+ *
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <plat/powerdomain.h>
+#include <plat/prcm.h>
+#include "powerdomains.h"
+
+static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+				(pwrst << OMAP_POWERSTATE_SHIFT),
+				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				OMAP2_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
+}
+
+static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
+}
+
+static int omap2_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+				OMAP3430_LASTPOWERSTATEENTERED_MASK);
+}
+
+struct pwrdm_functions omap2_pwrdm_functions = {
+	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst	= omap2_pwrdm_read_prev_pwrst,
+};
diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
new file mode 100644
index 0000000..b3aaf9b
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains44xx.c
@@ -0,0 +1,53 @@
+/*
+ * OMAP4 powerdomain control
+ *
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <plat/powerdomain.h>
+#include <plat/prcm.h>
+#include "powerdomains.h"
+
+static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+				(pwrst << OMAP_POWERSTATE_SHIFT),
+				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				OMAP4_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
+}
+
+static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				OMAP4_PM_PWSTST, OMAP_POWERSTATEST_MASK);
+}
+
+static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+				OMAP4430_LASTPOWERSTATEENTERED_MASK);
+}
+
+struct pwrdm_functions omap4_pwrdm_functions = {
+	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+};
diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
index 9e2d712..73d6dad 100644
--- a/arch/arm/plat-omap/powerdomain.c
+++ b/arch/arm/plat-omap/powerdomain.c
@@ -438,6 +438,8 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
  */
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
@@ -447,11 +449,10 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
-	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
-			     (pwrst << OMAP_POWERSTATE_SHIFT),
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
+		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -464,11 +465,15 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
  */
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				 pwrstctrl_reg_offs, OMAP_POWERSTATE_MASK);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst)
+		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -481,11 +486,15 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				 pwrstst_reg_offs, OMAP_POWERSTATEST_MASK);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
+		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
@@ -498,11 +507,15 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
-					OMAP3430_LASTPOWERSTATEENTERED_MASK);
+	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_pwrst)
+		ret = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
+
+	return ret;
 }
 
 /**
-- 
1.7.0.4


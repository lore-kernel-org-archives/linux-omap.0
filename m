From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 3/6] OMAP: powerdomain: Arch specific funcs for state control
Date: Fri,  3 Dec 2010 17:08:50 +0530
Message-ID: <1291376333-13603-4-git-send-email-rnayak@ti.com>
References: <1291376333-13603-1-git-send-email-rnayak@ti.com>
 <1291376333-13603-2-git-send-email-rnayak@ti.com>
 <1291376333-13603-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51059 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758490Ab0LCLjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 06:39:06 -0500
In-Reply-To: <1291376333-13603-3-git-send-email-rnayak@ti.com>
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
 arch/arm/mach-omap2/Makefile               |    5 ++
 arch/arm/mach-omap2/powerdomain.c          |   33 ++++++++++----
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |   62 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain44xx.c      |   55 ++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains.h         |   36 ++++++++++++++++
 arch/arm/mach-omap2/powerdomains_data.c    |    8 +++-
 6 files changed, 188 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5e20bc5..bba0d17 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -94,6 +94,11 @@ obj-$(CONFIG_ARCH_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
+#powerdomain framework
+obj-$(CONFIG_ARCH_OMAP2)		+= powerdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= powerdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
+
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3aa3eb3..0ae1ebf 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -439,6 +439,8 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
  */
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
+	int ret = -EINVAL;
+
 	if (!pwrdm)
 		return -EINVAL;
 
@@ -448,11 +450,10 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
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
@@ -465,11 +466,15 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
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
@@ -482,11 +487,15 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
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
@@ -499,11 +508,15 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
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
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
new file mode 100644
index 0000000..a25dd64
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -0,0 +1,62 @@
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
+#include <plat/prcm.h>
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+#include "powerdomains.h"
+
+/* Common functions across OMAP2 and OMAP3 */
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
+/* Applicable only for OMAP3. Not supported on OMAP2 */
+static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+				OMAP3430_LASTPOWERSTATEENTERED_MASK);
+}
+
+struct pwrdm_ops omap2_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+};
+
+struct pwrdm_ops omap3_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst	= omap3_pwrdm_read_prev_pwrst,
+};
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
new file mode 100644
index 0000000..5dc337c
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -0,0 +1,55 @@
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
+#include "prm.h"
+#include "prm-regbits-44xx.h"
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
+struct pwrdm_ops omap4_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
+};
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
new file mode 100644
index 0000000..c98b5fe
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -0,0 +1,36 @@
+/*
+ *  linux/arch/arm/mach-omap2/powerdomains.h
+ *
+ *  Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ *  Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
+
+#include <plat/powerdomain.h>
+
+#ifdef CONFIG_ARCH_OMAP2
+extern struct pwrdm_ops omap2_pwrdm_operations;
+#else
+static struct pwrdm_ops omap2_pwrdm_operations;
+#endif /* CONFIG_ARCH_OMAP2 */
+
+#ifdef CONFIG_ARCH_OMAP3
+extern struct pwrdm_ops omap3_pwrdm_operations;
+#else
+static struct pwrdm_ops omap3_pwrdm_operations;
+#endif /* CONFIG_ARCH_OMAP3 */
+
+#ifdef CONFIG_ARCH_OMAP4
+extern struct pwrdm_ops omap4_pwrdm_operations;
+#else
+static struct pwrdm_ops omap4_pwrdm_operations;
+#endif /* CONFIG_ARCH_OMAP4 */
+
+#endif /* ARCH_ARM_MACH_OMAP2_POWERDOMAINS */
diff --git a/arch/arm/mach-omap2/powerdomains_data.c b/arch/arm/mach-omap2/powerdomains_data.c
index bf5b39b..29690c6 100644
--- a/arch/arm/mach-omap2/powerdomains_data.c
+++ b/arch/arm/mach-omap2/powerdomains_data.c
@@ -55,6 +55,7 @@
 #include "powerdomains24xx.h"
 #include "powerdomains34xx.h"
 #include "powerdomains44xx.h"
+#include "powerdomains.h"
 
 /* OMAP2/3-common powerdomains */
 
@@ -149,5 +150,10 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 
 void pwrdm_fw_init(void)
 {
-	pwrdm_init(powerdomains_omap, NULL);
+	if (cpu_is_omap24xx())
+		pwrdm_init(powerdomains_omap, &omap2_pwrdm_operations);
+	else if (cpu_is_omap34xx())
+		pwrdm_init(powerdomains_omap, &omap3_pwrdm_operations);
+	else if (cpu_is_omap44xx())
+		pwrdm_init(powerdomains_omap, &omap4_pwrdm_operations);
 }
-- 
1.7.0.4


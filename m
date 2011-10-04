From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH 2/5] ARM: OMAP: TI81xx: add powerdomain code
Date: Tue, 04 Oct 2011 03:31:26 -0600
Message-ID: <20111004093117.9657.4268.stgit@dusk>
References: <20111004092947.9657.16166.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52218 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab1JDJcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 05:32:42 -0400
In-Reply-To: <20111004092947.9657.16166.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hemant Pedanekar <hemantp@ti.com>

TI81xx uses a novel PRCM register layout.  It most closely resembles
the OMAP4 PRCM, but with a few changes.  These devices also have
limited power management functionality.

Add powerdomain & PRCM implementation code for the TI81xx chips.

This patch is a collaboration between Hemant Pedanekar <hemantp@ti.com>
and Paul Walmsley <paul@pwsan.com>.
---
 arch/arm/mach-omap2/Makefile            |    2 +
 arch/arm/mach-omap2/powerdomain.h       |    1 
 arch/arm/mach-omap2/powerdomain81xx.c   |   81 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-regbits-81xx.h |   23 ++++++++
 arch/arm/mach-omap2/prcm81xx.c          |   93 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm81xx.h          |   14 +++++
 6 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain81xx.c
 create mode 100644 arch/arm/mach-omap2/prcm-regbits-81xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9c6b185..292941d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -112,6 +112,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
+obj-$(CONFIG_SOC_OMAPTI81XX)		+= $(powerdomain-common) \
+					   powerdomain81xx.o
 
 # PRCM clockdomain control
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 8febd84..b3d51f2 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -218,6 +218,7 @@ extern void omap44xx_powerdomains_init(void);
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
+extern struct pwrdm_ops ti81xx_pwrdm_operations;
 
 /* Common Internal functions used across OMAP rev's */
 extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
diff --git a/arch/arm/mach-omap2/powerdomain81xx.c b/arch/arm/mach-omap2/powerdomain81xx.c
new file mode 100644
index 0000000..c78db22
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain81xx.c
@@ -0,0 +1,81 @@
+/*
+ * TI81xx powerdomain control
+ *
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ *
+ * Rajendra Nayak <rnayak@ti.com>
+ * Paul Walmsley
+ * Hemant Pedanekar
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <plat/prcm.h>
+
+#include "powerdomain.h"
+#include "prcm81xx.h"
+
+static int ti81xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	ti81xx_prcm_pwrdm_set_powerstate(pwrdm->prcm_offs, pwrst);
+	return 0;
+}
+
+static int ti81xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	return ti81xx_prcm_pwrdm_read_powerstate(pwrdm->prcm_offs);
+}
+
+static int ti81xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	return ti81xx_prcm_pwrdm_read_powerstatest(pwrdm->prcm_offs);
+}
+
+static int ti81xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return ti81xx_prcm_pwrdm_read_logicstatest(pwrdm->prcm_offs);
+}
+
+static int ti81xx_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	return ti81xx_prcm_pwrdm_read_mem_statest(pwrdm->prcm_offs);
+}
+
+static int ti81xx_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
+{
+	ti81xx_prcm_pwrdm_set_lowpowerstatechange(pwrdm->prcm_offs);
+	return 0;
+}
+
+static int ti81xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	int r;
+
+	r = ti81xx_prcm_pwrdm_wait_transition(pwrdm->prcm_offs);
+	if (r == -ETIMEDOUT) {
+		pr_err("powerdomain: waited too long for powerdomain %s to complete transition\n",
+		       pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", r);
+
+	return 0;
+}
+
+struct pwrdm_ops ti81xx_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= ti81xx_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= ti81xx_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= ti81xx_pwrdm_read_pwrst,
+	.pwrdm_set_lowpwrstchange	= ti81xx_pwrdm_set_lowpwrstchange,
+	.pwrdm_read_logic_pwrst	= ti81xx_pwrdm_read_logic_pwrst,
+	.pwrdm_read_mem_pwrst	= ti81xx_pwrdm_read_mem_pwrst,
+	.pwrdm_wait_transition	= ti81xx_pwrdm_wait_transition,
+};
diff --git a/arch/arm/mach-omap2/prcm-regbits-81xx.h b/arch/arm/mach-omap2/prcm-regbits-81xx.h
new file mode 100644
index 0000000..8eda6b0
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm-regbits-81xx.h
@@ -0,0 +1,23 @@
+/*
+ * OMAP81xx PRCM register bits
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * Paul Walmsley (paul@pwsan.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PRCM_REGBITS_81XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRCM_REGBITS_81XX_H
+
+/*
+ * Used by PM_ACTIVE_PWRSTST, PM_HDVICP_PWRSTST, PM_ISP_PWRSTST,
+ * PM_DSS_PWRSTST, PM_SGX_PWRSTST
+ */
+#define TI81XX_MEM_STATEST_SHIFT				4
+#define TI81XX_MEM_STATEST_MASK					(0x3 << 4)
+
+#endif
diff --git a/arch/arm/mach-omap2/prcm81xx.c b/arch/arm/mach-omap2/prcm81xx.c
index d48e5fc..5846969 100644
--- a/arch/arm/mach-omap2/prcm81xx.c
+++ b/arch/arm/mach-omap2/prcm81xx.c
@@ -17,7 +17,17 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 
+#include <plat/common.h>
+
+#include "powerdomain.h"
+
 #include "prcm81xx.h"
+#include "prcm-regbits-81xx.h"
+#include "prm.h"
+
+#include "prm-regbits-44xx.h"
+
+/* prm_base = cm_base on TI81xx, so either is fine */
 
 static u32 ti81xx_prcm_inst_read(u16 inst, u16 offs)
 {
@@ -29,4 +39,87 @@ static void ti81xx_prcm_inst_write(u32 v, u16 inst, u16 offs)
 	__raw_writel(v, prm_base + inst + offs);
 }
 
+void ti81xx_prcm_pwrdm_set_powerstate(u16 offs, u8 pwrst)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+	v &= ~OMAP_POWERSTATE_MASK;
+	v |= pwrst << OMAP_POWERSTATE_SHIFT;
+	ti81xx_prcm_inst_write(v, offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+}
+
+u8 ti81xx_prcm_pwrdm_read_powerstate(u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+	v &= OMAP_POWERSTATE_MASK;
+	v >>= OMAP_POWERSTATE_SHIFT;
+
+	return v;
+}
+
+u8 ti81xx_prcm_pwrdm_read_powerstatest(u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTST_OFFSET);
+	v &= OMAP_POWERSTATEST_MASK;
+	v >>= OMAP_POWERSTATEST_SHIFT;
+
+	return v;
+}
+
+u8 ti81xx_prcm_pwrdm_read_logicstatest(u16 offs)
+{
+	u32 v;
 
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+	v &= OMAP4430_LOGICSTATEST_MASK;
+	v >>= OMAP4430_LOGICSTATEST_SHIFT;
+
+	return v;
+}
+
+u8 ti81xx_prcm_pwrdm_read_mem_statest(u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTST_OFFSET);
+	v &= TI81XX_MEM_STATEST_MASK;
+	v >>= TI81XX_MEM_STATEST_SHIFT;
+
+	return v;
+}
+
+void ti81xx_prcm_pwrdm_set_lowpowerstatechange(u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+	v &= ~OMAP4430_LOWPOWERSTATECHANGE_MASK;
+	v |= 1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT;
+	ti81xx_prcm_inst_write(v, offs, TI81XX_PM_PWRSTCTRL_OFFSET);
+}
+
+int ti81xx_prcm_pwrdm_wait_transition(u16 offs)
+{
+	u32 c = 0;
+
+	/*
+	 * REVISIT: pwrdm_wait_transition() may be better implemented
+	 * via a callback and a periodic timer check -- how long do we expect
+	 * powerdomain transitions to take?
+	 */
+
+	omap_test_timeout((ti81xx_prcm_inst_read(offs,
+						 TI81XX_PM_PWRSTST_OFFSET) &
+			   OMAP_INTRANSITION_MASK),
+			  PWRDM_TRANSITION_BAILOUT, c);
+
+	if (c > INT_MAX)
+		c = INT_MAX;
+
+	return (c <= PWRDM_TRANSITION_BAILOUT) ? c : -ETIMEDOUT;
+}
diff --git a/arch/arm/mach-omap2/prcm81xx.h b/arch/arm/mach-omap2/prcm81xx.h
index fd0a174..e0c20b9 100644
--- a/arch/arm/mach-omap2/prcm81xx.h
+++ b/arch/arm/mach-omap2/prcm81xx.h
@@ -188,6 +188,20 @@
 #define TI81XX_CM_ALWON_SR_1_CLKCTRL_OFFSET		0x020C
 #define TI81XX_CM_ALWON_SR_1_CLKCTRL			TI81XX_CM_REGADDR(TI81XX_CM_ALWON_INST, 0x020C)
 
+/*
+ * Register offset aliases (for clearer code, at least in theory)
+ */
+#define TI81XX_PM_PWRSTCTRL_OFFSET			TI81XX_PRM_ACTIVE_PM_PWRSTCTRL_OFFSET
+#define TI81XX_PM_PWRSTST_OFFSET			TI81XX_PRM_ACTIVE_PM_PWRSTST_OFFSET
+
 /* Function prototypes */
 
+extern void ti81xx_prcm_pwrdm_set_powerstate(u16 offs, u8 pwrst);
+extern u8 ti81xx_prcm_pwrdm_read_powerstate(u16 offs);
+extern u8 ti81xx_prcm_pwrdm_read_powerstatest(u16 offs);
+extern u8 ti81xx_prcm_pwrdm_read_logicstatest(u16 offs);
+extern u8 ti81xx_prcm_pwrdm_read_mem_statest(u16 offs);
+extern void ti81xx_prcm_pwrdm_set_lowpowerstatechange(u16 offs);
+extern int ti81xx_prcm_pwrdm_wait_transition(u16 offs);
+
 #endif



From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH 4/5] ARM: OMAP: TI81xx: add clockdomain control code
Date: Tue, 04 Oct 2011 03:31:36 -0600
Message-ID: <20111004093131.9657.44524.stgit@dusk>
References: <20111004092947.9657.16166.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52224 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab1JDJcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 05:32:42 -0400
In-Reply-To: <20111004092947.9657.16166.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hemant Pedanekar <hemantp@ti.com>

Add clockdomain control code for the TI816x and TI814x SoCs.

This patch is a collaboration between Hemant Pedanekar <hemantp@ti.com>
and Paul Walmsley <paul@pwsan.com>.
---
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/clockdomain.h     |    1 
 arch/arm/mach-omap2/clockdomain81xx.c |   77 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm81xx.c        |   59 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm81xx.h        |    5 ++
 5 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain81xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4f728a1..6962c5c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -129,6 +129,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
+obj-$(CONFIG_SOC_OMAPTI81XX)		+= clockdomain.o \
+					   clockdomain81xx.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..9c7c5e9 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -202,6 +202,7 @@ extern void _clkdm_del_autodeps(struct clockdomain *clkdm);
 extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
 extern struct clkdm_ops omap4_clkdm_operations;
+extern struct clkdm_ops ti81xx_clkdm_operations;
 
 extern struct clkdm_dep gfx_24xx_wkdeps[];
 extern struct clkdm_dep dsp_24xx_wkdeps[];
diff --git a/arch/arm/mach-omap2/clockdomain81xx.c b/arch/arm/mach-omap2/clockdomain81xx.c
new file mode 100644
index 0000000..eab50f8
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain81xx.c
@@ -0,0 +1,77 @@
+/*
+ * TI81XX clockdomain control
+ *
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ * Rajendra Nayak <rnayak@ti.com>
+ * Hemant Pedanekar
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+
+#include <plat/prcm.h>
+
+#include "prcm81xx.h"
+#include "prm.h"
+#include "clockdomain.h"
+
+static int ti81xx_clkdm_sleep(struct clockdomain *clkdm)
+{
+	ti81xx_prcm_clkdm_force_sleep(clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+static int ti81xx_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	ti81xx_prcm_clkdm_force_wakeup(clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+static void ti81xx_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	ti81xx_prcm_clkdm_enable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
+static void ti81xx_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	ti81xx_prcm_clkdm_disable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
+static int ti81xx_clkdm_clk_enable(struct clockdomain *clkdm)
+{
+	bool hwsup;
+
+	hwsup = ti81xx_prcm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+
+	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		ti81xx_clkdm_wakeup(clkdm);
+
+	return 0;
+}
+
+static int ti81xx_clkdm_clk_disable(struct clockdomain *clkdm)
+{
+	bool hwsup;
+
+	hwsup = ti81xx_prcm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+
+	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+		ti81xx_clkdm_sleep(clkdm);
+
+	return 0;
+}
+
+struct clkdm_ops ti81xx_clkdm_operations = {
+	.clkdm_sleep		= ti81xx_clkdm_sleep,
+	.clkdm_wakeup		= ti81xx_clkdm_wakeup,
+	.clkdm_allow_idle	= ti81xx_clkdm_allow_idle,
+	.clkdm_deny_idle	= ti81xx_clkdm_deny_idle,
+	.clkdm_clk_enable	= ti81xx_clkdm_clk_enable,
+	.clkdm_clk_disable	= ti81xx_clkdm_clk_disable,
+};
diff --git a/arch/arm/mach-omap2/prcm81xx.c b/arch/arm/mach-omap2/prcm81xx.c
index 5846969..523b594 100644
--- a/arch/arm/mach-omap2/prcm81xx.c
+++ b/arch/arm/mach-omap2/prcm81xx.c
@@ -2,6 +2,8 @@
  * TI81XX PRCM register access functions
  *
  * Copyright (C) 2010-2011 Texas Instruments, Inc. - http://www.ti.com/
+ * Hemant Pedanekar
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -27,6 +29,9 @@
 
 #include "prm-regbits-44xx.h"
 
+#include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
+
 /* prm_base = cm_base on TI81xx, so either is fine */
 
 static u32 ti81xx_prcm_inst_read(u16 inst, u16 offs)
@@ -123,3 +128,57 @@ int ti81xx_prcm_pwrdm_wait_transition(u16 offs)
 
 	return (c <= PWRDM_TRANSITION_BAILOUT) ? c : -ETIMEDOUT;
 }
+
+void ti81xx_prcm_clkdm_enable_hwsup(s16 inst, u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(inst, offs);
+	v &= ~OMAP4430_CLKTRCTRL_MASK;
+	v |= OMAP34XX_CLKSTCTRL_ENABLE_AUTO << OMAP4430_CLKTRCTRL_SHIFT;
+	ti81xx_prcm_inst_write(v, inst, offs);
+
+}
+
+void ti81xx_prcm_clkdm_disable_hwsup(s16 inst, u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(inst, offs);
+	v &= ~OMAP4430_CLKTRCTRL_MASK;
+	v |= OMAP34XX_CLKSTCTRL_DISABLE_AUTO << OMAP4430_CLKTRCTRL_SHIFT;
+	ti81xx_prcm_inst_write(v, inst, offs);
+}
+
+void ti81xx_prcm_clkdm_force_sleep(s16 inst, u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(inst, offs);
+	v &= ~OMAP4430_CLKTRCTRL_MASK;
+	v |= OMAP34XX_CLKSTCTRL_FORCE_SLEEP << OMAP4430_CLKTRCTRL_SHIFT;
+	ti81xx_prcm_inst_write(v, inst, offs);
+}
+
+void ti81xx_prcm_clkdm_force_wakeup(s16 inst, u16 offs)
+{
+	u32 v;
+
+	v = ti81xx_prcm_inst_read(inst, offs);
+	v &= ~OMAP4430_CLKTRCTRL_MASK;
+	v |= OMAP34XX_CLKSTCTRL_FORCE_WAKEUP << OMAP4430_CLKTRCTRL_SHIFT;
+	ti81xx_prcm_inst_write(v, inst, offs);
+}
+
+bool ti81xx_prcm_is_clkdm_in_hwsup(s16 inst, u16 offs)
+{
+	u32 v;
+	bool ret = 0;
+
+	v = ti81xx_prcm_inst_read(inst, offs);
+	v &= OMAP4430_CLKTRCTRL_MASK;
+	v >>= OMAP4430_CLKTRCTRL_SHIFT;
+	ret = (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/prcm81xx.h b/arch/arm/mach-omap2/prcm81xx.h
index e0c20b9..19a7b40 100644
--- a/arch/arm/mach-omap2/prcm81xx.h
+++ b/arch/arm/mach-omap2/prcm81xx.h
@@ -203,5 +203,10 @@ extern u8 ti81xx_prcm_pwrdm_read_logicstatest(u16 offs);
 extern u8 ti81xx_prcm_pwrdm_read_mem_statest(u16 offs);
 extern void ti81xx_prcm_pwrdm_set_lowpowerstatechange(u16 offs);
 extern int ti81xx_prcm_pwrdm_wait_transition(u16 offs);
+extern void ti81xx_prcm_clkdm_enable_hwsup(s16 inst, u16 offs);
+extern void ti81xx_prcm_clkdm_disable_hwsup(s16 inst, u16 offs);
+extern void ti81xx_prcm_clkdm_force_sleep(s16 inst, u16 offs);
+extern void ti81xx_prcm_clkdm_force_wakeup(s16 inst, u16 offs);
+extern bool ti81xx_prcm_is_clkdm_in_hwsup(s16 inst, u16 offs);
 
 #endif



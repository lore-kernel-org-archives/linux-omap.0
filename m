From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 6/7] omap4: dpll: Add dpll api to control GATE_CTRL
Date: Sat, 12 Feb 2011 18:08:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121807140.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com> <1297329400-5936-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49503 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1BMBIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 20:08:54 -0500
In-Reply-To: <1297329400-5936-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> On OMAP4, the dpll post divider outputs (MX outputs)
> along with clockout_x2 output provide a way to allow/deny
> hardware level autogating.
> Allowing autoidle would mean that the hw would autogate
> this clock when there is no dependency for it.
> Denying idle would mean that this clock output will be
> forced to stay enabled.
> 
> Add dpll api's to read/allow/deny idle control
> for these dpll mx postdividers.
> 
> NOTE: The gatectrl bit set to 0 allows gatectrl,
> and the bit set to 1 denies gatectrl.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, I moved the OMAP4-specific code to a file that is only compiled in 
on OMAP4, and added some documentation, and queued it for 2.6.39 in the 
'clk_autoidle_a_2.6.39' branch here.  Updated version follows.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 10 Feb 2011 14:46:39 +0530
Subject: [PATCH] OMAP4: DPLL: Add dpll api to control GATE_CTRL

On OMAP4, the dpll post divider outputs (MX outputs)
along with clockout_x2 output provide a way to allow/deny
hardware level autogating.
Allowing autoidle would mean that the hw would autogate
this clock when there is no dependency for it.
Denying idle would mean that this clock output will be
forced to stay enabled.

Add dpll api's to read/allow/deny idle control
for these dpll mx postdividers.

NOTE: The gatectrl bit set to 0 allows gatectrl,
and the bit set to 1 denies gatectrl.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: moved OMAP4-specific DPLL control code to
 mach-omap2/dpll44xx.c; added some documentation for CLOCK_CLKOUTX2]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile            |    2 +-
 arch/arm/mach-omap2/clock.h             |    3 +
 arch/arm/mach-omap2/dpll44xx.c          |   78 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |   14 +++++-
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dpll44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9eeabaf..c21b3ae 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -120,7 +120,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock3517.o clock36xx.o \
 					   dpll3xxx.o clock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
-					   dpll3xxx.o
+					   dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 2a939e5..c450d69 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -65,6 +65,9 @@ u32 omap3_dpll_autoidle_read(struct clk *clk);
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 int omap3_noncore_dpll_enable(struct clk *clk);
 void omap3_noncore_dpll_disable(struct clk *clk);
+int omap4_dpllmx_gatectrl_read(struct clk *clk);
+void omap4_dpllmx_allow_gatectrl(struct clk *clk);
+void omap4_dpllmx_deny_gatectrl(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
new file mode 100644
index 0000000..94a3592
--- /dev/null
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -0,0 +1,78 @@
+/*
+ * OMAP4-specific DPLL control functions
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Rajendra Nayak
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+
+#include <plat/cpu.h>
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "cm-regbits-44xx.h"
+
+/* Supported only on OMAP4 */
+int omap4_dpllmx_gatectrl_read(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return -EINVAL;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+void omap4_dpllmx_allow_gatectrl(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Clear the bit to allow gatectrl */
+	v &= ~mask;
+	__raw_writel(v, clk->clksel_reg);
+}
+
+void omap4_dpllmx_deny_gatectrl(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Set the bit to deny gatectrl */
+	v |= mask;
+	__raw_writel(v, clk->clksel_reg);
+}
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8534f71..dd09e61 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -175,12 +175,24 @@ struct dpll_data {
 
 #endif
 
-/* struct clk.flags possibilities */
+/*
+ * struct clk.flags possibilities
+ *
+ * XXX document the rest of the clock flags here
+ *
+ * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
+ *     bits share the same register.  This flag allows the
+ *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
+ *     should be used.  This is a temporary solution - a better approach
+ *     would be to associate clock type-specific data with the clock,
+ *     similar to the struct dpll_data approach.
+ */
 #define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 1)
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
 
 /**
  * struct clk - OMAP struct clk
-- 
1.7.2.3


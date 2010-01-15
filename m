From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/18] OMAP2xxx clock: move the APLL clock code into
	clkt2xxx_apll.c
Date: Fri, 15 Jan 2010 02:07:00 -0700
Message-ID: <20100115090659.30690.33519.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>
List-Id: linux-omap@vger.kernel.org

Move the APLL-related clock functions from clock2xxx.c to
clkt2xxx_apll.c to improve maintainability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +
 arch/arm/mach-omap2/clkt2xxx_apll.c |  120 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.c     |   86 -------------------------
 arch/arm/mach-omap2/clock2xxx.h     |    1 
 4 files changed, 124 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2b58363..825c303 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -12,7 +12,8 @@ clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
 clock-omap2xxx				= clkt2xxx_dpllcore.o \
-					  clkt2xxx_virt_prcm_set.o
+					  clkt2xxx_virt_prcm_set.o \
+					  clkt2xxx_apll.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(clock-omap2xxx)
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
new file mode 100644
index 0000000..459fd75
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -0,0 +1,120 @@
+/*
+ * clkt2xxx_apll.c - OMAP2xxx APLL clock control functions
+ *
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
+ *
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
+ *
+ * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ * Gordon McNutt and RidgeRun, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/prcm.h>
+
+#include "clock.h"
+#include "clock2xxx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
+#define EN_APLL_STOPPED			0
+#define EN_APLL_LOCKED			3
+
+/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
+#define APLLS_CLKIN_19_2MHZ		0
+#define APLLS_CLKIN_13MHZ		2
+#define APLLS_CLKIN_12MHZ		3
+
+/* Private functions */
+
+/* Enable an APLL if off */
+static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
+{
+	u32 cval, apll_mask;
+
+	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
+
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+
+	if ((cval & apll_mask) == apll_mask)
+		return 0;   /* apll already enabled */
+
+	cval &= ~apll_mask;
+	cval |= apll_mask;
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+
+	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
+			     clk->name);
+
+	/*
+	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
+	 * fails?
+	 */
+	return 0;
+}
+
+static int omap2_clk_apll96_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
+}
+
+static int omap2_clk_apll54_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
+}
+
+/* Stop APLL */
+static void omap2_clk_apll_disable(struct clk *clk)
+{
+	u32 cval;
+
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+}
+
+/* Public data */
+
+const struct clkops clkops_apll96 = {
+	.enable		= omap2_clk_apll96_enable,
+	.disable	= omap2_clk_apll_disable,
+};
+
+const struct clkops clkops_apll54 = {
+	.enable		= omap2_clk_apll54_enable,
+	.disable	= omap2_clk_apll_disable,
+};
+
+/* Public functions */
+
+u32 omap2xxx_get_apll_clkin(void)
+{
+	u32 aplls, srate = 0;
+
+	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
+	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
+
+	if (aplls == APLLS_CLKIN_19_2MHZ)
+		srate = 19200000;
+	else if (aplls == APLLS_CLKIN_13MHZ)
+		srate = 13000000;
+	else if (aplls == APLLS_CLKIN_12MHZ)
+		srate = 12000000;
+
+	return srate;
+}
+
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 11d6edb..88077e7 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -44,16 +44,6 @@
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 
-
-/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
-#define EN_APLL_STOPPED			0
-#define EN_APLL_LOCKED			3
-
-/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
-#define APLLS_CLKIN_19_2MHZ		0
-#define APLLS_CLKIN_13MHZ		2
-#define APLLS_CLKIN_12MHZ		3
-
 struct clk *vclk, *sclk, *dclk;
 
 void __iomem *prcm_clksrc_ctrl;
@@ -126,80 +116,6 @@ static void omap2_sys_clk_recalc(struct clk *clk)
 }
 #endif	/* OLD_CK */
 
-/* Enable an APLL if off */
-static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
-{
-	u32 cval, apll_mask;
-
-	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
-
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-
-	if ((cval & apll_mask) == apll_mask)
-		return 0;   /* apll already enabled */
-
-	cval &= ~apll_mask;
-	cval |= apll_mask;
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
-
-	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
-			     clk->name);
-
-	/*
-	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
-	 * fails?
-	 */
-	return 0;
-}
-
-static int omap2_clk_apll96_enable(struct clk *clk)
-{
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
-}
-
-static int omap2_clk_apll54_enable(struct clk *clk)
-{
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
-}
-
-/* Stop APLL */
-static void omap2_clk_apll_disable(struct clk *clk)
-{
-	u32 cval;
-
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
-}
-
-const struct clkops clkops_apll96 = {
-	.enable		= omap2_clk_apll96_enable,
-	.disable	= omap2_clk_apll_disable,
-};
-
-const struct clkops clkops_apll54 = {
-	.enable		= omap2_clk_apll54_enable,
-	.disable	= omap2_clk_apll_disable,
-};
-
-static u32 omap2_get_apll_clkin(void)
-{
-	u32 aplls, srate = 0;
-
-	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
-	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
-	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
-
-	if (aplls == APLLS_CLKIN_19_2MHZ)
-		srate = 19200000;
-	else if (aplls == APLLS_CLKIN_13MHZ)
-		srate = 13000000;
-	else if (aplls == APLLS_CLKIN_12MHZ)
-		srate = 12000000;
-
-	return srate;
-}
-
 static u32 omap2_get_sysclkdiv(void)
 {
 	u32 div;
@@ -213,7 +129,7 @@ static u32 omap2_get_sysclkdiv(void)
 
 unsigned long omap2_osc_clk_recalc(struct clk *clk)
 {
-	return omap2_get_apll_clkin() * omap2_get_sysclkdiv();
+	return omap2xxx_get_apll_clkin() * omap2_get_sysclkdiv();
 }
 
 unsigned long omap2_sys_clk_recalc(struct clk *clk)
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index e35efde..3f1672e 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -17,6 +17,7 @@ unsigned long omap2_sys_clk_recalc(struct clk *clk);
 unsigned long omap2_dpllcore_recalc(struct clk *clk);
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
+u32 omap2xxx_get_apll_clkin(void);
 
 /* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420

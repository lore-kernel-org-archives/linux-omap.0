From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/22] omap2 clock: omap2 clock.c: Consolidate wait-for-lock
	code
Date: Thu, 02 Aug 2007 12:10:16 -0600
Message-ID: <20070802181142.901869865@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=consolidate-wait-for-lock.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

omap2 clock.c contains two nearly identical wait-for-clock-enable routines.
Consolidate them into one omap2_wait_clock_ready() function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   77 +++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -42,6 +42,8 @@
 #define CLKSEL_VLYNQ_96MHZ		0
 #define CLKSEL_VLYNQ_CORECLK_16		0x10
 
+#define MAX_PLL_LOCK_WAIT		100000
+
 //#define DOWN_VARIABLE_DPLL 1			/* Experimental */
 
 static struct prcm_config *curr_prcm_set;
@@ -117,10 +119,37 @@ static void omap2_set_osc_ck(int enable)
 			      OMAP24XX_PRCM_CLKSRC_CTRL);
 }
 
+/*
+ * omap2_wait_clock_ready - wait for PLL to lock
+ *
+ * Returns 1 if the PLL locked, 0 if it failed to lock.
+ */
+static int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name)
+{
+	int i = 0;
+
+	/* Wait for lock */
+	while (!(cm_read_reg(reg) & cval)) {
+		++i;
+		udelay(1);
+		if (i == MAX_PLL_LOCK_WAIT) {
+			printk(KERN_ERR "Clock %s didn't lock in %d tries\n",
+			       name, MAX_PLL_LOCK_WAIT);
+			break;
+		}
+	}
+
+	if (i)
+		pr_debug("Clock %s stable after %d loops\n", name, i);
+
+	return (i < MAX_PLL_LOCK_WAIT) ? 1 : 0;
+};
+
+
 /* Enable an APLL if off */
 static void omap2_clk_fixed_enable(struct clk *clk)
 {
-	u32 cval, i=0;
+	u32 cval;
 
 	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
@@ -136,35 +165,27 @@ static void omap2_clk_fixed_enable(struc
 	else if (clk == &apll54_ck)
 		cval = OMAP24XX_ST_54M_CLK;
 
-	/* Wait for lock */
-	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST) & cval)) {
-		++i;
-		udelay(1);
-		if (i == 100000) {
-			printk(KERN_ERR "Clock %s didn't lock\n", clk->name);
-			break;
-		}
-	}
+	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
+			    clk->name);
 }
 
 static void omap2_clk_wait_ready(struct clk *clk)
 {
-	unsigned long reg, other_reg, st_reg;
+	void __iomem *reg, *other_reg, *st_reg;
 	u32 bit;
-	int i;
 
-	reg = (unsigned long) clk->enable_reg;
-	if (reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
-	    reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2))
-		other_reg = (reg & ~0xf0) | 0x10; /* CM_ICLKEN* */
-	else if (reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1) ||
-		 reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2))
-		other_reg = (reg & ~0xf0) | 0x00; /* CM_FCLKEN* */
+	reg = clk->enable_reg;
+	if (reg == OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
+	    reg == OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2))
+		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
+	else if (reg == OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1) ||
+		 reg == OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2))
+		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
 	else
 		return;
 
 	/* No check for DSS or cam clocks */
-	if ((reg & 0x0f) == 0) {
+	if (((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 		if (clk->enable_bit <= 1 || clk->enable_bit == 31)
 			return;
 	}
@@ -172,19 +193,11 @@ static void omap2_clk_wait_ready(struct 
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
-	if (!(cm_read_reg((void __iomem *)other_reg) & bit))
+	if (!(cm_read_reg(other_reg) & bit))
 		return;
-	st_reg = (other_reg & ~0xf0) | 0x20; /* CM_IDLEST* */
-	i = 0;
-	while (!(cm_read_reg((void __iomem *)st_reg) & bit)) {
-		i++;
-		if (i == 100000) {
-			printk(KERN_ERR "Timeout enabling clock %s\n", clk->name);
-			break;
-		}
-	}
-	if (i)
-		pr_debug("Clock %s stable after %d loops\n", clk->name, i);
+	st_reg = (void __iomem *)(((u32)other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+
+	omap2_wait_clock_ready(st_reg, bit, clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count

-- 

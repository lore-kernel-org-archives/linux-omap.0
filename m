From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] omap2 clock: add support for inverted enable bits
Date: Wed, 19 Sep 2007 15:10:02 -0600
Message-ID: <20070919211138.968218917@pwsan.com>
References: <20070919210959.062447046@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_invert_enable.patch
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

On 3430ES2 (and presumably beyond), some clock tree branches from
DPLL3 & 4 can be powered down by setting 'PWRDN' bits in CM_CLKEN_PLL.
It appears that an easy way to power these branches down in our
existing clock framework is to use the PWRDN bits as clock enable bits
for the specific DPLL branches they affect.  The problem with this is
that the meaning of a set PWRDN bit is 'disable,' not 'enable.'  So,
introduce a new clock flag, INVERT_ENABLE, that clears the bit on
'clock enable,' and sets the bit on 'clock disable.'  This flag is used
on all PWRDN clock branches in the 3430 clock framework.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   21 +++++++++++++++++----
 include/asm-arm/arch-omap/clock.h |    3 ++-
 2 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-09-15 17:34:37.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-09-15 17:40:31.000000000 -0600
@@ -166,6 +166,11 @@
 };
 
 
+/*
+ * Note: We don't need special code here for INVERT_ENABLE
+ * for the time being since INVERT_ENABLE only applies to clocks enabled by
+ * CM_CLKEN_PLL
+ */
 static void omap2_clk_wait_ready(struct clk *clk)
 {
 	void __iomem *reg, *other_reg, *st_reg;
@@ -220,7 +225,10 @@
 	}
 
 	regval32 = cm_read_reg(clk->enable_reg);
-	regval32 |= (1 << clk->enable_bit);
+	if (clk->flags & INVERT_ENABLE)
+		regval32 &= ~(1 << clk->enable_bit);
+	else
+		regval32 |= (1 << clk->enable_bit);
 	cm_write_reg(regval32, clk->enable_reg);
 	wmb();
 
@@ -253,7 +261,10 @@
 	}
 
 	regval32 = cm_read_reg(clk->enable_reg);
-	regval32 &= ~(1 << clk->enable_bit);
+	if (clk->flags & INVERT_ENABLE)
+		regval32 |= (1 << clk->enable_bit);
+	else
+		regval32 &= ~(1 << clk->enable_bit);
 	cm_write_reg(regval32, clk->enable_reg);
 	wmb();
 }
@@ -705,10 +716,12 @@
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void __init omap2_clk_disable_unused(struct clk *clk)
 {
-	u32 regval32;
+	u32 regval32, v;
+
+	v = (clk->flags & INVERT_ENABLE) ? (1 << clk->enable_bit) : 0;
 
 	regval32 = cm_read_reg(clk->enable_reg);
-	if ((regval32 & (1 << clk->enable_bit)) == 0)
+	if ((regval32 & (1 << clk->enable_bit)) == v)
 		return;
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-09-15 17:28:20.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-09-15 17:40:31.000000000 -0600
@@ -104,7 +104,8 @@
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
-/* bits 12-20 are currently free */
+#define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
+/* bits 13-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)

-- 

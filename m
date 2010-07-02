From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/20] OMAP: clock: add kerneldoc for structures;
	move flags closer to structs
Date: Fri, 02 Jul 2010 09:29:12 -0600
Message-ID: <20100702152910.6221.66742.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
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
List-Id: linux-omap@vger.kernel.org

Add kerneldoc for struct clk, struct clksel_rate, struct clksel.  Move
flag macros for struct clk.flags and struct clksel_rate.flags closer
to the structures.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/clock.h |  130 ++++++++++++++++++++++++++-----
 1 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index dfc472c..fef4696 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -19,6 +19,22 @@ struct module;
 struct clk;
 struct clockdomain;
 
+/**
+ * struct clkops - some clock function pointers
+ * @enable: fn ptr that enables the current clock in hardware
+ * @disable: fn ptr that enables the current clock in hardware
+ * @find_idlest: function returning the IDLEST register for the clock's IP blk
+ * @find_companion: function returning the "companion" clk reg for the clock
+ *
+ * A "companion" clk is an accompanying clock to the one being queried
+ * that must be enabled for the IP module connected to the clock to
+ * become accessible by the hardware.  Neither @find_idlest nor
+ * @find_companion should be needed; that information is IP
+ * block-specific; the hwmod code has been created to handle this, but
+ * until hwmod data is ready and drivers have been converted to use PM
+ * runtime calls in place of clk_enable()/clk_disable(), @find_idlest and
+ * @find_companion must, unfortunately, remain.
+ */
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
@@ -30,12 +46,45 @@ struct clkops {
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
+/* struct clksel_rate.flags possibilities */
+#define RATE_IN_242X		(1 << 0)
+#define RATE_IN_243X		(1 << 1)
+#define RATE_IN_3XXX		(1 << 2)	/* rates common to all OMAP3 */
+#define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
+#define RATE_IN_36XX		(1 << 4)
+#define RATE_IN_4430		(1 << 5)
+
+#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
+#define RATE_IN_3430ES2PLUS	(RATE_IN_3430ES2 | RATE_IN_36XX)
+
+/**
+ * struct clksel_rate - register bitfield values corresponding to clk divisors
+ * @val: register bitfield value (shifted to bit 0)
+ * @div: clock divisor corresponding to @val
+ * @flags: (see "struct clksel_rate.flags possibilities" above)
+ *
+ * @val should match the value of a read from struct clk.clksel_reg
+ * AND'ed with struct clk.clksel_mask, shifted right to bit 0.
+ *
+ * @div is the divisor that should be applied to the parent clock's rate
+ * to produce the current clock's rate.
+ *
+ * XXX @flags probably should be replaced with an struct omap_chip.
+ */
 struct clksel_rate {
 	u32			val;
 	u8			div;
 	u8			flags;
 };
 
+/**
+ * struct clksel - available parent clocks, and a pointer to their divisors
+ * @parent: struct clk * to a possible parent clock
+ * @rates: available divisors for this parent clock
+ *
+ * A struct clksel is always associated with one or more struct clks
+ * and one or more struct clksel_rates.
+ */
 struct clksel {
 	struct clk		 *parent;
 	const struct clksel_rate *rates;
@@ -116,6 +165,60 @@ struct dpll_data {
 
 #endif
 
+/* struct clk.flags possibilities */
+#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+
+/**
+ * struct clk - OMAP struct clk
+ * @node: list_head connecting this clock into the full clock list
+ * @ops: struct clkops * for this clock
+ * @name: the name of the clock in the hardware (used in hwmod data and debug)
+ * @parent: pointer to this clock's parent struct clk
+ * @children: list_head connecting to the child clks' @sibling list_heads
+ * @sibling: list_head connecting this clk to its parent clk's @children
+ * @rate: current clock rate
+ * @enable_reg: register to write to enable the clock (see @enable_bit)
+ * @recalc: fn ptr that returns the clock's current rate
+ * @set_rate: fn ptr that can change the clock's current rate
+ * @round_rate: fn ptr that can round the clock's current rate
+ * @init: fn ptr to do clock-specific initialization
+ * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
+ * @usecount: number of users that have requested this clock to be enabled
+ * @fixed_div: when > 0, this clock's rate is its parent's rate / @fixed_div
+ * @flags: see "struct clk.flags possibilities" above
+ * @clksel_reg: for clksel clks, register va containing src/divisor select
+ * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
+ * @clksel: for clksel clks, pointer to struct clksel for this clock
+ * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
+ * @clkdm_name: clockdomain name that this clock is contained in
+ * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
+ * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
+ * @src_offset: bitshift for source selection bitfield (OMAP1 only)
+ *
+ * XXX @rate_offset, @src_offset should probably be removed and OMAP1
+ * clock code converted to use clksel.
+ *
+ * XXX @usecount is poorly named.  It should be "enable_count" or
+ * something similar.  "users" in the description refers to kernel
+ * code (core code or drivers) that have called clk_enable() and not
+ * yet called clk_disable(); the usecount of parent clocks is also
+ * incremented by the clock code when clk_enable() is called on child
+ * clocks and decremented by the clock code when clk_disable() is
+ * called on child clocks.
+ *
+ * XXX @clkdm, @usecount, @children, @sibling should be marked for
+ * internal use only.
+ *
+ * @children and @sibling are used to optimize parent-to-child clock
+ * tree traversals.  (child-to-parent traversals use @parent.)
+ *
+ * XXX The notion of the clock's current rate probably needs to be
+ * separated from the clock's target rate.
+ */
 struct clk {
 	struct list_head	node;
 	const struct clkops	*ops;
@@ -129,8 +232,8 @@ struct clk {
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
 	void			(*init)(struct clk *);
-	__u8			enable_bit;
-	__s8			usecount;
+	u8			enable_bit;
+	s8			usecount;
 	u8			fixed_div;
 	u8			flags;
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -141,8 +244,8 @@ struct clk {
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
 #else
-	__u8			rate_offset;
-	__u8			src_offset;
+	u8			rate_offset;
+	u8			src_offset;
 #endif
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 	struct dentry		*dent;	/* For visible tree hierarchy */
@@ -188,23 +291,4 @@ extern const struct clkops clkops_null;
 
 extern struct clk dummy_ck;
 
-/* Clock flags */
-#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
-#define CLOCK_IDLE_CONTROL	(1 << 1)
-#define CLOCK_NO_IDLE_PARENT	(1 << 2)
-#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-
-/* Clksel_rate flags */
-#define RATE_IN_242X		(1 << 0)
-#define RATE_IN_243X		(1 << 1)
-#define RATE_IN_3XXX		(1 << 2)	/* rates common to all OMAP3 */
-#define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
-#define RATE_IN_36XX		(1 << 4)
-#define RATE_IN_4430		(1 << 5)
-
-#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
-
-#define RATE_IN_3430ES2PLUS	(RATE_IN_3430ES2 | RATE_IN_36XX)
-
 #endif

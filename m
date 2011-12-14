From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 5/6] clk: basic gateable and fixed-rate clks
Date: Tue, 13 Dec 2011 19:53:57 -0800
Message-ID: <1323834838-2206-6-git-send-email-mturquette@linaro.org>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1323834838-2206-1-git-send-email-mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Many platforms support simple gateable clks and fixed-rate clks that
should not be re-implemented by every platform.

This patch introduces a gateable clk with a common programming model of
gate control via a write of 1 bit to a register.  Both set-to-enable and
clear-to-enable are supported.

Also introduced is a fixed-rate clk which has no reprogrammable aspects.

The purpose of both types of clks is documented in drivers/clk/basic.c.

TODO: add support for a simple divider, simple mux and a dummy clk for
stubbing out platform support.

Based on original patch by Jeremy Kerr and contribution by Jamie Iles.

Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
---
 drivers/clk/Kconfig     |    7 ++
 drivers/clk/Makefile    |    5 +-
 drivers/clk/clk-basic.c |  208 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h     |   35 ++++++++
 4 files changed, 253 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk-basic.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index adc0586..ba7eb8c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -12,3 +12,10 @@ config HAVE_CLK_PREPARE
 config GENERIC_CLK
 	bool
 	select HAVE_CLK_PREPARE
+
+config GENERIC_CLK_BASIC
+	bool "Basic clock definitions"
+	depends on GENERIC_CLK
+	help
+	   Allow use of basic, single-function clock types.  These
+	   common definitions can be used across many platforms.
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 570d5b9..68b20a1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,3 +1,4 @@
 
-obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
-obj-$(CONFIG_GENERIC_CLK)	+= clk.o
+obj-$(CONFIG_CLKDEV_LOOKUP)		+= clkdev.o
+obj-$(CONFIG_GENERIC_CLK)		+= clk.o
+obj-$(CONFIG_GENERIC_CLK_BASIC)		+= clk-basic.o
diff --git a/drivers/clk/clk-basic.c b/drivers/clk/clk-basic.c
new file mode 100644
index 0000000..a065bc8
--- /dev/null
+++ b/drivers/clk/clk-basic.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
+ * Copyright (C) 2011 Linaro Ltd <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Basic single-function clk implementations
+ */
+
+/* TODO add basic divider clk, basic mux clk and dummy clk */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+
+/*
+ * NOTE: all of the basic clks here are just that: single-function
+ * simple clks.  One assumption in their implementation is that existing
+ * locking mechanisms (prepare_mutex and enable_spinlock) are enough to
+ * prevent race conditions during register accesses.  If this is not
+ * true for your platform then please implement your own version of
+ * these clks which take such issues into account.
+ */
+
+#define to_clk_hw_gate(ck) container_of(ck, struct clk_hw_gate, clk)
+#define to_clk_hw_fixed(ck) container_of(ck, struct clk_hw_fixed, clk)
+
+/**
+ * DOC: basic gatable clock which can gate and ungate it's ouput
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare & clk_unprepare do nothing
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ *
+ * note: parent should not be NULL for this clock, but we check because we're
+ * paranoid
+ */
+
+static unsigned long clk_hw_gate_recalc_rate(struct clk *clk)
+{
+	if (clk->parent)
+		return clk->parent->rate;
+	else
+		return 0;
+}
+
+static struct clk *clk_hw_gate_get_parent(struct clk *clk)
+{
+	return to_clk_hw_gate(clk)->fixed_parent;
+}
+
+static void clk_hw_gate_set_bit(struct clk *clk)
+{
+	struct clk_hw_gate *gate = to_clk_hw_gate(clk);
+	u32 reg;
+
+	reg = readl(gate->reg);
+	reg |= BIT(gate->bit_idx);
+	writel(reg, gate->reg);
+}
+
+static void clk_hw_gate_clear_bit(struct clk *clk)
+{
+	struct clk_hw_gate *gate = to_clk_hw_gate(clk);
+	u32 reg;
+
+	reg = readl(gate->reg);
+	reg &= ~BIT(gate->bit_idx);
+	writel(reg, gate->reg);
+}
+
+static int clk_hw_gate_enable_set(struct clk *clk)
+{
+	clk_hw_gate_set_bit(clk);
+
+	return 0;
+}
+
+static void clk_hw_gate_disable_clear(struct clk *clk)
+{
+	clk_hw_gate_clear_bit(clk);
+}
+
+struct clk_hw_ops clk_hw_gate_set_enable_ops = {
+	.enable = clk_hw_gate_enable_set,
+	.disable = clk_hw_gate_disable_clear,
+	.recalc_rate = clk_hw_gate_recalc_rate,
+	.get_parent = clk_hw_gate_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_hw_gate_set_enable_ops);
+
+static int clk_hw_gate_enable_clear(struct clk *clk)
+{
+	clk_hw_gate_clear_bit(clk);
+
+	return 0;
+}
+
+static void clk_hw_gate_disable_set(struct clk *clk)
+{
+	clk_hw_gate_set_bit(clk);
+}
+
+struct clk_hw_ops clk_hw_gate_set_disable_ops = {
+	.enable = clk_hw_gate_enable_clear,
+	.disable = clk_hw_gate_disable_set,
+	.recalc_rate = clk_hw_gate_recalc_rate,
+	.get_parent = clk_hw_gate_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_hw_gate_set_disable_ops);
+
+int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
+		struct clk *fixed_parent, void __iomem *reg, u8 bit_idx,
+		int set_to_enable)
+{
+	struct clk_hw_gate *gclk;
+	struct clk *clk;
+
+	gclk = kmalloc(sizeof(struct clk_hw_gate), GFP_KERNEL);
+
+	if (!gclk) {
+		pr_err("%s: could not allocate gated clk\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk = &gclk->clk;
+
+	/* struct clk_hw_gate assignments */
+	gclk->fixed_parent = fixed_parent;
+	gclk->reg = reg;
+	gclk->bit_idx = bit_idx;
+
+	/* struct clk assignments */
+	clk->name = name;
+	clk->flags = flags;
+
+	if (set_to_enable)
+		clk->ops = &clk_hw_gate_set_enable_ops;
+	else
+		clk->ops = &clk_hw_gate_set_disable_ops;
+
+	clk_init(NULL, clk);
+
+	return 0;
+}
+
+/*
+ * DOC: basic fixed-rate clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clock never gates.  clk_prepare & clk_unprepare do nothing
+ * enable - clock never gates.  clk_enable & clk_disable do nothing
+ * rate - rate is always a fixed value.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ *
+ * note: parent can be NULL, which implies that this clock is a root clock.
+ */
+
+static unsigned long clk_hw_fixed_recalc_rate(struct clk *clk)
+{
+	return to_clk_hw_fixed(clk)->fixed_rate;
+}
+
+static struct clk *clk_hw_fixed_get_parent(struct clk *clk)
+{
+	return to_clk_hw_fixed(clk)->fixed_parent;
+}
+
+struct clk_hw_ops clk_hw_fixed_ops = {
+	.recalc_rate = clk_hw_fixed_recalc_rate,
+	.get_parent = clk_hw_fixed_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_hw_fixed_ops);
+
+int clk_register_fixed(struct device *dev, const char *name,
+		unsigned long flags, struct clk *fixed_parent,
+		unsigned long fixed_rate)
+{
+	struct clk_hw_fixed *fclk;
+	struct clk *clk;
+
+	fclk = kmalloc(sizeof(struct clk_hw_fixed), GFP_KERNEL);
+
+	if (!fclk) {
+		pr_err("%s: could not allocate fixed clk\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk = &fclk->clk;
+
+	/* struct clk_hw_fixed assignments */
+	fclk->fixed_parent = fixed_parent;
+	fclk->fixed_rate = fixed_rate;
+
+	/* struct clk assignments */
+	clk->name = name;
+	clk->flags = flags;
+	clk->ops = &clk_hw_fixed_ops;
+
+	clk_init(NULL, clk);
+
+	return 0;
+}
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 63a72f2..55049ee 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -131,6 +131,41 @@ struct clk_hw_ops {
 	int		(*set_rate)(struct clk *clk, unsigned long);
 };
 
+/*
+ * Base clock implementations. Platform clock implementations can use these
+ * directly, or 'subclass' as approprate
+ */
+
+#ifdef CONFIG_GENERIC_CLK_BASIC
+
+struct clk_hw_fixed {
+	struct clk	clk;
+	struct clk	*fixed_parent;
+	unsigned long	fixed_rate;
+};
+
+extern struct clk_hw_ops clk_hw_fixed_ops;
+
+int clk_register_fixed(struct device *dev, const char *name,
+		unsigned long flags, struct clk *fixed_parent,
+		unsigned long fixed_rate);
+
+struct clk_hw_gate {
+	struct clk	clk;
+	struct clk	*fixed_parent;
+	void __iomem	*reg;
+	u8		bit_idx;
+};
+
+extern struct clk_hw_ops clk_hw_gate_set_enable_ops;
+extern struct clk_hw_ops clk_hw_gate_set_disable_ops;
+
+int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
+		struct clk *fixed_parent, void __iomem *reg, u8 bit_idx,
+		int set_to_enable);
+
+#endif
+
 /**
  * clk_init - initialize the data structures in a struct clk
  * @dev: device initializing this clk, placeholder for now
-- 
1.7.5.4

From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/11] clk: ti: add core support for initializing legacy clocks
Date: Tue, 16 Dec 2014 18:20:46 +0200
Message-ID: <1418746856-17173-2-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47451 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaLPQT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 11:19:59 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data for OMAP3 is being moved under clock driver, thus
base support for this is needed. This patch adds basic definitions for
clock init descriptors and core infrastructure for initialization,
which will be called from the OMAP3 clock init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   |  110 +++++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h |  160 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 drivers/clk/ti/clock.h

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 337abe5..a8958f1 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -22,6 +22,8 @@
 #include <linux/of_address.h>
 #include <linux/list.h>
 
+#include "clock.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
@@ -183,3 +185,111 @@ void ti_dt_clk_init_retry_clks(void)
 		retries--;
 	}
 }
+
+void __init ti_clk_patch_legacy_clks(struct ti_clk **patch)
+{
+	while (*patch) {
+		memcpy((*patch)->patch, *patch, sizeof(**patch));
+		patch++;
+	}
+}
+
+struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
+{
+	struct clk *clk;
+	struct ti_clk_fixed *fixed;
+	struct ti_clk_fixed_factor *fixed_factor;
+	struct clk_hw *clk_hw;
+
+	if (setup->clk)
+		return setup->clk;
+
+	switch (setup->type) {
+	case TI_CLK_FIXED:
+		fixed = setup->data;
+
+		clk = clk_register_fixed_rate(NULL, setup->name, NULL,
+					      CLK_IS_ROOT, fixed->frequency);
+		break;
+	case TI_CLK_FIXED_FACTOR:
+		fixed_factor = setup->data;
+
+		clk = clk_register_fixed_factor(NULL, setup->name,
+						fixed_factor->parent,
+						0, fixed_factor->mult,
+						fixed_factor->div);
+		break;
+	default:
+		pr_err("bad type for %s!\n", setup->name);
+		clk = ERR_PTR(-EINVAL);
+	}
+
+	if (!IS_ERR(clk)) {
+		setup->clk = clk;
+		if (setup->clkdm_name) {
+			if (__clk_get_flags(clk) & CLK_IS_BASIC) {
+				pr_warn("can't setup clkdm for basic clk %s\n",
+					setup->name);
+			} else {
+				clk_hw = __clk_get_hw(clk);
+				to_clk_hw_omap(clk_hw)->clkdm_name =
+					setup->clkdm_name;
+				omap2_init_clk_clkdm(clk_hw);
+			}
+		}
+	}
+
+	return clk;
+}
+
+int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
+{
+	struct clk *clk;
+	bool retry;
+	struct ti_clk_alias *retry_clk;
+	struct ti_clk_alias *tmp;
+
+	while (clks->clk) {
+		clk = ti_clk_register_clk(clks->clk);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) == -EAGAIN) {
+				list_add(&clks->link, &retry_list);
+			} else {
+				pr_err("register for %s failed: %ld\n",
+				       clks->clk->name, PTR_ERR(clk));
+				return PTR_ERR(clk);
+			}
+		} else {
+			clks->lk.clk = clk;
+			clkdev_add(&clks->lk);
+		}
+		clks++;
+	}
+
+	retry = true;
+
+	while (!list_empty(&retry_list) && retry) {
+		retry = false;
+		list_for_each_entry_safe(retry_clk, tmp, &retry_list, link) {
+			pr_debug("retry-init: %s\n", retry_clk->clk->name);
+			clk = ti_clk_register_clk(retry_clk->clk);
+			if (IS_ERR(clk)) {
+				if (PTR_ERR(clk) == -EAGAIN) {
+					continue;
+				} else {
+					pr_err("register for %s failed: %ld\n",
+					       retry_clk->clk->name,
+					       PTR_ERR(clk));
+					return PTR_ERR(clk);
+				}
+			} else {
+				retry = true;
+				retry_clk->lk.clk = clk;
+				clkdev_add(&retry_clk->lk);
+				list_del(&retry_clk->link);
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
new file mode 100644
index 0000000..6ee6c6e
--- /dev/null
+++ b/drivers/clk/ti/clock.h
@@ -0,0 +1,160 @@
+/*
+ * TI Clock driver internal definitions
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc
+ *     Tero Kristo (t-kristo@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DRIVERS_CLK_TI_CLOCK__
+#define __DRIVERS_CLK_TI_CLOCK__
+
+enum {
+	TI_CLK_FIXED,
+	TI_CLK_MUX,
+	TI_CLK_DIVIDER,
+	TI_CLK_COMPOSITE,
+	TI_CLK_FIXED_FACTOR,
+	TI_CLK_GATE,
+	TI_CLK_DPLL,
+};
+
+/* Global flags */
+#define CLKF_INDEX_POWER_OF_TWO		(1 << 0)
+#define CLKF_INDEX_STARTS_AT_ONE	(1 << 1)
+#define CLKF_SET_RATE_PARENT		(1 << 2)
+#define CLKF_OMAP3			(1 << 3)
+#define CLKF_AM35XX			(1 << 4)
+
+/* Gate flags */
+#define CLKF_SET_BIT_TO_DISABLE		(1 << 5)
+#define CLKF_INTERFACE			(1 << 6)
+#define CLKF_SSI			(1 << 7)
+#define CLKF_DSS			(1 << 8)
+#define CLKF_HSOTGUSB			(1 << 9)
+#define CLKF_WAIT			(1 << 10)
+#define CLKF_NO_WAIT			(1 << 11)
+#define CLKF_HSDIV			(1 << 12)
+#define CLKF_CLKDM			(1 << 13)
+
+/* DPLL flags */
+#define CLKF_LOW_POWER_STOP		(1 << 5)
+#define CLKF_LOCK			(1 << 6)
+#define CLKF_LOW_POWER_BYPASS		(1 << 7)
+#define CLKF_PER			(1 << 8)
+#define CLKF_CORE			(1 << 9)
+#define CLKF_J_TYPE			(1 << 10)
+
+#define CLK(dev, con, ck)		\
+	{				\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+		},			\
+		.clk = ck,		\
+	}
+
+struct ti_clk {
+	const char *name;
+	const char *clkdm_name;
+	int type;
+	void *data;
+	struct ti_clk *patch;
+	struct clk *clk;
+};
+
+struct ti_clk_alias {
+	struct ti_clk *clk;
+	struct clk_lookup lk;
+	struct list_head link;
+};
+
+struct ti_clk_fixed {
+	u32 frequency;
+	u16 flags;
+};
+
+struct ti_clk_mux {
+	u8 bit_shift;
+	int num_parents;
+	u16 reg;
+	u8 module;
+	const char **parents;
+	u16 flags;
+};
+
+struct ti_clk_divider {
+	const char *parent;
+	u8 bit_shift;
+	u16 max_div;
+	u16 reg;
+	u8 module;
+	int *dividers;
+	int num_dividers;
+	u16 flags;
+};
+
+struct ti_clk_fixed_factor {
+	const char *parent;
+	u16 div;
+	u16 mult;
+	u16 flags;
+};
+
+struct ti_clk_gate {
+	const char *parent;
+	u8 bit_shift;
+	u16 reg;
+	u8 module;
+	u16 flags;
+};
+
+struct ti_clk_composite {
+	struct ti_clk_divider *divider;
+	struct ti_clk_mux *mux;
+	struct ti_clk_gate *gate;
+	u16 flags;
+};
+
+struct ti_clk_clkdm_gate {
+	const char *parent;
+	u16 flags;
+};
+
+struct ti_clk_dpll {
+	int num_parents;
+	u16 control_reg;
+	u16 idlest_reg;
+	u16 autoidle_reg;
+	u16 mult_div1_reg;
+	u8 module;
+	const char **parents;
+	u16 flags;
+	u8 modes;
+	u32 mult_mask;
+	u32 div1_mask;
+	u32 enable_mask;
+	u32 autoidle_mask;
+	u32 freqsel_mask;
+	u32 idlest_mask;
+	u32 dco_mask;
+	u32 sddiv_mask;
+	u16 max_multiplier;
+	u16 max_divider;
+	u8 auto_recal_bit;
+	u8 recal_en_bit;
+	u8 recal_st_bit;
+};
+
+void ti_clk_patch_legacy_clks(struct ti_clk **patch);
+struct clk *ti_clk_register_clk(struct ti_clk *setup);
+int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
+
+#endif
-- 
1.7.9.5


From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 5/9] ARM: OMAP: clock: add DT duplicate clock registration mechanism
Date: Tue, 25 Jun 2013 15:38:29 +0300
Message-ID: <1372163913-16566-6-git-send-email-t-kristo@ti.com>
References: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51261 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab3FYMj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 08:39:26 -0400
In-Reply-To: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |   16 ++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0c38ca9..6fe14b5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -584,6 +584,45 @@ void __init omap_clocks_register(struct omap_clk oclks[], int cnt)
 }
 
 /**
+ * omap_dt_clocks_register - register DT duplicate clocks during boot
+ * @oclks: list of clocks to register
+ * @cnt: number of clocks
+ *
+ * Register duplicate or non-standard DT clock entries during boot. By
+ * default, DT clocks are found based on their node name. If any
+ * additional con-id / dev-id -> clock mapping is required, use this
+ * function to list these.
+ */
+void __init omap_dt_clocks_register(struct omap_dt_clk oclks[], int cnt)
+{
+	struct omap_dt_clk *c;
+	struct device_node *n;
+	struct clk *clk;
+	struct of_phandle_args clkspec;
+
+	for (c = oclks; c < oclks + cnt; c++) {
+		n = of_find_node_by_name(NULL, c->node_name);
+
+		if (!n) {
+			pr_err("%s: %s not found!\n", __func__, c->node_name);
+			continue;
+		}
+
+		clkspec.np = n;
+
+		clk = of_clk_get_from_provider(&clkspec);
+
+		if (!clk) {
+			pr_err("%s: %s has no clock!\n", __func__,
+				c->node_name);
+			continue;
+		}
+		c->lk.clk = clk;
+		clkdev_add(&c->lk);
+	}
+}
+
+/**
  * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
  * @mpurate_ck_name: clk name of the clock to change rate
  *
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 3238c57..1c1fbe4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -37,6 +37,21 @@ struct omap_clk {
 		},			\
 	}
 
+struct omap_dt_clk {
+	u16				cpu;
+	struct clk_lookup		lk;
+	const char			*node_name;
+};
+
+#define DT_CLK(dev, con, name)		\
+	{				\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+		},			\
+		.node_name = name,	\
+	}
+
 struct clockdomain;
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
@@ -316,4 +331,5 @@ extern const struct clksel_rate div31_1to31_rates[];
 extern int am33xx_clk_init(void);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
+extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
 #endif
-- 
1.7.9.5


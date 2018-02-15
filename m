From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/5] clk: ti: add generic support for clock latching
Date: Thu, 15 Feb 2018 14:49:49 +0200
Message-ID: <1518698991-10099-4-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Certain clocks require latching to be done, so that the actual
settings get updated on the HW that generates the clock signal.
One example of such a clock is the dra76x GMAC DPLL H14 output,
which requires its divider settings to be latched when updated.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 14 ++++++++++++++
 drivers/clk/ti/clock.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 4efa2c9..7d22e1a 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -275,6 +275,20 @@ int ti_clk_get_reg_addr(struct device_node *node, int index,
 	return 0;
 }
 
+void ti_clk_latch(struct clk_omap_reg *reg, s8 shift)
+{
+	u32 latch;
+
+	if (shift < 0)
+		return;
+
+	latch = 1 << shift;
+
+	ti_clk_ll_ops->clk_rmw(latch, latch, reg);
+	ti_clk_ll_ops->clk_rmw(0, latch, reg);
+	ti_clk_ll_ops->clk_readl(reg); /* OCP barrier */
+}
+
 /**
  * omap2_clk_provider_init - init master clock provider
  * @parent: master node
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index d9b43bf..2f8af8f 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -194,6 +194,8 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
+void ti_clk_latch(struct clk_omap_reg *reg, s8 shift);
+
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
 
 int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

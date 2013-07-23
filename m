From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 15/33] CLK: OMAP: DPLL: add support for DT property ti,dpll-no-gate
Date: Tue, 23 Jul 2013 10:20:10 +0300
Message-ID: <1374564028-11352-16-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254Ab3GWHWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:38 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

AM335x has DPLL clocks that should never be attempted to be gated. Adding
ti,dpll-no-gate property for them handles this situation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/dpll.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
index 66e82be..1d24feada 100644
--- a/drivers/clk/omap/dpll.c
+++ b/drivers/clk/omap/dpll.c
@@ -54,6 +54,13 @@ static const struct clk_ops dpll_x2_ck_ops = {
 	.recalc_rate	= &omap3_clkoutx2_recalc,
 };
 
+static const struct clk_ops dpll_no_gate_ck_ops = {
+	.recalc_rate	= &omap3_dpll_recalc,
+	.get_parent	= &omap2_init_dpll_parent,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+};
+
 struct clk *omap_clk_register_dpll(struct device *dev, const char *name,
 		const char **parent_names, int num_parents, unsigned long flags,
 		struct dpll_data *dpll_data, const char *clkdm_name,
@@ -288,6 +295,9 @@ __init void of_omap4_dpll_setup(struct device_node *node)
 		return;
 	}
 
+	if (of_property_read_bool(node, "ti,dpll-no-gate"))
+		ops = &dpll_no_gate_ck_ops;
+
 	of_omap_dpll_setup(node, ops);
 }
 EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
-- 
1.7.9.5


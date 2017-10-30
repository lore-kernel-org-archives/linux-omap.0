From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/27] clk: ti: clkctrl: add support for clkdm init for clkctrl clocks
Date: Mon, 30 Oct 2017 15:04:20 +0200
Message-ID: <1509368685-29112-3-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Clkctrl clocks now support clockdomain init also. This will be needed
so that hwmod core can drop the support for clockdomain handling.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 22 ++++++++++++++++++++++
 drivers/clk/ti/clock.h   |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 2db7d40..284ba449 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -46,6 +46,7 @@
 struct omap_clkctrl_provider {
 	void __iomem *base;
 	struct list_head clocks;
+	char *clkdm_name;
 };
 
 struct omap_clkctrl_clk {
@@ -208,6 +209,7 @@ static int _omap4_clkctrl_clk_is_enabled(struct clk_hw *hw)
 	.enable		= _omap4_clkctrl_clk_enable,
 	.disable	= _omap4_clkctrl_clk_disable,
 	.is_enabled	= _omap4_clkctrl_clk_is_enabled,
+	.init		= omap2_init_clk_clkdm,
 };
 
 static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
@@ -438,6 +440,21 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 
 	provider->base = of_iomap(node, 0);
 
+	provider->clkdm_name = kmalloc(strlen(node->parent->name) + 3,
+				       GFP_KERNEL);
+	if (!provider->clkdm_name) {
+		kfree(provider);
+		return;
+	}
+
+	/*
+	 * Create default clkdm name, replace _cm from end of parent node
+	 * name with _clkdm
+	 */
+	strcpy(provider->clkdm_name, node->parent->name);
+	provider->clkdm_name[strlen(provider->clkdm_name) - 2] = 0;
+	strcat(provider->clkdm_name, "clkdm");
+
 	INIT_LIST_HEAD(&provider->clocks);
 
 	/* Generate clocks */
@@ -460,6 +477,11 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		if (reg_data->flags & CLKF_NO_IDLEST)
 			hw->flags |= NO_IDLEST;
 
+		if (reg_data->clkdm_name)
+			hw->clkdm_name = reg_data->clkdm_name;
+		else
+			hw->clkdm_name = provider->clkdm_name;
+
 		init.parent_names = &reg_data->parent;
 		init.num_parents = 1;
 		init.flags = 0;
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 561dbe9..169241f 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -221,6 +221,7 @@ struct omap_clkctrl_reg_data {
 	const struct omap_clkctrl_bit_data *bit_data;
 	u16 flags;
 	const char *parent;
+	const char *clkdm_name;
 };
 
 struct omap_clkctrl_data {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

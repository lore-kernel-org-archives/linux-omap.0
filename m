From: Rob Herring <robh@kernel.org>
Subject: [PATCH] clk: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:13 -0500
Message-ID: <20180828015252.28511-12-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/axs10x/pll_clock.c      |  4 ++--
 drivers/clk/bcm/clk-kona-setup.c    | 22 +++++++++++-----------
 drivers/clk/clk-asm9260.c           |  4 ++--
 drivers/clk/clk-cdce925.c           | 10 +++++-----
 drivers/clk/clk-fixed-factor.c      |  8 ++++----
 drivers/clk/clk-gpio.c              |  8 ++++----
 drivers/clk/clk-hsdk-pll.c          |  4 ++--
 drivers/clk/clk-nomadik.c           |  4 ++--
 drivers/clk/clk-npcm7xx.c           |  2 +-
 drivers/clk/clk-palmas.c            |  4 ++--
 drivers/clk/clk-qoriq.c             | 14 +++++++-------
 drivers/clk/clk-scmi.c              |  2 +-
 drivers/clk/clk-scpi.c              |  6 +++---
 drivers/clk/clk-si5351.c            |  4 ++--
 drivers/clk/clk-stm32f4.c           |  2 +-
 drivers/clk/clk-stm32h7.c           |  2 +-
 drivers/clk/clk-stm32mp1.c          |  2 +-
 drivers/clk/clk-tango4.c            | 10 +++++-----
 drivers/clk/keystone/gate.c         |  2 +-
 drivers/clk/keystone/pll.c          |  2 +-
 drivers/clk/renesas/clk-div6.c      | 12 ++++++------
 drivers/clk/renesas/clk-emev2.c     |  8 ++++----
 drivers/clk/renesas/clk-mstp.c      |  8 ++++----
 drivers/clk/renesas/clk-r8a73a4.c   |  4 ++--
 drivers/clk/renesas/clk-r8a7740.c   |  4 ++--
 drivers/clk/renesas/clk-r8a7778.c   |  4 ++--
 drivers/clk/renesas/clk-r8a7779.c   |  4 ++--
 drivers/clk/renesas/clk-rcar-gen2.c |  4 ++--
 drivers/clk/renesas/clk-rz.c        |  4 ++--
 drivers/clk/renesas/clk-sh73a0.c    |  4 ++--
 drivers/clk/st/clkgen-fsyn.c        |  2 +-
 drivers/clk/sunxi/clk-mod0.c        |  6 +++---
 drivers/clk/sunxi/clk-sun9i-core.c  | 20 ++++++++++----------
 drivers/clk/sunxi/clk-sunxi.c       |  4 ++--
 drivers/clk/ti/apll.c               | 18 +++++++++---------
 drivers/clk/ti/clk-dra7-atl.c       |  4 ++--
 drivers/clk/ti/clk.c                | 10 +++++-----
 drivers/clk/ti/clkctrl.c            | 14 ++++++--------
 drivers/clk/ti/composite.c          | 14 +++++++-------
 drivers/clk/ti/divider.c            |  4 ++--
 drivers/clk/ti/dpll.c               | 12 ++++++------
 drivers/clk/ti/fapll.c              |  8 ++++----
 drivers/clk/ti/fixed-factor.c       |  4 ++--
 drivers/clk/ti/gate.c               |  2 +-
 drivers/clk/ti/interface.c          |  2 +-
 drivers/clk/ti/mux.c                |  4 ++--
 drivers/clk/zynq/clkc.c             |  4 ++--
 47 files changed, 151 insertions(+), 153 deletions(-)

diff --git a/drivers/clk/axs10x/pll_clock.c b/drivers/clk/axs10x/pll_clock.c
index 25d8c240ddfb..c68dada97316 100644
--- a/drivers/clk/axs10x/pll_clock.c
+++ b/drivers/clk/axs10x/pll_clock.c
@@ -301,13 +301,13 @@ static void __init of_axs10x_pll_clk_setup(struct device_node *node)
 
 	ret = clk_hw_register(NULL, &pll_clk->hw);
 	if (ret) {
-		pr_err("failed to register %s clock\n", node->name);
+		pr_err("failed to register %pOFn clock\n", node);
 		goto err_unmap_lock;
 	}
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &pll_clk->hw);
 	if (ret) {
-		pr_err("failed to add hw provider for %s clock\n", node->name);
+		pr_err("failed to add hw provider for %pOFn clock\n", node);
 		goto err_unregister_clk;
 	}
 
diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index 281f4322355c..e65eeef9cbaf 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -808,29 +808,29 @@ void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
-		pr_err("%s: no valid CCU registers found for %s\n", __func__,
-			node->name);
+		pr_err("%s: no valid CCU registers found for %pOFn\n", __func__,
+			node);
 		goto out_err;
 	}
 
 	range = resource_size(&res);
 	if (range > (resource_size_t)U32_MAX) {
-		pr_err("%s: address range too large for %s\n", __func__,
-			node->name);
+		pr_err("%s: address range too large for %pOFn\n", __func__,
+			node);
 		goto out_err;
 	}
 
 	ccu->range = (u32)range;
 
 	if (!ccu_data_valid(ccu)) {
-		pr_err("%s: ccu data not valid for %s\n", __func__, node->name);
+		pr_err("%s: ccu data not valid for %pOFn\n", __func__, node);
 		goto out_err;
 	}
 
 	ccu->base = ioremap(res.start, ccu->range);
 	if (!ccu->base) {
-		pr_err("%s: unable to map CCU registers for %s\n", __func__,
-			node->name);
+		pr_err("%s: unable to map CCU registers for %pOFn\n", __func__,
+			node);
 		goto out_err;
 	}
 	ccu->node = of_node_get(node);
@@ -848,16 +848,16 @@ void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 
 	ret = of_clk_add_hw_provider(node, of_clk_kona_onecell_get, ccu);
 	if (ret) {
-		pr_err("%s: error adding ccu %s as provider (%d)\n", __func__,
-				node->name, ret);
+		pr_err("%s: error adding ccu %pOFn as provider (%d)\n", __func__,
+				node, ret);
 		goto out_err;
 	}
 
 	if (!kona_ccu_init(ccu))
-		pr_err("Broadcom %s initialization had errors\n", node->name);
+		pr_err("Broadcom %pOFn initialization had errors\n", node);
 
 	return;
 out_err:
 	kona_ccu_teardown(ccu);
-	pr_err("Broadcom %s setup aborted\n", node->name);
+	pr_err("Broadcom %pOFn setup aborted\n", node);
 }
diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 44b544157121..d571a00b5282 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -281,7 +281,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 
 	base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(base))
-		panic("%s: unable to map resource", np->name);
+		panic("%pOFn: unable to map resource", np);
 
 	/* register pll */
 	rate = (ioread32(base + HW_SYSPLLCTRL) & 0xffff) * 1000000;
@@ -292,7 +292,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 			ref_clk, 0, rate, accuracy);
 
 	if (IS_ERR(hw))
-		panic("%s: can't register REFCLK. Check DT!", np->name);
+		panic("%pOFn: can't register REFCLK. Check DT!", np);
 
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_clks); n++) {
 		const struct asm9260_mux_clock *mc = &asm9260_mux_clks[n];
diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 0a7e7d5a7506..49531a2a5436 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -669,8 +669,8 @@ static int cdce925_probe(struct i2c_client *client,
 
 	/* Register PLL clocks */
 	for (i = 0; i < data->chip_info->num_plls; ++i) {
-		pll_clk_name[i] = kasprintf(GFP_KERNEL, "%s.pll%d",
-			client->dev.of_node->name, i);
+		pll_clk_name[i] = kasprintf(GFP_KERNEL, "%pOFn.pll%d",
+			client->dev.of_node, i);
 		init.name = pll_clk_name[i];
 		data->pll[i].chip = data;
 		data->pll[i].hw.init = &init;
@@ -710,7 +710,7 @@ static int cdce925_probe(struct i2c_client *client,
 	init.flags = 0;
 	init.num_parents = 1;
 	init.parent_names = &parent_name; /* Mux Y1 to input */
-	init.name = kasprintf(GFP_KERNEL, "%s.Y1", client->dev.of_node->name);
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.Y1", client->dev.of_node);
 	data->clk[0].chip = data;
 	data->clk[0].hw.init = &init;
 	data->clk[0].index = 0;
@@ -727,8 +727,8 @@ static int cdce925_probe(struct i2c_client *client,
 	init.flags = CLK_SET_RATE_PARENT;
 	init.num_parents = 1;
 	for (i = 1; i < data->chip_info->num_outputs; ++i) {
-		init.name = kasprintf(GFP_KERNEL, "%s.Y%d",
-			client->dev.of_node->name, i+1);
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.Y%d",
+			client->dev.of_node, i+1);
 		data->clk[i].chip = data;
 		data->clk[i].hw.init = &init;
 		data->clk[i].index = i;
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 20724abd38bd..ef0ca9414f37 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -158,14 +158,14 @@ static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
 	int ret;
 
 	if (of_property_read_u32(node, "clock-div", &div)) {
-		pr_err("%s Fixed factor clock <%s> must have a clock-div property\n",
-			__func__, node->name);
+		pr_err("%s Fixed factor clock <%pOFn> must have a clock-div property\n",
+			__func__, node);
 		return ERR_PTR(-EIO);
 	}
 
 	if (of_property_read_u32(node, "clock-mult", &mult)) {
-		pr_err("%s Fixed factor clock <%s> must have a clock-mult property\n",
-			__func__, node->name);
+		pr_err("%s Fixed factor clock <%pOFn> must have a clock-mult property\n",
+			__func__, node);
 		return ERR_PTR(-EIO);
 	}
 
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 40af4fbab4d2..6a43ce420492 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -233,11 +233,11 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	if (IS_ERR(gpiod)) {
 		ret = PTR_ERR(gpiod);
 		if (ret == -EPROBE_DEFER)
-			pr_debug("%s: %s: GPIOs not yet available, retry later\n",
-					node->name, __func__);
+			pr_debug("%pOFn: %s: GPIOs not yet available, retry later\n",
+					node, __func__);
 		else
-			pr_err("%s: %s: Can't get '%s' named GPIO property\n",
-					node->name, __func__,
+			pr_err("%pOFn: %s: Can't get '%s' named GPIO property\n",
+					node, __func__,
 					gpio_name);
 		return ret;
 	}
diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index c4ee280f454d..a47c2b600f20 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -390,13 +390,13 @@ static void __init of_hsdk_pll_clk_setup(struct device_node *node)
 
 	ret = clk_hw_register(NULL, &pll_clk->hw);
 	if (ret) {
-		pr_err("failed to register %s clock\n", node->name);
+		pr_err("failed to register %pOFn clock\n", node);
 		goto err_unmap_spec_regs;
 	}
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &pll_clk->hw);
 	if (ret) {
-		pr_err("failed to add hw provider for %s clock\n", node->name);
+		pr_err("failed to add hw provider for %pOFn clock\n", node);
 		goto err_unmap_spec_regs;
 	}
 
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 13ad6d1e5090..84a24875c629 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -97,8 +97,8 @@ static void __init nomadik_src_init(void)
 	}
 	src_base = of_iomap(np, 0);
 	if (!src_base) {
-		pr_err("%s: must have src parent node with REGS (%s)\n",
-		       __func__, np->name);
+		pr_err("%s: must have src parent node with REGS (%pOFn)\n",
+		       __func__, np);
 		return;
 	}
 
diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 740af90a9508..afb0eb106953 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -549,7 +549,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 
 	ret = of_address_to_resource(clk_np, 0, &res);
 	if (ret) {
-		pr_err("%s: failed to get resource, ret %d\n", clk_np->name,
+		pr_err("%pOFn: failed to get resource, ret %d\n", clk_np,
 			ret);
 		return;
 	}
diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
index 7f51c01085ab..e9612e7068e9 100644
--- a/drivers/clk/clk-palmas.c
+++ b/drivers/clk/clk-palmas.c
@@ -195,8 +195,8 @@ static void palmas_clks_get_clk_data(struct platform_device *pdev,
 		prop = PALMAS_EXT_CONTROL_NSLEEP;
 		break;
 	default:
-		dev_warn(&pdev->dev, "%s: Invalid ext control option: %u\n",
-			 node->name, prop);
+		dev_warn(&pdev->dev, "%pOFn: Invalid ext control option: %u\n",
+			 node, prop);
 		prop = 0;
 		break;
 	}
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f65e5d..4c30b6e799ed 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -945,8 +945,8 @@ static void __init core_mux_init(struct device_node *np)
 
 	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
 	if (rc) {
-		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
-		       __func__, np->name, rc);
+		pr_err("%s: Couldn't register clk provider for node %pOFn: %d\n",
+		       __func__, np, rc);
 		return;
 	}
 }
@@ -1199,8 +1199,8 @@ static void __init legacy_pll_init(struct device_node *np, int idx)
 
 	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
 	if (rc) {
-		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
-		       __func__, np->name, rc);
+		pr_err("%s: Couldn't register clk provider for node %pOFn: %d\n",
+		       __func__, np, rc);
 		goto err_cell;
 	}
 
@@ -1360,7 +1360,7 @@ static void __init clockgen_init(struct device_node *np)
 		is_old_ls1021a = true;
 	}
 	if (!clockgen.regs) {
-		pr_err("%s(): %s: of_iomap() failed\n", __func__, np->name);
+		pr_err("%s(): %pOFn: of_iomap() failed\n", __func__, np);
 		return;
 	}
 
@@ -1406,8 +1406,8 @@ static void __init clockgen_init(struct device_node *np)
 
 	ret = of_clk_add_provider(np, clockgen_clk_get, &clockgen);
 	if (ret) {
-		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
-		       __func__, np->name, ret);
+		pr_err("%s: Couldn't register clk provider for node %pOFn: %d\n",
+		       __func__, np, ret);
 	}
 
 	return;
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index a985bf5e1ac6..a2287c770d5c 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -132,7 +132,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 
 	count = handle->clk_ops->count_get(handle);
 	if (count < 0) {
-		dev_err(dev, "%s: invalid clock output count\n", np->name);
+		dev_err(dev, "%pOFn: invalid clock output count\n", np);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 25854722810e..d3ccc1cfccd5 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -207,7 +207,7 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 
 	count = of_property_count_strings(np, "clock-output-names");
 	if (count < 0) {
-		dev_err(dev, "%s: invalid clock output count\n", np->name);
+		dev_err(dev, "%pOFn: invalid clock output count\n", np);
 		return -EINVAL;
 	}
 
@@ -232,13 +232,13 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 
 		if (of_property_read_string_index(np, "clock-output-names",
 						  idx, &name)) {
-			dev_err(dev, "invalid clock name @ %s\n", np->name);
+			dev_err(dev, "invalid clock name @ %pOFn\n", np);
 			return -EINVAL;
 		}
 
 		if (of_property_read_u32_index(np, "clock-indices",
 					       idx, &val)) {
-			dev_err(dev, "invalid clock index @ %s\n", np->name);
+			dev_err(dev, "invalid clock index @ %pOFn\n", np);
 			return -EINVAL;
 		}
 
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 50e7c341e97e..8bdf91b56012 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1215,8 +1215,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 	/* per clkout properties */
 	for_each_child_of_node(np, child) {
 		if (of_property_read_u32(child, "reg", &num)) {
-			dev_err(&client->dev, "missing reg property of %s\n",
-				child->name);
+			dev_err(&client->dev, "missing reg property of %pOFn\n",
+				child);
 			goto put_child;
 		}
 
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 294850bdc195..cdaa567c8042 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -1433,7 +1433,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return;
 	}
 
diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
index d3271eca3779..0ea7261d15e0 100644
--- a/drivers/clk/clk-stm32h7.c
+++ b/drivers/clk/clk-stm32h7.c
@@ -1216,7 +1216,7 @@ static void __init stm32h7_rcc_init(struct device_node *np)
 	/* get RCC base @ from DT */
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("%s: unable to map resource", np->name);
+		pr_err("%pOFn: unable to map resource", np);
 		goto err_free_clks;
 	}
 
diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index a907555b2a3d..4f48342bc280 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -2088,7 +2088,7 @@ static void stm32mp1_rcc_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("%s: unable to map resource", np->name);
+		pr_err("%pOFn: unable to map resource", np);
 		of_node_put(np);
 		return;
 	}
diff --git a/drivers/clk/clk-tango4.c b/drivers/clk/clk-tango4.c
index 34b22b7930fb..fe12a43f7a40 100644
--- a/drivers/clk/clk-tango4.c
+++ b/drivers/clk/clk-tango4.c
@@ -54,13 +54,13 @@ static void __init tango4_clkgen_setup(struct device_node *np)
 	const char *parent = of_clk_get_parent_name(np, 0);
 
 	if (!base)
-		panic("%s: invalid address\n", np->name);
+		panic("%pOFn: invalid address\n", np);
 
 	if (readl(base + CPUCLK_DIV) & DIV_BYPASS)
-		panic("%s: unsupported cpuclk setup\n", np->name);
+		panic("%pOFn: unsupported cpuclk setup\n", np);
 
 	if (readl(base + SYSCLK_DIV) & DIV_BYPASS)
-		panic("%s: unsupported sysclk setup\n", np->name);
+		panic("%pOFn: unsupported sysclk setup\n", np);
 
 	writel(0x100, base + CPUCLK_DIV); /* disable frequency ramping */
 
@@ -77,9 +77,9 @@ static void __init tango4_clkgen_setup(struct device_node *np)
 	pp[3] = clk_register_fixed_factor(NULL, "sdio_clk", "cd6", 0, 1, 2);
 
 	if (IS_ERR(pp[0]) || IS_ERR(pp[1]) || IS_ERR(pp[2]) || IS_ERR(pp[3]))
-		panic("%s: clk registration failed\n", np->name);
+		panic("%pOFn: clk registration failed\n", np);
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data))
-		panic("%s: clk provider registration failed\n", np->name);
+		panic("%pOFn: clk provider registration failed\n", np);
 }
 CLK_OF_DECLARE(tango4_clkgen, "sigma,tango4-clkgen", tango4_clkgen_setup);
diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
index aed5af23895b..def15db4eef0 100644
--- a/drivers/clk/keystone/gate.c
+++ b/drivers/clk/keystone/gate.c
@@ -245,7 +245,7 @@ static void __init of_psc_clk_init(struct device_node *node, spinlock_t *lock)
 		return;
 	}
 
-	pr_err("%s: error registering clk %s\n", __func__, node->name);
+	pr_err("%s: error registering clk %pOFn\n", __func__, node);
 
 unmap_domain:
 	iounmap(data->domain_base);
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index e7e840fb74ea..2b871fc91d56 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -219,7 +219,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 out:
-	pr_err("%s: error initializing pll %s\n", __func__, node->name);
+	pr_err("%s: error initializing pll %pOFn\n", __func__, node);
 	kfree(pll_data);
 }
 
diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 9febbf42c3df..3ca4a047edc7 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -312,8 +312,8 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents < 1) {
-		pr_err("%s: no parent found for %s DIV6 clock\n",
-		       __func__, np->name);
+		pr_err("%s: no parent found for %pOFn DIV6 clock\n",
+		       __func__, np);
 		return;
 	}
 
@@ -324,8 +324,8 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 
 	reg = of_iomap(np, 0);
 	if (reg == NULL) {
-		pr_err("%s: failed to map %s DIV6 clock register\n",
-		       __func__, np->name);
+		pr_err("%s: failed to map %pOFn DIV6 clock register\n",
+		       __func__, np);
 		goto error;
 	}
 
@@ -337,8 +337,8 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 
 	clk = cpg_div6_register(clk_name, num_parents, parent_names, reg, NULL);
 	if (IS_ERR(clk)) {
-		pr_err("%s: failed to register %s DIV6 clock (%ld)\n",
-		       __func__, np->name, PTR_ERR(clk));
+		pr_err("%s: failed to register %pOFn DIV6 clock (%ld)\n",
+		       __func__, np, PTR_ERR(clk));
 		goto error;
 	}
 
diff --git a/drivers/clk/renesas/clk-emev2.c b/drivers/clk/renesas/clk-emev2.c
index a91825471c79..a587f63378b3 100644
--- a/drivers/clk/renesas/clk-emev2.c
+++ b/drivers/clk/renesas/clk-emev2.c
@@ -86,8 +86,8 @@ static void __init emev2_smu_clkdiv_init(struct device_node *np)
 	clk = clk_register_divider(NULL, np->name, parent_name, 0,
 				   smu_base + reg[0], reg[1], 8, 0, &lock);
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, np->name, NULL);
-	pr_debug("## %s %s %p\n", __func__, np->name, clk);
+	clk_register_clkdev(clk, np->full_name, NULL);
+	pr_debug("## %s %pOFn %p\n", __func__, np, clk);
 }
 CLK_OF_DECLARE(emev2_smu_clkdiv, "renesas,emev2-smu-clkdiv",
 		emev2_smu_clkdiv_init);
@@ -104,7 +104,7 @@ static void __init emev2_smu_gclk_init(struct device_node *np)
 	clk = clk_register_gate(NULL, np->name, parent_name, 0,
 				smu_base + reg[0], reg[1], 0, &lock);
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, np->name, NULL);
-	pr_debug("## %s %s %p\n", __func__, np->name, clk);
+	clk_register_clkdev(clk, np->full_name, NULL);
+	pr_debug("## %s %pOFn %p\n", __func__, np, clk);
 }
 CLK_OF_DECLARE(emev2_smu_gclk, "renesas,emev2-smu-gclk", emev2_smu_gclk_init);
diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index e82adcb16a52..b72c7344effa 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -239,8 +239,8 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			break;
 
 		if (clkidx >= MSTP_MAX_CLOCKS) {
-			pr_err("%s: invalid clock %s %s index %u\n",
-			       __func__, np->name, name, clkidx);
+			pr_err("%s: invalid clock %pOFn %s index %u\n",
+			       __func__, np, name, clkidx);
 			continue;
 		}
 
@@ -259,8 +259,8 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			 */
 			clk_register_clkdev(clks[clkidx], name, NULL);
 		} else {
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clks[clkidx]));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clks[clkidx]));
 		}
 	}
 
diff --git a/drivers/clk/renesas/clk-r8a73a4.c b/drivers/clk/renesas/clk-r8a73a4.c
index 7b903ce4c901..48e9f1e816ad 100644
--- a/drivers/clk/renesas/clk-r8a73a4.c
+++ b/drivers/clk/renesas/clk-r8a73a4.c
@@ -228,8 +228,8 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
 
 		clk = r8a73a4_cpg_register_clock(np, cpg, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-r8a7740.c b/drivers/clk/renesas/clk-r8a7740.c
index a7a30d2eca41..da781640f88f 100644
--- a/drivers/clk/renesas/clk-r8a7740.c
+++ b/drivers/clk/renesas/clk-r8a7740.c
@@ -187,8 +187,8 @@ static void __init r8a7740_cpg_clocks_init(struct device_node *np)
 
 		clk = r8a7740_cpg_register_clock(np, cpg, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
index 886a8380e912..9b964611e5b6 100644
--- a/drivers/clk/renesas/clk-r8a7778.c
+++ b/drivers/clk/renesas/clk-r8a7778.c
@@ -130,8 +130,8 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 
 		clk = r8a7778_cpg_register_clock(np, cpg, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-r8a7779.c b/drivers/clk/renesas/clk-r8a7779.c
index 5adcca4656c3..10019145a912 100644
--- a/drivers/clk/renesas/clk-r8a7779.c
+++ b/drivers/clk/renesas/clk-r8a7779.c
@@ -164,8 +164,8 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 		clk = r8a7779_cpg_register_clock(np, cpg, config,
 						 plla_mult, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index bccd62f2cb09..06c015d43167 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -445,8 +445,8 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 
 		clk = rcar_gen2_cpg_register_clock(np, cpg, config, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-rz.c b/drivers/clk/renesas/clk-rz.c
index ac2f86d626b6..8ac904912439 100644
--- a/drivers/clk/renesas/clk-rz.c
+++ b/drivers/clk/renesas/clk-rz.c
@@ -113,8 +113,8 @@ static void __init rz_cpg_clocks_init(struct device_node *np)
 
 		clk = rz_cpg_register_clock(np, cpg, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/renesas/clk-sh73a0.c b/drivers/clk/renesas/clk-sh73a0.c
index bab33610eb6c..2f44e0dd7afa 100644
--- a/drivers/clk/renesas/clk-sh73a0.c
+++ b/drivers/clk/renesas/clk-sh73a0.c
@@ -206,8 +206,8 @@ static void __init sh73a0_cpg_clocks_init(struct device_node *np)
 
 		clk = sh73a0_cpg_register_clock(np, cpg, name);
 		if (IS_ERR(clk))
-			pr_err("%s: failed to register %s %s clock (%ld)\n",
-			       __func__, np->name, name, PTR_ERR(clk));
+			pr_err("%s: failed to register %pOFn %s clock (%ld)\n",
+			       __func__, np, name, PTR_ERR(clk));
 		else
 			cpg->data.clks[i] = clk;
 	}
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index a79d81985c4e..cfa000007622 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -936,7 +936,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 	if (!clk_parent_name)
 		return;
 
-	pll_name = kasprintf(GFP_KERNEL, "%s.pll", np->name);
+	pll_name = kasprintf(GFP_KERNEL, "%pOFn.pll", np);
 	if (!pll_name)
 		return;
 
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index a27c264cc9b4..fc0278a1acc7 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -140,8 +140,8 @@ static void __init sun9i_a80_mod0_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for mod0-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for mod0-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
@@ -306,7 +306,7 @@ static void __init sunxi_mmc_setup(struct device_node *node,
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Couldn't map the %s clock registers\n", node->name);
+		pr_err("Couldn't map the %pOFn clock registers\n", node);
 		return;
 	}
 
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index e9295c286d5d..7e21b2b10c94 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -88,8 +88,8 @@ static void __init sun9i_a80_pll4_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for a80-pll4-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for a80-pll4-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
@@ -142,8 +142,8 @@ static void __init sun9i_a80_gt_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for a80-gt-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for a80-gt-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
@@ -197,8 +197,8 @@ static void __init sun9i_a80_ahb_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for a80-ahb-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for a80-ahb-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
@@ -223,8 +223,8 @@ static void __init sun9i_a80_apb0_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for a80-apb0-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for a80-apb0-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
@@ -280,8 +280,8 @@ static void __init sun9i_a80_apb1_setup(struct device_node *node)
 
 	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(reg)) {
-		pr_err("Could not get registers for a80-apb1-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for a80-apb1-clk: %pOFn\n",
+		       node);
 		return;
 	}
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 012714d94b42..892c29030b7b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -568,8 +568,8 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 
 	reg = of_iomap(node, 0);
 	if (!reg) {
-		pr_err("Could not get registers for factors-clk: %s\n",
-		       node->name);
+		pr_err("Could not get registers for factors-clk: %pOFn\n",
+		       node);
 		return NULL;
 	}
 
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 61c126a5d26a..222f68bc3f2a 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -143,8 +143,8 @@ static void __init omap_clk_register_apll(void *user,
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_debug("clk-ref for %s not ready, retry\n",
-			 node->name);
+		pr_debug("clk-ref for %pOFn not ready, retry\n",
+			 node);
 		if (!ti_clk_retry_init(node, hw, omap_clk_register_apll))
 			return;
 
@@ -155,8 +155,8 @@ static void __init omap_clk_register_apll(void *user,
 
 	clk = of_clk_get(node, 1);
 	if (IS_ERR(clk)) {
-		pr_debug("clk-bypass for %s not ready, retry\n",
-			 node->name);
+		pr_debug("clk-bypass for %pOFn not ready, retry\n",
+			 node);
 		if (!ti_clk_retry_init(node, hw, omap_clk_register_apll))
 			return;
 
@@ -202,7 +202,7 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents < 1) {
-		pr_err("dra7 apll %s must have parent(s)\n", node->name);
+		pr_err("dra7 apll %pOFn must have parent(s)\n", node);
 		goto cleanup;
 	}
 
@@ -366,7 +366,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 1) {
-		pr_err("%s must have one parent\n", node->name);
+		pr_err("%pOFn must have one parent\n", node);
 		goto cleanup;
 	}
 
@@ -374,13 +374,13 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	init->parent_names = &parent_name;
 
 	if (of_property_read_u32(node, "ti,clock-frequency", &val)) {
-		pr_err("%s missing clock-frequency\n", node->name);
+		pr_err("%pOFn missing clock-frequency\n", node);
 		goto cleanup;
 	}
 	clk_hw->fixed_rate = val;
 
 	if (of_property_read_u32(node, "ti,bit-shift", &val)) {
-		pr_err("%s missing bit-shift\n", node->name);
+		pr_err("%pOFn missing bit-shift\n", node);
 		goto cleanup;
 	}
 
@@ -389,7 +389,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	ad->autoidle_mask = 0x3 << val;
 
 	if (of_property_read_u32(node, "ti,idlest-shift", &val)) {
-		pr_err("%s missing idlest-shift\n", node->name);
+		pr_err("%pOFn missing idlest-shift\n", node);
 		goto cleanup;
 	}
 
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index 148815470431..a01ca9395179 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -190,8 +190,8 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	init.num_parents = of_clk_get_parent_count(node);
 
 	if (init.num_parents != 1) {
-		pr_err("%s: atl clock %s must have 1 parent\n", __func__,
-		       node->name);
+		pr_err("%s: atl clock %pOFn must have 1 parent\n", __func__,
+		       node);
 		goto cleanup;
 	}
 
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7d22e1af2247..be04214970cf 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -223,7 +223,7 @@ int __init ti_clk_retry_init(struct device_node *node, void *user,
 {
 	struct clk_init_item *retry;
 
-	pr_debug("%s: adding to retry list...\n", node->name);
+	pr_debug("%pOFn: adding to retry list...\n", node);
 	retry = kzalloc(sizeof(*retry), GFP_KERNEL);
 	if (!retry)
 		return -ENOMEM;
@@ -258,14 +258,14 @@ int ti_clk_get_reg_addr(struct device_node *node, int index,
 	}
 
 	if (i == CLK_MAX_MEMMAPS) {
-		pr_err("clk-provider not found for %s!\n", node->name);
+		pr_err("clk-provider not found for %pOFn!\n", node);
 		return -ENOENT;
 	}
 
 	reg->index = i;
 
 	if (of_property_read_u32_index(node, "reg", index, &val)) {
-		pr_err("%s must have reg[%d]!\n", node->name, index);
+		pr_err("%pOFn must have reg[%d]!\n", node, index);
 		return -EINVAL;
 	}
 
@@ -312,7 +312,7 @@ int __init omap2_clk_provider_init(struct device_node *parent, int index,
 	/* get clocks for this parent */
 	clocks = of_get_child_by_name(parent, "clocks");
 	if (!clocks) {
-		pr_err("%s missing 'clocks' child node.\n", parent->name);
+		pr_err("%pOFn missing 'clocks' child node.\n", parent);
 		return -EINVAL;
 	}
 
@@ -365,7 +365,7 @@ void ti_dt_clk_init_retry_clks(void)
 
 	while (!list_empty(&retry_list) && retries) {
 		list_for_each_entry_safe(retry, tmp, &retry_list, link) {
-			pr_debug("retry-init: %s\n", retry->node->name);
+			pr_debug("retry-init: %pOFn\n", retry->node);
 			retry->func(retry->user, retry->node);
 			list_del(&retry->link);
 			kfree(retry);
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 421b05392220..240e911a3db9 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -259,8 +259,8 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider *provider,
 	struct omap_clkctrl_clk *clkctrl_clk;
 	int ret = 0;
 
-	init.name = kasprintf(GFP_KERNEL, "%s:%s:%04x:%d", node->parent->name,
-			      node->name, offset, bit);
+	init.name = kasprintf(GFP_KERNEL, "%pOFn:%pOFn:%04x:%d", node->parent,
+			      node, offset, bit);
 	clkctrl_clk = kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
 	if (!init.name || !clkctrl_clk) {
 		ret = -ENOMEM;
@@ -492,8 +492,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 
 	provider->base = of_iomap(node, 0);
 
-	provider->clkdm_name = kmalloc(strlen(node->parent->name) + 3,
-				       GFP_KERNEL);
+	provider->clkdm_name = kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent);
 	if (!provider->clkdm_name) {
 		kfree(provider);
 		return;
@@ -503,8 +502,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	 * Create default clkdm name, replace _cm from end of parent node
 	 * name with _clkdm
 	 */
-	strcpy(provider->clkdm_name, node->parent->name);
-	provider->clkdm_name[strlen(provider->clkdm_name) - 2] = 0;
+	provider->clkdm_name[strlen(provider->clkdm_name) - 5] = 0;
 	strcat(provider->clkdm_name, "clkdm");
 
 	INIT_LIST_HEAD(&provider->clocks);
@@ -539,8 +537,8 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		init.flags = 0;
 		if (reg_data->flags & CLKF_SET_RATE_PARENT)
 			init.flags |= CLK_SET_RATE_PARENT;
-		init.name = kasprintf(GFP_KERNEL, "%s:%s:%04x:%d",
-				      node->parent->name, node->name,
+		init.name = kasprintf(GFP_KERNEL, "%pOFn:%pOFn:%04x:%d",
+				      node->parent, node,
 				      reg_data->offset, 0);
 		clkctrl_clk = kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
 		if (!init.name || !clkctrl_clk)
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 030e8b2c1050..e76c81a62262 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -135,8 +135,8 @@ static void __init _register_composite(void *user,
 
 		comp = _lookup_component(cclk->comp_nodes[i]);
 		if (!comp) {
-			pr_debug("component %s not ready for %s, retry\n",
-				 cclk->comp_nodes[i]->name, node->name);
+			pr_debug("component %s not ready for %pOFn, retry\n",
+				 cclk->comp_nodes[i], node);
 			if (!ti_clk_retry_init(node, hw,
 					       _register_composite))
 				return;
@@ -144,8 +144,8 @@ static void __init _register_composite(void *user,
 			goto cleanup;
 		}
 		if (cclk->comp_clks[comp->type] != NULL) {
-			pr_err("duplicate component types for %s (%s)!\n",
-			       node->name, component_clk_types[comp->type]);
+			pr_err("duplicate component types for %pOFn (%s)!\n",
+			       node, component_clk_types[comp->type]);
 			goto cleanup;
 		}
 
@@ -168,7 +168,7 @@ static void __init _register_composite(void *user,
 	}
 
 	if (!num_parents) {
-		pr_err("%s: no parents found for %s!\n", __func__, node->name);
+		pr_err("%s: no parents found for %pOFn!\n", __func__, node);
 		goto cleanup;
 	}
 
@@ -212,7 +212,7 @@ static void __init of_ti_composite_clk_setup(struct device_node *node)
 	num_clks = of_clk_get_parent_count(node);
 
 	if (!num_clks) {
-		pr_err("composite clk %s must have component(s)\n", node->name);
+		pr_err("composite clk %pOFn must have component(s)\n", node);
 		return;
 	}
 
@@ -248,7 +248,7 @@ int __init ti_clk_add_component(struct device_node *node, struct clk_hw *hw,
 	num_parents = of_clk_get_parent_count(node);
 
 	if (!num_parents) {
-		pr_err("component-clock %s must have parent(s)\n", node->name);
+		pr_err("component-clock %pOFn must have parent(s)\n", node);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index ccfb4d9a152a..4fcb337a6d1c 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -492,7 +492,7 @@ __init ti_clk_get_div_table(struct device_node *node)
 	}
 
 	if (!valid_div) {
-		pr_err("no valid dividers for %s table\n", node->name);
+		pr_err("no valid dividers for %pOFn table\n", node);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -530,7 +530,7 @@ static int _get_divider_width(struct device_node *node,
 			min_div = 1;
 
 		if (of_property_read_u32(node, "ti,max-div", &max_div)) {
-			pr_err("no max-div for %s!\n", node->name);
+			pr_err("no max-div for %pOFn!\n", node);
 			return -EINVAL;
 		}
 
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index dc86d07d0921..2e80c5ead74a 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -162,8 +162,8 @@ static void __init _register_dpll(void *user,
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_debug("clk-ref missing for %s, retry later\n",
-			 node->name);
+		pr_debug("clk-ref missing for %pOFn, retry later\n",
+			 node);
 		if (!ti_clk_retry_init(node, hw, _register_dpll))
 			return;
 
@@ -175,8 +175,8 @@ static void __init _register_dpll(void *user,
 	clk = of_clk_get(node, 1);
 
 	if (IS_ERR(clk)) {
-		pr_debug("clk-bypass missing for %s, retry later\n",
-			 node->name);
+		pr_debug("clk-bypass missing for %pOFn, retry later\n",
+			 node);
 		if (!ti_clk_retry_init(node, hw, _register_dpll))
 			return;
 
@@ -226,7 +226,7 @@ static void _register_dpll_x2(struct device_node *node,
 
 	parent_name = of_clk_get_parent_name(node, 0);
 	if (!parent_name) {
-		pr_err("%s must have parent\n", node->name);
+		pr_err("%pOFn must have parent\n", node);
 		return;
 	}
 
@@ -305,7 +305,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (!init->num_parents) {
-		pr_err("%s must have parent(s)\n", node->name);
+		pr_err("%pOFn must have parent(s)\n", node);
 		goto cleanup;
 	}
 
diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 071af44b1ba8..ed24f20f63c7 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -555,7 +555,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 2) {
-		pr_err("%s must have two parents\n", node->name);
+		pr_err("%pOFn must have two parents\n", node);
 		goto free;
 	}
 
@@ -564,19 +564,19 @@ static void __init ti_fapll_setup(struct device_node *node)
 
 	fd->clk_ref = of_clk_get(node, 0);
 	if (IS_ERR(fd->clk_ref)) {
-		pr_err("%s could not get clk_ref\n", node->name);
+		pr_err("%pOFn could not get clk_ref\n", node);
 		goto free;
 	}
 
 	fd->clk_bypass = of_clk_get(node, 1);
 	if (IS_ERR(fd->clk_bypass)) {
-		pr_err("%s could not get clk_bypass\n", node->name);
+		pr_err("%pOFn could not get clk_bypass\n", node);
 		goto free;
 	}
 
 	fd->base = of_iomap(node, 0);
 	if (!fd->base) {
-		pr_err("%s could not get IO base\n", node->name);
+		pr_err("%pOFn could not get IO base\n", node);
 		goto free;
 	}
 
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index 0174a51a4ba6..7cbe896db071 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -42,12 +42,12 @@ static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 	u32 flags = 0;
 
 	if (of_property_read_u32(node, "ti,clock-div", &div)) {
-		pr_err("%s must have a clock-div property\n", node->name);
+		pr_err("%pOFn must have a clock-div property\n", node);
 		return;
 	}
 
 	if (of_property_read_u32(node, "ti,clock-mult", &mult)) {
-		pr_err("%s must have a clock-mult property\n", node->name);
+		pr_err("%pOFn must have a clock-mult property\n", node);
 		return;
 	}
 
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 935b2de5fb88..d4b5638e8b99 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -179,7 +179,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	}
 
 	if (of_clk_get_parent_count(node) != 1) {
-		pr_err("%s must have 1 parent\n", node->name);
+		pr_err("%pOFn must have 1 parent\n", node);
 		return;
 	}
 
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 41ae7021670e..87e00c2ee957 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -84,7 +84,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 
 	parent_name = of_clk_get_parent_name(node, 0);
 	if (!parent_name) {
-		pr_err("%s must have a parent\n", node->name);
+		pr_err("%pOFn must have a parent\n", node);
 		return;
 	}
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 69a4308a5a98..18be7eb51546 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -186,7 +186,7 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 2) {
-		pr_err("mux-clock %s must have parents\n", node->name);
+		pr_err("mux-clock %pOFn must have parents\n", node);
 		return;
 	}
 	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
@@ -278,7 +278,7 @@ static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
 	num_parents = of_clk_get_parent_count(node);
 
 	if (num_parents < 2) {
-		pr_err("%s must have parents\n", node->name);
+		pr_err("%pOFn must have parents\n", node);
 		goto cleanup;
 	}
 
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 88a2cab37f62..d7b53ac8ad11 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -602,7 +602,7 @@ void __init zynq_clock_init(void)
 	}
 
 	if (of_address_to_resource(np, 0, &res)) {
-		pr_err("%s: failed to get resource\n", np->name);
+		pr_err("%pOFn: failed to get resource\n", np);
 		goto np_err;
 	}
 
@@ -611,7 +611,7 @@ void __init zynq_clock_init(void)
 	if (slcr->data) {
 		zynq_clkc_base = (__force void __iomem *)slcr->data + res.start;
 	} else {
-		pr_err("%s: Unable to get I/O memory\n", np->name);
+		pr_err("%pOFn: Unable to get I/O memory\n", np);
 		of_node_put(slcr);
 		goto np_err;
 	}
-- 
2.17.1

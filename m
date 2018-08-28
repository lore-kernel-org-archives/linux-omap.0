From: Rob Herring <robh@kernel.org>
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:41 -0500
Message-ID: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-omap@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/berlin/berlin.c               |  6 ++--
 drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +--
 drivers/pinctrl/meson/pinctrl-meson.c         |  2 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c         |  4 +--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |  6 ++--
 drivers/pinctrl/pinctrl-at91.c                |  8 ++---
 drivers/pinctrl/pinctrl-lantiq.c              |  8 ++---
 drivers/pinctrl/pinctrl-rockchip.c            |  8 ++---
 drivers/pinctrl/pinctrl-rza1.c                |  8 ++---
 drivers/pinctrl/pinctrl-single.c              | 32 +++++++++----------
 drivers/pinctrl/pinctrl-st.c                  |  6 ++--
 drivers/pinctrl/sirf/pinctrl-atlas7.c         |  4 +--
 drivers/pinctrl/stm32/pinctrl-stm32.c         |  4 +--
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |  8 ++---
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c       |  8 ++---
 17 files changed, 66 insertions(+), 69 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index b5903fffb3d0..b17a03cf87be 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -64,16 +64,14 @@ static int berlin_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
 	ret = of_property_read_string(node, "function", &function_name);
 	if (ret) {
 		dev_err(pctrl->dev,
-			"missing function property in node %s\n",
-			node->name);
+			"missing function property in node %pOFn\n", node);
 		return -EINVAL;
 	}
 
 	ngroups = of_property_count_strings(node, "groups");
 	if (ngroups < 0) {
 		dev_err(pctrl->dev,
-			"missing groups property in node %s\n",
-			node->name);
+			"missing groups property in node %pOFn\n", node);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index b04edc22dad7..4e8cf0e357c6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -69,8 +69,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 */
 	grp = imx_pinctrl_find_group_by_name(pctldev, np->name);
 	if (!grp) {
-		dev_err(ipctl->dev, "unable to find group for node %s\n",
-			np->name);
+		dev_err(ipctl->dev, "unable to find group for node %pOFn\n", np);
 		return -EINVAL;
 	}
 
@@ -434,7 +433,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 	int i;
 	u32 config;
 
-	dev_dbg(ipctl->dev, "group(%d): %s\n", index, np->name);
+	dev_dbg(ipctl->dev, "group(%d): %pOFn\n", index, np);
 
 	if (info->flags & SHARE_MUX_CONF_REG)
 		pin_size = FSL_PIN_SHARE_SIZE;
@@ -544,7 +543,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	struct group_desc *grp;
 	u32 i = 0;
 
-	dev_dbg(pctl->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(pctl->dev, "parse function(%d): %pOFn\n", index, np);
 
 	func = pinmux_generic_get_function(pctl, index);
 	if (!func)
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index deb7870b3d1a..7e29e3fecdb2 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -233,8 +233,8 @@ static int imx1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 */
 	grp = imx1_pinctrl_find_group_by_name(info, np->name);
 	if (!grp) {
-		dev_err(info->dev, "unable to find group for node %s\n",
-			np->name);
+		dev_err(info->dev, "unable to find group for node %pOFn\n",
+			np);
 		return -EINVAL;
 	}
 
@@ -466,7 +466,7 @@ static int imx1_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *list;
 	int i;
 
-	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "group(%d): %pOFn\n", index, np);
 
 	/* Initialise group */
 	grp->name = np->name;
@@ -477,8 +477,8 @@ static int imx1_pinctrl_parse_groups(struct device_node *np,
 	list = of_get_property(np, "fsl,pins", &size);
 	/* we do not check return since it's safe node passed down */
 	if (!size || size % 12) {
-		dev_notice(info->dev, "Not a valid fsl,pins property (%s)\n",
-				np->name);
+		dev_notice(info->dev, "Not a valid fsl,pins property (%pOFn)\n",
+				np);
 		return -EINVAL;
 	}
 
@@ -513,7 +513,7 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 	static u32 grp_index;
 	u32 i = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "parse function(%d): %pOFn\n", index, np);
 
 	func = &info->functions[index];
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 16ff56f93501..071623873ca5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -514,8 +514,8 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	pins = of_find_property(node, "pinmux", NULL);
 	if (!pins) {
-		dev_err(pctl->dev, "missing pins property in node %s .\n",
-				node->name);
+		dev_err(pctl->dev, "missing pins property in node %pOFn .\n",
+				node);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 29a458da78db..9cb81aec4e3b 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -451,7 +451,7 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
 
 	meson_regmap_config.max_register = resource_size(&res) - 4;
 	meson_regmap_config.name = devm_kasprintf(pc->dev, GFP_KERNEL,
-						  "%s-%s", node->name,
+						  "%pOFn-%s", node,
 						  name);
 	if (!meson_regmap_config.name)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index d7ec7119701b..7ee5f7970585 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -413,14 +413,14 @@ static int mvebu_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	ret = of_property_read_string(np, "marvell,function", &function);
 	if (ret) {
 		dev_err(pctl->dev,
-			"missing marvell,function in node %s\n", np->name);
+			"missing marvell,function in node %pOFn\n", np);
 		return 0;
 	}
 
 	nmaps = of_property_count_strings(np, "marvell,pins");
 	if (nmaps < 0) {
 		dev_err(pctl->dev,
-			"missing marvell,pins in node %s\n", np->name);
+			"missing marvell,pins in node %pOFn\n", np);
 		return 0;
 	}
 
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f0e7a8c114b2..866db2706b8b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1051,7 +1051,7 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 
 	gpio_pdev = of_find_device_by_node(np);
 	if (!gpio_pdev) {
-		pr_err("populate \"%s\": device not found\n", np->name);
+		pr_err("populate \"%pOFn\": device not found\n", np);
 		return ERR_PTR(-ENODEV);
 	}
 	if (of_property_read_u32(np, "gpio-bank", &id)) {
@@ -1904,8 +1904,8 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 		gpio_np = of_parse_phandle(np, "nomadik-gpio-chips", i);
 		if (gpio_np) {
 			dev_info(&pdev->dev,
-				 "populate NMK GPIO %d \"%s\"\n",
-				 i, gpio_np->name);
+				 "populate NMK GPIO %d \"%pOFn\"\n",
+				 i, gpio_np);
 			nmk_chip = nmk_gpio_populate_chip(gpio_np, pdev);
 			if (IS_ERR(nmk_chip))
 				dev_err(&pdev->dev,
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 50f0ec42c637..cfd8239f2727 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -263,8 +263,8 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 */
 	grp = at91_pinctrl_find_group_by_name(info, np->name);
 	if (!grp) {
-		dev_err(info->dev, "unable to find group for node %s\n",
-			np->name);
+		dev_err(info->dev, "unable to find group for node %pOFn\n",
+			np);
 		return -EINVAL;
 	}
 
@@ -1071,7 +1071,7 @@ static int at91_pinctrl_parse_groups(struct device_node *np,
 	const __be32 *list;
 	int i, j;
 
-	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "group(%d): %pOFn\n", index, np);
 
 	/* Initialise group */
 	grp->name = np->name;
@@ -1122,7 +1122,7 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	static u32 grp_index;
 	u32 i = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "parse function(%d): %pOFn\n", index, np);
 
 	func = &info->functions[index];
 
diff --git a/drivers/pinctrl/pinctrl-lantiq.c b/drivers/pinctrl/pinctrl-lantiq.c
index 81632af3a86a..22e80613e269 100644
--- a/drivers/pinctrl/pinctrl-lantiq.c
+++ b/drivers/pinctrl/pinctrl-lantiq.c
@@ -80,14 +80,14 @@ static void ltq_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	int ret, i;
 
 	if (!pins && !groups) {
-		dev_err(pctldev->dev, "%s defines neither pins nor groups\n",
-			np->name);
+		dev_err(pctldev->dev, "%pOFn defines neither pins nor groups\n",
+			np);
 		return;
 	}
 
 	if (pins && groups) {
-		dev_err(pctldev->dev, "%s defines both pins and groups\n",
-			np->name);
+		dev_err(pctldev->dev, "%pOFn defines both pins and groups\n",
+			np);
 		return;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index f4a61429e06e..1fe72af3717b 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -501,8 +501,8 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 */
 	grp = pinctrl_name_to_group(info, np->name);
 	if (!grp) {
-		dev_err(info->dev, "unable to find group for node %s\n",
-			np->name);
+		dev_err(info->dev, "unable to find group for node %pOFn\n",
+			np);
 		return -EINVAL;
 	}
 
@@ -2454,7 +2454,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 	int i, j;
 	int ret;
 
-	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "group(%d): %pOFn\n", index, np);
 
 	/* Initialise group */
 	grp->name = np->name;
@@ -2519,7 +2519,7 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 	static u32 grp_index;
 	u32 i = 0;
 
-	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+	dev_dbg(info->dev, "parse function(%d): %pOFn\n", index, np);
 
 	func = &info->functions[index];
 
diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
index f76edf664539..042ede3b8ada 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -930,8 +930,8 @@ static int rza1_parse_pinmux_node(struct rza1_pinctrl *rza1_pctl,
 					      &npin_configs);
 	if (ret) {
 		dev_err(rza1_pctl->dev,
-			"Unable to parse pin configuration options for %s\n",
-			np->name);
+			"Unable to parse pin configuration options for %pOFn\n",
+			np);
 		return ret;
 	}
 
@@ -1226,8 +1226,8 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 
 	*chip		= rza1_gpiochip_template;
 	chip->base	= -1;
-	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%s",
-					 np->name);
+	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
+					 np);
 	chip->ngpio	= of_args.args[2];
 	chip->of_node	= np;
 	chip->parent	= rza1_pctl->dev;
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 7ec72ff2419a..1e0614daee9b 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1022,14 +1022,14 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 		vals[found].reg = pcs->base + offset;
 		vals[found].val = pinctrl_spec.args[1];
 
-		dev_dbg(pcs->dev, "%s index: 0x%x value: 0x%x\n",
-			pinctrl_spec.np->name, offset, pinctrl_spec.args[1]);
+		dev_dbg(pcs->dev, "%pOFn index: 0x%x value: 0x%x\n",
+			pinctrl_spec.np, offset, pinctrl_spec.args[1]);
 
 		pin = pcs_get_pin_by_offset(pcs, offset);
 		if (pin < 0) {
 			dev_err(pcs->dev,
-				"could not add functions for %s %ux\n",
-				np->name, offset);
+				"could not add functions for %pOFn %ux\n",
+				np, offset);
 			break;
 		}
 		pins[found++] = pin;
@@ -1135,8 +1135,8 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 		val = pinctrl_spec.args[1];
 		mask = pinctrl_spec.args[2];
 
-		dev_dbg(pcs->dev, "%s index: 0x%x value: 0x%x mask: 0x%x\n",
-			pinctrl_spec.np->name, offset, val, mask);
+		dev_dbg(pcs->dev, "%pOFn index: 0x%x value: 0x%x mask: 0x%x\n",
+			pinctrl_spec.np, offset, val, mask);
 
 		/* Parse pins in each row from LSB */
 		while (mask) {
@@ -1148,8 +1148,8 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 
 			if ((mask & mask_pos) == 0) {
 				dev_err(pcs->dev,
-					"Invalid mask for %s at 0x%x\n",
-					np->name, offset);
+					"Invalid mask for %pOFn at 0x%x\n",
+					np, offset);
 				break;
 			}
 
@@ -1157,8 +1157,8 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 
 			if (submask != mask_pos) {
 				dev_warn(pcs->dev,
-						"Invalid submask 0x%x for %s at 0x%x\n",
-						submask, np->name, offset);
+						"Invalid submask 0x%x for %pOFn at 0x%x\n",
+						submask, np, offset);
 				continue;
 			}
 
@@ -1169,8 +1169,8 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 			pin = pcs_get_pin_by_offset(pcs, offset);
 			if (pin < 0) {
 				dev_err(pcs->dev,
-					"could not add functions for %s %ux\n",
-					np->name, offset);
+					"could not add functions for %pOFn %ux\n",
+					np, offset);
 				break;
 			}
 			pins[found++] = pin + pin_num_from_lsb;
@@ -1254,16 +1254,16 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = pcs_parse_bits_in_pinctrl_entry(pcs, np_config, map,
 				num_maps, pgnames);
 		if (ret < 0) {
-			dev_err(pcs->dev, "no pins entries for %s\n",
-				np_config->name);
+			dev_err(pcs->dev, "no pins entries for %pOFn\n",
+				np_config);
 			goto free_pgnames;
 		}
 	} else {
 		ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map,
 				num_maps, pgnames);
 		if (ret < 0) {
-			dev_err(pcs->dev, "no pins entries for %s\n",
-				np_config->name);
+			dev_err(pcs->dev, "no pins entries for %pOFn\n",
+				np_config);
 			goto free_pgnames;
 		}
 	}
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0966bb0bf71f..e66af93f2cbf 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -817,8 +817,8 @@ static int st_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	grp = st_pctl_find_group_by_name(info, np->name);
 	if (!grp) {
-		dev_err(info->dev, "unable to find group for node %s\n",
-			np->name);
+		dev_err(info->dev, "unable to find group for node %pOFn\n",
+			np);
 		return -EINVAL;
 	}
 
@@ -1184,7 +1184,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 		if (pp->length / sizeof(__be32) >= OF_GPIO_ARGS_MIN) {
 			npins++;
 		} else {
-			pr_warn("Invalid st,pins in %s node\n", np->name);
+			pr_warn("Invalid st,pins in %pOFn node\n", np);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 3abb028f6158..1d16df128b1a 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -6058,8 +6058,8 @@ static int atlas7_gpio_probe(struct platform_device *pdev)
 	ret = gpiochip_add_data(chip, a7gc);
 	if (ret) {
 		dev_err(&pdev->dev,
-			"%s: error in probe function with status %d\n",
-			np->name, ret);
+			"%pOF: error in probe function with status %d\n",
+			np, ret);
 		goto failed;
 	}
 
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a9bec6e6fdd1..0fbfcc9ea07c 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -416,8 +416,8 @@ static int stm32_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	pins = of_find_property(node, "pinmux", NULL);
 	if (!pins) {
-		dev_err(pctl->dev, "missing pins property in node %s .\n",
-				node->name);
+		dev_err(pctl->dev, "missing pins property in node %pOFn .\n",
+				node);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 4d9bf9b3e9f3..3ccbe221e024 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -332,15 +332,15 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	function = sunxi_pctrl_parse_function_prop(node);
 	if (!function) {
-		dev_err(pctl->dev, "missing function property in node %s\n",
-			node->name);
+		dev_err(pctl->dev, "missing function property in node %pOFn\n",
+			node);
 		return -EINVAL;
 	}
 
 	pin_prop = sunxi_pctrl_find_pins_prop(node, &npins);
 	if (!pin_prop) {
-		dev_err(pctl->dev, "missing pins property in node %s\n",
-			node->name);
+		dev_err(pctl->dev, "missing pins property in node %pOFn\n",
+			node);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 8782c348ebe9..a4bc506a01a3 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -452,8 +452,8 @@ static int ti_iodelay_node_iterator(struct pinctrl_dev *pctldev,
 
 	pin = ti_iodelay_offset_to_pin(iod, cfg[pin_index].offset);
 	if (pin < 0) {
-		dev_err(iod->dev, "could not add functions for %s %ux\n",
-			np->name, cfg[pin_index].offset);
+		dev_err(iod->dev, "could not add functions for %pOFn %ux\n",
+			np, cfg[pin_index].offset);
 		return -ENODEV;
 	}
 	pins[pin_index] = pin;
@@ -461,8 +461,8 @@ static int ti_iodelay_node_iterator(struct pinctrl_dev *pctldev,
 	pd = &iod->pa[pin];
 	pd->drv_data = &cfg[pin_index];
 
-	dev_dbg(iod->dev, "%s offset=%x a_delay = %d g_delay = %d\n",
-		np->name, cfg[pin_index].offset, cfg[pin_index].a_delay,
+	dev_dbg(iod->dev, "%pOFn offset=%x a_delay = %d g_delay = %d\n",
+		np, cfg[pin_index].offset, cfg[pin_index].a_delay,
 		cfg[pin_index].g_delay);
 
 	return 0;
-- 
2.17.1

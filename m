From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] pinctrl: single: Use generic pinctrl helpers for managing groups
Date: Tue, 25 Oct 2016 14:02:20 -0700
Message-ID: <20161025210221.9150-5-tony@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025210221.9150-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can now drop the driver specific code for managing groups.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/Kconfig          |   2 +-
 drivers/pinctrl/pinctrl-single.c | 155 +++------------------------------------
 2 files changed, 11 insertions(+), 146 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -157,8 +157,8 @@ config PINCTRL_ROCKCHIP
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
+	select GENERIC_PINCTRL
 	select PINMUX
-	select PINCONF
 	select GENERIC_PINCONF
 	help
 	  This selects the device tree based generic pinctrl driver.
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -38,22 +38,6 @@
 #define PCS_OFF_DISABLED		~0U
 
 /**
- * struct pcs_pingroup - pingroups for a function
- * @np:		pingroup device node pointer
- * @name:	pingroup name
- * @gpins:	array of the pins in the group
- * @ngpins:	number of pins in the group
- * @node:	list node
- */
-struct pcs_pingroup {
-	struct device_node *np;
-	const char *name;
-	int *gpins;
-	int ngpins;
-	struct list_head node;
-};
-
-/**
  * struct pcs_func_vals - mux function register offset and value pair
  * @reg:	register virtual address
  * @val:	register value
@@ -176,15 +160,12 @@ struct pcs_soc_data {
  * @bits_per_mux: number of bits per mux
  * @bits_per_pin: number of bits per pin
  * @pins:	physical pins on the SoC
- * @pgtree:	pingroup index radix tree
  * @ftree:	function index radix tree
- * @pingroups:	list of pingroups
  * @functions:	list of functions
  * @gpiofuncs:	list of gpio functions
  * @irqs:	list of interrupt registers
  * @chip:	chip container for this instance
  * @domain:	IRQ domain for this instance
- * @ngroups:	number of pingroups
  * @nfuncs:	number of functions
  * @desc:	pin controller descriptor
  * @read:	register read function to use
@@ -213,15 +194,12 @@ struct pcs_device {
 	bool bits_per_mux;
 	unsigned bits_per_pin;
 	struct pcs_data pins;
-	struct radix_tree_root pgtree;
 	struct radix_tree_root ftree;
-	struct list_head pingroups;
 	struct list_head functions;
 	struct list_head gpiofuncs;
 	struct list_head irqs;
 	struct irq_chip chip;
 	struct irq_domain *domain;
-	unsigned ngroups;
 	unsigned nfuncs;
 	struct pinctrl_desc desc;
 	unsigned (*read)(void __iomem *reg);
@@ -288,54 +266,6 @@ static void __maybe_unused pcs_writel(unsigned val, void __iomem *reg)
 	writel(val, reg);
 }
 
-static int pcs_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct pcs_device *pcs;
-
-	pcs = pinctrl_dev_get_drvdata(pctldev);
-
-	return pcs->ngroups;
-}
-
-static const char *pcs_get_group_name(struct pinctrl_dev *pctldev,
-					unsigned gselector)
-{
-	struct pcs_device *pcs;
-	struct pcs_pingroup *group;
-
-	pcs = pinctrl_dev_get_drvdata(pctldev);
-	group = radix_tree_lookup(&pcs->pgtree, gselector);
-	if (!group) {
-		dev_err(pcs->dev, "%s could not find pingroup%i\n",
-			__func__, gselector);
-		return NULL;
-	}
-
-	return group->name;
-}
-
-static int pcs_get_group_pins(struct pinctrl_dev *pctldev,
-					unsigned gselector,
-					const unsigned **pins,
-					unsigned *npins)
-{
-	struct pcs_device *pcs;
-	struct pcs_pingroup *group;
-
-	pcs = pinctrl_dev_get_drvdata(pctldev);
-	group = radix_tree_lookup(&pcs->pgtree, gselector);
-	if (!group) {
-		dev_err(pcs->dev, "%s could not find pingroup%i\n",
-			__func__, gselector);
-		return -EINVAL;
-	}
-
-	*pins = group->gpins;
-	*npins = group->ngpins;
-
-	return 0;
-}
-
 static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 					struct seq_file *s,
 					unsigned pin)
@@ -368,9 +298,9 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 				struct pinctrl_map **map, unsigned *num_maps);
 
 static const struct pinctrl_ops pcs_pinctrl_ops = {
-	.get_groups_count = pcs_get_groups_count,
-	.get_group_name = pcs_get_group_name,
-	.get_group_pins = pcs_get_group_pins,
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name = pinctrl_generic_get_group_name,
+	.get_group_pins = pinctrl_generic_get_group_pins,
 	.pin_dbg_show = pcs_pin_dbg_show,
 	.dt_node_to_map = pcs_dt_node_to_map,
 	.dt_free_map = pcs_dt_free_map,
@@ -684,7 +614,7 @@ static int pcs_pinconf_group_get(struct pinctrl_dev *pctldev,
 	unsigned npins, old = 0;
 	int i, ret;
 
-	ret = pcs_get_group_pins(pctldev, group, &pins, &npins);
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
 	if (ret)
 		return ret;
 	for (i = 0; i < npins; i++) {
@@ -706,7 +636,7 @@ static int pcs_pinconf_group_set(struct pinctrl_dev *pctldev,
 	unsigned npins;
 	int i, ret;
 
-	ret = pcs_get_group_pins(pctldev, group, &pins, &npins);
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
 	if (ret)
 		return ret;
 	for (i = 0; i < npins; i++) {
@@ -896,40 +826,6 @@ static void pcs_remove_function(struct pcs_device *pcs,
 }
 
 /**
- * pcs_add_pingroup() - add a pingroup to the pingroup list
- * @pcs: pcs driver instance
- * @np: device node of the mux entry
- * @name: name of the pingroup
- * @gpins: array of the pins that belong to the group
- * @ngpins: number of pins in the group
- */
-static int pcs_add_pingroup(struct pcs_device *pcs,
-					struct device_node *np,
-					const char *name,
-					int *gpins,
-					int ngpins)
-{
-	struct pcs_pingroup *pingroup;
-
-	pingroup = devm_kzalloc(pcs->dev, sizeof(*pingroup), GFP_KERNEL);
-	if (!pingroup)
-		return -ENOMEM;
-
-	pingroup->name = name;
-	pingroup->np = np;
-	pingroup->gpins = gpins;
-	pingroup->ngpins = ngpins;
-
-	mutex_lock(&pcs->mutex);
-	list_add_tail(&pingroup->node, &pcs->pingroups);
-	radix_tree_insert(&pcs->pgtree, pcs->ngroups, pingroup);
-	pcs->ngroups++;
-	mutex_unlock(&pcs->mutex);
-
-	return 0;
-}
-
-/**
  * pcs_get_pin_by_offset() - get a pin index based on the register offset
  * @pcs: pcs driver instance
  * @offset: register offset from the base
@@ -1099,10 +995,9 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 	return 0;
 }
 
-static void pcs_free_pingroups(struct pcs_device *pcs);
-
 /**
  * smux_parse_one_pinctrl_entry() - parses a device tree mux entry
+ * @pctldev: pin controller device
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
  * @map: map entry
@@ -1183,7 +1078,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (!function)
 		goto free_pins;
 
-	res = pcs_add_pingroup(pcs, np, np->name, pins, found);
+	res = pinctrl_generic_add_group(pcs->pctl, np->name, pins, found, pcs);
 	if (res < 0)
 		goto free_function;
 
@@ -1202,7 +1097,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	return 0;
 
 free_pingroups:
-	pcs_free_pingroups(pcs);
+	pinctrl_generic_remove_last_group(pcs->pctl);
 	*num_maps = 1;
 free_function:
 	pcs_remove_function(pcs, function);
@@ -1315,7 +1210,7 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	if (!function)
 		goto free_pins;
 
-	res = pcs_add_pingroup(pcs, np, np->name, pins, found);
+	res = pinctrl_generic_add_group(pcs->pctl, np->name, pins, found, pcs);
 	if (res < 0)
 		goto free_function;
 
@@ -1332,7 +1227,7 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	return 0;
 
 free_pingroups:
-	pcs_free_pingroups(pcs);
+	pinctrl_generic_remove_last_group(pcs->pctl);
 	*num_maps = 1;
 free_function:
 	pcs_remove_function(pcs, function);
@@ -1431,33 +1326,6 @@ static void pcs_free_funcs(struct pcs_device *pcs)
 }
 
 /**
- * pcs_free_pingroups() - free memory used by pingroups
- * @pcs: pcs driver instance
- */
-static void pcs_free_pingroups(struct pcs_device *pcs)
-{
-	struct list_head *pos, *tmp;
-	int i;
-
-	mutex_lock(&pcs->mutex);
-	for (i = 0; i < pcs->ngroups; i++) {
-		struct pcs_pingroup *pingroup;
-
-		pingroup = radix_tree_lookup(&pcs->pgtree, i);
-		if (!pingroup)
-			continue;
-		radix_tree_delete(&pcs->pgtree, i);
-	}
-	list_for_each_safe(pos, tmp, &pcs->pingroups) {
-		struct pcs_pingroup *pingroup;
-
-		pingroup = list_entry(pos, struct pcs_pingroup, node);
-		list_del(&pingroup->node);
-	}
-	mutex_unlock(&pcs->mutex);
-}
-
-/**
  * pcs_irq_free() - free interrupt
  * @pcs: pcs driver instance
  */
@@ -1486,7 +1354,6 @@ static void pcs_free_resources(struct pcs_device *pcs)
 	pcs_irq_free(pcs);
 	pinctrl_unregister(pcs->pctl);
 	pcs_free_funcs(pcs);
-	pcs_free_pingroups(pcs);
 	if (pcs->missing_nr_pinctrl_cells)
 		of_remove_property(pcs->np, pcs->missing_nr_pinctrl_cells);
 }
@@ -1874,7 +1741,6 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->np = np;
 	raw_spin_lock_init(&pcs->lock);
 	mutex_init(&pcs->mutex);
-	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
 	INIT_LIST_HEAD(&pcs->gpiofuncs);
 	soc = match->data;
@@ -1936,7 +1802,6 @@ static int pcs_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	INIT_RADIX_TREE(&pcs->pgtree, GFP_KERNEL);
 	INIT_RADIX_TREE(&pcs->ftree, GFP_KERNEL);
 	platform_set_drvdata(pdev, pcs);
 
-- 
2.9.3

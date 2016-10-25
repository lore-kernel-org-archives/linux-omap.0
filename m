From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] pinctrl: core: Add generic pinctrl functions for managing groups
Date: Tue, 25 Oct 2016 14:02:19 -0700
Message-ID: <20161025210221.9150-4-tony@atomide.com>
References: <20161025210221.9150-1-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025210221.9150-1-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can add generic helpers for function handling for cases where the pin
controller driver does not need to use static arrays.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/Kconfig  |   4 ++
 drivers/pinctrl/core.c   |   2 +
 drivers/pinctrl/core.h   |  18 +++++
 drivers/pinctrl/pinmux.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinmux.h |  42 ++++++++++++
 5 files changed, 239 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -14,6 +14,10 @@ config GENERIC_PINCTRL
 config PINMUX
 	bool "Support pin multiplexing controllers" if COMPILE_TEST
 
+config GENERIC_PINMUX
+	bool
+	select PINMUX
+
 config PINCONF
 	bool "Support pin configuration controllers" if COMPILE_TEST
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1971,6 +1971,7 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	pctldev->driver_data = driver_data;
 	INIT_RADIX_TREE(&pctldev->pin_desc_tree, GFP_KERNEL);
 	INIT_RADIX_TREE(&pctldev->pin_group_tree, GFP_KERNEL);
+	INIT_RADIX_TREE(&pctldev->pin_function_tree, GFP_KERNEL);
 	INIT_LIST_HEAD(&pctldev->gpio_ranges);
 	INIT_DELAYED_WORK(&pctldev->hog_work, pinctrl_hog_work);
 	pctldev->dev = dev;
@@ -2049,6 +2050,7 @@ void pinctrl_unregister(struct pinctrl_dev *pctldev)
 	mutex_lock(&pctldev->mutex);
 	/* TODO: check that no pinmuxes are still active? */
 	list_del(&pctldev->node);
+	pinmux_generic_free_functions(pctldev);
 	pinctrl_generic_free_groups(pctldev);
 	/* Destroy descriptor tree */
 	pinctrl_free_pindescs(pctldev, pctldev->desc->pins,
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -25,7 +25,9 @@ struct pinctrl_gpio_range;
  * @pin_desc_tree: each pin descriptor for this pin controller is stored in
  *	this radix tree
  * @pin_group_tree: optionally each pin group can be stored in this radix tree
+ * @pin_function_tree: optionally each function can be stored in this radix tree
  * @num_groups: optionally number of groups can be kept here
+ * @num_functions: optionally number of functions can be kept here
  * @gpio_ranges: a list of GPIO ranges that is handled by this pin controller,
  *	ranges are added to this list at runtime
  * @dev: the device entry for this pin controller
@@ -44,7 +46,9 @@ struct pinctrl_dev {
 	struct pinctrl_desc *desc;
 	struct radix_tree_root pin_desc_tree;
 	struct radix_tree_root pin_group_tree;
+	struct radix_tree_root pin_function_tree;
 	unsigned int num_groups;
+	unsigned int num_functions;
 	struct list_head gpio_ranges;
 	struct device *dev;
 	struct module *owner;
@@ -180,6 +184,20 @@ struct group_desc {
 };
 
 /**
+ * struct function_desc - generic function descriptor
+ * @name: name of the function
+ * @group_names: array of pin group names
+ * @num_group_names: number of pin group names
+ * @data: pin controller driver specific data
+ */
+struct function_desc {
+	const char *name;
+	const char **group_names;
+	int num_group_names;
+	void *data;
+};
+
+/**
  * struct pinctrl_maps - a list item containing part of the mapping table
  * @node: mapping table list node
  * @maps: array of mapping table entries
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -695,3 +695,176 @@ void pinmux_init_device_debugfs(struct dentry *devroot,
 }
 
 #endif /* CONFIG_DEBUG_FS */
+
+#ifdef CONFIG_GENERIC_PINMUX
+
+/**
+ * pinmux_generic_get_function_count() - returns number of functions
+ * @pctldev: pin controller device
+ */
+int pinmux_generic_get_function_count(struct pinctrl_dev *pctldev)
+{
+	return pctldev->num_functions;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_get_function_count);
+
+/**
+ * pinmux_generic_get_function_name() - returns the function name
+ * @pctldev: pin controller device
+ * @selector: function number
+ */
+const char *
+pinmux_generic_get_function_name(struct pinctrl_dev *pctldev,
+				 unsigned int selector)
+{
+	struct function_desc *function;
+
+	function = radix_tree_lookup(&pctldev->pin_function_tree,
+				     selector);
+	if (!function)
+		return NULL;
+
+	return function->name;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_get_function_name);
+
+/**
+ * pinmux_generic_get_function_groups() - gets the function groups
+ * @pctldev: pin controller device
+ * @selector: function number
+ * @groups: array of pin groups
+ * @num_groups: number of pin groups
+ */
+int pinmux_generic_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned * const num_groups)
+{
+	struct function_desc *function;
+
+	function = radix_tree_lookup(&pctldev->pin_function_tree,
+				     selector);
+	if (!function) {
+		dev_err(pctldev->dev, "%s could not find function%i\n",
+			__func__, selector);
+		return -EINVAL;
+	}
+	*groups = function->group_names;
+	*num_groups = function->num_group_names;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_get_function_groups);
+
+/**
+ * pinmux_generic_get_function() - returns a function based on the number
+ * @pctldev: pin controller device
+ * @group_selector: function number
+ */
+struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
+						  unsigned int selector)
+{
+	struct function_desc *function;
+
+	function = radix_tree_lookup(&pctldev->pin_function_tree,
+				     selector);
+	if (!function)
+		return NULL;
+
+	return function;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_get_function);
+
+/**
+ * pinmux_generic_get_function_groups() - gets the function groups
+ * @pctldev: pin controller device
+ * @name: name of the function
+ * @groups: array of pin groups
+ * @num_groups: number of pin groups
+ * @data: pin controller driver specific data
+ */
+int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
+				const char *name,
+				const char **groups,
+				const unsigned int num_groups,
+				void *data)
+{
+	struct function_desc *function;
+
+	function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
+	if (!function)
+		return -ENOMEM;
+
+	function->name = name;
+	function->group_names = groups;
+	function->num_group_names = num_groups;
+	function->data = data;
+
+	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
+			  function);
+
+	pctldev->num_functions++;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
+
+/**
+ * pinmux_generic_remove_function() - removes a numbered function
+ * @pctldev: pin controller device
+ * @selector: function number
+ *
+ * Note that the caller must take care of locking.
+ */
+int pinmux_generic_remove_function(struct pinctrl_dev *pctldev,
+				   unsigned int selector)
+{
+	struct function_desc *function;
+
+	function = radix_tree_lookup(&pctldev->pin_function_tree,
+				     selector);
+	if (!function)
+		return -ENOENT;
+
+	radix_tree_delete(&pctldev->pin_function_tree, selector);
+	devm_kfree(pctldev->dev, function);
+
+	pctldev->num_functions--;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pinmux_generic_remove_function);
+
+/**
+ * pinmux_generic_free_functions() - removes all functions
+ * @pctldev: pin controller device
+ *
+ * Note that the caller must take care of locking.
+ */
+void pinmux_generic_free_functions(struct pinctrl_dev *pctldev)
+{
+	struct radix_tree_iter iter;
+	struct function_desc *function;
+	unsigned long *indices;
+	void **slot;
+	int i = 0;
+
+	indices = devm_kzalloc(pctldev->dev, sizeof(*indices) *
+			       pctldev->num_functions, GFP_KERNEL);
+	if (!indices)
+		return;
+
+	radix_tree_for_each_slot(slot, &pctldev->pin_function_tree, &iter, 0)
+		indices[i++] = iter.index;
+
+	for (i = 0; i < pctldev->num_functions; i++) {
+		function = radix_tree_lookup(&pctldev->pin_function_tree,
+					     indices[i]);
+		radix_tree_delete(&pctldev->pin_function_tree, indices[i]);
+		devm_kfree(pctldev->dev, function);
+	}
+
+	pctldev->num_functions = 0;
+}
+
+#endif /* CONFIG_GENERIC_PINMUX */
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -111,3 +111,45 @@ static inline void pinmux_init_device_debugfs(struct dentry *devroot,
 }
 
 #endif
+
+#ifdef CONFIG_GENERIC_PINMUX
+
+int pinmux_generic_get_function_count(struct pinctrl_dev *pctldev);
+
+const char *
+pinmux_generic_get_function_name(struct pinctrl_dev *pctldev,
+				 unsigned int selector);
+
+int pinmux_generic_get_function_groups(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const char * const **groups,
+				       unsigned * const num_groups);
+
+struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
+						  unsigned int selector);
+
+int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
+				const char *name,
+				const char **groups,
+				unsigned const num_groups,
+				void *data);
+
+int pinmux_generic_remove_function(struct pinctrl_dev *pctldev,
+				   unsigned int selector);
+
+static inline int
+pinmux_generic_remove_last_function(struct pinctrl_dev *pctldev)
+{
+	return pinmux_generic_remove_function(pctldev,
+					      pctldev->num_functions - 1);
+}
+
+void pinmux_generic_free_functions(struct pinctrl_dev *pctldev);
+
+#else
+
+static inline void pinmux_generic_free_functions(struct pinctrl_dev *pctldev)
+{
+}
+
+#endif
-- 
2.9.3

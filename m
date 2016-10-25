From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and pinctrl_parse_index_with_args
Date: Tue, 25 Oct 2016 09:45:35 -0700
Message-ID: <20161025164538.453-2-tony@atomide.com>
References: <20161025164538.453-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025164538.453-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce #pinctrl-cells helper binding and generic helper functions
pinctrl_count_index_with_args() and pinctrl_parse_index_with_args().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../bindings/pinctrl/pinctrl-bindings.txt          |  42 +++++-
 drivers/pinctrl/devicetree.c                       | 151 +++++++++++++++++++++
 drivers/pinctrl/devicetree.h                       |  24 ++++
 3 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -97,6 +97,11 @@ For example:
 	};
 
 == Pin controller devices ==
+Required properties: See the pin controller driver specific documentation
+
+Optional properties:
+#pinctrl-cells:	Number of pin control cells in addition to the index within the
+		pin controller device instance
 
 Pin controller devices should contain the pin configuration nodes that client
 devices reference.
@@ -119,7 +124,8 @@ For example:
 
 The contents of each of those pin configuration child nodes is defined
 entirely by the binding for the individual pin controller device. There
-exists no common standard for this content.
+exists no common standard for this content. The pinctrl framework only
+provides generic helper bindings that the pin controller driver can use.
 
 The pin configuration nodes need not be direct children of the pin controller
 device; they may be grandchildren, for example. Whether this is legal, and
@@ -156,6 +162,40 @@ state_2_node_a {
 	pins = "mfio29", "mfio30";
 };
 
+For pin controller hardware with a large number of identical registers naming
+each bit both can be unmaintainable. Further there can be a large number of similar
+pinctrl hardware using the same registers for different purposes depending on the
+packaging. For cases like this, the pinctrl driver may use pinctrl-pin-array helper
+binding using a hardware based index and a number of configuration values:
+
+pincontroller {
+	... /* Standard DT properties for the device itself elided */
+	#pinctrl-cells = <2>;
+
+	state_0_node_a {
+		pinctrl-pin-array = <
+			0 A_DELAY_PS(0) G_DELAY_PS(120)
+			4 A_DELAY_PS(0) G_DELAY_PS(360)
+			...
+		>;
+	};
+	...
+};
+
+The #pinctrl-cells specifies the number of value cells in addition to the
+index of the registers. This is similar to the interrupts-extended binding with
+one exception. There is no need to specify the phandle for each entry as that
+is already known as the defined pins are always children of the pin controller
+node. Further having the phandle pointing to another pin controller would not
+currently work as the pinctrl framework uses named modes to group pins for each
+pin control device.
+
+The index for pinctrl-pin-array must relate to the hardware for the pinctrl
+registers, and must not be a virtual index of pin instances. The reason for
+this is to avoid mapping of the index in the dts files and the pin controller
+driver as it can change. And we want to avoid another case of interrupt
+numbering with pinctrl numbering.
+
 == Generic pin configuration node content ==
 
 Many data items that are represented in a pin configuration node are common
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -253,3 +253,154 @@ int pinctrl_dt_to_map(struct pinctrl *p)
 	pinctrl_dt_free_maps(p);
 	return ret;
 }
+
+/*
+ * For pinctrl binding, typically #pinctrl-cells is for the pin controller
+ * device, so either parent or grandparent. See pinctrl-bindings.txt.
+ */
+static int pinctrl_find_cells_size(const struct device_node *np,
+				   const char *cells_name)
+{
+	int cells_size, error;
+
+	error = of_property_read_u32(np->parent, cells_name, &cells_size);
+	if (error) {
+		error = of_property_read_u32(np->parent->parent,
+					     cells_name, &cells_size);
+		if (error)
+			return -ENOENT;
+	}
+
+	return cells_size;
+}
+
+/**
+ * pinctrl_get_list_and_count - Gets the list and it's cell size and number
+ * @np: pointer to device node with the property
+ * @list_name: property that contains the list
+ * @cells_name: property name that specifies phandle's argument count
+ * @list: pointer for the list found
+ * @cells_size: pointer for the cell size found
+ * @nr_elements: pointer for the number of elements found
+ *
+ * Typically np is a single pinctrl entry containing the list and
+ * cells_name is "#pinctrl-cells" for the parent pin controller.
+ */
+static int pinctrl_get_list_and_count(const struct device_node *np,
+				      const char *list_name,
+				      const char *cells_name,
+				      int nr_elem,
+				      const __be32 **list,
+				      int *cells_size,
+				      int *nr_elements)
+{
+	int size;
+
+	*cells_size = 0;
+	*nr_elements = 0;
+
+	*list = of_get_property(np, list_name, &size);
+	if (!*list)
+		return -ENOENT;
+
+	*cells_size = pinctrl_find_cells_size(np, cells_name);
+	if (*cells_size < 0)
+		return -ENOENT;
+
+	/* First element is always the index within the pinctrl device */
+	*nr_elements = (size / sizeof(**list)) / (*cells_size + 1);
+
+	return 0;
+}
+
+/**
+ * pinctrl_count_index_with_args - Count number of elements in a pinctrl entry
+ * @np: pointer to device node with the property
+ * @list_name: property that contains the list
+ * @cells_name: property name that specifies the argument count
+ *
+ * Counts the number of elements in a pinctrl array consisting of an index
+ * within the controller and a number of u32 entries specified for each
+ * entry. Note that device_node is always for the parent pin controller device.
+ */
+int pinctrl_count_index_with_args(const struct device_node *np,
+				  const char *list_name,
+				  const char *cells_name)
+{
+	const __be32 *list;
+	int size, nr_cells, error;
+
+	error = pinctrl_get_list_and_count(np, list_name, cells_name, -1,
+					   &list, &nr_cells, &size);
+	if (error)
+		return error;
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(pinctrl_count_index_with_args);
+
+/**
+ * pinctrl_copy_args - Populates of_phandle_args based on index
+ * @np: pointer to device node with the property
+ * @list: pointer to a list with the elements
+ * @index: entry within the list of elements
+ * @nr_cells: number of cells in the list
+ * @nr_elem: number of elements for each entry in the list
+ * @out_args: returned values
+ *
+ * Populates the of_phandle_args based on the index in the list.
+ */
+static int pinctrl_copy_args(const struct device_node *np,
+			     const __be32 *list,
+			     int index, int nr_cells, int nr_elem,
+			     struct of_phandle_args *out_args)
+{
+	int i;
+
+	memset(out_args, 0, sizeof(*out_args));
+	out_args->np = (struct device_node *)np;
+	out_args->args_count = nr_cells + 1;
+
+	if (index >= nr_elem)
+		return -EINVAL;
+
+	list += index * (nr_cells + 1);
+
+	for (i = 0; i < nr_cells + 1; i++)
+		out_args->args[i] = be32_to_cpup(list++);
+
+	return 0;
+}
+
+/**
+ * pinctrl_parse_index_with_args - Find a node pointed by index in a list
+ * @np: pointer to device node with the property
+ * @list_name: property that contains the list
+ * @cells_name: property name that specifies phandle's argument count
+ * @index: index within the list
+ * @out_arts: entries in the list pointed by index
+ *
+ * Finds the selected element in a pinctrl array consisting of an index
+ * within the controller and a number of u32 entries specified for each
+ * entry. Note that device_node is always for the parent pin controller device.
+ */
+int pinctrl_parse_index_with_args(const struct device_node *np,
+				  const char *list_name, const char *cells_name,
+				  int index, struct of_phandle_args *out_args)
+{
+	const __be32 *list;
+	int nr_elem, nr_cells, error;
+
+	error = pinctrl_get_list_and_count(np, list_name, cells_name, -1,
+					   &list, &nr_cells, &nr_elem);
+	if (error || !nr_cells)
+		return error;
+
+	error = pinctrl_copy_args(np, list, index, nr_cells, nr_elem,
+				  out_args);
+	if (error)
+		return error;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pinctrl_parse_index_with_args);
diff --git a/drivers/pinctrl/devicetree.h b/drivers/pinctrl/devicetree.h
--- a/drivers/pinctrl/devicetree.h
+++ b/drivers/pinctrl/devicetree.h
@@ -21,6 +21,14 @@
 void pinctrl_dt_free_maps(struct pinctrl *p);
 int pinctrl_dt_to_map(struct pinctrl *p);
 
+int pinctrl_count_index_with_args(const struct device_node *np,
+				  const char *list_name,
+				  const char *cells_name);
+
+int pinctrl_parse_index_with_args(const struct device_node *np,
+				  const char *list_name, const char *cells_name,
+				  int index, struct of_phandle_args *out_args);
+
 #else
 
 static inline int pinctrl_dt_to_map(struct pinctrl *p)
@@ -32,4 +40,20 @@ static inline void pinctrl_dt_free_maps(struct pinctrl *p)
 {
 }
 
+static inline int pinctrl_count_index_with_args(const struct device_node *np,
+						const char *list_name,
+						const char *cells_name)
+{
+	return -ENODEV;
+}
+
+static inline int
+pinctrl_parse_index_with_args(const struct device_node *np,
+			      const char *list_name,
+			      const char *cells_name, int index,
+			      struct of_phandle_args *out_args)
+{
+	return -ENODEV;
+}
+
 #endif
-- 
2.9.3

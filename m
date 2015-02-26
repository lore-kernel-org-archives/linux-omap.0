From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 4/6] drm/tilcdc: Add DRM_TILCDC_INIT for "ti,tilcdc,slave" binding support
Date: Thu, 26 Feb 2015 16:55:33 +0200
Message-ID: <6cf3243f87975ef349dead7af136870fa406ad6b.1424961754.git.jsarha@ti.com>
References: <cover.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbbBZO4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 09:56:16 -0500
In-Reply-To: <cover.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

Adds a DRM_TILCDC_INIT module for "ti,tilcdc,slave" node
conversion. The implementation is in tilcdc_boot_init.c and it uses
tilcdc_slave_convert.dts as a basis for creating a DTS overlay. The
DTS overlay adds an external tda998x encoder to tilcdc that
corresponds to the old tda998x based slave encoder.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/Kconfig                  |   6 +
 drivers/gpu/drm/tilcdc/Makefile                 |   2 +
 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c       | 270 ++++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts |  70 ++++++
 4 files changed, 348 insertions(+)
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts

diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
index 8394a0b..c35d088 100644
--- a/drivers/gpu/drm/tilcdc/Kconfig
+++ b/drivers/gpu/drm/tilcdc/Kconfig
@@ -1,3 +1,8 @@
+config DRM_TILCDC_INIT
+	select OF_RESOLVE
+	select OF_OVERLAY
+	bool
+
 config DRM_TILCDC
 	tristate "DRM Support for TI LCDC Display Controller"
 	depends on DRM && OF && ARM && HAVE_DMA_ATTRS
@@ -8,6 +13,7 @@ config DRM_TILCDC
 	select VIDEOMODE_HELPERS
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
+	select DRM_TILCDC_INIT
 	help
 	  Choose this option if you have an TI SoC with LCDC display
 	  controller, for example AM33xx in beagle-bone, DA8xx, or
diff --git a/drivers/gpu/drm/tilcdc/Makefile b/drivers/gpu/drm/tilcdc/Makefile
index e1f738b..fa184a5 100644
--- a/drivers/gpu/drm/tilcdc/Makefile
+++ b/drivers/gpu/drm/tilcdc/Makefile
@@ -3,6 +3,8 @@ ifeq (, $(findstring -W,$(EXTRA_CFLAGS)))
 	ccflags-y += -Werror
 endif
 
+obj-$(CONFIG_DRM_TILCDC_INIT) += tilcdc_boot_init.o tilcdc_slave_convert.dtb.o
+
 tilcdc-y := \
 	tilcdc_crtc.o \
 	tilcdc_tfp410.o \
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_boot_init.c b/drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
new file mode 100644
index 0000000..08f3110
--- /dev/null
+++ b/drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
@@ -0,0 +1,270 @@
+/*
+ * Copyright (C) 2015 Texas Instruments
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ */
+
+/*
+ * To support the old "ti,tilcdc,slave" binding the binding has to be
+ * transformed to the new external encoder binding.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/of_fdt.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+
+struct kfree_table {
+	int total;
+	int num;
+	void **table;
+};
+
+static int __init kfree_table_init(struct kfree_table *kft)
+{
+	kft->total = 128;
+	kft->num = 0;
+	kft->table = kmalloc(kft->total * sizeof(*kft->table),
+			     GFP_KERNEL);
+	if (!kft->table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int __init kfree_table_add(struct kfree_table *kft, void *p)
+{
+	if (kft->num == kft->total) {
+		void *old = kft->table;
+
+		kft->total *= 2;
+		kft->table = krealloc(old, kft->total * sizeof(*kft->table),
+				      GFP_KERNEL);
+		if (!kft->table) {
+			kft->table = old;
+			kfree(p);
+			return -ENOMEM;
+		}
+	}
+	kft->table[kft->num++] = p;
+	return 0;
+}
+
+static void __init kfree_table_free(struct kfree_table *kft)
+{
+	int i;
+
+	for (i = 0; i < kft->num; i++)
+		kfree(kft->table[i]);
+
+	kfree(kft->table);
+}
+
+static
+struct property * __init tilcdc_prop_dup(const struct property *prop,
+					 struct kfree_table *kft)
+{
+	struct property *nprop;
+
+	nprop = kzalloc(sizeof(*nprop), GFP_KERNEL);
+	if (!nprop || kfree_table_add(kft, nprop))
+		return NULL;
+
+	nprop->name = kstrdup(prop->name, GFP_KERNEL);
+	if (!nprop->name || kfree_table_add(kft, nprop->name))
+		return NULL;
+
+	nprop->value = kmemdup(prop->value, prop->length, GFP_KERNEL);
+	if (!nprop->value || kfree_table_add(kft, nprop->value))
+		return NULL;
+
+	nprop->length = prop->length;
+
+	return nprop;
+}
+
+static void __init tilcdc_copy_props(struct device_node *from,
+				     struct device_node *to,
+				     const char * const props[],
+				     struct kfree_table *kft)
+{
+	struct property *prop;
+	int i;
+
+	for (i = 0; props[i]; i++) {
+		prop = of_find_property(from, props[i], NULL);
+		if (!prop)
+			continue;
+
+		prop = tilcdc_prop_dup(prop, kft);
+		if (!prop)
+			continue;
+
+		prop->next = to->properties;
+		to->properties = prop;
+	}
+}
+
+static int __init tilcdc_prop_str_update(struct property *prop,
+					  const char *str,
+					  struct kfree_table *kft)
+{
+	prop->value = kstrdup(str, GFP_KERNEL);
+	if (kfree_table_add(kft, prop->value) || !prop->value)
+		return -ENOMEM;
+	prop->length = strlen(str)+1;
+	return 0;
+}
+
+static void __init tilcdc_node_disable(struct device_node *node)
+{
+	struct property *prop;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return;
+
+	prop->name = "status";
+	prop->value = "disabled";
+	prop->length = strlen((char *)prop->value)+1;
+
+	of_update_property(node, prop);
+}
+
+struct device_node * __init tilcdc_get_overlay(struct kfree_table *kft)
+{
+	extern uint8_t __dtb_tilcdc_slave_convert_begin[];
+	extern uint8_t __dtb_tilcdc_slave_convert_end[];
+	const int size = __dtb_tilcdc_slave_convert_end -
+		__dtb_tilcdc_slave_convert_begin;
+	static void *overlay_data;
+	struct device_node *overlay;
+	int ret;
+
+	if (!size) {
+		pr_warn("%s: No overlay data\n", __func__);
+		return NULL;
+	}
+
+	overlay_data = kmemdup(__dtb_tilcdc_slave_convert_begin,
+			       size, GFP_KERNEL);
+	if (!overlay_data || kfree_table_add(kft, overlay_data))
+		return NULL;
+
+	of_fdt_unflatten_tree(overlay_data, &overlay);
+	if (!overlay) {
+		pr_warn("%s: Unfattening overlay tree failed\n", __func__);
+		return NULL;
+	}
+
+	of_node_set_flag(overlay, OF_DETACHED);
+	ret = of_resolve_phandles(overlay);
+	if (ret) {
+		pr_err("%s: Failed to resolve phandles: %d\n", __func__, ret);
+		return NULL;
+	}
+
+	return overlay;
+}
+
+static const struct of_device_id tilcdc_slave_of_match[] __initconst = {
+	{ .compatible = "ti,tilcdc,slave", },
+	{},
+};
+
+static const struct of_device_id tilcdc_of_match[] __initconst = {
+	{ .compatible = "ti,am33xx-tilcdc", },
+	{},
+};
+
+static const struct of_device_id tilcdc_tda998x_of_match[] __initconst = {
+	{ .compatible = "nxp,tda998x", },
+	{},
+};
+
+static const char * const tilcdc_slave_props[] __initconst = {
+	"pinctrl-names",
+	"pinctrl-0",
+	"pinctrl-1",
+	NULL
+};
+
+void __init tilcdc_convert_slave_node(void)
+{
+	struct device_node *slave = NULL, *lcdc = NULL;
+	struct device_node *i2c = NULL, *fragment = NULL;
+	struct device_node *overlay, *encoder;
+	struct property *prop;
+	/* For all memory needed for the overlay tree. This memory can
+	   be freed after the overlay has been applied. */
+	struct kfree_table kft;
+	int ret;
+
+	if (kfree_table_init(&kft))
+		goto out;
+
+	lcdc = of_find_matching_node(NULL, tilcdc_of_match);
+	slave = of_find_matching_node(NULL, tilcdc_slave_of_match);
+
+	if (!slave || !of_device_is_available(lcdc))
+		goto out;
+
+	i2c = of_parse_phandle(slave, "i2c", 0);
+	if (!i2c) {
+		pr_err("%s: Can't find i2c node trough phandle\n", __func__);
+		goto out;
+	}
+
+	overlay = tilcdc_get_overlay(&kft);
+	if (!overlay)
+		goto out;
+
+	encoder = of_find_matching_node(overlay, tilcdc_tda998x_of_match);
+	if (!encoder) {
+		pr_err("%s: Failed to find tda998x node\n", __func__);
+		goto out;
+	}
+
+	tilcdc_copy_props(slave, encoder, tilcdc_slave_props, &kft);
+
+	for_each_child_of_node(overlay, fragment) {
+		prop = of_find_property(fragment, "target-path", NULL);
+		if (!prop)
+			continue;
+		if (!strncmp("i2c", (char *)prop->value, prop->length))
+			if (tilcdc_prop_str_update(prop, i2c->full_name, &kft))
+				goto out;
+		if (!strncmp("lcdc", (char *)prop->value, prop->length))
+			if (tilcdc_prop_str_update(prop, lcdc->full_name, &kft))
+				goto out;
+	}
+
+	tilcdc_node_disable(slave);
+
+	ret = of_overlay_create(overlay);
+	if (ret)
+		pr_err("%s: Creating overlay failed: %d\n", __func__, ret);
+	else
+		pr_info("%s: ti,tilcdc,slave node successfully converted\n",
+			__func__);
+out:
+	kfree_table_free(&kft);
+	of_node_put(i2c);
+	of_node_put(slave);
+	of_node_put(lcdc);
+	of_node_put(fragment);
+}
+
+int __init tilcdc_boot_init(void)
+{
+	tilcdc_convert_slave_node();
+	return 0;
+}
+
+subsys_initcall(tilcdc_boot_init);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts b/drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts
new file mode 100644
index 0000000..8a2bfa9
--- /dev/null
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts
@@ -0,0 +1,70 @@
+/*
+ * DTS overlay for converting ti,tilcdc,slave binding to new binding.
+ *
+ * Copyright (C) 2015 Texas Instruments Inc.
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+/*
+ * target-path property values are simple tags that are replaced with
+ * correct values in tildcdc_boot_init.c. Some properties are also copied
+ * over from the ti,tilcdc,slave node.
+ */
+/dts-v1/;
+/ {
+	fragment@0 {
+		target-path = "i2c";
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			tda19988 {
+				compatible = "nxp,tda998x";
+				reg = <0x70>;
+				status = "okay";
+
+				port {
+					hdmi_0: endpoint@0 {
+						remote-endpoint = <&lcd_0>;
+					};
+				};
+			};
+		};
+	};
+
+	fragment@1 {
+		target-path = "lcdc";
+		__overlay__ {
+			port {
+				lcd_0: endpoint@0 {
+					remote-endpoint = <&hdmi_0>;
+				};
+			};
+		};
+	};
+
+	__local_fixups__ {
+		fragment@0 {
+			__overlay__ {
+				tda19988 {
+					port {
+						endpoint@0 {
+							remote-endpoint	= <0>;
+						};
+					};
+				};
+			};
+		};
+		fragment@1 {
+			__overlay__ {
+				port {
+					endpoint@0 {
+						remote-endpoint	= <0>;
+					};
+				};
+			};
+		};
+	};
+};
-- 
1.9.1


From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 27/35] ARM: OMAP2+: pdata-quirks: add support for early and late pdata_quirks init
Date: Wed, 15 Apr 2015 15:53:14 +0300
Message-ID: <1429102402-5276-28-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52103 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbbDOMxQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:16 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

This splits up the platform bus registration to early boot and module
time probe versions, which register different portions of the bus based
on hwmod data availability. The common version is retained still for
supporting the different SoCs during transition time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h       |    2 +
 arch/arm/mach-omap2/pdata-quirks.c |  115 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 172b902..95b80a1 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -305,6 +305,8 @@ static inline void omap4_cpu_resume(void)
 
 #endif
 
+void omap_pdata_quirks_late_init(const struct of_device_id *);
+void omap_pdata_quirks_early_init(const struct of_device_id *);
 void pdata_quirks_init(const struct of_device_id *);
 void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6d5948a..ffdccd3 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -26,6 +26,7 @@
 #include "omap_device.h"
 #include "omap-secure.h"
 #include "soc.h"
+#include "clock.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -452,6 +453,120 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 	}
 }
 
+struct bus_entry {
+	struct platform_device *dev;
+	struct device_node *bus;
+	struct list_head link;
+};
+
+static LIST_HEAD(bus_list);
+
+static struct platform_device
+*omap_pdata_bus_create(struct device_node *bus,
+		       const struct of_device_id *bus_match,
+		       struct device *parent)
+{
+	const struct of_dev_auxdata *auxdata;
+	struct device_node *child;
+	struct platform_device *dev;
+	const char *oh_name;
+	const char *bus_id = NULL;
+	void *platform_data = NULL;
+	int i;
+	int count;
+
+	if (!of_get_property(bus, "compatible", NULL))
+		return NULL;
+
+	auxdata = of_dev_lookup(omap_auxdata_lookup, bus);
+	if (auxdata) {
+		bus_id = auxdata->name;
+		platform_data = auxdata->platform_data;
+	}
+
+	/* check hwmod availability */
+	count = of_property_count_strings(bus, "ti,hwmods");
+	for (i = 0; i < count; i++) {
+		of_property_read_string_index(bus, "ti,hwmods", i, &oh_name);
+		if (!omap_hwmod_lookup(oh_name)) {
+			pr_info("%s: hwmod %s not ready yet, skipping.\n",
+				__func__, oh_name);
+			return NULL;
+		}
+	}
+
+	dev = of_platform_device_create_pdata(bus, bus_id, platform_data,
+					      parent);
+
+	if (!dev || !of_match_node(bus_match, bus))
+		return NULL;
+
+	for_each_child_of_node(bus, child) {
+		omap_pdata_bus_create(child, bus_match, &dev->dev);
+	}
+
+	of_node_set_flag(bus, OF_POPULATED_BUS);
+
+	return dev;
+}
+
+void omap_pdata_quirks_late_init(const struct of_device_id *omap_dt_match_table)
+{
+	struct bus_entry *entry;
+	struct bus_entry *tmp;
+	struct device_node *child;
+
+	omapdss_early_init_of();
+
+	omap2_system_dma_init();
+
+	pdata_quirks_check(auxdata_quirks);
+
+	list_for_each_entry_safe(entry, tmp, &bus_list, link) {
+		for_each_child_of_node(entry->bus, child) {
+			omap_pdata_bus_create(child, omap_dt_match_table,
+					      &entry->dev->dev);
+		}
+
+		list_del(&entry->link);
+		kfree(entry);
+	}
+
+	pdata_quirks_check(pdata_quirks);
+
+	omapdss_init_of();
+
+#ifdef CONFIG_OMAP_HWMOD_DATA_MODULES
+	omap2_common_pm_late_init();
+
+	if (cpu_is_omap34xx())
+		omap3_pm_init();
+
+	omap2_clk_enable_autoidle_all();
+#endif
+}
+EXPORT_SYMBOL(omap_pdata_quirks_late_init);
+
+void __init omap_pdata_quirks_early_init(const struct of_device_id *bus_match)
+{
+	struct device_node *bus;
+	struct bus_entry *entry;
+	struct platform_device *dev;
+
+	omap_sdrc_init(NULL, NULL);
+
+	for_each_matching_node(bus, bus_match) {
+		dev = omap_pdata_bus_create(bus, bus_match, NULL);
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		entry->bus = bus;
+		entry->dev = dev;
+		list_add(&entry->link, &bus_list);
+	}
+
+	/* Populate any devices outside ocp bus */
+	of_platform_populate(NULL, bus_match, omap_auxdata_lookup, NULL);
+}
+
 void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 {
 	omap_sdrc_init(NULL, NULL);
-- 
1.7.9.5


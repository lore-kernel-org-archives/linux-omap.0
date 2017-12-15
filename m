From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] bus: ti-sysc: Add register bits for interconnect target modules
Date: Fri, 15 Dec 2017 10:08:56 -0800
Message-ID: <20171215180900.3243-6-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Let's add data for the known interconnect target module types by mapping
their register bits.

Note that we can handle many quirks for the older omap2 type1 modules
directly in the driver without a need for adding custom properties.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 256 ++++++++++++++++++++++++++++++++--
 include/linux/platform_data/ti-sysc.h |  40 ++++++
 2 files changed, 286 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -18,6 +18,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/ti-sysc.h>
+
+#include <dt-bindings/bus/ti-sysc.h>
 
 enum sysc_registers {
 	SYSC_REVISION,
@@ -45,6 +48,8 @@ static const char * const clock_names[] = { "fck", "ick", };
  * @offsets: register offsets from module base
  * @clocks: clocks used by the interconnect target module
  * @legacy_mode: configured for legacy mode if set
+ * @cap: interconnect target module capabilities
+ * @cfg: interconnect target module configuration
  */
 struct sysc {
 	struct device *dev;
@@ -54,6 +59,8 @@ struct sysc {
 	int offsets[SYSC_MAX_REGS];
 	struct clk *clocks[SYSC_MAX_CLOCKS];
 	const char *legacy_mode;
+	const struct sysc_capabilities *cap;
+	struct sysc_config cfg;
 };
 
 static u32 sysc_read_revision(struct sysc *ddata)
@@ -474,6 +481,228 @@ static void sysc_unprepare(struct sysc *ddata)
 	}
 }
 
+/*
+ * Common sysc register bits found on omap2, also known as type1
+ */
+static const struct sysc_regbits sysc_regbits_omap2 = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = 12,
+	.sidle_shift = 3,
+	.clkact_shift = 8,
+	.emufree_shift = 5,
+	.enwkup_shift = 2,
+	.srst_shift = 1,
+	.autoidle_shift = 0,
+};
+
+static const struct sysc_capabilities sysc_omap2 = {
+	.type = TI_SYSC_OMAP2,
+	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY | SYSC_OMAP2_EMUFREE |
+		     SYSC_OMAP2_ENAWAKEUP | SYSC_OMAP2_SOFTRESET |
+		     SYSC_OMAP2_AUTOIDLE,
+	.regbits = &sysc_regbits_omap2,
+};
+
+/* All omap2 and 3 timers, and timers 1, 2 & 10 on omap 4 and 5 */
+static const struct sysc_capabilities sysc_omap2_timer = {
+	.type = TI_SYSC_OMAP2_TIMER,
+	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY | SYSC_OMAP2_EMUFREE |
+		     SYSC_OMAP2_ENAWAKEUP | SYSC_OMAP2_SOFTRESET |
+		     SYSC_OMAP2_AUTOIDLE,
+	.regbits = &sysc_regbits_omap2,
+	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT,
+};
+
+/*
+ * SHAM2 (SHA1/MD5) sysc found on omap3, a variant of sysc_regbits_omap2
+ * with different sidle position
+ */
+static const struct sysc_regbits sysc_regbits_omap3_sham = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = 4,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = 1,
+	.autoidle_shift = 0,
+	.emufree_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap3_sham = {
+	.type = TI_SYSC_OMAP3_SHAM,
+	.sysc_mask = SYSC_OMAP2_SOFTRESET | SYSC_OMAP2_AUTOIDLE,
+	.regbits = &sysc_regbits_omap3_sham,
+};
+
+/*
+ * AES register bits found on omap3 and later, a variant of
+ * sysc_regbits_omap2 with different sidle position
+ */
+static const struct sysc_regbits sysc_regbits_omap3_aes = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = 6,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = 1,
+	.autoidle_shift = 0,
+	.emufree_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap3_aes = {
+	.type = TI_SYSC_OMAP3_AES,
+	.sysc_mask = SYSC_OMAP2_SOFTRESET | SYSC_OMAP2_AUTOIDLE,
+	.regbits = &sysc_regbits_omap3_aes,
+};
+
+/*
+ * Common sysc register bits found on omap4, also known as type2
+ */
+static const struct sysc_regbits sysc_regbits_omap4 = {
+	.dmadisable_shift = 16,
+	.midle_shift = 4,
+	.sidle_shift = 2,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.emufree_shift = 1,
+	.srst_shift = 0,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap4 = {
+	.type = TI_SYSC_OMAP4,
+	.sysc_mask = SYSC_OMAP4_DMADISABLE | SYSC_OMAP4_FREEEMU |
+		     SYSC_OMAP4_SOFTRESET,
+	.regbits = &sysc_regbits_omap4,
+};
+
+static const struct sysc_capabilities sysc_omap4_timer = {
+	.type = TI_SYSC_OMAP4_TIMER,
+	.sysc_mask = SYSC_OMAP4_DMADISABLE | SYSC_OMAP4_FREEEMU |
+		     SYSC_OMAP4_SOFTRESET,
+	.regbits = &sysc_regbits_omap4,
+};
+
+/*
+ * Common sysc register bits found on omap4, also known as type3
+ */
+static const struct sysc_regbits sysc_regbits_omap4_simple = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = 2,
+	.sidle_shift = 0,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap4_simple = {
+	.type = TI_SYSC_OMAP4_SIMPLE,
+	.regbits = &sysc_regbits_omap4_simple,
+};
+
+/*
+ * SmartReflex sysc found on omap34xx
+ */
+static const struct sysc_regbits sysc_regbits_omap34xx_sr = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = -ENODEV,
+	.clkact_shift = 20,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_34xx_sr = {
+	.type = TI_SYSC_OMAP34XX_SR,
+	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY,
+	.regbits = &sysc_regbits_omap34xx_sr,
+	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED,
+};
+
+/*
+ * SmartReflex sysc found on omap36xx and later
+ */
+static const struct sysc_regbits sysc_regbits_omap36xx_sr = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = 24,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = 26,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_36xx_sr = {
+	.type = TI_SYSC_OMAP36XX_SR,
+	.sysc_mask = SYSC_OMAP2_ENAWAKEUP,
+	.regbits = &sysc_regbits_omap36xx_sr,
+	.mod_quirks = SYSC_QUIRK_UNCACHED,
+};
+
+static const struct sysc_capabilities sysc_omap4_sr = {
+	.type = TI_SYSC_OMAP4_SR,
+	.regbits = &sysc_regbits_omap36xx_sr,
+};
+
+/*
+ * McASP register bits found on omap4 and later
+ */
+static const struct sysc_regbits sysc_regbits_omap4_mcasp = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = 0,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap4_mcasp = {
+	.type = TI_SYSC_OMAP4_MCASP,
+	.regbits = &sysc_regbits_omap4_mcasp,
+};
+
+/*
+ * FS USB host found on omap4 and later
+ */
+static const struct sysc_regbits sysc_regbits_omap4_usb_host_fs = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = 24,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = 26,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
+	.type = TI_SYSC_OMAP4_USB_HOST_FS,
+	.sysc_mask = SYSC_OMAP2_ENAWAKEUP,
+	.regbits = &sysc_regbits_omap4_usb_host_fs,
+};
+
+static int sysc_init_match(struct sysc *ddata)
+{
+	const struct sysc_capabilities *cap;
+
+	cap = of_device_get_match_data(ddata->dev);
+	if (!cap)
+		return -EINVAL;
+
+	ddata->cap = cap;
+	if (ddata->cap)
+		ddata->cfg.quirks |= ddata->cap->mod_quirks;
+
+	return 0;
+}
+
 static int sysc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -487,6 +716,10 @@ static int sysc_probe(struct platform_device *pdev)
 	ddata->dev = &pdev->dev;
 	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
 
+	error = sysc_init_match(ddata);
+	if (error)
+		return error;
+
 	error = sysc_get_clocks(ddata);
 	if (error)
 		return error;
@@ -554,16 +787,19 @@ static int sysc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sysc_match[] = {
-	{ .compatible = "ti,sysc-omap2" },
-	{ .compatible = "ti,sysc-omap4" },
-	{ .compatible = "ti,sysc-omap4-simple" },
-	{ .compatible = "ti,sysc-omap3430-sr" },
-	{ .compatible = "ti,sysc-omap3630-sr" },
-	{ .compatible = "ti,sysc-omap4-sr" },
-	{ .compatible = "ti,sysc-omap3-sham" },
-	{ .compatible = "ti,sysc-omap-aes" },
-	{ .compatible = "ti,sysc-mcasp" },
-	{ .compatible = "ti,sysc-usb-host-fs" },
+	{ .compatible = "ti,sysc-omap2", .data = &sysc_omap2, },
+	{ .compatible = "ti,sysc-omap2-timer", .data = &sysc_omap2_timer, },
+	{ .compatible = "ti,sysc-omap4", .data = &sysc_omap4, },
+	{ .compatible = "ti,sysc-omap4-timer", .data = &sysc_omap4_timer, },
+	{ .compatible = "ti,sysc-omap4-simple", .data = &sysc_omap4_simple, },
+	{ .compatible = "ti,sysc-omap3430-sr", .data = &sysc_34xx_sr, },
+	{ .compatible = "ti,sysc-omap3630-sr", .data = &sysc_36xx_sr, },
+	{ .compatible = "ti,sysc-omap4-sr", .data = &sysc_omap4_sr, },
+	{ .compatible = "ti,sysc-omap3-sham", .data = &sysc_omap3_sham, },
+	{ .compatible = "ti,sysc-omap-aes", .data = &sysc_omap3_aes, },
+	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
+	{ .compatible = "ti,sysc-usb-host-fs",
+	  .data = &sysc_omap4_usb_host_fs, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -1,6 +1,21 @@
 #ifndef __TI_SYSC_DATA_H__
 #define __TI_SYSC_DATA_H__
 
+enum ti_sysc_module_type {
+	TI_SYSC_OMAP2,
+	TI_SYSC_OMAP2_TIMER,
+	TI_SYSC_OMAP3_SHAM,
+	TI_SYSC_OMAP3_AES,
+	TI_SYSC_OMAP4,
+	TI_SYSC_OMAP4_TIMER,
+	TI_SYSC_OMAP4_SIMPLE,
+	TI_SYSC_OMAP34XX_SR,
+	TI_SYSC_OMAP36XX_SR,
+	TI_SYSC_OMAP4_SR,
+	TI_SYSC_OMAP4_MCASP,
+	TI_SYSC_OMAP4_USB_HOST_FS,
+};
+
 /**
  * struct sysc_regbits - TI OCP_SYSCONFIG register field offsets
  * @midle_shift: Offset of the midle bit
@@ -26,4 +41,29 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_UNCACHED		BIT(1)
+#define SYSC_QUIRK_USE_CLOCKACT		BIT(0)
+
+/**
+ * struct sysc_capabilities - capabilities for an interconnect target module
+ *
+ * @sysc_mask: bitmask of supported SYSCONFIG register bits
+ * @regbits: bitmask of SYSCONFIG register bits
+ * @mod_quirks: bitmask of module specific quirks
+ */
+struct sysc_capabilities {
+	const enum ti_sysc_module_type type;
+	const u32 sysc_mask;
+	const struct sysc_regbits *regbits;
+	const u32 mod_quirks;
+};
+
+/**
+ * struct sysc_config - configuration for an interconnect target module
+ * @quirks: bitmask of enabled quirks
+ */
+struct sysc_config {
+	u32 quirks;
+};
+
 #endif	/* __TI_SYSC_DATA_H__ */
-- 
2.15.0

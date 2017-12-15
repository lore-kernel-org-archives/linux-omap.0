From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/9] bus: ti-sysc: Add parsing of module capabilities
Date: Fri, 15 Dec 2017 10:08:59 -0800
Message-ID: <20171215180900.3243-9-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We need to configure the interconnect target module based on the
device three configuration.

Let's also add a new quirk for SYSC_QUIRK_RESET_STATUS to indicate
that the SYSCONFIG reset bit changes after the reset is done.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 100 ++++++++++++++++++++++++++++++++++
 include/linux/platform_data/ti-sysc.h |  10 ++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -39,6 +39,9 @@ enum sysc_clocks {
 
 static const char * const clock_names[] = { "fck", "ick", };
 
+#define SYSC_IDLEMODE_MASK		3
+#define SYSC_CLOCKACTIVITY_MASK		3
+
 /**
  * struct sysc - TI sysc interconnect target module registers and capabilities
  * @dev: struct device pointer
@@ -517,6 +520,91 @@ static int sysc_init_module(struct sysc *ddata)
 	return 0;
 }
 
+static int sysc_init_sysc_mask(struct sysc *ddata)
+{
+	struct device_node *np = ddata->dev->of_node;
+	int error;
+	u32 val;
+
+	error = of_property_read_u32(np, "ti,sysc-mask", &val);
+	if (error)
+		return 0;
+
+	if (val)
+		ddata->cfg.sysc_val = val & ddata->cap->sysc_mask;
+	else
+		ddata->cfg.sysc_val = ddata->cap->sysc_mask;
+
+	return 0;
+}
+
+static int sysc_init_idlemode(struct sysc *ddata, u8 *idlemodes,
+			      const char *name)
+{
+	struct device_node *np = ddata->dev->of_node;
+	struct property *prop;
+	const __be32 *p;
+	u32 val;
+
+	of_property_for_each_u32(np, name, prop, p, val) {
+		if (val >= SYSC_NR_IDLEMODES) {
+			dev_err(ddata->dev, "invalid idlemode: %i\n", val);
+			return -EINVAL;
+		}
+		*idlemodes |=  (1 << val);
+	}
+
+	return 0;
+}
+
+static int sysc_init_idlemodes(struct sysc *ddata)
+{
+	int error;
+
+	error = sysc_init_idlemode(ddata, &ddata->cfg.midlemodes,
+				   "ti,sysc-midle");
+	if (error)
+		return error;
+
+	error = sysc_init_idlemode(ddata, &ddata->cfg.sidlemodes,
+				   "ti,sysc-sidle");
+	if (error)
+		return error;
+
+	return 0;
+}
+
+/*
+ * Only some devices on omap4 and later have SYSCONFIG reset done
+ * bit. We can detect this if there is no SYSSTATUS at all, or the
+ * SYSTATUS bit 0 is not used. Note that some SYSSTATUS registers
+ * have multiple bits for the child devices like OHCI and EHCI.
+ * Depends on SYSC being parsed first.
+ */
+static int sysc_init_syss_mask(struct sysc *ddata)
+{
+	struct device_node *np = ddata->dev->of_node;
+	int error;
+	u32 val;
+
+	error = of_property_read_u32(np, "ti,syss-mask", &val);
+	if (error) {
+		if ((ddata->cap->type == TI_SYSC_OMAP4 ||
+		     ddata->cap->type == TI_SYSC_OMAP4_TIMER) &&
+		    (ddata->cfg.sysc_val & SYSC_OMAP4_SOFTRESET))
+			ddata->cfg.quirks |= SYSC_QUIRK_RESET_STATUS;
+
+		return 0;
+	}
+
+	if (!(val & 1) && (ddata->cfg.sysc_val & SYSC_OMAP4_SOFTRESET))
+		ddata->cfg.quirks |= SYSC_QUIRK_RESET_STATUS;
+
+	ddata->cfg.syss_mask = val;
+
+	return 0;
+}
+
 /* Device tree configured quirks */
 struct sysc_dts_quirk {
 	const char *name;
@@ -820,6 +908,18 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
+	error = sysc_init_sysc_mask(ddata);
+	if (error)
+		goto unprepare;
+
+	error = sysc_init_idlemodes(ddata);
+	if (error)
+		goto unprepare;
+
+	error = sysc_init_syss_mask(ddata);
+	if (error)
+		goto unprepare;
+
 	pm_runtime_enable(ddata->dev);
 
 	error = sysc_init_module(ddata);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -41,6 +41,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_RESET_STATUS		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
 #define SYSC_QUIRK_NO_RESET_ON_INIT	BIT(5)
 #define SYSC_QUIRK_OPT_CLKS_NEEDED	BIT(4)
@@ -49,6 +50,8 @@ struct sysc_regbits {
 #define SYSC_QUIRK_UNCACHED		BIT(1)
 #define SYSC_QUIRK_USE_CLOCKACT		BIT(0)
 
+#define SYSC_NR_IDLEMODES		4
+
 /**
  * struct sysc_capabilities - capabilities for an interconnect target module
  *
@@ -65,10 +68,17 @@ struct sysc_capabilities {
 
 /**
  * struct sysc_config - configuration for an interconnect target module
+ * @sysc_val: configured value for sysc register
+ * @midlemodes: bitmask of supported master idle modes
+ * @sidlemodes: bitmask of supported master idle modes
  * @srst_udelay: optional delay needed after OCP soft reset
  * @quirks: bitmask of enabled quirks
  */
 struct sysc_config {
+	u32 sysc_val;
+	u32 syss_mask;
+	u8 midlemodes;
+	u8 sidlemodes;
 	u8 srst_udelay;
 	u32 quirks;
 };
-- 
2.15.0

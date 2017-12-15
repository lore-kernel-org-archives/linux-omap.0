From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/9] bus: ti-sysc: Handle module quirks based dts configuration
Date: Fri, 15 Dec 2017 10:08:58 -0800
Message-ID: <20171215180900.3243-8-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171215180900.3243-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's configure few module quirks via device tree using the
properties for "ti,no-idle-on-init", "ti,no-reset-on-init"
and "ti,sysc-delay-us".

Let's also reorder the probe a bit so we have pdata available
earlier, and move the PM runtime calls to sysc_init_module()
from sysc_read_revision().

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/bus/ti-sysc.c                 | 114 ++++++++++++++++++++++++++++------
 include/linux/platform_data/ti-sysc.h |   6 ++
 2 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -50,6 +50,8 @@ static const char * const clock_names[] = { "fck", "ick", };
  * @legacy_mode: configured for legacy mode if set
  * @cap: interconnect target module capabilities
  * @cfg: interconnect target module configuration
+ * @name: name if available
+ * @revision: interconnect target module revision
  */
 struct sysc {
 	struct device *dev;
@@ -61,12 +63,32 @@ struct sysc {
 	const char *legacy_mode;
 	const struct sysc_capabilities *cap;
 	struct sysc_config cfg;
+	const char *name;
+	u32 revision;
 };
 
+static u32 sysc_read(struct sysc *ddata, int offset)
+{
+	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
+		u32 val;
+
+		val = readw_relaxed(ddata->module_va + offset);
+		val |= (readw_relaxed(ddata->module_va + offset + 4) << 16);
+
+		return val;
+	}
+
+	return readl_relaxed(ddata->module_va + offset);
+}
+
 static u32 sysc_read_revision(struct sysc *ddata)
 {
-	return readl_relaxed(ddata->module_va +
-			     ddata->offsets[SYSC_REVISION]);
+	int offset = ddata->offsets[SYSC_REVISION];
+
+	if (offset < 0)
+		return 0;
+
+	return sysc_read(ddata, offset);
 }
 
 static int sysc_get_one_clock(struct sysc *ddata,
@@ -393,22 +415,12 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
  */
 static int sysc_show_rev(char *bufp, struct sysc *ddata)
 {
-	int error, len;
+	int len;
 
 	if (ddata->offsets[SYSC_REVISION] < 0)
 		return sprintf(bufp, ":NA");
 
-	error = pm_runtime_get_sync(ddata->dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(ddata->dev);
-
-		return 0;
-	}
-
-	len = sprintf(bufp, ":%08x", sysc_read_revision(ddata));
-
-	pm_runtime_mark_last_busy(ddata->dev);
-	pm_runtime_put_autosuspend(ddata->dev);
+	len = sprintf(bufp, ":%08x", ddata->revision);
 
 	return len;
 }
@@ -488,6 +500,66 @@ static const struct dev_pm_ops sysc_pm_ops = {
 			   NULL)
 };
 
+/* At this point the module is configured enough to read the revision */
+static int sysc_init_module(struct sysc *ddata)
+{
+	int error;
+
+	error = pm_runtime_get_sync(ddata->dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(ddata->dev);
+
+		return 0;
+	}
+	ddata->revision = sysc_read_revision(ddata);
+	pm_runtime_put_sync(ddata->dev);
+
+	return 0;
+}
+
+/* Device tree configured quirks */
+struct sysc_dts_quirk {
+	const char *name;
+	u32 mask;
+};
+
+static const struct sysc_dts_quirk sysc_dts_quirks[] = {
+	{ .name = "ti,no-idle-on-init",
+	  .mask = SYSC_QUIRK_NO_IDLE_ON_INIT, },
+	{ .name = "ti,no-reset-on-init",
+	  .mask = SYSC_QUIRK_NO_RESET_ON_INIT, },
+};
+
+static int sysc_init_dts_quirks(struct sysc *ddata)
+{
+	struct device_node *np = ddata->dev->of_node;
+	const struct property *prop;
+	int i, len, error;
+	u32 val;
+
+	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
+
+	for (i = 0; i < ARRAY_SIZE(sysc_dts_quirks); i++) {
+		prop = of_get_property(np, sysc_dts_quirks[i].name, &len);
+		if (!prop)
+			break;
+
+		ddata->cfg.quirks |= sysc_dts_quirks[i].mask;
+	}
+
+	error = of_property_read_u32(np, "ti,sysc-delay-us", &val);
+	if (!error) {
+		if (val > 255) {
+			dev_warn(ddata->dev, "bad ti,sysc-delay-us: %i\n",
+				 val);
+		}
+
+		ddata->cfg.srst_udelay = (u8)val;
+	}
+
+	return 0;
+}
+
 static void sysc_unprepare(struct sysc *ddata)
 {
 	int i;
@@ -722,7 +794,6 @@ static int sysc_init_match(struct sysc *ddata)
 
 static int sysc_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct sysc *ddata;
 	int error;
 
@@ -731,12 +802,16 @@ static int sysc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
-	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
+	platform_set_drvdata(pdev, ddata);
 
 	error = sysc_init_match(ddata);
 	if (error)
 		return error;
 
+	error = sysc_init_dts_quirks(ddata);
+	if (error)
+		goto unprepare;
+
 	error = sysc_get_clocks(ddata);
 	if (error)
 		return error;
@@ -745,9 +820,12 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
-	platform_set_drvdata(pdev, ddata);
-
 	pm_runtime_enable(ddata->dev);
+
+	error = sysc_init_module(ddata);
+	if (error)
+		goto unprepare;
+
 	error = pm_runtime_get_sync(ddata->dev);
 	if (error < 0) {
 		pm_runtime_put_noidle(ddata->dev);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -41,6 +41,10 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
+#define SYSC_QUIRK_NO_RESET_ON_INIT	BIT(5)
+#define SYSC_QUIRK_OPT_CLKS_NEEDED	BIT(4)
+#define SYSC_QUIRK_OPT_CLKS_IN_RESET	BIT(3)
 #define SYSC_QUIRK_16BIT		BIT(2)
 #define SYSC_QUIRK_UNCACHED		BIT(1)
 #define SYSC_QUIRK_USE_CLOCKACT		BIT(0)
@@ -61,9 +65,11 @@ struct sysc_capabilities {
 
 /**
  * struct sysc_config - configuration for an interconnect target module
+ * @srst_udelay: optional delay needed after OCP soft reset
  * @quirks: bitmask of enabled quirks
  */
 struct sysc_config {
+	u8 srst_udelay;
 	u32 quirks;
 };
 
-- 
2.15.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

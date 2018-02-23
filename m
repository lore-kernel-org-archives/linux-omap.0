From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] bus: ti-sysc: Add support for platform data callbacks
Date: Fri, 23 Feb 2018 13:00:54 -0800
Message-ID: <20180223210100.86732-7-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to pass the device tree configuration for interconnect target
modules from ti-sysc driver to the existing platform hwmod code.

This allows us to first validate the dts data against the existing
platform data before we start dropping the platform data in favor of
device tree data.

To do this, let's add platform data callbacks for PM runtime functions
to call for the interconnect target modules if platform data is
available.

Note that as ti-sysc driver can rebind, omap_auxdata_lookup and related
functions can no longer be __init.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c      |  4 +-
 arch/arm/mach-omap2/pdata-quirks.c    | 40 ++++++++++++++-
 drivers/bus/ti-sysc.c                 | 96 ++++++++++++++++++++++++++++++-----
 include/linux/platform_data/ti-sysc.h | 49 ++++++++++++++++++
 4 files changed, 172 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -566,11 +566,11 @@ static int n8x0_menelaus_late_init(struct device *dev)
 }
 #endif
 
-struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
+struct menelaus_platform_data n8x0_menelaus_platform_data = {
 	.late_init = n8x0_menelaus_late_init,
 };
 
-struct aic3x_pdata n810_aic33_data __initdata = {
+struct aic3x_pdata n810_aic33_data = {
 	.gpio_reset = 118,
 };
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -24,6 +24,7 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
+#include <linux/platform_data/ti-sysc.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
@@ -455,6 +456,42 @@ static void __init dra7x_evm_mmc_quirk(void)
 }
 #endif
 
+static int ti_sysc_enable_module(struct device *dev,
+				 const struct ti_sysc_cookie *cookie)
+{
+	if (!cookie->data)
+		return -EINVAL;
+
+	return omap_hwmod_enable(cookie->data);
+}
+
+static int ti_sysc_idle_module(struct device *dev,
+			       const struct ti_sysc_cookie *cookie)
+{
+	if (!cookie->data)
+		return -EINVAL;
+
+	return omap_hwmod_idle(cookie->data);
+}
+
+static int ti_sysc_shutdown_module(struct device *dev,
+				   const struct ti_sysc_cookie *cookie)
+{
+	if (!cookie->data)
+		return -EINVAL;
+
+	return omap_hwmod_shutdown(cookie->data);
+}
+
+static struct of_dev_auxdata omap_auxdata_lookup[];
+
+static struct ti_sysc_platform_data ti_sysc_pdata = {
+	.auxdata = omap_auxdata_lookup,
+	.enable_module = ti_sysc_enable_module,
+	.idle_module = ti_sysc_idle_module,
+	.shutdown_module = ti_sysc_shutdown_module,
+};
+
 static struct pcs_pdata pcs_pdata;
 
 void omap_pcs_legacy_init(int irq, void (*rearm)(void))
@@ -545,7 +582,7 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 
 struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
 
-static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
 	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
@@ -603,6 +640,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 		       &dra7_hsmmc_data_mmc3),
 #endif
 	/* Common auxdata */
+	OF_DEV_AUXDATA("ti,sysc", 0, NULL, &ti_sysc_pdata),
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
 	{ /* sentinel */ },
 };
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -25,13 +25,6 @@
 
 #include <dt-bindings/bus/ti-sysc.h>
 
-enum sysc_registers {
-	SYSC_REVISION,
-	SYSC_SYSCONFIG,
-	SYSC_SYSSTATUS,
-	SYSC_MAX_REGS,
-};
-
 static const char * const reg_names[] = { "rev", "sysc", "syss", };
 
 enum sysc_clocks {
@@ -70,6 +63,7 @@ struct sysc {
 	const char *legacy_mode;
 	const struct sysc_capabilities *cap;
 	struct sysc_config cfg;
+	struct ti_sysc_cookie cookie;
 	const char *name;
 	u32 revision;
 	bool enabled;
@@ -494,6 +488,7 @@ static void sysc_show_registers(struct sysc *ddata)
 		bufp += sysc_show_reg(ddata, bufp, i);
 
 	bufp += sysc_show_rev(bufp, ddata);
+	bufp += sysc_show_rev(bufp, ddata);
 
 	dev_dbg(ddata->dev, "%llx:%x%s\n",
 		ddata->module_pa, ddata->module_size,
@@ -502,33 +497,70 @@ static void sysc_show_registers(struct sysc *ddata)
 
 static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 {
+	struct ti_sysc_platform_data *pdata;
 	struct sysc *ddata;
-	int i;
+	int error = 0, i;
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->legacy_mode)
+	if (!ddata->enabled)
 		return 0;
 
+	if (ddata->legacy_mode) {
+		pdata = dev_get_platdata(ddata->dev);
+		if (!pdata)
+			return 0;
+
+		if (!pdata->idle_module)
+			return -ENODEV;
+
+		error = pdata->idle_module(dev, &ddata->cookie);
+		if (error)
+			dev_err(dev, "%s: could not idle: %i\n",
+				__func__, error);
+
+		goto idled;
+	}
+
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
 		clk_disable(ddata->clocks[i]);
 	}
 
-	return 0;
+idled:
+	ddata->enabled = false;
+
+	return error;
 }
 
 static int __maybe_unused sysc_runtime_resume(struct device *dev)
 {
+	struct ti_sysc_platform_data *pdata;
 	struct sysc *ddata;
-	int i, error;
+	int error = 0, i;
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->legacy_mode)
+	if (ddata->enabled)
 		return 0;
 
+	if (ddata->legacy_mode) {
+		pdata = dev_get_platdata(ddata->dev);
+		if (!pdata)
+			return 0;
+
+		if (!pdata->enable_module)
+			return -ENODEV;
+
+		error = pdata->enable_module(dev, &ddata->cookie);
+		if (error)
+			dev_err(dev, "%s: could not enable: %i\n",
+				__func__, error);
+
+		goto awake;
+	}
+
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
@@ -537,7 +569,10 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 			return error;
 	}
 
-	return 0;
+awake:
+	ddata->enabled = true;
+
+	return error;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1007,6 +1042,33 @@ static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
 	.regbits = &sysc_regbits_omap4_usb_host_fs,
 };
 
+static int sysc_init_pdata(struct sysc *ddata)
+{
+	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
+	struct ti_sysc_module_data mdata;
+	int error = 0;
+
+	if (!pdata || !ddata->legacy_mode)
+		return 0;
+
+	mdata.name = ddata->legacy_mode;
+	mdata.module_pa = ddata->module_pa;
+	mdata.module_size = ddata->module_size;
+	mdata.offsets = ddata->offsets;
+	mdata.nr_offsets = SYSC_MAX_REGS;
+	mdata.cap = ddata->cap;
+	mdata.cfg = &ddata->cfg;
+
+	if (!pdata->init_module)
+		return -ENODEV;
+
+	error = pdata->init_module(ddata->dev, &mdata, &ddata->cookie);
+	if (error == -EEXIST)
+		error = 0;
+
+	return error;
+}
+
 static int sysc_init_match(struct sysc *ddata)
 {
 	const struct sysc_capabilities *cap;
@@ -1034,6 +1096,7 @@ static void ti_sysc_idle(struct work_struct *work)
 
 static int sysc_probe(struct platform_device *pdev)
 {
+	struct ti_sysc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct sysc *ddata;
 	int error;
 
@@ -1072,6 +1135,10 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
+	error = sysc_init_pdata(ddata);
+	if (error)
+		goto unprepare;
+
 	pm_runtime_enable(ddata->dev);
 
 	error = sysc_init_module(ddata);
@@ -1089,7 +1156,8 @@ static int sysc_probe(struct platform_device *pdev)
 
 	ddata->dev->type = &sysc_device_type;
 	error = of_platform_populate(ddata->dev->of_node,
-				     NULL, NULL, ddata->dev);
+				     NULL, pdata ? pdata->auxdata : NULL,
+				     ddata->dev);
 	if (error)
 		goto err;
 
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -16,6 +16,10 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_USB_HOST_FS,
 };
 
+struct ti_sysc_cookie {
+	void *data;
+};
+
 /**
  * struct sysc_regbits - TI OCP_SYSCONFIG register field offsets
  * @midle_shift: Offset of the midle bit
@@ -83,4 +87,49 @@ struct sysc_config {
 	u32 quirks;
 };
 
+enum sysc_registers {
+	SYSC_REVISION,
+	SYSC_SYSCONFIG,
+	SYSC_SYSSTATUS,
+	SYSC_MAX_REGS,
+};
+
+/**
+ * struct ti_sysc_module_data - ti-sysc to hwmod translation data for a module
+ * @name: legacy "ti,hwmods" module name
+ * @module_pa: physical address of the interconnect target module
+ * @module_size: size of the interconnect target module
+ * @offsets: array of register offsets as listed in enum sysc_registers
+ * @nr_offsets: number of registers
+ * @cap: interconnect target module capabilities
+ * @cfg: interconnect target module configuration
+ *
+ * This data is enough to allocate a new struct omap_hwmod_class_sysconfig
+ * based on device tree data parsed by ti-sysc driver.
+ */
+struct ti_sysc_module_data {
+	const char *name;
+	u64 module_pa;
+	u32 module_size;
+	int *offsets;
+	int nr_offsets;
+	const struct sysc_capabilities *cap;
+	struct sysc_config *cfg;
+};
+
+struct device;
+
+struct ti_sysc_platform_data {
+	struct of_dev_auxdata *auxdata;
+	int (*init_module)(struct device *dev,
+			   const struct ti_sysc_module_data *data,
+			   struct ti_sysc_cookie *cookie);
+	int (*enable_module)(struct device *dev,
+			     const struct ti_sysc_cookie *cookie);
+	int (*idle_module)(struct device *dev,
+			   const struct ti_sysc_cookie *cookie);
+	int (*shutdown_module)(struct device *dev,
+			       const struct ti_sysc_cookie *cookie);
+};
+
 #endif	/* __TI_SYSC_DATA_H__ */
-- 
2.16.2

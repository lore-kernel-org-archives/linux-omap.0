From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] bus: ti-sysc: Handle some devices in omap_device
 compatible way
Date: Fri, 23 Feb 2018 13:00:55 -0800
Message-ID: <20180223210100.86732-8-tony@atomide.com>
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

Now that ti-sysc can manage child devices, we must also be backwards
compatible with the current omap_device code. With omap_device, we
assume that the child device manages the interconnect target module
directly.

The drivers needing special handling are the ones that still set
pm_runtime_irq_safe(). In the long run we want to update those drivers
as otherwise they will cause problems with genpd as a permanent PM
runtime usage count is set on the parent device.

We can handle omap_device these devices by improving the ti-sysc quirk
handling to detect the devices needing special handling based on
register map and revision register if usable. We also need to implement
dev_pm_domain for these child devices just like omap_device does.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 227 +++++++++++++++++++++++++++++++++-
 include/linux/platform_data/ti-sysc.h |   1 +
 2 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -14,8 +14,10 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -68,6 +70,7 @@ struct sysc {
 	u32 revision;
 	bool enabled;
 	bool needs_resume;
+	bool child_needs_resume;
 	struct delayed_work idle_work;
 };
 
@@ -474,6 +477,14 @@ static int sysc_show_reg(struct sysc *ddata,
 	return sprintf(bufp, ":%x", ddata->offsets[reg]);
 }
 
+static int sysc_show_name(char *bufp, struct sysc *ddata)
+{
+	if (!ddata->name)
+		return 0;
+
+	return sprintf(bufp, ":%s", ddata->name);
+}
+
 /**
  * sysc_show_registers - show information about interconnect target module
  * @ddata: device driver data
@@ -488,7 +499,7 @@ static void sysc_show_registers(struct sysc *ddata)
 		bufp += sysc_show_reg(ddata, bufp, i);
 
 	bufp += sysc_show_rev(bufp, ddata);
-	bufp += sysc_show_rev(bufp, ddata);
+	bufp += sysc_show_name(bufp, ddata);
 
 	dev_dbg(ddata->dev, "%llx:%x%s\n",
 		ddata->module_pa, ddata->module_size,
@@ -612,11 +623,94 @@ static const struct dev_pm_ops sysc_pm_ops = {
 			   NULL)
 };
 
+/* Module revision register based quirks */
+struct sysc_revision_quirk {
+	const char *name;
+	u32 base;
+	int rev_offset;
+	int sysc_offset;
+	int syss_offset;
+	u32 revision;
+	u32 revision_mask;
+	u32 quirks;
+};
+
+#define SYSC_QUIRK(optname, optbase, optrev, optsysc, optsyss,		\
+		   optrev_val, optrevmask, optquirkmask)		\
+	{								\
+		.name = (optname),					\
+		.base = (optbase),					\
+		.rev_offset = (optrev),					\
+		.sysc_offset = (optsysc),				\
+		.syss_offset = (optsyss),				\
+		.revision = (optrev_val),				\
+		.revision_mask = (optrevmask),				\
+		.quirks = (optquirkmask),				\
+	}
+
+static const struct sysc_revision_quirk sysc_revision_quirks[] = {
+	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
+	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000020, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000030, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("sham", 0, 0x100, 0x110, 0x114, 0x40000c03, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("smartreflex", 0, -1, 0x24, -1, 0x00000000, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("smartreflex", 0, -1, 0x38, -1, 0x00000000, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("timer", 0, 0, 0x10, 0x14, 0x00000015, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+};
+
+static void sysc_init_revision_quirks(struct sysc *ddata)
+{
+	const struct sysc_revision_quirk *q;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sysc_revision_quirks); i++) {
+		q = &sysc_revision_quirks[i];
+
+		if (q->base && q->base != ddata->module_pa)
+			continue;
+
+		if (q->rev_offset >= 0 &&
+		    q->rev_offset != ddata->offsets[SYSC_REVISION])
+			continue;
+
+		if (q->sysc_offset >= 0 &&
+		    q->sysc_offset != ddata->offsets[SYSC_SYSCONFIG])
+			continue;
+
+		if (q->syss_offset >= 0 &&
+		    q->syss_offset != ddata->offsets[SYSC_SYSSTATUS])
+			continue;
+
+		if (q->revision == ddata->revision ||
+		    (q->revision & q->revision_mask) ==
+		    (ddata->revision & q->revision_mask)) {
+			ddata->name = q->name;
+			ddata->cfg.quirks |= q->quirks;
+		}
+	}
+}
+
 /* At this point the module is configured enough to read the revision */
 static int sysc_init_module(struct sysc *ddata)
 {
 	int error;
 
+	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
+				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
+		ddata->revision = sysc_read_revision(ddata);
+		goto rev_quirks;
+	}
+
 	error = pm_runtime_get_sync(ddata->dev);
 	if (error < 0) {
 		pm_runtime_put_noidle(ddata->dev);
@@ -626,6 +720,9 @@ static int sysc_init_module(struct sysc *ddata)
 	ddata->revision = sysc_read_revision(ddata);
 	pm_runtime_put_sync(ddata->dev);
 
+rev_quirks:
+	sysc_init_revision_quirks(ddata);
+
 	return 0;
 }
 
@@ -753,6 +850,127 @@ static struct sysc *sysc_child_to_parent(struct device *dev)
 	return dev_get_drvdata(parent);
 }
 
+static int __maybe_unused sysc_child_runtime_suspend(struct device *dev)
+{
+	struct sysc *ddata;
+	int error;
+
+	ddata = sysc_child_to_parent(dev);
+
+	error = pm_generic_runtime_suspend(dev);
+	if (error)
+		return error;
+
+	if (!ddata->enabled)
+		return 0;
+
+	return sysc_runtime_suspend(ddata->dev);
+}
+
+static int __maybe_unused sysc_child_runtime_resume(struct device *dev)
+{
+	struct sysc *ddata;
+	int error;
+
+	ddata = sysc_child_to_parent(dev);
+
+	if (!ddata->enabled) {
+		error = sysc_runtime_resume(ddata->dev);
+		if (error < 0)
+			dev_err(ddata->dev,
+				"%s error: %i\n", __func__, error);
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sysc_child_suspend_noirq(struct device *dev)
+{
+	struct sysc *ddata;
+	int error;
+
+	ddata = sysc_child_to_parent(dev);
+
+	error = pm_generic_suspend_noirq(dev);
+	if (error)
+		return error;
+
+	if (!pm_runtime_status_suspended(dev)) {
+		error = pm_generic_runtime_suspend(dev);
+		if (error)
+			return error;
+
+		error = sysc_runtime_suspend(ddata->dev);
+		if (error)
+			return error;
+
+		ddata->child_needs_resume = true;
+	}
+
+	return 0;
+}
+
+static int sysc_child_resume_noirq(struct device *dev)
+{
+	struct sysc *ddata;
+	int error;
+
+	ddata = sysc_child_to_parent(dev);
+
+	if (ddata->child_needs_resume) {
+		ddata->child_needs_resume = false;
+
+		error = sysc_runtime_resume(ddata->dev);
+		if (error)
+			dev_err(ddata->dev,
+				"%s runtime resume error: %i\n",
+				__func__, error);
+
+		error = pm_generic_runtime_resume(dev);
+		if (error)
+			dev_err(ddata->dev,
+				"%s generic runtime resume: %i\n",
+				__func__, error);
+	}
+
+	return pm_generic_resume_noirq(dev);
+}
+#endif
+
+struct dev_pm_domain sysc_child_pm_domain = {
+	.ops = {
+		SET_RUNTIME_PM_OPS(sysc_child_runtime_suspend,
+				   sysc_child_runtime_resume,
+				   NULL)
+		USE_PLATFORM_PM_SLEEP_OPS
+		SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sysc_child_suspend_noirq,
+					      sysc_child_resume_noirq)
+	}
+};
+
+/**
+ * sysc_legacy_idle_quirk - handle children in omap_device compatible way
+ * @ddata: device driver data
+ * @child: child device driver
+ *
+ * Allow idle for child devices as done with _od_runtime_suspend().
+ * Otherwise many child devices will not idle because of the permanent
+ * parent usecount set in pm_runtime_irq_safe().
+ *
+ * Note that the long term solution is to just modify the child device
+ * drivers to not set pm_runtime_irq_safe() and then this can be just
+ * dropped.
+ */
+static void sysc_legacy_idle_quirk(struct sysc *ddata, struct device *child)
+{
+	if (!ddata->legacy_mode)
+		return;
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
+		dev_pm_domain_set(child, &sysc_child_pm_domain);
+}
+
 static int sysc_notifier_call(struct notifier_block *nb,
 			      unsigned long event, void *device)
 {
@@ -770,6 +988,7 @@ static int sysc_notifier_call(struct notifier_block *nb,
 		if (error && error != -EEXIST)
 			dev_warn(ddata->dev, "could not add %s fck: %i\n",
 				 dev_name(dev), error);
+		sysc_legacy_idle_quirk(ddata, dev);
 		break;
 	default:
 		break;
@@ -974,7 +1193,8 @@ static const struct sysc_capabilities sysc_34xx_sr = {
 	.type = TI_SYSC_OMAP34XX_SR,
 	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY,
 	.regbits = &sysc_regbits_omap34xx_sr,
-	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED,
+	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED |
+		      SYSC_QUIRK_LEGACY_IDLE,
 };
 
 /*
@@ -995,12 +1215,13 @@ static const struct sysc_capabilities sysc_36xx_sr = {
 	.type = TI_SYSC_OMAP36XX_SR,
 	.sysc_mask = SYSC_OMAP3_SR_ENAWAKEUP,
 	.regbits = &sysc_regbits_omap36xx_sr,
-	.mod_quirks = SYSC_QUIRK_UNCACHED,
+	.mod_quirks = SYSC_QUIRK_UNCACHED | SYSC_QUIRK_LEGACY_IDLE,
 };
 
 static const struct sysc_capabilities sysc_omap4_sr = {
 	.type = TI_SYSC_OMAP4_SR,
 	.regbits = &sysc_regbits_omap36xx_sr,
+	.mod_quirks = SYSC_QUIRK_LEGACY_IDLE,
 };
 
 /*
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -45,6 +45,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
 #define SYSC_QUIRK_RESET_STATUS		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
 #define SYSC_QUIRK_NO_RESET_ON_INIT	BIT(5)
-- 
2.16.2

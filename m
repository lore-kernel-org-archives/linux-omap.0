From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/16] bus: ti-sysc: Tag some modules resource providers for noirq suspend
Date: Mon, 23 Apr 2018 10:45:43 -0700
Message-ID: <20180423174549.57412-11-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Modules that provide resources for other modules need to be suspended
and resumed in the noirq calls. Tag the resource providing modules.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -665,6 +665,10 @@ static int sysc_suspend(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
+	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
+				 SYSC_QUIRK_LEGACY_IDLE))
+		return 0;
+
 	if (!ddata->enabled)
 		return 0;
 
@@ -678,6 +682,58 @@ static int sysc_resume(struct device *dev)
 	struct sysc *ddata;
 
 	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
+				 SYSC_QUIRK_LEGACY_IDLE))
+		return 0;
+
+	if (ddata->needs_resume) {
+		dev_dbg(ddata->dev, "%s %s\n", __func__,
+			ddata->name ? ddata->name : "");
+
+		ddata->needs_resume = false;
+
+		return sysc_runtime_resume(dev);
+	}
+
+	return 0;
+}
+
+static int sysc_noirq_suspend(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
+		return 0;
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
+		return 0;
+
+	if (!ddata->enabled)
+		return 0;
+
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
+
+	ddata->needs_resume = true;
+
+	return sysc_runtime_suspend(dev);
+}
+
+static int sysc_noirq_resume(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
+		return 0;
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
+		return 0;
+
 	if (ddata->needs_resume) {
 		ddata->needs_resume = false;
 
@@ -690,6 +746,7 @@ static int sysc_resume(struct device *dev)
 
 static const struct dev_pm_ops sysc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sysc_suspend, sysc_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sysc_noirq_suspend, sysc_noirq_resume)
 	SET_RUNTIME_PM_OPS(sysc_runtime_suspend,
 			   sysc_runtime_resume,
 			   NULL)
@@ -721,6 +778,26 @@ struct sysc_revision_quirk {
 	}
 
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
+	/* These need to use noirq_suspend */
+	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("mcspi", 0, 0, 0x10, -1, 0x40300a0b, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("sdma", 0, 0, 0x2c, 0x28, 0x00010900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -45,6 +45,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_RESOURCE_PROVIDER	BIT(9)
 #define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
 #define SYSC_QUIRK_RESET_STATUS		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
-- 
2.17.0

From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/16] bus: ti-sysc: Add initial support for external resets
Date: Mon, 23 Apr 2018 10:45:45 -0700
Message-ID: <20180423174549.57412-13-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some modules need to use external resets in the rstctrl bits. Typically
only one of the rstctrl bits is for the interconnect target module while
the others are for various child devices.

For ti-sysc driver, we just need the module rstctrl bit mapped. The rest
of the rstctrl bits can be directly mapped to the child devices.

Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
@@ -74,6 +75,7 @@ struct sysc {
 	struct clk **clocks;
 	const char **clock_roles;
 	int nr_clocks;
+	struct reset_control *rsts;
 	const char *legacy_mode;
 	const struct sysc_capabilities *cap;
 	struct sysc_config cfg;
@@ -213,6 +215,42 @@ static int sysc_get_clocks(struct sysc *ddata)
 	return 0;
 }
 
+/**
+ * sysc_init_resets - reset module on init
+ * @ddata: device driver data
+ *
+ * A module can have both OCP softreset control and external rstctrl.
+ * If more complicated rstctrl resets are needed, please handle these
+ * directly from the child device driver and map only the module reset
+ * for the parent interconnect target module device.
+ *
+ * Automatic reset of the module on init can be skipped with the
+ * "ti,no-reset-on-init" device tree property.
+ */
+static int sysc_init_resets(struct sysc *ddata)
+{
+	int error;
+
+	ddata->rsts =
+		devm_reset_control_array_get_optional_exclusive(ddata->dev);
+	if (IS_ERR(ddata->rsts))
+		return PTR_ERR(ddata->rsts);
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
+		goto deassert;
+
+	error = reset_control_assert(ddata->rsts);
+	if (error)
+		return error;
+
+deassert:
+	error = reset_control_deassert(ddata->rsts);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 /**
  * sysc_parse_and_check_child_range - parses module IO region from ranges
  * @ddata: device driver data
@@ -889,6 +927,7 @@ static int sysc_init_module(struct sysc *ddata)
 
 		return 0;
 	}
+
 	ddata->revision = sysc_read_revision(ddata);
 	pm_runtime_put_sync(ddata->dev);
 
@@ -1583,8 +1622,11 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
-	pm_runtime_enable(ddata->dev);
+	error = sysc_init_resets(ddata);
+	if (error)
+		return error;
 
+	pm_runtime_enable(ddata->dev);
 	error = sysc_init_module(ddata);
 	if (error)
 		goto unprepare;
@@ -1615,6 +1657,9 @@ static int sysc_probe(struct platform_device *pdev)
 		pm_runtime_put(&pdev->dev);
 	}
 
+	if (!of_get_available_child_count(ddata->dev->of_node))
+		reset_control_assert(ddata->rsts);
+
 	return 0;
 
 err:
@@ -1644,6 +1689,7 @@ static int sysc_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(ddata->rsts);
 
 unprepare:
 	sysc_unprepare(ddata);
-- 
2.17.0

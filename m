From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Wed, 6 Jun 2018 11:38:24 +0530
Message-ID: <20180606060826.14671-5-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, faiz_abbas@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/bus/ti-sysc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4a2244419b9b..74d716a7bd6e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -22,11 +22,14 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include <linux/platform_data/ti-sysc.h>
 
 #include <dt-bindings/bus/ti-sysc.h>
 
+#define MAX_MODULE_SOFTRESET_WAIT		10000
+
 static const char * const reg_names[] = { "rev", "sysc", "syss", };
 
 enum sysc_clocks {
@@ -74,6 +77,11 @@ struct sysc {
 	struct delayed_work idle_work;
 };
 
+void sysc_write(struct sysc *ddata, int offset, u32 value)
+{
+	writel_relaxed(value, ddata->module_va + offset);
+}
+
 static u32 sysc_read(struct sysc *ddata, int offset)
 {
 	if (ddata->cfg.quirks & SYSC_QUIRK_16BIT) {
@@ -700,6 +708,26 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+static int sysc_reset(struct sysc *ddata)
+{
+	int offset = ddata->offsets[SYSC_SYSCONFIG];
+	int val = sysc_read(ddata, offset);
+
+	val |= (0x1 << ddata->cap->regbits->srst_shift);
+	sysc_write(ddata, offset, val);
+
+	/* Poll on reset status */
+	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
+		offset = ddata->offsets[SYSC_SYSSTATUS];
+
+		return readl_poll_timeout(ddata->module_va + offset, val,
+				(val & ddata->cfg.syss_mask) == 0x0,
+				100, MAX_MODULE_SOFTRESET_WAIT);
+	}
+
+	return 0;
+}
+
 /* At this point the module is configured enough to read the revision */
 static int sysc_init_module(struct sysc *ddata)
 {
@@ -716,6 +744,18 @@ static int sysc_init_module(struct sysc *ddata)
 
 		return 0;
 	}
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
+	    !ddata->legacy_mode) {
+		error = sysc_reset(ddata);
+		if (error) {
+			dev_err(ddata->dev, "Reset failed with %d\n", error);
+			pm_runtime_put_sync(ddata->dev);
+
+			return error;
+		}
+	}
+
 	ddata->revision = sysc_read_revision(ddata);
 	pm_runtime_put_sync(ddata->dev);
 
-- 
2.17.0

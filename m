From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Date: Thu, 5 Jul 2018 19:53:17 +0530
Message-ID: <20180705142319.19583-5-faiz_abbas@ti.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705142319.19583-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/bus/ti-sysc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ad1cd6888757..ac65a4f336d5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -23,11 +23,14 @@
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
@@ -88,6 +91,11 @@ struct sysc {
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
@@ -943,6 +951,26 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
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
+	if (ddata->cfg.syss_mask) {
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
@@ -960,6 +988,17 @@ static int sysc_init_module(struct sysc *ddata)
 		return 0;
 	}
 
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

From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 4/6] bus: ti-sysc: Add support for software reset
Date: Mon, 9 Jul 2018 22:18:39 +0530
Message-ID: <20180709164841.14182-5-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: mark.rutland@arm.com, paul@pwsan.com, tony@atomide.com, faiz_abbas@ti.com, t-kristo@ti.com, sboyd@kernel.org, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/bus/ti-sysc.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index ad1cd6888757..1b1b2ced3494 100644
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
@@ -943,6 +951,31 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+static int sysc_reset(struct sysc *ddata)
+{
+	int offset = ddata->offsets[SYSC_SYSCONFIG];
+	int val = sysc_read(ddata, offset);
+
+	/*
+	 * Currently only support reset status in sysstatus.
+	 * Warn and return error in all other cases
+	 */
+	if (!ddata->cfg.syss_mask) {
+		dev_err(ddata->dev, "No ti,syss-mask. Reset failed\n");
+		return -EINVAL;
+	}
+
+	val |= (0x1 << ddata->cap->regbits->srst_shift);
+	sysc_write(ddata, offset, val);
+
+	/* Poll on reset status */
+	offset = ddata->offsets[SYSC_SYSSTATUS];
+
+	return readl_poll_timeout(ddata->module_va + offset, val,
+				  (val & ddata->cfg.syss_mask) == 0x0,
+				  100, MAX_MODULE_SOFTRESET_WAIT);
+}
+
 /* At this point the module is configured enough to read the revision */
 static int sysc_init_module(struct sysc *ddata)
 {
@@ -960,6 +993,17 @@ static int sysc_init_module(struct sysc *ddata)
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

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 4/6] bus: ti-sysc: Add support for software reset
Date: Tue, 10 Jul 2018 04:42:48 -0700
Message-ID: <20180710114248.GI99251@atomide.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
 <20180709164841.14182-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709164841.14182-5-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com, sboyd@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Faiz Abbas <faiz_abbas@ti.com> [180709 16:50]:
> Add support for the software reset of a target interconnect
> module using its sysconfig and sysstatus registers.
...
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
...
> +static int sysc_reset(struct sysc *ddata)
> +{
> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> +	int val = sysc_read(ddata, offset);

Testing with omap4 sysc dts data I noticed we already
have modules where there is only rev register and no
SYSC_SYSCONFIG. So not using legacy mode. The
above offset with -ENODEV value will not work :)

I added some more checks and moved them to the reset
function.

Updated patch below for reference, I've pushed out
new branches omap-for-v4.19/ti-sysc-v2 and
omap-for-v4.19/dt-mcan-v2. I've also updated my
for-next branch.

Regards,

Tony

8< -----------
>From tony Mon Sep 17 00:00:00 2001
From: Faiz Abbas <faiz_abbas@ti.com>
Date: Mon, 9 Jul 2018 22:18:39 +0530
Subject: [PATCH] bus: ti-sysc: Add support for software reset

Add support for the software reset of a target interconnect
module using its sysconfig and sysstatus registers.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
[tony@atomide.com: updated to check if sysconfig exists]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
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
@@ -943,6 +951,36 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+static int sysc_reset(struct sysc *ddata)
+{
+	int offset = ddata->offsets[SYSC_SYSCONFIG];
+	int val;
+
+	if (ddata->legacy_mode || offset < 0 ||
+	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
+		return 0;
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
+	val = sysc_read(ddata, offset);
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
@@ -960,6 +998,14 @@ static int sysc_init_module(struct sysc *ddata)
 		return 0;
 	}
 
+	error = sysc_reset(ddata);
+	if (error) {
+		dev_err(ddata->dev, "Reset failed with %d\n", error);
+		pm_runtime_put_sync(ddata->dev);
+
+		return error;
+	}
+
 	ddata->revision = sysc_read_revision(ddata);
 	pm_runtime_put_sync(ddata->dev);
 
-- 
2.17.1

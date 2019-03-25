From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/14] bus: ti-sysc: Add separate functions for handling clocks
Date: Mon, 25 Mar 2019 14:58:40 -0700
Message-ID: <20190325215849.13182-6-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

At least McPDM module depends on an external optional clock to be
usable. To make handling of the McPDM clock easier in the following
patches, let's add separate functions for handling the main clocks
and the optional clocks.

Let's also add error handling to shut down already enabled clocks
while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 141 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 123 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -231,6 +231,112 @@ static int sysc_get_clocks(struct sysc *ddata)
 	return 0;
 }
 
+static int sysc_enable_main_clocks(struct sysc *ddata)
+{
+	struct clk *clock;
+	int i, error;
+
+	if (!ddata->clocks)
+		return 0;
+
+	for (i = 0; i < SYSC_OPTFCK0; i++) {
+		clock = ddata->clocks[i];
+
+		/* Main clocks may not have ick */
+		if (IS_ERR_OR_NULL(clock))
+			continue;
+
+		error = clk_enable(clock);
+		if (error)
+			goto err_disable;
+	}
+
+	return 0;
+
+err_disable:
+	for (; i >= 0; i--) {
+		clock = ddata->clocks[i];
+
+		/* Main clocks may not have ick */
+		if (IS_ERR_OR_NULL(clock))
+			continue;
+
+		clk_disable(clock);
+	}
+
+	return error;
+}
+
+static void sysc_disable_main_clocks(struct sysc *ddata)
+{
+	struct clk *clock;
+	int i;
+
+	if (!ddata->clocks)
+		return;
+
+	for (i = 0; i < SYSC_OPTFCK0; i++) {
+		clock = ddata->clocks[i];
+		if (IS_ERR_OR_NULL(clock))
+			continue;
+
+		clk_disable(clock);
+	}
+}
+
+static int sysc_enable_opt_clocks(struct sysc *ddata)
+{
+	struct clk *clock;
+	int i, error;
+
+	if (!ddata->clocks)
+		return 0;
+
+	for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
+		clock = ddata->clocks[i];
+
+		/* Assume no holes for opt clocks */
+		if (IS_ERR_OR_NULL(clock))
+			return 0;
+
+		error = clk_enable(clock);
+		if (error)
+			goto err_disable;
+	}
+
+	return 0;
+
+err_disable:
+	for (; i >= 0; i--) {
+		clock = ddata->clocks[i];
+		if (IS_ERR_OR_NULL(clock))
+			continue;
+
+		clk_disable(clock);
+	}
+
+	return error;
+}
+
+static void sysc_disable_opt_clocks(struct sysc *ddata)
+{
+	struct clk *clock;
+	int i;
+
+	if (!ddata->clocks)
+		return;
+
+	for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
+		clock = ddata->clocks[i];
+
+		/* Assume no holes for opt clocks */
+		if (IS_ERR_OR_NULL(clock))
+			return;
+
+		clk_disable(clock);
+	}
+}
+
 /**
  * sysc_init_resets - reset module on init
  * @ddata: device driver data
@@ -667,7 +773,7 @@ static int __maybe_unused sysc_runtime_resume_legacy(struct device *dev,
 static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 {
 	struct sysc *ddata;
-	int error = 0, i;
+	int error = 0;
 
 	ddata = dev_get_drvdata(dev);
 
@@ -682,15 +788,10 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		return error;
 	}
 
-	for (i = 0; i < ddata->nr_clocks; i++) {
-		if (IS_ERR_OR_NULL(ddata->clocks[i]))
-			continue;
+	sysc_disable_main_clocks(ddata);
 
-		if (i >= SYSC_OPTFCK0 && !sysc_opt_clks_needed(ddata))
-			break;
-
-		clk_disable(ddata->clocks[i]);
-	}
+	if (sysc_opt_clks_needed(ddata))
+		sysc_disable_opt_clocks(ddata);
 
 	ddata->enabled = false;
 
@@ -700,7 +801,7 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 static int __maybe_unused sysc_runtime_resume(struct device *dev)
 {
 	struct sysc *ddata;
-	int error = 0, i;
+	int error = 0;
 
 	ddata = dev_get_drvdata(dev);
 
@@ -715,20 +816,24 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 		return error;
 	}
 
-	for (i = 0; i < ddata->nr_clocks; i++) {
-		if (IS_ERR_OR_NULL(ddata->clocks[i]))
-			continue;
-
-		if (i >= SYSC_OPTFCK0 && !sysc_opt_clks_needed(ddata))
-			break;
-
-		error = clk_enable(ddata->clocks[i]);
+	if (sysc_opt_clks_needed(ddata)) {
+		error = sysc_enable_opt_clocks(ddata);
 		if (error)
 			return error;
 	}
 
+	error = sysc_enable_main_clocks(ddata);
+	if (error)
+		goto err_main_clocks;
+
 	ddata->enabled = true;
 
+	return 0;
+
+err_main_clocks:
+	if (sysc_opt_clks_needed(ddata))
+		sysc_disable_opt_clocks(ddata);
+
 	return error;
 }
 
-- 
2.21.0

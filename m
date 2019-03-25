From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/14] bus: ti-sysc: Manage clocks for the interconnect target module in all cases
Date: Mon, 25 Mar 2019 14:58:43 -0700
Message-ID: <20190325215849.13182-9-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are currently not managing interconnect target module clocks in the
for legacy platform data based case. This causes a problem for using the
platform data based functions when dropping the platform data for the
interconnect target module configuration.

To avoid a situation where we need to populate the main and optional
clocks also for the platform data based functions, let's just manage the
clocks directly in ti-sysc driver. This means that until the interconnect
target module confugration platform data is dropped our use count for
clk_enable() will be 2 instead of 1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -783,10 +783,8 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 
 	if (ddata->legacy_mode) {
 		error = sysc_runtime_suspend_legacy(dev, ddata);
-		if (!error)
-			ddata->enabled = false;
-
-		return error;
+		if (error)
+			return error;
 	}
 
 	sysc_disable_main_clocks(ddata);
@@ -809,14 +807,6 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	if (ddata->enabled)
 		return 0;
 
-	if (ddata->legacy_mode) {
-		error = sysc_runtime_resume_legacy(dev, ddata);
-		if (!error)
-			ddata->enabled = true;
-
-		return error;
-	}
-
 	if (sysc_opt_clks_needed(ddata)) {
 		error = sysc_enable_opt_clocks(ddata);
 		if (error)
@@ -825,13 +815,21 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 
 	error = sysc_enable_main_clocks(ddata);
 	if (error)
-		goto err_main_clocks;
+		goto err_opt_clocks;
+
+	if (ddata->legacy_mode) {
+		error = sysc_runtime_resume_legacy(dev, ddata);
+		if (error)
+			goto err_main_clocks;
+	}
 
 	ddata->enabled = true;
 
 	return 0;
 
 err_main_clocks:
+	sysc_disable_main_clocks(ddata);
+err_opt_clocks:
 	if (sysc_opt_clks_needed(ddata))
 		sysc_disable_opt_clocks(ddata);
 
-- 
2.21.0

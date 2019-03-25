From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] bus: ti-sysc: Enable all clocks directly during init to read revision
Date: Mon, 25 Mar 2019 14:58:41 -0700
Message-ID: <20190325215849.13182-7-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The first thing we want to do is just read the module revision register to
be able to configure the module specific quirks and configure the module
registers.

As the interconnect target module may not yet be properly configured and
may need a reset first, we don't want to use pm_runtime_get() at this
point.

To read the revision register, let's just enable the all the clocks for
the interconnect target module during init even if the optional clocks
are not needed. That way we can read the revision register to configure
the quirks needed for PM runtime.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 50 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1042,39 +1042,45 @@ static int sysc_reset(struct sysc *ddata)
 				  100, MAX_MODULE_SOFTRESET_WAIT);
 }
 
-/* At this point the module is configured enough to read the revision */
+/*
+ * At this point the module is configured enough to read the revision but
+ * module may not be completely configured yet to use PM runtime. Enable
+ * all clocks directly during init to configure the quirks needed for PM
+ * runtime based on the revision register.
+ */
 static int sysc_init_module(struct sysc *ddata)
 {
-	int error;
+	int error = 0;
+	bool manage_clocks = true;
 
 	if (ddata->cfg.quirks &
-	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT)) {
-		ddata->revision = sysc_read_revision(ddata);
-		goto rev_quirks;
-	}
+	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))
+		manage_clocks = false;
 
-	error = pm_runtime_get_sync(ddata->dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(ddata->dev);
+	if (manage_clocks) {
+		error = sysc_enable_opt_clocks(ddata);
+		if (error)
+			return error;
 
-		return 0;
+		error = sysc_enable_main_clocks(ddata);
+		if (error)
+			goto err_opt_clocks;
 	}
 
+	ddata->revision = sysc_read_revision(ddata);
+	sysc_init_revision_quirks(ddata);
+
 	error = sysc_reset(ddata);
-	if (error) {
+	if (error)
 		dev_err(ddata->dev, "Reset failed with %d\n", error);
-		pm_runtime_put_sync(ddata->dev);
 
-		return error;
-	}
-
-	ddata->revision = sysc_read_revision(ddata);
-	pm_runtime_put_sync(ddata->dev);
-
-rev_quirks:
-	sysc_init_revision_quirks(ddata);
+	if (manage_clocks)
+		sysc_disable_main_clocks(ddata);
+err_opt_clocks:
+	if (manage_clocks)
+		sysc_disable_opt_clocks(ddata);
 
-	return 0;
+	return error;
 }
 
 static int sysc_init_sysc_mask(struct sysc *ddata)
@@ -1812,11 +1818,11 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	pm_runtime_enable(ddata->dev);
 	error = sysc_init_module(ddata);
 	if (error)
 		goto unprepare;
 
+	pm_runtime_enable(ddata->dev);
 	error = pm_runtime_get_sync(ddata->dev);
 	if (error < 0) {
 		pm_runtime_put_noidle(ddata->dev);
-- 
2.21.0

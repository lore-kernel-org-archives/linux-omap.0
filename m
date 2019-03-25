From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] bus: ti-sysc: Add support for early quirks based on register address
Date: Mon, 25 Mar 2019 14:58:45 -0700
Message-ID: <20190325215849.13182-11-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

At least mcpdm needs an optional external clock enabled to function and
this clock typically comes from the PMIC. We can detect mcpdm based on
the interconnect target module address and set a quirk flag early.

To do this, let's initialize the clocks a bit later and add a new
function for sysc_init_early_quirks(). Note that we cannot yet enable
the early quirks for mcpdm until the optional external clocks are
handled in the in the following patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 46 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -959,6 +959,42 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 #endif
 };
 
+/*
+ * Early quirks based on module base and register offsets only that are
+ * needed before the module revision can be read
+ */
+static void sysc_init_early_quirks(struct sysc *ddata)
+{
+	const struct sysc_revision_quirk *q;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sysc_revision_quirks); i++) {
+		q = &sysc_revision_quirks[i];
+
+		if (!q->base)
+			continue;
+
+		if (q->base != ddata->module_pa)
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
+		ddata->name = q->name;
+		ddata->cfg.quirks |= q->quirks;
+	}
+}
+
+/* Quirks that also consider the revision register value */
 static void sysc_init_revision_quirks(struct sysc *ddata)
 {
 	const struct sysc_revision_quirk *q;
@@ -1825,10 +1861,6 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
-	error = sysc_get_clocks(ddata);
-	if (error)
-		return error;
-
 	error = sysc_map_and_check_registers(ddata);
 	if (error)
 		goto unprepare;
@@ -1849,6 +1881,12 @@ static int sysc_probe(struct platform_device *pdev)
 	if (error)
 		goto unprepare;
 
+	sysc_init_early_quirks(ddata);
+
+	error = sysc_get_clocks(ddata);
+	if (error)
+		return error;
+
 	error = sysc_init_resets(ddata);
 	if (error)
 		return error;
-- 
2.21.0

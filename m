From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] bus: ti-sysc: Allocate mdata as needed and do platform data based init later
Date: Mon, 25 Mar 2019 14:58:42 -0700
Message-ID: <20190325215849.13182-8-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The platform data based init functions typically reset the interconnect
target module configure the registers. As we may need the interconnect
target module specific quirks configured based on the revision register,
we want to move the platform data based init to happen later.

Let's allocate mdata as needed so it's available for sysc_legacy_init()
that we call with module clocks enabled from sysc_init_module().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 54 +++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -75,6 +75,7 @@ struct sysc {
 	u32 module_size;
 	void __iomem *module_va;
 	int offsets[SYSC_MAX_REGS];
+	struct ti_sysc_module_data *mdata;
 	struct clk **clocks;
 	const char **clock_roles;
 	int nr_clocks;
@@ -1012,6 +1013,26 @@ static void sysc_init_revision_quirks(struct sysc *ddata)
 	}
 }
 
+/*
+ * Note that pdata->init_module() typically does a reset first. After
+ * pdata->init_module() is done, PM runtime can be used for the interconnect
+ * target module.
+ */
+static int sysc_legacy_init(struct sysc *ddata)
+{
+	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
+	int error;
+
+	if (!ddata->legacy_mode || !pdata || !pdata->init_module)
+		return 0;
+
+	error = pdata->init_module(ddata->dev, ddata->mdata, &ddata->cookie);
+	if (error == -EEXIST)
+		error = 0;
+
+	return error;
+}
+
 static int sysc_reset(struct sysc *ddata)
 {
 	int offset = ddata->offsets[SYSC_SYSCONFIG];
@@ -1070,10 +1091,15 @@ static int sysc_init_module(struct sysc *ddata)
 	ddata->revision = sysc_read_revision(ddata);
 	sysc_init_revision_quirks(ddata);
 
+	error = sysc_legacy_init(ddata);
+	if (error)
+		goto err_main_clocks;
+
 	error = sysc_reset(ddata);
 	if (error)
 		dev_err(ddata->dev, "Reset failed with %d\n", error);
 
+err_main_clocks:
 	if (manage_clocks)
 		sysc_disable_main_clocks(ddata);
 err_opt_clocks:
@@ -1715,28 +1741,26 @@ static const struct sysc_capabilities sysc_dra7_mcan = {
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
-	struct ti_sysc_module_data mdata;
-	int error = 0;
+	struct ti_sysc_module_data *mdata;
 
 	if (!pdata || !ddata->legacy_mode)
 		return 0;
 
-	mdata.name = ddata->legacy_mode;
-	mdata.module_pa = ddata->module_pa;
-	mdata.module_size = ddata->module_size;
-	mdata.offsets = ddata->offsets;
-	mdata.nr_offsets = SYSC_MAX_REGS;
-	mdata.cap = ddata->cap;
-	mdata.cfg = &ddata->cfg;
+	mdata = devm_kzalloc(ddata->dev, sizeof(*mdata), GFP_KERNEL);
+	if (!mdata)
+		return -ENOMEM;
 
-	if (!pdata->init_module)
-		return -ENODEV;
+	mdata->name = ddata->legacy_mode;
+	mdata->module_pa = ddata->module_pa;
+	mdata->module_size = ddata->module_size;
+	mdata->offsets = ddata->offsets;
+	mdata->nr_offsets = SYSC_MAX_REGS;
+	mdata->cap = ddata->cap;
+	mdata->cfg = &ddata->cfg;
 
-	error = pdata->init_module(ddata->dev, &mdata, &ddata->cookie);
-	if (error == -EEXIST)
-		error = 0;
+	ddata->mdata = mdata;
 
-	return error;
+	return 0;
 }
 
 static int sysc_init_match(struct sysc *ddata)
-- 
2.21.0

From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/16] bus: ti-sysc: Make child clock alias handling more generic
Date: Mon, 23 Apr 2018 10:45:41 -0700
Message-ID: <20180423174549.57412-9-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In order to prepare supporting clkctrl optional clocks, we need to
make the current child clock handling more generic so we can use the
clock role names for the optional clocks in the following patch.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -811,29 +811,38 @@ static int sysc_init_syss_mask(struct sysc *ddata)
 }
 
 /*
- * Many child device drivers need to have fck available to get the clock
- * rate for device internal configuration.
+ * Many child device drivers need to have fck and opt clocks available
+ * to get the clock rate for device internal configuration etc.
  */
-static int sysc_child_add_fck(struct sysc *ddata,
-			      struct device *child)
+static int sysc_child_add_named_clock(struct sysc *ddata,
+				      struct device *child,
+				      const char *name)
 {
-	struct clk *fck;
+	struct clk *clk;
 	struct clk_lookup *l;
-	const char *name = clock_names[SYSC_FCK];
+	int error = 0;
 
-	if (IS_ERR_OR_NULL(ddata->clocks[SYSC_FCK]))
+	if (!name)
 		return 0;
 
-	fck = clk_get(child, name);
-	if (!IS_ERR(fck)) {
-		clk_put(fck);
+	clk = clk_get(child, name);
+	if (!IS_ERR(clk)) {
+		clk_put(clk);
 
 		return -EEXIST;
 	}
 
-	l = clkdev_create(ddata->clocks[SYSC_FCK], name, dev_name(child));
+	clk = clk_get(ddata->dev, name);
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	l = clkdev_create(clk, name, dev_name(child));
+	if (!l)
+		error = -ENOMEM;
 
-	return l ? 0 : -ENODEV;
+	clk_put(clk);
+
+	return error;
 }
 
 static struct device_type sysc_device_type = {
@@ -983,7 +992,8 @@ static int sysc_notifier_call(struct notifier_block *nb,
 
 	switch (event) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		error = sysc_child_add_fck(ddata, dev);
+		error = sysc_child_add_named_clock(ddata, dev,
+						   clock_names[SYSC_FCK]);
 		if (error && error != -EEXIST)
 			dev_warn(ddata->dev, "could not add %s fck: %i\n",
 				 dev_name(dev), error);
-- 
2.17.0

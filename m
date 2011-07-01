From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2] OMAP: omap_device: Create clkdev entry for hwmod main_clk
Date: Fri, 1 Jul 2011 23:18:21 +0200
Message-ID: <1309555101-21198-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36476 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757638Ab1GAVSc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:18:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Todd Poynor <toddpoynor@google.com>

Extend the existing function to create clkdev for every optional
clocks to add a well one "fck" alias for the main_clk of the
omap_hwmod.
It will allow to remove these static clkdev entries from the
clockXXX_data.c file.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Todd Poynor <toddpoynor@google.com>
---
The first version of that patch was included in the modulemode series.
It is now a standalone patch due to the lack of dependency with the
original series.

I fixed a clk_put issue reported by Todd.

Benoit


 arch/arm/plat-omap/omap_device.c |   85 ++++++++++++++++++++++---------------
 1 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 49fc0df..9a02d95 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -241,56 +241,71 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
 	return container_of(pdev, struct omap_device, pdev);
 }
 
+static void _add_clkdev(struct omap_device *od, const char *clk_alias,
+		       const char *clk_name)
+{
+	struct clk *r;
+	struct clk_lookup *l;
+
+	if (!clk_alias || !clk_name)
+		return;
+
+	pr_debug("omap_device: %s: Creating %s -> %s\n",
+		 dev_name(&od->pdev.dev), clk_alias, clk_name);
+
+	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
+	if (!IS_ERR(r)) {
+		pr_warning("omap_device: %s: %s already exist\n",
+			   dev_name(&od->pdev.dev), clk_alias);
+		clk_put(r);
+		return;
+	}
+
+	r = omap_clk_get_by_name(clk_name);
+	if (IS_ERR(r)) {
+		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
+		       dev_name(&od->pdev.dev), clk_name);
+		return;
+	}
+
+	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
+	if (!l) {
+		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
+		       dev_name(&od->pdev.dev), clk_alias);
+		return;
+	}
+
+	clkdev_add(l);
+}
+
 /**
- * _add_optional_clock_clkdev - Add clkdev entry for hwmod optional clocks
+ * _add_hwmod_clocks_clkdev - Add clkdev entry for hwmod optional clocks
+ * and main clock
  * @od: struct omap_device *od
+ * @oh: struct omap_hwmod *oh
  *
- * For every optional clock present per hwmod per omap_device, this function
- * adds an entry in the clkdev table of the form <dev-id=dev_name, con-id=role>
- * if it does not exist already.
+ * For the main clock and every optional clock present per hwmod per
+ * omap_device, this function adds an entry in the clkdev table of the
+ * form <dev-id=dev_name, con-id=role> if it does not exist already.
  *
  * The function is called from inside omap_device_build_ss(), after
  * omap_device_register.
  *
  * This allows drivers to get a pointer to its optional clocks based on its role
  * by calling clk_get(<dev*>, <role>).
+ * In the case of the main clock, a "fck" alias is used.
  *
  * No return value.
  */
-static void _add_optional_clock_clkdev(struct omap_device *od,
-				      struct omap_hwmod *oh)
+static void _add_hwmod_clocks_clkdev(struct omap_device *od,
+				     struct omap_hwmod *oh)
 {
 	int i;
 
-	for (i = 0; i < oh->opt_clks_cnt; i++) {
-		struct omap_hwmod_opt_clk *oc;
-		struct clk *r;
-		struct clk_lookup *l;
-
-		oc = &oh->opt_clks[i];
-
-		if (!oc->_clk)
-			continue;
-
-		r = clk_get_sys(dev_name(&od->pdev.dev), oc->role);
-		if (!IS_ERR(r))
-			continue; /* clkdev entry exists */
+	_add_clkdev(od, "fck", oh->main_clk);
 
-		r = omap_clk_get_by_name((char *)oc->clk);
-		if (IS_ERR(r)) {
-			pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
-			       dev_name(&od->pdev.dev), oc->clk);
-			continue;
-		}
-
-		l = clkdev_alloc(r, oc->role, dev_name(&od->pdev.dev));
-		if (!l) {
-			pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
-			       dev_name(&od->pdev.dev), oc->role);
-			return;
-		}
-		clkdev_add(l);
-	}
+	for (i = 0; i < oh->opt_clks_cnt; i++)
+		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
 }
 
 
@@ -497,7 +512,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
-		_add_optional_clock_clkdev(od, hwmods[i]);
+		_add_hwmod_clocks_clkdev(od, hwmods[i]);
 	}
 
 	if (ret)
-- 
1.7.0.4


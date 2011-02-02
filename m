From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] OMAP: hwmod: Do not expect an entry in clkdev for opt_clks
Date: Wed,  2 Feb 2011 11:25:17 +0530
Message-ID: <1296626117-31716-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab1BBFze (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 00:55:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>

The _add_optional_clock_alias function expects an entry
already existing in the clkdev table in the form of
<dev-id=NULL, con-id=role> which might not be the case
always.

Instead, just check if an entry already exists in clkdev
in the <dev-id=dev_name, con-id=role> form, else go ahead
and add one.

Remove any assumption of an entry already existing in clkdev
table in any form.

Since this means, adding a new entry in clkdev if it does
not already exist, and not really adding an 'alias',
also rename the function name
(s/_add_optional_clock_alias/_add_optional_clock_clkdev)
to reflect this.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reported-by: Sumit Semwal <sumit.semwal@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Partha Basak <p-basak2@ti.com>
---
Applies on 2.6.38-rc3
Changes in v2:
-1- (s/_add_optional_clock_alias/_add_optional_clock_clkdev)
-2- pr_err added when clkdev_alloc fails

 arch/arm/plat-omap/omap_device.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 57adb27..9bbda9a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -83,9 +83,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
+#include <plat/clock.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0
@@ -239,12 +241,12 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
 }
 
 /**
- * _add_optional_clock_alias - Add clock alias for hwmod optional clocks
+ * _add_optional_clock_clkdev - Add clkdev entry for hwmod optional clocks
  * @od: struct omap_device *od
  *
  * For every optional clock present per hwmod per omap_device, this function
- * adds an entry in the clocks list of the form <dev-id=dev_name, con-id=role>
- * if an entry is already present in it with the form <dev-id=NULL, con-id=role>
+ * adds an entry in the clkdev table of the form <dev-id=dev_name, con-id=role>
+ * if it does not exist already.
  *
  * The function is called from inside omap_device_build_ss(), after
  * omap_device_register.
@@ -254,25 +256,39 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
  *
  * No return value.
  */
-static void _add_optional_clock_alias(struct omap_device *od,
+static void _add_optional_clock_clkdev(struct omap_device *od,
 				      struct omap_hwmod *oh)
 {
 	int i;
 
 	for (i = 0; i < oh->opt_clks_cnt; i++) {
 		struct omap_hwmod_opt_clk *oc;
-		int r;
+		struct clk *r;
+		struct clk_lookup *l;
 
 		oc = &oh->opt_clks[i];
 
 		if (!oc->_clk)
 			continue;
 
-		r = clk_add_alias(oc->role, dev_name(&od->pdev.dev),
-				  (char *)oc->clk, &od->pdev.dev);
-		if (r)
-			pr_err("omap_device: %s: clk_add_alias for %s failed\n",
+		r = clk_get_sys(dev_name(&od->pdev.dev), oc->role);
+		if (!IS_ERR(r))
+			continue; /* clkdev entry exists */
+
+		r = omap_clk_get_by_name((char *)oc->clk);
+		if (IS_ERR(r)) {
+			pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
+			       dev_name(&od->pdev.dev), oc->clk);
+			continue;
+		}
+
+		l = clkdev_alloc(r, oc->role, dev_name(&od->pdev.dev));
+		if (!l) {
+			pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
 			       dev_name(&od->pdev.dev), oc->role);
+			return;
+		}
+		clkdev_add(l);
 	}
 }
 
@@ -480,7 +496,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
-		_add_optional_clock_alias(od, hwmods[i]);
+		_add_optional_clock_clkdev(od, hwmods[i]);
 	}
 
 	if (ret)
-- 
1.7.0.4


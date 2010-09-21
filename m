From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP: hwmod: Handle opt clocks node using clk_add_alias
Date: Tue, 21 Sep 2010 19:23:04 +0200
Message-ID: <1285089784-2786-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034Ab0IURXI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 13:23:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Basak, Partha <p-basak2@ti.com>

For every optional clock present per hwmod per omap-device, this function
adds an entry in the clocks list of the form <dev-id=dev_name, con-id=role>,
if an entry is already present in the list of the form <dev-id=NULL, con-id=role>.

The function is called from within the framework inside omap_device_build_ss(),
after omap_device_register.

This allows drivers to get a pointer to its optional clocks based on its role
by calling clk_get(<dev*>, <role>).

Link to discussions related to this patch:
http://www.spinics.net/lists/linux-omap/msg34809.html

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |   39 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..d876cec 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -82,6 +82,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -243,6 +244,40 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
 	return container_of(pdev, struct omap_device, pdev);
 }
 
+/**
+ * _add_optional_clock_alias - Add clock alias for hwmod optional clocks
+ * @od: struct omap_device *od
+ *
+ * For every optional clock present per hwmod per omap_device, this function
+ * adds an entry in the clocks list of the form <dev-id=dev_name, con-id=role>
+ * if an entry is already present in it with the form <dev-id=NULL, con-id=role>
+ *
+ * The function is called from inside omap_device_build_ss(), after
+ * omap_device_register.
+ *
+ * This allows drivers to get a pointer to its optional clocks based on its role
+ * by calling clk_get(<dev*>, <role>).
+ */
+static void _add_optional_clock_alias(struct omap_device *od,
+				      struct omap_hwmod *oh)
+{
+	int i;
+	struct omap_hwmod_opt_clk *oc;
+
+	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
+		int ret;
+
+		if (!oc->_clk || !IS_ERR(clk_get(&od->pdev.dev, oc->role)))
+			return;
+
+		ret = clk_add_alias(oc->role, dev_name(&od->pdev.dev),
+				    (char *)oc->clk, NULL);
+		if (ret)
+			pr_err("omap_device: clk_add_alias for %s failed\n",
+			       oc->role);
+	}
+}
+
 
 /* Public functions for use by core code */
 
@@ -421,8 +456,10 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	else
 		ret = omap_device_register(od);
 
-	for (i = 0; i < oh_cnt; i++)
+	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
+		_add_optional_clock_alias(od, hwmods[i]);
+	}
 
 	if (ret)
 		goto odbs_exit4;
-- 
1.6.0.4


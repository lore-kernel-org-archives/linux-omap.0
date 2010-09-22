From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP: hwmod: Handle opt clocks node using clk_add_alias
Date: Tue, 21 Sep 2010 18:19:37 -0600
Message-ID: <20100922001934.8621.17518.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35994 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab0IVAV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:21:29 -0400
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Partha Basak <p-basak2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Charulatha V <charu@ti.com>

From: Partha Basak <p-basak2@ti.com>

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
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: simplified loop iterator; removed the superfluous clk_get(),
 using the clk_get() in clk_add_alias() instead]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |   43 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..ceba58a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -82,6 +82,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -243,6 +244,44 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
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
+ *
+ * No return value.
+ */
+static void _add_optional_clock_alias(struct omap_device *od,
+				      struct omap_hwmod *oh)
+{
+	int i;
+
+	for (i = 0; i < oh->opt_clks_cnt; i++) {
+		struct omap_hwmod_opt_clk *oc;
+		int r;
+
+		oc = &oh->opt_clks[i];
+
+		if (!oc->_clk)
+			continue;
+
+		r = clk_add_alias(oc->role, dev_name(&od->pdev.dev),
+				  (char *)oc->clk, &od->pdev.dev);
+		if (r)
+			pr_err("omap_device: %s: clk_add_alias for %s failed\n",
+			       dev_name(&od->pdev.dev), oc->role);
+	}
+}
+
 
 /* Public functions for use by core code */
 
@@ -421,8 +460,10 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	else
 		ret = omap_device_register(od);
 
-	for (i = 0; i < oh_cnt; i++)
+	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
+		_add_optional_clock_alias(od, hwmods[i]);
+	}
 
 	if (ret)
 		goto odbs_exit4;



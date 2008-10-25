From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Sat, 25 Oct 2008 22:55:46 +0300
Message-ID: <1224964548-31844-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52382 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYJYTz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Oct 2008 15:55:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Introduce a new mechanism to omap's clk implementation to
associate the device with its clock during platform_device
registration. Also gives the clock a function name (like
mmc_fck, uart_fck, ehci_fck, etc) so drivers won't have to
care about clk names any longer.

With this mechanism we can also be sure drivers won't be able
to clk_get the wrong clk (only true when we move all drivers
to this new mechanism and drop the old ones).

Clk's function names will be defined as they come necessary
but let's try to keep it as simple as possible.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/clock.c              |   47 ++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/clock.h |    4 ++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5178701..083a3ff 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -44,6 +44,7 @@ static struct clk_functions *arch_clock;
 struct clk * clk_get(struct device *dev, const char *id)
 {
 	struct clk *p, *clk = ERR_PTR(-ENOENT);
+	struct device *d;
 	int idno;
 
 	if (dev == NULL || dev->bus != &platform_bus_type)
@@ -54,27 +55,65 @@ struct clk * clk_get(struct device *dev, const char *id)
 	mutex_lock(&clocks_mutex);
 
 	list_for_each_entry(p, &clocks, node) {
+		list_for_each_entry(d, &p->consumers, node) {
+			if (dev == d) {
+				clk = p;
+				break;
+			}
+		}
+
 		if (p->id == idno &&
 		    strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
 			clk = p;
-			goto found;
+			break;
 		}
-	}
 
-	list_for_each_entry(p, &clocks, node) {
 		if (strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
 			clk = p;
 			break;
 		}
 	}
 
-found:
 	mutex_unlock(&clocks_mutex);
 
 	return clk;
 }
 EXPORT_SYMBOL(clk_get);
 
+/**
+ * omap_clk_associate - associates a clock to its consumer device(s)
+ * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
+ * @dev: device pointer for the clock consumer
+ *
+ * This function attempts to simplify clock handling for device drivers
+ * by letting struct clk know which device is the correct consumer for
+ * that clock. By making this trick, we let drivers get the correct
+ * clock without knowing about different clock names between omap
+ * versions.
+ */
+void __init omap_clk_associate(const char *id, struct device *dev)
+{
+	struct clk *clk = clk_get(NULL, id);
+
+	if (!clk || IS_ERR(clk)) {
+		pr_debug("%s: unable to get clock\n", __func__);
+		return;
+	}
+
+	if (!dev) {
+		pr_debug("%s: missing device to associate with\n", __func__);
+		clk_put(clk);
+		return;
+	}
+
+	if (list_empty(&clk->consumers))
+		INIT_LIST_HEAD(&clk->consumers);
+
+	/* add device to consumer list */
+	list_add(&dev->node, &clk->consumers);
+	clk_put(clk);
+};
+
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 9088925..1600a14 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -13,6 +13,8 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <linux/device.h>
+
 struct module;
 struct clk;
 struct clockdomain;
@@ -61,6 +63,7 @@ struct dpll_data {
 
 struct clk {
 	struct list_head	node;
+	struct list_head	consumers;
 	struct module		*owner;
 	const char		*name;
 	int			id;
@@ -116,6 +119,7 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 
+extern void omap_clk_associate(const char *id, struct device *dev);
 extern int clk_init(struct clk_functions *custom_clocks);
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
-- 
1.6.0.2.307.gc427


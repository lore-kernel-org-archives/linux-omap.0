From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed,  1 Oct 2008 13:36:01 +0300
Message-ID: <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com>
References: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42148 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbYJAKgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:36:44 -0400
In-Reply-To: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <felipe.balbi@nokia.com>

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
 arch/arm/plat-omap/clock.c              |   38 +++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/clock.h |    5 ++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 197974d..1c1f6c7 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -43,7 +43,7 @@ static struct clk_functions *arch_clock;
  */
 struct clk * clk_get(struct device *dev, const char *id)
 {
-	struct clk *p, *clk = ERR_PTR(-ENOENT);
+	struct clk *p, *clk;
 	int idno;
 
 	if (dev == NULL || dev->bus != &platform_bus_type)
@@ -53,6 +53,15 @@ struct clk * clk_get(struct device *dev, const char *id)
 
 	mutex_lock(&clocks_mutex);
 
+	list_for_each_entry(clk, &clocks, node) {
+		if (clk->function && (dev == clk->dev) &&
+				strcmp(id, clk->function) == 0)
+			goto found;
+
+		if (strcmp(id, clk->name) == 0)
+			goto found;
+	}
+
 	list_for_each_entry(p, &clocks, node) {
 		if (p->id == idno &&
 		    strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
@@ -64,10 +73,14 @@ struct clk * clk_get(struct device *dev, const char *id)
 	list_for_each_entry(p, &clocks, node) {
 		if (strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
 			clk = p;
-			break;
+			goto found;
 		}
 	}
 
+	mutex_unlock(&clocks_mutex);
+
+	return ERR_PTR(-ENOENT);
+
 found:
 	mutex_unlock(&clocks_mutex);
 
@@ -75,6 +88,27 @@ found:
 }
 EXPORT_SYMBOL(clk_get);
 
+/**
+ * clk_associate - associates a user to a clock so device drivers don't
+ * have to care about clock names
+ *
+ * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
+ * @dev: device pointer for the clock user
+ * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
+ */
+void __init clk_associate(const char *id, struct device *dev, const char *f)
+{
+	struct clk *clk = clk_get(NULL, id);
+
+	if (!dev || !clk || !IS_ERR(clk_get(dev, f)))
+		return;
+
+	clk->function = f;
+	clk->dev = dev;
+
+	clk_put(clk);
+};
+
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 9088925..dcfb205 100644
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
@@ -61,8 +63,10 @@ struct dpll_data {
 
 struct clk {
 	struct list_head	node;
+	struct device		*dev;
 	struct module		*owner;
 	const char		*name;
+	const char		*function;
 	int			id;
 	struct clk		*parent;
 	unsigned long		rate;
@@ -116,6 +120,7 @@ struct clk_functions {
 
 extern unsigned int mpurate;
 
+extern void clk_associate(const char *id, struct device *dev, const char *func);
 extern int clk_init(struct clk_functions *custom_clocks);
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
-- 
1.6.0.2.307.gc427


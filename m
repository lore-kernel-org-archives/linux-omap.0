From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 1/8] ARM: OMAP: clk: add support for omap_clk_for_each
Date: Fri, 13 Jul 2012 17:19:38 +0300
Message-ID: <1342189185-5306-2-git-send-email-t-kristo@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35592 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933265Ab2GMOUS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 10:20:18 -0400
In-Reply-To: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This works similarly to e.g. pwrdm_for_each(). Needed by enhanced
usecounting debug functionality that will be added to pm-debug.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/clock.c              |   33 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 706b7e2..ad9dc59 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -355,6 +355,39 @@ int omap_clk_enable_autoidle_all(void)
 	return 0;
 }
 
+/**
+ * omap_clk_for_each - call a function for each registered clock
+ * @fn: pointer to callback function
+ * @data: void * data to pass to callback function
+ *
+ * Call @fn for each registered clock, passing @data to each function.
+ * @fn must return 0 for success or any other value for failure. If
+ * @fn returns non-zero, the iteration across clocks will stop and
+ * the non-zero return value will be passed to the caller of
+ * omap_clk_for_each(). @fn is called with clockfw_lock held.
+ */
+int omap_clk_for_each(int (*fn)(struct clk *clk, void *user), void *user)
+{
+	struct clk *c;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+
+	list_for_each_entry(c, &clocks, node) {
+		ret = fn(c, user);
+		if (ret)
+			break;
+	}
+
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+
+	return ret;
+}
+
 int omap_clk_disable_autoidle_all(void)
 {
 	struct clk *c;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..998947e 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -294,6 +294,8 @@ extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+extern int omap_clk_for_each(int (*fn)(struct clk *clk, void *user),
+				void *user);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
 extern struct clk *omap_clk_get_by_name(const char *name);
 extern int omap_clk_enable_autoidle_all(void);
-- 
1.7.4.1


From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 1/9] ARM: OMAP: clk: add support for omap_clk_for_each
Date: Thu, 31 May 2012 16:28:54 +0300
Message-ID: <1338470942-20185-2-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

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
index 62ec5c4..0a0775a 100644
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

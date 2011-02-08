From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/7] omap: clock: Add allow_idle/deny_idle support in clkops
Date: Tue,  8 Feb 2011 15:40:34 +0530
Message-ID: <1297159838-30282-4-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
 <1297159838-30282-2-git-send-email-rnayak@ti.com>
 <1297159838-30282-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab1BHKKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 05:10:53 -0500
In-Reply-To: <1297159838-30282-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP various clock nodes (dpll's, mx post dividers, interface clocks)
support hardware level autogating which can be controlled from
software.
Support such functionality by adding two new function pointer
allow_idle and deny_idle in the clkops structure.

These function pointers can be populated for any clock
node which supports hardware level autogating.

Also add 2 new functions (omap_clk_enable_auotidle and
omap_clk_disable_autoidle) which can be called from
architecture specific PM core code, if hardware level
autogating (for all supported clock nodes) is to be
enabled or disabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/clock.c              |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    6 ++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index fc62fb5..6889c5a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -335,6 +335,32 @@ struct clk *omap_clk_get_by_name(const char *name)
 	return ret;
 }
 
+void omap_clk_enable_autoidle(void)
+{
+	struct clk *c;
+
+	mutex_lock(&clocks_mutex);
+
+	list_for_each_entry(c, &clocks, node)
+		if (c->ops->allow_idle)
+			c->ops->allow_idle(c);
+
+	mutex_unlock(&clocks_mutex);
+}
+
+void omap_clk_disable_autoidle(void)
+{
+	struct clk *c;
+
+	mutex_lock(&clocks_mutex);
+
+	list_for_each_entry(c, &clocks, node)
+		if (c->ops->deny_idle)
+			c->ops->deny_idle(c);
+
+	mutex_unlock(&clocks_mutex);
+}
+
 /*
  * Low level helpers
  */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..167f1e0 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -25,6 +25,8 @@ struct clockdomain;
  * @disable: fn ptr that enables the current clock in hardware
  * @find_idlest: function returning the IDLEST register for the clock's IP blk
  * @find_companion: function returning the "companion" clk reg for the clock
+ * @allow_idle: fn ptr that enables autoidle for the current clock in hardware
+ * @deny_idle: fn ptr that disables autoidle for the current clock in hardware
  *
  * A "companion" clk is an accompanying clock to the one being queried
  * that must be enabled for the IP module connected to the clock to
@@ -42,6 +44,8 @@ struct clkops {
 					       u8 *, u8 *);
 	void			(*find_companion)(struct clk *, void __iomem **,
 						  u8 *);
+	void			(*allow_idle)(struct clk *);
+	void			(*deny_idle)(struct clk *);
 };
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -292,6 +296,8 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
 extern struct clk *omap_clk_get_by_name(const char *name);
+extern void omap_clk_enable_autoidle(void);
+extern void omap_clk_disable_autoidle(void);
 
 extern const struct clkops clkops_null;
 
-- 
1.7.0.4


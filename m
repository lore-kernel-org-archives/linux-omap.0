From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle support in
 clkops
Date: Sat, 12 Feb 2011 17:25:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121723250.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40385 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab1BMAZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 19:25:57 -0500
In-Reply-To: <alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Sat, 12 Feb 2011, Paul Walmsley wrote:

> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
> 
> > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > index fc62fb5..6889c5a 100644
> > --- a/arch/arm/plat-omap/clock.c
> > +++ b/arch/arm/plat-omap/clock.c
> > @@ -335,6 +335,32 @@ struct clk *omap_clk_get_by_name(const char *name)
> >  	return ret;
> >  }
> >
> > +void omap_clk_enable_autoidle(void)

I also renamed these functions to

omap_clk_enable_autoidle_all()
omap_clk_disable_autoidle_all()

since they operate on all clocks.  Updated patch follows.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 10 Feb 2011 14:46:36 +0530
Subject: [PATCH] OMAP: clock: Add allow_idle/deny_idle support in clkops

On OMAP various clock nodes (dpll's, mx post dividers, interface clocks)
support hardware level autogating which can be controlled from
software.
Support such functionality by adding two new function pointer
allow_idle and deny_idle in the clkops structure.

These function pointers can be populated for any clock
node which supports hardware level autogating.

Also add 2 new functions (omap_clk_enable_autoidle_all and
omap_clk_disable_autoidle_all) which can be called from
architecture specific PM core code, if hardware level
autogating (for all supported clock nodes) is to be
enabled or disabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: use spinlock rather than mutex due to race; renamed functions]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |   28 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    6 ++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index fc62fb5..585533a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -335,6 +335,34 @@ struct clk *omap_clk_get_by_name(const char *name)
 	return ret;
 }
 
+void omap_clk_enable_autoidle_all(void)
+{
+	struct clk *c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+
+	list_for_each_entry(c, &clocks, node)
+		if (c->ops->allow_idle)
+			c->ops->allow_idle(c);
+
+	spin_lock_irqrestore(&clockfw_lock, flags);
+}
+
+void omap_clk_disable_autoidle_all(void)
+{
+	struct clk *c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+
+	list_for_each_entry(c, &clocks, node)
+		if (c->ops->deny_idle)
+			c->ops->deny_idle(c);
+
+	spin_lock_irqrestore(&clockfw_lock, flags);
+}
+
 /*
  * Low level helpers
  */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..8534f71 100644
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
+extern void omap_clk_enable_autoidle_all(void);
+extern void omap_clk_disable_autoidle_all(void);
 
 extern const struct clkops clkops_null;
 
-- 
1.7.2.3


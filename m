From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 2/6] Documentation: common clk API
Date: Tue, 13 Dec 2011 19:53:54 -0800
Message-ID: <1323834838-2206-3-git-send-email-mturquette@linaro.org>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1323834838-2206-1-git-send-email-mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Provide documentation for the common clk structures and APIs.  This code
can be found in drivers/clk/ and include/linux/clk.h.

Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 Documentation/clk.txt |  312 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/clk.txt

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
new file mode 100644
index 0000000..ff75539c
--- /dev/null
+++ b/Documentation/clk.txt
@@ -0,0 +1,312 @@
+		The Common Clk Framework
+		Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
+
+	Part 1 - common data structures and API
+
+The common clk framework is a combination of a common definition of
+struct clk which can be used across most platforms as well as a set of
+driver-facing APIs which operate on those clks.  Platforms can enable it
+by selecting CONFIG_GENERIC_CLK.
+
+Below is the common struct clk definition from include/linux/clk.h.  It
+is modified slightly for brevity:
+
+struct clk {
+	const char		*name;
+	const struct clk_ops	*ops;
+	struct clk		*parent;
+	unsigned long		rate;
+	unsigned long		flags;
+	unsigned int		enable_count;
+	unsigned int		prepare_count;
+	struct hlist_head	children;
+	struct hlist_node	child_node;
+};
+
+The .name, .parent and .children members make up the core of the clk
+tree topology.  The clk API itself defines several driver-facing
+functions which operate on struct clk.  Below is an abbreviated
+description of some of those functions taken from the kerneldoc in
+include/linux/clk.h:
+
+clk_prepare - This prepares the clock source for use.  Must not be
+called from within atomic context.  Must be called before clk_enable.
+
+clk_unprepare - This undoes a previously prepared clock.  The caller
+must balance the number of prepare and unprepare calls.  Must not be
+called from within atomic context.  Must be called after clk_disable.
+
+clk_enable - Inform the system when the clock source should be running.
+If the clock can not be enabled/disabled, this should return success.
+May be called from atomic contexts.  Returns success (0) or negative
+errno.  Must be called after clk_prepare.
+
+clk_disable - Inform the system that a clock source is no longer
+required by a driver and may be shut down.  May be called from atomic
+contexts.  Must be called before clk_unprepare.
+
+clk_get_rate - Obtain the current clock rate (in Hz) for a clock source.
+This is only valid once the clock source has been enabled.  Returns zero
+if the clock rate is unknown.  Does not touch the hardware, just the
+cached rate value.
+
+clk_round_rate - Adjust a rate to the exact rate a clock can provide.
+Returns rounded clock rate in Hz, or negative errno.
+
+clk_set_rate - Set the clock rate for a clock source.  Returns success
+(0) or negative errno.
+
+clk_get_parent - Get the parent clock source for this clock.  Returns
+struct clk corresponding to parent clock source, or valid IS_ERR()
+condition containing errno.  Does not touch the hardware, just the
+cached parent value.
+
+clk_set_parent - Set the parent clock source for this clock.  Returns
+success (0) or negative errno.
+
+For clk implementations which use the common definition of struct clk,
+the above functions use the struct clk_ops pointer in struct clk to
+perform the hardware-specific parts of those operations.  The definition
+of struct clk_ops:
+
+	struct clk_ops {
+		int		(*prepare)(struct clk *clk);
+		void		(*unprepare)(struct clk *clk);
+		int		(*enable)(struct clk *clk);
+		void		(*disable)(struct clk *clk);
+		unsigned long	(*recalc_rate)(struct clk *clk);
+		long		(*round_rate)(struct clk *clk, unsigned long,
+				unsigned long *);
+		int		(*set_rate)(struct clk *clk, unsigned long);
+		int		(*set_parent)(struct clk *clk, struct clk *);
+		struct clk *	(*get_parent)(struct clk *clk);
+	};
+
+	Part 2 - hardware clk implementations
+
+The strength of the common struct clk comes from its .ops pointer and
+the ability for platform and driver code to wrap the struct clk instance
+with hardware-specific data which the operations in the .ops pointer
+have knowledge of.  To illustrate consider the simple gateable clk
+implementation in drivers/clk/clk-basic.c:
+
+struct clk_gate {
+	struct clk      clk;
+	struct clk      *fixed_parent;
+	void __iomem    *reg;
+	u8              bit_idx;
+};
+
+struct clk_gate contains the clk as well as hardware-specific knowledge
+about which register and bit controls this clk's gating.  The
+fixed-parent member is also there as a way to initialize the topology.
+
+Let's walk through enabling this clk from driver code:
+
+	struct clk *clk;
+	clk = clk_get(NULL, "my_gateable_clk");
+
+	clk_prepare(clk);
+	clk_enable(clk);
+
+Note that clk_prepare MUST be called before clk_enable even if
+clk_prepare does nothing (which in this case is true).
+
+The call graph for clk_enable is very simple:
+
+clk_enable(clk);
+	clk->enable(clk);
+			clk_gate_enable_set(clk);
+				clk_gate_set_bit(clk);
+
+And the definition of clk_gate_set_bit:
+
+static void clk_gate_set_bit(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 reg;
+
+	reg = __raw_readl(gate->reg);
+	reg |= BIT(gate->bit_idx);
+	__raw_writel(reg, gate->reg);
+}
+
+Note that in the final call to clk_gate_set_bit there is use of
+to_clk_gate, which is defined as:
+
+#define to_clk_gate(ck) container_of(ck, struct clk_gate, clk)
+
+This simple abstraction is what allows the common clk framework to scale
+across many platforms.  The struct clk definition remains the same while
+the hardware operations in the .ops pointer know the details of the clk
+hardware.  A little pointer arithmetic to get to the data is all that
+the ops need.
+
+	Part 3 - Supporting your own clk hardware
+
+To construct a clk hardware structure for your platform you simply need
+to define the following:
+
+struct clk_your_clk {
+	struct clk;
+	unsigned long some_data;
+	struct your_struct *some_more_data;
+};
+
+To take advantage of your data you'll need to support valid operations
+for your clk:
+
+struct clk_ops clk_ops_your_clk {
+	.enable		= &clk_your_clk_enable;
+	.disable	= &clk_your_clk_disable;
+};
+
+Implement the above functions using container_of:
+
+int clk_your_clk_enable(struct clk *clk)
+{
+	struct clk_your_clk *yclk;
+
+	yclk = container_of(clk, struct clk_your_clk, clk);
+
+	magic(yclk);
+};
+
+If you are statically allocating all of your clk_your_clk instances then
+you will still need to initialize some stuff in struct clk with the
+clk_init function from include/linux/clk.h:
+
+clk_init(&yclk->clk);
+
+If you are dynamically creating clks or using device tree then you might
+want a hardware-specific register function:
+
+int clk_your_clk_register(const char *name, unsigned long flags,
+		unsigned long some_data,
+		struct your_struct *some_more_data)
+{
+	struct clk_your_clk *yclk;
+
+	yclk = kmalloc(sizeof(struct clk_your_clk), GFP_KERNEL);
+
+	yclk->some_data = some_data;
+	yclk->some_more_data = some_more_data;
+
+	yclk->clk.name = name;
+	yclk->clk.flags = flags;
+
+	clk_init(&yclk->clk);
+
+	return 0;
+}
+
+	Part 4 - clk_set_rate & rate change notifications
+
+FIXME - need to flesh this out with notifer info
+
+clk_set_rate deserves a special mention because it is more complex than
+the other operations.  There are three key concepts to the common
+clk_set_rate implementation:
+
+1) recursively traversing up the clk tree and changing clk rates, one
+parent at a time, if each clk allows it
+2) failing to change rate if the clk is enabled and must only change
+rates while disabled
+3) using clk rate change notifiers to allow devices to handle dynamic
+rate changes for clks which do support changing rates while enabled
+
+For the simple, non-recursive case the call graph looks like:
+
+clk_set_rate(clk, rate);
+	__clk_set_rate(clk, rate);
+		clk->round_rate(clk, rate *parent_rate);
+		clk->set_rate(clk, rate);
+
+You might be wondering what that third paramater in .round_rate is.  If
+a clk supports the CLK_PARENT_SET_RATE flag then that enables it's
+hardware-specific .round_rate function to provide a new rate that the
+parent should transition to.  For example, imagine a rate-adjustable clk
+A that is the parent of clk B, which has a fixed divider of 2.
+
+	clk A	(rate = 10MHz) (possible rates = 5MHz, 10MHz, 20MHz)
+	  |
+	  |
+	  |
+	clk B	(rate = 5MHz) (fixed divider of 2)
+
+In the above scenario clk B will always have half the rate of clk A.  If
+clk B is to generate a 10MHz clk then clk A must generate 20MHz in turn.
+The driver writer could hack in knowledge of clk A, but in reality clk B
+drives the devices operation and the driver shouldn't know the details
+of the clk tree topology.  In this case it would be nice for clk B to
+propagate it's request up to clk A.
+
+Here the call graph for our above example:
+
+clk_set_rate(clk, rate);
+	__clk_set_rate(clk, rate);
+		clk->round_rate(clk, rate *parent_rate);
+		clk->set_rate(clk, rate);
+		__clk_set_rate(clk->parent, parent_rate);
+			clk->round_rate(clk, rate *parent_rate);
+			clk->set_rate(clk, rate);
+
+Note that the burden of figuring out whether to recurse upwards falls on
+the hardware-specific .round_rate function.  The common clk framework
+does not have the context to make such complicated decisions in a
+generic way for all platforms.
+
+Another caveat is that child clks might run at weird intermediate
+frequencies during a complex upwards propagation, as illustrated below:
+
+	clk A  (pll 100MHz - 300MHz)	(currently locked at 200MHz)
+	  |
+	  |
+	  |
+	clk B  (divide by 1 or 2)	(currently divide by 2, 100MHz)
+	  |
+	  |
+	  |
+	clk C  (divide by 1 or 2)	(currently divide by 1, 100MHz)
+
+The call graph below, with some bracketed annotations, describes how
+this might work with some clever .round_rate callbacks when trying to
+set clk C to run at 26MHz:
+
+clk_set_rate(C, 26MHz);
+	__clk_set_rate(C, 26MHz);
+		clk->round_rate(C, 26MHz, *parent_rate);
+		[ round_rate returns 50MHz ]
+		[ &parent_rate is 52MHz ]
+		clk->set_rate(C, 50Mhz);
+		[ clk C is set to 50MHz, which sets divider to 2 ]
+		__clk_set_rate(clk->parent, parent_rate);
+			clk->round_rate(B, 52MHz, *parent_rate);
+			[ round_rate returns 100MHz ]
+			[ &parent_rate is 104MHz ]
+			clk->set_rate(B, 100MHz);
+			[ clk B stays at 100MHz, divider stays at 2 ]
+			__clk_set_rate(clk->parent, parent_rate);
+				[ round_rate returns 104MHz ]
+				[ &parent_rate is ignored ]
+				clk->set_rate(A, 104MHz);
+				[ clk A is set to 104MHz]
+
+The end result is that clk C runs at 26MHz.  Each .set_rate callback
+actually sets the intermediate rate, which nicely reflects reality.
+Once clk rate change notifiers are supported then it is expected that
+PRECHANGE notifiers will "stack" in situations with recursive
+clk_set_rate calls.
+
+Thus a driver X which subcribes to rate-change notifers for clk C would
+have received 2 PRECHANGE notifiers in the above example.  The first
+would have notified the driver that clk C was changing from 100MHz to
+50MHz.  The second PRECHANGE notifier would have told driver X that clk
+C had changed from 50MHz to 26MHz.  There would not be a PRECHANGE
+notifier corresponding to __clk_set_rate(B, 50MHz) since B is already
+running at that rate and the notification would be unnecessary.
+
+clk_set_rate is written in such a way that POSTCHANGE notifiers and
+ABORTCHANGE notifiers will only be sent once.  Each will start
+propagation from the highest point in the tree which was affected by the
+operation.
-- 
1.7.5.4

From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle support in
	clkops
Date: Mon, 14 Feb 2011 17:53:49 +0530
Message-ID: <ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 5:35 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle
support in clkops
>
> Hi Rajendra
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > index fc62fb5..6889c5a 100644
> > --- a/arch/arm/plat-omap/clock.c
> > +++ b/arch/arm/plat-omap/clock.c
> > @@ -335,6 +335,32 @@ struct clk *omap_clk_get_by_name(const char
*name)
> >  	return ret;
> >  }
> >
> > +void omap_clk_enable_autoidle(void)
> > +{
> > +	struct clk *c;
> > +
> > +	mutex_lock(&clocks_mutex);
>
> With the current OMAP clock code, it isn't sufficient to use a mutex
here.
> Your underlying functions have to read, modify, and write a register
that
> is also touched by clock functions like clk_set_rate(), which take the
> clockfw spinlock and not the mutex.  This is potentially racy and could
> result in inconsistencies between the internal clock tree data and the
> hardware settings.
>
> While it is true that these functions are currently only called during
PM
> init, I'd rather not commit code that is subject to known races into the
> tree.
>
> So, before applying this patch, the mutexes have been converted into
> spinlocks.  I would appreciate it if you could help test this.  Updated
> patch follows, which has been queued for 2.6.39 as part of the
> 'clk_autoidle_a_2.6.39' branch of git://git.pwsan.com/linux-2.6.

I used the clk_autoidle_a_2.6.39 branch and tested OFF mode
in suspend on 3430sdp.
I also tested CORE ret in suspend (using some out of tree patches)
on 4430sdp.

A couple of issues on the clk_autoidle_a_2.6.39 branch:
-1- There seems to be a missing fix which causes an abort
at boot on omap4
http://marc.info/?l=linux-omap&m=129768574027232&w=2
-2- There is a trivial fix (Patch below) needed which otherwise
breaks build

----
>From fbfb508e319021026402d743d76cac294bd02cfa Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Mon, 14 Feb 2011 17:47:15 +0530
Subject: [PATCH] OMAP: clock: Fix compile break with a
s/spin_lock_irq*/spin_unlock_irq*

Trivial fix to do a s/spin_lock_irqrestore/spin_unlock_irqrestore
and fix the compile break.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 585533a..a2b069f 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -346,7 +346,7 @@ void omap_clk_enable_autoidle_all(void)
 		if (c->ops->allow_idle)
 			c->ops->allow_idle(c);

-	spin_lock_irqrestore(&clockfw_lock, flags);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
 }

 void omap_clk_disable_autoidle_all(void)
@@ -360,7 +360,7 @@ void omap_clk_disable_autoidle_all(void)
 		if (c->ops->deny_idle)
 			c->ops->deny_idle(c);

-	spin_lock_irqrestore(&clockfw_lock, flags);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
 }

 /*
-- 
1.7.0.4

Regards,
Rajendra

>
>
> - Paul
>
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Thu, 10 Feb 2011 14:46:36 +0530
> Subject: [PATCH] omap: clock: Add allow_idle/deny_idle support in clkops
>
> On OMAP various clock nodes (dpll's, mx post dividers, interface clocks)
> support hardware level autogating which can be controlled from
> software.
> Support such functionality by adding two new function pointer
> allow_idle and deny_idle in the clkops structure.
>
> These function pointers can be populated for any clock
> node which supports hardware level autogating.
>
> Also add 2 new functions (omap_clk_enable_auotidle and
> omap_clk_disable_autoidle) which can be called from
> architecture specific PM core code, if hardware level
> autogating (for all supported clock nodes) is to be
> enabled or disabled.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: use spinlock rather than mutex due to race]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/clock.c              |   28
++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/clock.h |    6 ++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index fc62fb5..0cdac8d 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -335,6 +335,34 @@ struct clk *omap_clk_get_by_name(const char *name)
>  	return ret;
>  }
>
> +void omap_clk_enable_autoidle(void)
> +{
> +	struct clk *c;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +
> +	list_for_each_entry(c, &clocks, node)
> +		if (c->ops->allow_idle)
> +			c->ops->allow_idle(c);
> +
> +	spin_lock_irqrestore(&clockfw_lock, flags);
> +}
> +
> +void omap_clk_disable_autoidle(void)
> +{
> +	struct clk *c;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +
> +	list_for_each_entry(c, &clocks, node)
> +		if (c->ops->deny_idle)
> +			c->ops->deny_idle(c);
> +
> +	spin_lock_irqrestore(&clockfw_lock, flags);
> +}
> +
>  /*
>   * Low level helpers
>   */
> diff --git a/arch/arm/plat-omap/include/plat/clock.h
b/arch/arm/plat-omap/include/plat/clock.h
> index 8eb0ada..167f1e0f 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -25,6 +25,8 @@ struct clockdomain;
>   * @disable: fn ptr that enables the current clock in hardware
>   * @find_idlest: function returning the IDLEST register for the clock's
IP blk
>   * @find_companion: function returning the "companion" clk reg for the
clock
> + * @allow_idle: fn ptr that enables autoidle for the current clock in
hardware
> + * @deny_idle: fn ptr that disables autoidle for the current clock in
hardware
>   *
>   * A "companion" clk is an accompanying clock to the one being queried
>   * that must be enabled for the IP module connected to the clock to
> @@ -42,6 +44,8 @@ struct clkops {
>  					       u8 *, u8 *);
>  	void			(*find_companion)(struct clk *, void
__iomem **,
>  						  u8 *);
> +	void			(*allow_idle)(struct clk *);
> +	void			(*deny_idle)(struct clk *);
>  };
>
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> @@ -292,6 +296,8 @@ extern void clk_init_cpufreq_table(struct
cpufreq_frequency_table **table);
>  extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table
**table);
>  #endif
>  extern struct clk *omap_clk_get_by_name(const char *name);
> +extern void omap_clk_enable_autoidle(void);
> +extern void omap_clk_disable_autoidle(void);
>
>  extern const struct clkops clkops_null;
>
> --
> 1.7.2.3

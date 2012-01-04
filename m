From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Wed, 4 Jan 2012 10:15:42 +0800
Message-ID: <20120104021541.GI2414@b20223-02.ap.freescale.net>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-4-git-send-email-mturquette@linaro.org>
	<alpine.LFD.2.02.1112141007550.3020@ionos>
	<CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wro=
te:
> > On Tue, 13 Dec 2011, Mike Turquette wrote:
> >> +void __clk_unprepare(struct clk *clk)
> >> +{
> >> + =A0 =A0 if (!clk)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 if (WARN_ON(clk->prepare_count =3D=3D 0))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 if (--clk->prepare_count > 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 WARN_ON(clk->enable_count > 0);
> >
> > So this leaves the clock enable count set. I'm a bit wary about
> > that. Shouldn't it either return (including bumping the prepare_count
> > again) or call clk_disable() ?
> =

> I've hit this in my port of OMAP.  It comes from this simple situation:
> =

> driver 1 (adapted for clk_prepare/clk_unprepare):
> clk_prepare(clk);
> clk_enable(clk);
> =

> ...
> =

> driver2 (not adapted for clk_prepare/clk_unprepare):
> clk_enable(clk);
> =

> ...
> =

> driver1:
> clk_disable(clk);
> clk_unprepare(clk);
> =

> In such a case we don't want to bump the prepare_count, since the
> offending driver2 won't decrement that count.  Also we don't want to
> shut down that clk since driver2 is using it.
> =

> Returning after the WARN is maybe OK, but the point of this check is
> really to find code which hasn't yet been made prepare-aware, and the
> current implementation is noisy enough about it.
> =

> >> +/**
> >> + * clk_get_parent - return the parent of a clk
> >> + * @clk: the clk whose parent gets returned
> >> + *
> >> + * Simply returns clk->parent. =A0It is up to the caller to hold the
> >> + * prepare_lock, if desired. =A0Returns NULL if clk is NULL.
> >
> > Holding the prepare lock in the caller will deadlock. So it's not a
> > real good idea to document it as an option :)
> =

> Oops.  That comment is left over from before clk_get_parent held the
> lock.  Will remove.
> =

> >
> >> + */
> >> +struct clk *clk_get_parent(struct clk *clk)
> >> +{
> >> + =A0 =A0 struct clk *parent;
> >> +
> >> + =A0 =A0 if (!clk)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> >> +
> >> + =A0 =A0 mutex_lock(&prepare_lock);
> >
> >> +/**
> >> + * clk_init - initialize the data structures in a struct clk
> >> + * @dev: device initializing this clk, placeholder for now
> >> + * @clk: clk being initialized
> >> + *
> >> + * Initializes the lists in struct clk, queries the hardware for the
> >> + * parent and rate and sets them both. =A0Adds the clk to the sysfs t=
ree
> >> + * topology.
> >> + *
> >> + * Caller must populate clk->name and clk->flags before calling
> >
> > I'm not too happy about this construct. That leaves struct clk and its
> > members exposed to the world instead of making it a real opaque
> > cookie. I know from my own painful experience, that this will lead to
> > random fiddling in that data structure in drivers and arch code just
> > because the core code has a shortcoming.
> >
> > Why can't we make struct clk a real cookie and confine the data
> > structure to the core code ?
> >
> > That would change the init call to something like:
> >
> > struct clk *clk_init(struct device *dev, const struct clk_hw *hw,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *parent)
> >
> > And have:
> > struct clk_hw {
> > =A0 =A0 =A0 struct clk_hw_ops *ops;
> > =A0 =A0 =A0 const char =A0 =A0 =A0 =A0*name;
> > =A0 =A0 =A0 unsigned long =A0 =A0 flags;
> > };
> >
> > Implementers can do:
> > struct my_clk_hw {
> > =A0 =A0 =A0 struct clk_hw =A0 =A0hw;
> > =A0 =A0 =A0 mydata;
> > };
> >
> > And then change the clk ops callbacks to take struct clk_hw * as an
> > argument.
We have to define static clocks before we adopt DT binding.
If clk is opaque and allocate memory in clk core, it'll make hard
to define static clocks. And register/init will pass a long parameter
list.
> >
> > So the core code can allocate the clk data structure and you return a
> > real opaque cookie. You do the same thing for the basic gated clock in
> > one of the next patches, so doing it for struct clk itself is just
> > consequent.
> =

> The opaque cookie would work if platform code never needs any
> information outside of the data a single clk_hw_whatever provides.
> Unfortunately hardware doesn't make things that easy on us and the
> operations we do for a single clk are affected by the state of other
> clks.
> =

> Here is an example I've been using a lot lately: on OMAP we have two
> clock inputs to our PLLs: a bypass clk and reference clk (actually we
> can have more than this).  When changing the PLL rate both clks must
> be enabled, regardless of which clk ends up driving the PLL.  To
> illustrate, the PLL may be driven by clk_ref at 400MHz, and then we
> call clk_set_rate(pll_clk, 196000000); which will also leave it
> clocked by clk_ref but at 196MHz.  For this to happen however, the
> clk_bypass had to be enabled during the rate change operation.  Here
> is the relevant .set_rate implementation:
> http://git.linaro.org/gitweb?p=3Dpeople/mturquette/linux.git;a=3Dblob;f=
=3Darch/arm/mach-omap2/dpll3xxx.c;h=3Db2412574b63829944593c1a7a6eda5fa43506=
86f;hb=3D738bde65918ae1ac743b1498801da0b860e2ee32#l461
> =

> In order for the OMAP platform code to do this, we have to have two
> things: firstly we need the struct clk so that we can call
> clk_enable/disable and __clk_prepare/unprepare on the ref and bypass
> clks from within .set_rate.  The second thing is that we need
> __clk_prepare and __clk_unprepare to be visible by this code so that
> we don't nest the prepare_lock mutex.
> =

> Is there a good way to solve such problems if we hide struct clk from
> the platform code/clk driver implementation?
You can add a function clk_to_hw to convert struct clk to struct clk_hw.
It's the way I did with the patch you didn't expose struct clk.

clock driver gate2b needs to access clk_hw. clk_gate2b_set_val can set
value for enable and disable at runtime. At opaque time, it have to get
clk_hw first and then get struct clk_gate2b.
> =

> Also note that if top-level clk APIs are going to be holding
> prepare_lock (clk_get_rate, clk_get_parent, etc) then we can't call
> these APIs to get the info we want from within the platform code.  For
> example, today most .recalc_rate implementations reference
> clk->parent->rate and apply it to some divider or something.  To get
> around having an opaque cookie .recalc_rate would have to have
> parent->rate passed into it since the implementation cannot call
> clk_get_rate(clk_get_parent(clk)) due to not having 'clk' in the first
> place, and also because of mutex nesting.
why do we need lock in clk_get_rate?
> =

> I agree that by not using an opaque cookie we open ourselves up to the
> possibility of badness, but we'll just have to catch it in code
> review.
> =

> >
> >> + * clk_init. =A0A key assumption in the call to .get_parent is that c=
lks
> >> + * are being initialized in-order.
> >
> > We should not require that, see below.
> >
> >> + */
> >
> >> +void clk_init(struct device *dev, struct clk *clk)
> >> +{
> >> + =A0 =A0 if (!clk)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 INIT_HLIST_HEAD(&clk->children);
> >> + =A0 =A0 INIT_HLIST_NODE(&clk->child_node);
> >> +
> >> + =A0 =A0 mutex_lock(&prepare_lock);
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* .get_parent is mandatory for populating .parent for clk=
s with
> >> + =A0 =A0 =A0* multiple possible parents. =A0For clks with a fixed par=
ent
> >> + =A0 =A0 =A0* .get_parent is not mandatory and .parent can be statica=
lly
> >> + =A0 =A0 =A0* initialized
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (clk->ops->get_parent)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 clk->parent =3D clk->ops->get_parent(clk);
> >> +
> >> + =A0 =A0 /* clks without a parent are considered root clks */
> >
> > I'd rather prefer that root clocks are explicitely marked with a flag
> > instead of relying on clk->parent being NULL.
> =

> I originally had CLK_IS_ROOT flag but removed it after thinking that
> some clks might be a root sometimes, or a child at other times and I
> had considered the flags to be constant.
I didn't see part-time root clock in IMX.
> =

> If the flags aren't going to be constant and can change at run-time
> then I can move this back to a flag.  Also if there are no use cases
> where a clk can change from a root to a child then again this can
> safely go into flags.  Thoughts?
> =

> >
> >> + =A0 =A0 if (clk->parent)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 hlist_add_head(&clk->child_node,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &clk->parent=
->children);
> >> + =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 hlist_add_head(&clk->child_node, &clk_root_l=
ist);
> >
> > You could put clocks which have no parent and are not marked as root
> > clock onto a separate list clk_orphaned or such. You might need this
> > for handling clocks which are disconnected from any parent runtime as
> > well.
> =

> Agreed, that is a more well-defined approach.
> =

> > And to avoid the whole in-order initialization issue, you could change
> > clk_init to:
> >
> > struct clk *clk_init(struct device *dev, const struct clk_hw *hw,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags, const char=
 *parent_name)
> >
> > Then you can lookup the requested parent by name. If that fails, you
> > put the clock into the orphaned list. When a new clock is initialized,
> > then you walk the orphaned list and check whether something is waiting
> > for that clock.
> >
> > To handle multi-parent clocks you need to go one step further and add:
> >
> > struct clk_hw {
> > =A0 =A0 =A0 struct clk_hw_ops *ops;
> > =A0 =A0 =A0 const char =A0 =A0 =A0 =A0*name;
> > =A0 =A0 =A0 const char =A0 =A0 =A0 =A0**possible_parents;
> > };
> >
> > You also require a get_parent_idx() function in clk_hw_ops. So when
> > clk_init() is called with parent_name =3D NULL and get_parent_idx() is
> > implemented, then you call it and the clock returns you the index of
> > the possible_parents array. If that parent clock is not yet
> > registered, you store the requested name and do the lookup when new
> > clocks are registered.
> =

> This approach ends up having something like O(n^2) (similar to
> discussion around driver re-probing).
Split it to two functions? clk_add can add clks in any order, and
clk_tree_init call .get_parent (if possible) create the tree.
Adding clk after clk_tree_init must be in strong order.
> =

> However, I agree that forcing folks to register/init clks in-order is
> asking for trouble.  I also think that for groups of well defined clks
> (SoC clks, or clks in the same device) that are statically initialized
> we should allow for having clk->parent populated statically and leave
> it at that (mux clks will still need to run clk->get_parent() in
> clk_init of course, since we can't trust the bootloader).
right.
> =

> >
> > That has also the advantage, that you can validate parent settings
> > upfront and for setting the parent during runtime, you don't have to
> > acquire a pointer to the parent clock. It's enough to call
> > clk_set_named_parent().
That'll cause clk core to call clkdev functions. But looks fine.

Thanks
Richard
> =

> Right, but the usefulness of this last point hinges on whether or not
> we want to hide struct clk from the rest of the world.  I still think
> that doing so will end up being a limitation that platforms end up
> having to hack around.  I'd like a lot more input from the folks
> porting their platforms to this code on that point, as it is a
> critical design element.
> =

> Thanks for reviewing,
> Mike
> =

> >
> > Thoughts ?
> >
> > =A0 =A0 =A0 =A0 tglx
> >
> >
> >
> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> =

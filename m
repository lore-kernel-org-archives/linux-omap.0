From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Wed, 14 Dec 2011 11:07:12 -0800
Message-ID: <CAJOA=zPdjqpAzqWEJyKX9qKXhtDpuUz5GhBRz2sNyZV77di5QQ@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-4-git-send-email-mturquette@linaro.org>
	<4EE82B76.2000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4EE82B76.2000204-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 13, 2011 at 8:52 PM, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 14/12/11 14:53, Mike Turquette wrote:
>> +void __clk_unprepare(struct clk *clk)
>> +{
>> + =A0 =A0 if (!clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (WARN_ON(clk->prepare_count =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (--clk->prepare_count > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 WARN_ON(clk->enable_count > 0);
>> +
>> + =A0 =A0 if (clk->ops->unprepare)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->unprepare(clk);
>> +
>> + =A0 =A0 __clk_unprepare(clk->parent);
>> +}
>
>
> I think you can rewrite this to get rid of the recursion as below:
>
> =A0 =A0 =A0 =A0while (clk) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WARN_ON(clk->prepare_count =3D=3D 0))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (--clk->prepare_count > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ON(clk->enable_count > 0)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->ops->unprepare)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk->ops->unprepare(clk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk =3D clk->parent;
> =A0 =A0 =A0 =A0}

Looks good.  I'll roll into next set.

> Also, should this function be static?

No, since platform clk code will occasionally be forced to call
clk_(un)prepare while the prepare_lock mutex is held.  For a valid
example see:
http://git.linaro.org/gitweb?p=3Dpeople/mturquette/linux.git;a=3Dblob;f=3Da=
rch/arm/mach-omap2/dpll3xxx.c;h=3Db2412574b63829944593c1a7a6eda5fa4350686f;=
hb=3D738bde65918ae1ac743b1498801da0b860e2ee32#l461

>> +void clk_unprepare(struct clk *clk)
>> +{
>> + =A0 =A0 mutex_lock(&prepare_lock);
>> + =A0 =A0 __clk_unprepare(clk);
>> + =A0 =A0 mutex_unlock(&prepare_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(clk_unprepare);
>> +
>> +int __clk_prepare(struct clk *clk)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (!clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (clk->prepare_count =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __clk_prepare(clk->parent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (clk->ops->prepare) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->ops->prepare(clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_unprepar=
e(clk->parent);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk->prepare_count++;
>> +
>> + =A0 =A0 return 0;
>> +}
>
>
> This is unfortunately a bit tricky to remove the recursion from without
> keeping a local stack of the clocks leading up to first unprepared
> client :-/.
>
> Again, should this be static? What outside this file needs to
> prepare/unprepare clocks without the lock held?

Same as above.

>> +int clk_prepare(struct clk *clk)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 mutex_lock(&prepare_lock);
>> + =A0 =A0 ret =3D __clk_prepare(clk);
>> + =A0 =A0 mutex_unlock(&prepare_lock);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(clk_prepare);
>> +
>> +void __clk_disable(struct clk *clk)
>> +{
>> + =A0 =A0 if (!clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (WARN_ON(clk->enable_count =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (--clk->enable_count > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (clk->ops->disable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->disable(clk);
>> +
>> + =A0 =A0 if (clk->parent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __clk_disable(clk->parent);
>
>
> Easy to get rid of the recursion here. Also should be static?

Yes the enable/disable should be static.  I originally made them
non-static when I converted the prepare/unprepare set, but of course
it's possible to call these with the prepare_lock mutex held so I'll
fix this up in the next set.

>> +long clk_round_rate(struct clk *clk, unsigned long rate)
>> +{
>> + =A0 =A0 if (clk && clk->ops->round_rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return clk->ops->round_rate(clk, rate, NULL);
>> +
>> + =A0 =A0 return rate;
>> +}
>> +EXPORT_SYMBOL_GPL(clk_round_rate);
>
>
> If the clock doesn't provide a round rate function then shouldn't we
> return an error to the caller? Telling the caller that the rate is
> perfect might lead to odd driver bugs?

Yes this code should so something better.  I've been focused mostly on
the "write" aspects of the clk API (set_rate, set_parent,
enable/disable and prepare/unprepare) and less on the "read" aspects
of the clk API (get_rate, get_parent, round_rate, etc).  I'll give
this a closer look for the next set.

>> +/**
>> + * DOC: Using the CLK_PARENT_SET_RATE flag
>> + *
>> + * __clk_set_rate changes the child's rate before the parent's to more
>> + * easily handle failure conditions.
>> + *
>> + * This means clk might run out of spec for a short time if its rate is
>> + * increased before the parent's rate is updated.
>> + *
>> + * To prevent this consider setting the CLK_GATE_SET_RATE flag on any
>> + * clk where you also set the CLK_PARENT_SET_RATE flag
>> + */
>
>
> Is this standard kerneldoc format?

It is:
http://git.linaro.org/gitweb?p=3Dpeople/mturquette/linux.git;a=3Dblob;f=3DD=
ocumentation/kernel-doc-nano-HOWTO.txt;h=3D3d8a97747f7731c801ca7d3a1483858f=
eeb76b6c;hb=3Drefs/heads/v3.2-rc5-clkv4-omap#l298

>> +struct clk *__clk_set_rate(struct clk *clk, unsigned long rate)
>
>
> static?

I'll make it static.  I don't think any platform code needs to call
this (at least I hope not).

>> +{
>> + =A0 =A0 struct clk *fail_clk =3D NULL;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 unsigned long old_rate =3D clk->rate;
>> + =A0 =A0 unsigned long new_rate;
>> + =A0 =A0 unsigned long parent_old_rate;
>> + =A0 =A0 unsigned long parent_new_rate =3D 0;
>> + =A0 =A0 struct clk *child;
>> + =A0 =A0 struct hlist_node *tmp;
>> +
>> + =A0 =A0 /* bail early if we can't change rate while clk is enabled */
>> + =A0 =A0 if ((clk->flags & CLK_GATE_SET_RATE) && clk->enable_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return clk;
>> +
>> + =A0 =A0 /* find the new rate and see if parent rate should change too =
*/
>> + =A0 =A0 WARN_ON(!clk->ops->round_rate);
>> +
>> + =A0 =A0 new_rate =3D clk->ops->round_rate(clk, rate, &parent_new_rate);
>> +
>> + =A0 =A0 /* FIXME propagate pre-rate change notification here */
>> + =A0 =A0 /* XXX note that pre-rate change notifications will stack */
>> +
>> + =A0 =A0 /* change the rate of this clk */
>> + =A0 =A0 if (clk->ops->set_rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->ops->set_rate(clk, new_rate);
>> +
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return clk;
>
>
> Is there are reason to write it this way and not:
>
> =A0 =A0 =A0 =A0if (clk->ops->set_rate) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D clk->ops->set_rate(clk, new_rate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return clk;
> =A0 =A0 =A0 =A0}
>
> If !clk->ops->set_rate then ret is always zero right? Note, making this
> change means that you don't need to init ret to zero at the top of this
> function.

Looks good.  Will fix in the next set.

>> +int clk_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> + =A0 =A0 struct clk *fail_clk;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 /* prevent racing with updates to the clock topology */
>> + =A0 =A0 mutex_lock(&prepare_lock);
>> +
>> + =A0 =A0 /* bail early if nothing to do */
>> + =A0 =A0 if (rate =3D=3D clk->rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
>> +
>> + =A0 =A0 fail_clk =3D __clk_set_rate(clk, rate);
>> + =A0 =A0 if (fail_clk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: failed to set %s rate\n", __func_=
_,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fail_clk->name=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME propagate rate change abort notificat=
ion here */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>
>
> Why does __clk_set_rate return a struct clk if you don't do anything
> with it? You can move the pr_warn into __clk_set_rate and have it return
> a proper errno value instead so that you get a reason why it failed to
> set the rate.

The next patch in the series uses fail_clk to propagate
ABORT_RATE_CHANGE notifications to any drivers that have subscribed to
them.  The FIXME comment hints at that but doesn't make it clear.  The
idea is that the PRE_RATE_CHANGE notifiers will be noisy and stack up
(potentially), but I only want to propagate the POST_RATE_CHANGE and
ABORT_RATE_CHANGE notifications once for any single call to
clk_set_rate, which is why __clk_set_rate returns a struct clk *.

>> +void __clk_reparent(struct clk *clk, struct clk *new_parent)
>> +{
>
>> + =A0 =A0 if (!clk || !new_parent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>
>
> clk_reparent already checks for !clk, shouldn't it also check for
> !new_parent and remove the check from here?

I need to take another look at this.  new_parent can be NULL if we
think it is plausible for a parented clk to suddenly become a root clk
(where clk->parent =3D=3D NULL).

Thanks for reviewing,
Mike

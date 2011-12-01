From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/5] clk: introduce the common clock framework
Date: Wed, 30 Nov 2011 21:53:40 -0800
Message-ID: <CAJOA=zM4vcyTt_RBEVm6JxmzW-Dna0gpuWda7ytq_mqFSuXw9g@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-4-git-send-email-mturquette@linaro.org>
	<alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1111291619110.6289-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 30, 2011 at 5:20 PM, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> wrote:
> This implementation of clk_get_rate() is racy, and is, in general, unsafe.
> The problem is that, in many cases, the clock's rate may change between
> the time that clk_get_rate() is called and the time that the returned
> rate is used. =A0This is the case for many clocks which are part of a
> larger DVFS domain, for example.

Hi Paul,

Thanks much for reviewing.  Just FYI, the v4 patchset I'm working on
has clk_get_rate and clk_get_parent hold the prepare mutex themselves,
so it solves some of the raciness of accessing struct clk members.
This change does not address your points below but I wanted to include
it for completeness sake.

> Several changes are needed to fix this:
>
> 1. When a clock user calls clk_enable() on a clock, the clock framework
> should prevent other users of the clock from changing the clock's rate.
> This should persist until the clock user calls clk_disable() (but see also
> #2 below). =A0This will ensure that clock users can rely on the rate
> returned by clk_get_rate(), as long as it's called between clk_enable()
> and clk_disable(). =A0And since the clock's rate is guaranteed to remain =
the
> same during this time, code that cannot tolerate clock rate changes
> without special handling (such as driver code for external I/O devices)
> will work safely without further modification.

This is certainly imposing a default behavior in the clk framework core.

> 2. Since the protocol described in #1 above will prevent DVFS from working
> when the clock is part of a larger DVFS clock group, functions need to be
> added to allow and prevent other clock users from changing the clock's
> rate. =A0I'll use the function names "clk_allow_rate_changes(struct clk *=
)"
> and "clk_block_rate_changes(struct clk *)" for this discussion. =A0These
> functions can be used by clock users to define critical sections during
> which other entities on the system are allowed to change a clock's rate -
> even if the clock is currently enabled. =A0(Note that when a clock is
> prevented from changing its rate, all of the clocks from it up to the root
> of the tree should also be prevented from changing rates, since parent
> rate changes generally cause disruptions in downstream clocks.)

Likewise when a clk is requested to transition to a new frequency it
will have to clear it with all of the clks below it, so there is still
a need to propagate a request throughout the clk tree whenever
clk_set_rate is called and take a decision.

One way to solve this is for driver owners to sprinkle their code with
clk_block_rate_change and clk_allow_rate_change as you propose.  There
is a problem with this method if it is not supplemented with
rate-change notifications that drivers are allowed to handle
asynchronously.  Take for example a MMC driver which normally runs
it's functional clk at 24MHz.  However for a low-intensity, periodic
task such as playing an mp3 from SD card we would really like to lower
clk rates across the whole SoC.  Assuming that the MMC driver holds
clk_block_rate_change across any SD card transaction, our low power
scheme to lower clks across the SoC is stuck in a racy game of trying
to request a lower clk rate for the MMC functional clk while that same
MMC controller is mostly saturated serving up the mp3.

In this case it would be nice to have asynchronous notifiers that can
interrupt the MMC driver with a pre-change notifier and say "please
finish your current transaction, stall your next transaction, and then
return so I can change your clk rate".  Then after the clk rate change
occurs a post-change notification would also go out to the MMC driver
saying "ok I'm done changing rates.  here is your new clk rate and
please continue working".  The notification is very polite.

It is worth nothing that the MMC driver can return NOTIFY_STOP in it's
pre-change notification handler and this effectively does the same
thing as traversing the clk subtree and checking to make sure that
nobody is holding clk_block_rate_change against any of the children
clocks.

The point of all of that text above is to say: if we have to walk the
whole clk subtree below the point where we want to change rates AND we
want to make a dynamic case-by-case call on whether to allow the rate
change to happen (as opposed to contending with the allow/block
semantics) then I think that only having notifications will suffice.

> 3. For the above changes to work, the clock framework will need to
> discriminate between different clock users' calls to clock functions like
> clk_{get,set}_rate(), etc. =A0Luckily this should be possible within the
> current clock interface. =A0clk_get() can allocate and return a new struct
> clk that clk_put() can later free. =A0One useful side effect of doing this
> is that the clock framework could catch unbalanced clk_{enable,disable}()
> calls.

This is definitely worth thinking about.  Another way to accomplish
this is stop treating prepare_count and enable_count as scalars and
instead vectorize them by tracking a list of struct device *'s.  This
starts to get into can-of-worms territory if we want to consider
clk_set_rate_range(dev, clk, min, max) and the broader DVFS
implications.  I'm a little worried about under-designing now for
future DVFS stuff, but I also don't want the common clk fundamentals
to stall any more than it has (2+ years!).

> 4. clk_get_rate() must return an error when it's called in situations
> where the caller hasn't ensured that the clock's rate won't be changed by
> other entities. =A0For non-fixed rate clocks, these forbidden sections wo=
uld
> include code between a clk_get() and a clk_enable(), or between a
> clk_disable() and a clk_put() or clk_enable(), or between a
> clk_allow_rate_changes() and clk_block_rate_changes(). =A0The first and
> second of those three cases will require some code auditing of
> clk_get_rate() users to ensure that they are only calling it after they've
> enabled the clock. =A0And presumably most of them are not checking for
> error. =A0include/linux/clk.h doesn't define an error return value, so th=
is
> needs to be explicitly defined in clk.h.

This adds a lot of burden to a driver that just wants to know a rate.
Especially if that purpose is for something as simple/transient as a
pr_debug message or something.

Thanks again for the review.  I'll chew on it a bit.

Regards,
Mike

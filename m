From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 2/5] Documentation: common clk API
Date: Sat, 26 Nov 2011 16:47:25 +0800
Message-ID: <20111126084724.GB19025@S2100-06.ap.freescale.net>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-3-git-send-email-mturquette@linaro.org>
	<4ECC5455.6040806@codeaurora.org>
	<CAJOA=zNPNok6HG1jvg=v-_SFJCyNgYPPJbmTeyfOQ0iYdjbStQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJOA=zNPNok6HG1jvg=v-_SFJCyNgYPPJbmTeyfOQ0iYdjbStQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 23, 2011 at 12:33:47PM -0800, Turquette, Mike wrote:
> On Tue, Nov 22, 2011 at 6:03 PM, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>=
 wrote:
> > On 11/21/2011 05:40 PM, Mike Turquette wrote:

[...]

> >> +is modified slightly for brevity:
> >> +
> >> +struct clk {
> >> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> >> + =A0 =A0 =A0 const struct clk_hw_ops *ops;
> >
> > No strong opinion, but can we call this clk_ops for brevity?
> =

> I prefer clk_hw_ops, as it clearly delineates that these operations
> know hardware-specific details.
> =

I tend to agree with Saravana for brevity.  Looking at clk-basic.c,
I do not think it's necessary to encode 'hw' in naming of clk_hw_fixed,
clk_hw_gate and any clocks wrapping 'struct clk' in there.  For
example, naming like clk_dummy, clk_imx seems brevity and clear,
and we do not need clk_hw_dummy and clk_hw_imx necessarily.

[...]

> >> +
> >> +clk_set_rate - Attempts to change the clk rate to the one specified.
> >> +Depending on a variety of common flags it may fail to maintain system
> >> +stability or result in a variety of other clk rates changing.
> >
> > I'm not sure if this is intentional or if it's a mistake in phrasing it=
. IMHO, the rates of other clocks that are actually made available to devic=
e drivers should not be changed. This call might trigger rate changes insid=
e the tree to accommodate the request from various children, but should not=
 affect the rate of the leaf nodes.
> >
> > Can you please clarify the intention and/or the wording?
> =

> Setting the flag CLK_GATE_SET_RATE tells clk_set_rate not to change
> the rate if the clk is enabled.  This policy is not enforced
> abritrarily: you don't have to set the flag on your clk.  I'll update
> the doc to make explicit mention of this flag.
> =

I guess the concern is not about the flag but the result of clk_set_rate
that might change a variety of other clocks, while Saravana said it
should not.  And I agree with Saravana.

> >> +clk_set_rate deserves a special mention because it is more complex th=
an
> >> +the other operations. =A0There are three key concepts to the common
> >> +clk_set_rate implementation:
> >> +
> >> +1) recursively traversing up the clk tree and changing clk rates, one
> >> +parent at a time, if each clk allows it
> >> +2) failing to change rate if the clk is enabled and must only change
> >> +rates while disabled
> >
> > Is this really true? Based on a quick glance at the other patches, it d=
oesn't look it disallows set rate if the clock is enabled. Which is correct=
, because clock rates can be change while they are enabled (I'm referring t=
o leaf clocks) as long as the hardware supports doing it correctly. So, thi=
s needs rewording? I'm guessing you are trying to say that you can't change=
 the parent rate if it has multiple enabled child clocks running off of it =
and one of them wants to cause a parent rate change? I'm not sure if even t=
hat should be enforced in the common code -- doesn't look like you do eithe=
r.
> =

> Same as my answer above.  There is a flag which allows you to control
> this behavior.
> =

On the contrary, I have clocks on mxs platform which can be set rate
only when they are enabled, while there are users call clk_set_rate
when the clock is not enabled yet.  Do we need another flag
CLK_ON_SET_RATE for this type of clocks?

I'm unsure that clk API users will all agree with the use of the flags.
>From the code, the clock framework will make the call fail if users
attempt to clk_set_rate an enabled clock with flag CLK_GATE_SET_RATE.
And clk API users might argue that they do not (need to) know this
clock details, and it's clock itself (clock framework or/and clock
driver) who should handle this type of details.

> >
> >> +2) using clk rate change notifiers to allow devices to handle dynamic
> >
> > Must be 3)
> =

> Haha good catch.
> =

> >>
> >> +rate changes for clks which do support changing rates while enabled
> >
> > Again, I guess this applies to the other clock. Not the one for which c=
lk_set_rate() is being called.
> =

> This applies to ANY clk which has the flag set and is called by
> __clk_set_rate (which may be called many times in a recursive path).
> =

> >> +clk_set_rate(C, 26MHz);
> >> + =A0 =A0 =A0 __clk_set_rate(C, 26MHz);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->round_rate(C, 26MHz, *parent_rate);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ round_rate returns 50MHz ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&parent_rate is 52MHz ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->set_rate(C, 50Mhz);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk C is set to 50MHz, which sets divi=
der to 2 ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_set_rate(clk->parent, parent_rate);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->round_rate(B, 52MHz=
, *parent_rate);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ round_rate returns 100=
MHz ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&parent_rate is 104MHz ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->set_rate(B, 100MHz);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk B stays at 100MHz,=
 divider stays at 2 ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_set_rate(clk->pare=
nt, parent_rate);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ round_=
rate returns 104MHz ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&parent=
_rate is ignored ]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->set=
_rate(A, 104MHz);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk A =
is set to 104MHz]
> >> +
> >
> > I will come back to this topic later on. I like the idea of propagating=
 the needs to the parent, but not sure if the current implementation will w=
ork for all types of clock trees/set rates even though the HW might actuall=
y allow it to be done right.
> =

> I'll need more to go on than "it may not work".

		clk A
		  |
		  |
		  |
		clk B -----------\
		  |		 |
		  |		 |
		  |		 |
		clk C		clk D

You have stated "Another caveat is that child clks might run at weird
intermediate frequencies during a complex upwards propagation".  I'm
not sure that intermediate frequency will be safe/reasonable for all
the clocks.

Another thing is what we mentioned above, the set_rate propagating
should not change other leaf clocks' frequency.  For example, there is
timer_clk (clk D) as another child of clk B.  When the set_rate of
clk C gets propagated to change frequency for clk B, it will in turn
change the frequency for timer_clk.  I'm sure that some talk need to
happen between clk framework and timer driver before frequency of clk B
gets actually changed.  Is this something will be handled by rate
change notifications which is to be added?

> As proof of concept I
> converted OMAP4's CPUfreq driver to use this strategy.  Quick
> explanation:
> =

> OMAP4's CPUfreq driver currently adjusts the rate of a PLL via
> clk_set_rate.  However the PLL isn't *really* the clk closest to the
> ARM IP, there are other divider clocks after the PLL, which typically
> divide by 1.  So practically speaking the PLL is the one that matters
> with respect to getting the Cortex-A9 rates to change.
> =

> To test the recursive clk_set_rate I wrote a new .round_rate for the
> clks below the PLL and set the CLK_PARENT_SET_RATE flag on those clks.
>  Then I changed the CPUfreq driver to call clk_set_rate on the lowest
> clk in that path (instead of the PLL) which better reflects reality.
> The code worked perfectly, propagating the request up to the PLL where
> the rate was finally set.
> =

> This was a simple test since that PLL is dedicated to the Cortex-A9s,
> but the code does work.  If there is a sequencing issue please let me
> know and I'll see how things can be re-arranged or made more flexible
> for your platform.
> =

I'm currently looking at imx6 and mxs (imx28).  On imx6, I do not see
the need for set_rate propagation at all.  On mxs, I do see the need,
but it's a simple propagation, with only one level up and 1-1
parent-child relationship.  I'm not sure if it's a good idea to support
the full set_rate propagation from the beginning, since it makes the
implementation difficult dramatically.

-- =

Regards,
Shawn

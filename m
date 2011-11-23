From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v3 2/5] Documentation: common clk API
Date: Wed, 23 Nov 2011 12:33:47 -0800
Message-ID: <CAJOA=zNPNok6HG1jvg=v-_SFJCyNgYPPJbmTeyfOQ0iYdjbStQ@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-3-git-send-email-mturquette@linaro.org> <4ECC5455.6040806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ECC5455.6040806@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: linux@arm.linux.org.uk, linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, aul@pwsan.com, jeremy.kerr@canonical.com, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <magnus.damm@gmail.com>, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, tglx@linutronix.de, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 6:03 PM, Saravana Kannan <skannan@codeaurora.or=
g> wrote:
> On 11/21/2011 05:40 PM, Mike Turquette wrote:
>> +Below is the common struct clk definition from include/linux.clk.h.=
 =A0It
>
> Typo

Will fix in V4.

>
>> +is modified slightly for brevity:
>> +
>> +struct clk {
>> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
>> + =A0 =A0 =A0 const struct clk_hw_ops *ops;
>
> No strong opinion, but can we call this clk_ops for brevity?

I prefer clk_hw_ops, as it clearly delineates that these operations
know hardware-specific details.

>> +clk_prepare - does everything needed to get a clock ready to genera=
te a
>> +proper signal which may include ungating the clk and actually gener=
ating
>> +that signal. =A0clk_prepare MUST be called before clk_enable. =A0Th=
is call
>> +holds the global prepare_mutex, which also prevents clk rates and
>> +topology from changing while held. =A0This API is meant to be the "=
slow"
>> +part of a clk enable sequence, if applicable. =A0This function must=
 not be
>> +called in an interrupt context.
>
> in an atomic context?

Will fix in V4.

>> +clk_get_rate - Returns the cached rate for the clk. =A0Does NOT que=
ry the
>> +hardware state. =A0No lock is held.
>
> I wrote the stuff below and then realized that this ops is not really=
 present in the code. Looks like stale doc. Can you please remove this?=
 But I think the comments below do hold true for the actual clk_set_rat=
e()/get_rate() implementation. I will try to repeat this as part of the=
 actual code review.

=46irstly this is a summary of the clk API in clk.h, not clk_hw_ops.
There isn't a hardware op for this since we just return clk->parent.

Secondly it is up to the caller to hold a lock.  Any code calling
clk_get_rate might likely want to hold that lock anyways.  I'll update
the comments to be explicit about this.

>
> I will be looking into the other patches in order, so, forgive me if =
I'm asking a question that has an obvious answer in the remaining patch=
es.
>
> I think a lock needs to be taken for this call too. What prevents a c=
lock set rate from getting called and modifying the cached rate variabl=
e while it's bring read. I don't think we should have a common code ass=
ume that read/write of longs are atomic.
>
>> +
>> +clk_get_parent - Returns the cached parent for the clk. =A0Does NOT=
 query
>> +the hardware state. =A0No lock is held.
>
> Same question as above. Can we assume a read of a pointer variable is=
 atomic? I'm not sure. I think this needs locking too.

Same answer as above.  The caller must hold the lock.  I'll update the =
comments.

>
>> +
>> +clk_set_rate - Attempts to change the clk rate to the one specified=
=2E
>> +Depending on a variety of common flags it may fail to maintain syst=
em
>> +stability or result in a variety of other clk rates changing.
>
> I'm not sure if this is intentional or if it's a mistake in phrasing =
it. IMHO, the rates of other clocks that are actually made available to=
 device drivers should not be changed. This call might trigger rate cha=
nges inside the tree to accommodate the request from various children, =
but should not affect the rate of the leaf nodes.
>
> Can you please clarify the intention and/or the wording?

Setting the flag CLK_GATE_SET_RATE tells clk_set_rate not to change
the rate if the clk is enabled.  This policy is not enforced
abritrarily: you don't have to set the flag on your clk.  I'll update
the doc to make explicit mention of this flag.

>> +clk_set_rate deserves a special mention because it is more complex =
than
>> +the other operations. =A0There are three key concepts to the common
>> +clk_set_rate implementation:
>> +
>> +1) recursively traversing up the clk tree and changing clk rates, o=
ne
>> +parent at a time, if each clk allows it
>> +2) failing to change rate if the clk is enabled and must only chang=
e
>> +rates while disabled
>
> Is this really true? Based on a quick glance at the other patches, it=
 doesn't look it disallows set rate if the clock is enabled. Which is c=
orrect, because clock rates can be change while they are enabled (I'm r=
eferring to leaf clocks) as long as the hardware supports doing it corr=
ectly. So, this needs rewording? I'm guessing you are trying to say tha=
t you can't change the parent rate if it has multiple enabled child clo=
cks running off of it and one of them wants to cause a parent rate chan=
ge? I'm not sure if even that should be enforced in the common code -- =
doesn't look like you do either.

Same as my answer above.  There is a flag which allows you to control
this behavior.

>
>> +2) using clk rate change notifiers to allow devices to handle dynam=
ic
>
> Must be 3)

Haha good catch.

>>
>> +rate changes for clks which do support changing rates while enabled
>
> Again, I guess this applies to the other clock. Not the one for which=
 clk_set_rate() is being called.

This applies to ANY clk which has the flag set and is called by
__clk_set_rate (which may be called many times in a recursive path).

>> +clk_set_rate(C, 26MHz);
>> + =A0 =A0 =A0 __clk_set_rate(C, 26MHz);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->round_rate(C, 26MHz, *parent_rate=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ round_rate returns 50MHz ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&parent_rate is 52MHz ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->set_rate(C, 50Mhz);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk C is set to 50MHz, which sets di=
vider to 2 ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_set_rate(clk->parent, parent_rat=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->round_rate(B, 52M=
Hz, *parent_rate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ round_rate returns 1=
00MHz ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&parent_rate is 104MH=
z ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->set_rate(B, 100MH=
z);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk B stays at 100MH=
z, divider stays at 2 ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_set_rate(clk->pa=
rent, parent_rate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ roun=
d_rate returns 104MHz ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [&pare=
nt_rate is ignored ]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->s=
et_rate(A, 104MHz);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ clk =
A is set to 104MHz]
>> +
>
> I will come back to this topic later on. I like the idea of propagati=
ng the needs to the parent, but not sure if the current implementation =
will work for all types of clock trees/set rates even though the HW mig=
ht actually allow it to be done right.

I'll need more to go on than "it may not work".  As proof of concept I
converted OMAP4's CPUfreq driver to use this strategy.  Quick
explanation:

OMAP4's CPUfreq driver currently adjusts the rate of a PLL via
clk_set_rate.  However the PLL isn't *really* the clk closest to the
ARM IP, there are other divider clocks after the PLL, which typically
divide by 1.  So practically speaking the PLL is the one that matters
with respect to getting the Cortex-A9 rates to change.

To test the recursive clk_set_rate I wrote a new .round_rate for the
clks below the PLL and set the CLK_PARENT_SET_RATE flag on those clks.
 Then I changed the CPUfreq driver to call clk_set_rate on the lowest
clk in that path (instead of the PLL) which better reflects reality.
The code worked perfectly, propagating the request up to the PLL where
the rate was finally set.

This was a simple test since that PLL is dedicated to the Cortex-A9s,
but the code does work.  If there is a sequencing issue please let me
know and I'll see how things can be re-arranged or made more flexible
for your platform.

Regards,
Mike

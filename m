From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 02:53:15 -0700
Message-ID: <AANLkTik3zu5s8PjuZ6NdtVMKRuGIB-9CUyvA48JG8ybh@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
	<alpine.LFD.2.00.1006021117480.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006021117480.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neil Brown <neilb@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

2010/6/2 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 2 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/2 Neil Brown <neilb@suse.de>:
>> > There would still need to be some sort of communication between th=
e the
>> > suspend daemon on any event daemon to ensure that the events had b=
een
>> > processed. =A0This could be very light weight interaction. =A0The =
point though is
>> > that with this patch it becomes possible to avoid races. =A0Possib=
le is better
>> > than impossible.
>> >
>>
>> We already have a solution. I don't think rejecting our solution but
>> merging a worse solution should be the goal.
>
> That's not the goal at all. We want a solution which is acceptable fo=
r
> android and OTOH does not get into the way of other approaches.
>

I don't actually think the suspend blocker patchset get in the way of
anything else.

> The main problem I have is that suspend blockers are only addressing
> one particular problem space of power management.
>
> We have more requirements than that, e.g. an active device transfer
> requires to prevent the idle code to select a deep power state due to
> latency requirements.
>
> So we then have to implement two mechanisms in the relevant drivers:
>
> =A0 1) telling the idle code to limit latency
> =A0 2) telling the suspend code not to suspend

And 3) telling the idle code to not enter low power modes that disrupt
active interrupts or clocks.

Our wakelock code handles 2 and 3, but I removed support for 3 on
request since you can hack it by specifying a latency value that you
know the low power mode cannot support.

>
> My main interest is to limit it to one mechanism, which is QoS based
> and let idle and suspend make the appropriate decisions based on that
> information.
>

We can use one mechanism for this, but we still have to specify both.
To me this is just another naming argument and not a good reason to
not merge the suspend blocker code. You have to modify the same
drivers if you call suspend_block() as if you call
pm_qos_update_requirement(don't suspend). We have to specify when it
is not safe to suspend independent of when it is not safe to enter low
power idle modes so unless you want to have a bitmap of constraints
you don't save any calls. And, if we later get a constraint framework
that supports everything, we can switch to it then and we will then
already have some drivers annotated.

--=20
Arve Hj=F8nnev=E5g

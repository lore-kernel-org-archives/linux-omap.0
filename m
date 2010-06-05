From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 14:26:14 -0700
Message-ID: <AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100605092851.6ee15f13@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 5, 2010 at 9:28 AM, Arjan van de Ven <arjan@infradead.org> =
wrote:
> On Sat, 05 Jun 2010 11:54:13 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=F8nnev=E5g wrote:
>> > > Trusted processes are assumed to be sane and idle when there is
>> > > nothing for them to do, allowing the machine to go into deep idl=
e
>> > > states.
>> > >
>> >
>> > Neither the kernel nor our trusted user-space code currently meets
>> > this criteria.
>>
>> Then both need fixing. Really, that's the only sane approach.
>
> fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
> without really bad hacks.
>

We clearly have different standards for what we consider good. We
measure time suspended in minutes or hours, not seconds, and waking up
every second or two causes a noticeable decrease in battery life on
the hardware we have today.

> the kernel has a set of infrastructure already to help here (range
> timers, with which you can wakeup-limit untrusted userspace crap),
> timer slack for legacy background timers, etc etc.

Range timers allows the kernel to align different timers so they don't
each bring the cpu out of idle individually. They do not eliminate
timers or make individual timers fire less often. For example if you
have 10 timers that fire every second on an idle system, without range
timers you will most likely have to bring the cpu out of idle 10 times
a second, but with range timers you have a chance of waking up only
once a second (I say a chance here, since if they are identical they
will just chase each other and never catch up).

>
> getting to 10 seconds is not in the range of impossibilities to be
> honest... and that's even without doing things like putting untrusted

That is still far short of what we get with suspend (in terms of time).

> junk (read: Appstore apps) into a cgroup and do wakeup limiting and c=
pu
> time limiting on a cgroup level....
>
>
> --
> Arjan van de Ven =A0 =A0 =A0 =A0Intel Open Source Technology Centre
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>



--=20
Arve Hj=F8nnev=E5g

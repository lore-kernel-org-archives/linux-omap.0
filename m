From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 18:03:11 -0700
Message-ID: <AANLkTikXUTZE1vesD-Ccn8VhPjhBYYS0Tw_Pq9u5nnq7@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<201006052025.11526.rjw@sisk.pl>
	<AANLkTilP0uyJRuUq6BlVeHDydPYi4oJsf37VvSAixwgN@mail.gmail.com>
	<201006060103.20540.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006060103.20540.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matt Helsley <matthltc@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/6/4 Matt Helsley <matthltc@us.ibm.com>:
>> >> > On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g wr=
ote:
>> >> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutron=
ix.de> wrote:
>> >> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> >> >
>> >> > <snip>
>> >> >
>> >> >>
>> >> >> > =A0 =A0 With the cgroup freezer you can "suspend" them right=
 away and
>> >> >> > =A0 =A0 just keep the trusted background task(s) alive which=
 allows us to
>> >> >> > =A0 =A0 go into deeper idle states instead of letting the cr=
applications
>> >> >> > =A0 =A0 run unconfined until the download finished and the s=
uspend
>> >> >> > =A0 =A0 blocker goes away.
>> >> >> >
>> >> >>
>> >> >> Yes this would be better, but I want it in addition to suspend=
, not
>> >> >> instead of it. It is also unclear if our user-space code could=
 easily
>> >> >> make use of it since our trusted code calls into untrusted cod=
e.
>> >> >>
>> >> >
>> >> > Perhaps I'm misunderstanding, but suspend and the cgroup freeze=
r
>> >> > interoperate well today -- you don't have to choose one or the =
other.
>> >> > If you've discovered otherwise I'd consider it a bug and would =
like to
>> >> > hear more about it.
>> >> >
>> >>
>> >> I'm not aware of any bug with combining both, but we cannot use
>> >> suspend at all without suspend blockers in the kernel (since wake=
up
>> >> events may be ignored)
>> >
>> > The more I think of it, the more it appears to me that the problem=
 of
>> > lost wakeup events can actually be solved without suspend blockers=
=2E
>> > I'll send a bunch of patches to address this issue, probably tomor=
row.
>> >
>>
>> I know of two ways to prevent lost wakeup events. Reset a timeout
>> every time you receive a wakeup event or prevents suspend until you
>> know the event has been fully processed. Does your solution fall ont=
o
>> one of these two categories, or do you have a third way?
>
> Basically, it involves two mechanisms, detection of wakeup events occ=
uring
> right before suspend is started

This sounds like the timeout approach which I thought you did not like.

> and aborting suspend if wakeup events occur
> in the middle of it.
>
Aborting suspend is easy, but when do you allow suspend again?

>> >> and I don't know how we can safely freeze
>> >> cgroups without funneling all potential wakeup events through a
>> >> process that never gets frozen.
>> >
>> > If your untrusted apps get called by the trusted ones, they aren't=
 really
>> > untrusted in the first place.
>> >
>> That is not a correct statement. A trusted apps can call into an
>> untrusted app, it just has to validate the response and handle not
>> getting a response at all. There are also different levels of trust.=
 I
>> may have trusted an app to provide a contact pictures, but not trust=
ed
>> it to block suspend. When the phone rings the app will be called to
>> provide the picture for the incoming call dialog, but if it is froze=
n
>> at this point the more trusted app that handles the incoming phone
>> call will not be able to get the picture.
>
> It will be able to do that if it causes the frozen part of user space=
 to be
> thawed.
>
> I think you have this problem already, though, because you use full s=
ystem
> suspend and all of your apps are frozen by it. =A0So, to handle the s=
ituation you
> describe above, you need to carry out full system resume that will th=
aw the
> tasks for you. =A0I don't see any fundamental difference betwee the t=
wo cases.
>

Yes, we can keep all our user space suspend blockers and thaw the
frozen cgroup when any suspend blocker is held, but this would
eliminate any power advantage that freezing a cgroup has over using
suspend to freeze all processes. Without annotating the drivers to
block the cgroup freezing in the same places as we now block suspend,
it also prevents processes in the cgroup that we freeze from directly
consuming wakup events.

>> > From what you're saying it follows that you're not really willing =
to accept
>> > any solution different to your suspend blockers. =A0Is that really=
 the case?
>> >
>> I don't think that is a fair way to put it. We need to support our
>> user-space framework and I have not seen an alternative solution tha=
t
>> clearly will work (other than replacing suspend_blockers with pm_qos
>> constraints that do the same thing).
>
> Then think again of the approach I proposed and explain to me why it =
won't
> work, because I haven't seen any convincing argument on that yet.
>

If you are referring to the approach that we don't use suspend but
freeze a cgroup instead, this only solves the problem of bad apps. It
does not help pause timers in trusted user space code and in the
kernel, so it does not lower our average power consumption. And, it
does not solve the problem for systems that enters lower power states
from suspend than it can from idle. The last point my not be relevant
to android anymore, but desktop systems already have auto suspend and
it would be preferable to have a race free kernel api for this.

--=20
Arve Hj=F8nnev=E5g

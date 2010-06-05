From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 15:10:46 -0700
Message-ID: <AANLkTilP0uyJRuUq6BlVeHDydPYi4oJsf37VvSAixwgN@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100605011826.GB21016@count0.beaverton.ibm.com>
	<AANLkTim3MMfJ6oa9OhUJch_v1qGyxSfrfxF3zDZhxqHk@mail.gmail.com>
	<201006052025.11526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006052025.11526.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matt Helsley <matthltc@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/4 Matt Helsley <matthltc@us.ibm.com>:
>> > On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g wrote=
:
>> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> >
>> > <snip>
>> >
>> >>
>> >> > =A0 =A0 With the cgroup freezer you can "suspend" them right aw=
ay and
>> >> > =A0 =A0 just keep the trusted background task(s) alive which al=
lows us to
>> >> > =A0 =A0 go into deeper idle states instead of letting the crapp=
lications
>> >> > =A0 =A0 run unconfined until the download finished and the susp=
end
>> >> > =A0 =A0 blocker goes away.
>> >> >
>> >>
>> >> Yes this would be better, but I want it in addition to suspend, n=
ot
>> >> instead of it. It is also unclear if our user-space code could ea=
sily
>> >> make use of it since our trusted code calls into untrusted code.
>> >>
>> >
>> > Perhaps I'm misunderstanding, but suspend and the cgroup freezer
>> > interoperate well today -- you don't have to choose one or the oth=
er.
>> > If you've discovered otherwise I'd consider it a bug and would lik=
e to
>> > hear more about it.
>> >
>>
>> I'm not aware of any bug with combining both, but we cannot use
>> suspend at all without suspend blockers in the kernel (since wakeup
>> events may be ignored)
>
> The more I think of it, the more it appears to me that the problem of
> lost wakeup events can actually be solved without suspend blockers.
> I'll send a bunch of patches to address this issue, probably tomorrow=
=2E
>

I know of two ways to prevent lost wakeup events. Reset a timeout
every time you receive a wakeup event or prevents suspend until you
know the event has been fully processed. Does your solution fall onto
one of these two categories, or do you have a third way?

>> and I don't know how we can safely freeze
>> cgroups without funneling all potential wakeup events through a
>> process that never gets frozen.
>
> If your untrusted apps get called by the trusted ones, they aren't re=
ally
> untrusted in the first place.
>
That is not a correct statement. A trusted apps can call into an
untrusted app, it just has to validate the response and handle not
getting a response at all. There are also different levels of trust. I
may have trusted an app to provide a contact pictures, but not trusted
it to block suspend. When the phone rings the app will be called to
provide the picture for the incoming call dialog, but if it is frozen
at this point the more trusted app that handles the incoming phone
call will not be able to get the picture.

> From what you're saying it follows that you're not really willing to =
accept
> any solution different to your suspend blockers. =A0Is that really th=
e case?
>
I don't think that is a fair way to put it. We need to support our
user-space framework and I have not seen an alternative solution that
clearly will work (other than replacing suspend_blockers with pm_qos
constraints that do the same thing).

--=20
Arve Hj=F8nnev=E5g

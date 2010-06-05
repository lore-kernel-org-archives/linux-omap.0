From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 22:23:29 -0700
Message-ID: <AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:38403 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0FEFXa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 01:23:30 -0400
In-Reply-To: <alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/4 Thomas Gleixner <tglx@linutronix.de>:
> Arve,
>
> On Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> >> I kind of agree here, so I'd like to focus a bit on that.
>> >>
>> >> Here's my idea in the very general terms:
>> >>
>> >> (1) Use the cgroup freezer to "suspend" the "untrusted" apps (ie.=
 the ones
>> >> =A0 =A0 that don't use suspend blockers aka wakelocks in the Andr=
oid world) at the
>> >> =A0 =A0 point Android would normally start opportunistic suspend.
>> >
>> > There is an additional benefit to this approach:
>> >
>> > =A0 =A0 In the current android world a background task (e.g. downl=
oad
>> > =A0 =A0 initiated before the screensaver kicked in) prevents the s=
uspend,
>> > =A0 =A0 but that also means that the crapplications can still suck=
 power
>> > =A0 =A0 completely unconfined.
>> >
>>
>> Yes this can happen. It is usually only a big problem when you combi=
ne
>> an (trusted) application that has a bug that blocks suspend forever
>> with an application that wakes up too often for us to enter low powe=
r
>> idle modes.
>
> Why is it a BUG in the trusted app, when I initiate a download and pu=
t
> the phone down ?
>

It is not, but we have had bugs where a trusted app does not unblock
suspend after some failure case where it is no longer making any
progress.

> That download might take a minute or two, but that's not an
> justification for the crapplication to run unconfined and prevent
> lower power states.
>

I agree, but this is not a simple problem to solve.

>> > =A0 =A0 With the cgroup freezer you can "suspend" them right away =
and
>> > =A0 =A0 just keep the trusted background task(s) alive which allow=
s us to
>> > =A0 =A0 go into deeper idle states instead of letting the crapplic=
ations
>> > =A0 =A0 run unconfined until the download finished and the suspend
>> > =A0 =A0 blocker goes away.
>> >
>>
>> Yes this would be better, but I want it in addition to suspend, not
>> instead of it. It is also unclear if our user-space code could easil=
y
>> make use of it since our trusted code calls into untrusted code.
>
> Sorry, that's really the worst argument I saw in this whole
> discussion.
>
> You're basically saying, that you have no idea what your user space
> stack is doing and you do not care at all as long as your suspend
> blocker scheme makes things work somehow.
>

Yes I don't know everything our user-space stack is doing, but I do
know that it makes many calls between processes (and in both
directions). As far as I know it uses timeouts when calling into
untrusted code, so a misbehaving application will cause an error
dialog to pop up asking if the user if it should wait longer or
terminate the application.

> Up to that point, I really tried hard to step back from my initial
> "OMG, promoting crap is a nono" reaction and work with you on a
> sensible technical solution to confine crap and make it aligned with
> other efforts in this area.
>
> So now, after I spent a reasonable amount of time (as you did) to
> understand what your requirements are, you come up with another
> restriction which is so outside of any level of sanity, that I'm at
> the point of giving up and just going into NAK mode.
>

I don't think this is a new restriction. Both Brian and I have
mentioned that we have a lot of dependencies between processes.

> Can you please answer the following question:
>
> =A0 =A0What is the point of having the distinction of "trusted" and
> =A0 =A0"untrusted" when you have no way to prevent "trusted" code cal=
ling
> =A0 =A0"into "untrusted" code ?
>

Trusted code that calls into untrusted code has to deal with the
untrusted code not responding, but we only want to pop up a message
that the application is not responding if it is misbehaving, not just
because it was frozen though no fault of its own.

> That's violating any sense of abstraction and layering and makes it
> entirely clear that the only way you can deal with your own design
> failure is a big hammer which you need to force into the kernel.
>

How can it be fixed? The user presses the back button, the framework
determines that app A is in the foreground and send the key to app A,
app A decides that it it does not have anything internal to go back to
and tells the framework to switch back to the previous app. If the
user presses the back key again, the framework does not know which app
this key should go to until app A has finished processing the first
key press.

> Sorry, no. I'm perfectly willing to make progress on that, as long as
> we walk on a sane ground. But abusing the kernel for fixing basic
> engineering problems in the user space side of affairs is completely
> out of discussion.
>
>> >> I wonder what people think. =A0Is this realistic and if so, would=
 it be difficult
>> >> to implement?
>> >
>> > I think it's realistic and not overly complicated to implement.
>> >
>>
>> The kernel support can be easily implemented on most arm hardware, I
>> don't know if it can work on most existing x86 hardware. It does not
>
> It does not matter. Even Intel folks told you more than once, that x8=
6

How does it not matter. Are dropping support for existing x86 hardware
once the new hardware comes out?

> hardware is going to be fixed pretty soon. Hint: that's crucial to
> their business ....
>
>> give us the same power savings as suspend with existing software, bu=
t
>> it can handle bad apps better (assuming you don't combine
>> opportunistic suspend and cgroup freezing). The biggest hurdle is ho=
w
>> to handle dependencies between processes that gets frozen and
>> processes that don't get frozen.
>
> See above.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

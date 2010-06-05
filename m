From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 16:56:38 -0700
Message-ID: <AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<201006060044.16950.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006060044.16950.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> >> 2010/6/4 Thomas Gleixner <tglx@linutronix.de>:
>> >> > Arve,
>> >> >
>> >> > On Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >
>> >> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutron=
ix.de> wrote:
>> >> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> >> >> >> I kind of agree here, so I'd like to focus a bit on that.
>> >> >> >>
>> >> >> >> Here's my idea in the very general terms:
>> >> >> >>
>> >> >> >> (1) Use the cgroup freezer to "suspend" the "untrusted" app=
s (ie. the ones
>> >> >> >> =A0 =A0 that don't use suspend blockers aka wakelocks in th=
e Android world) at the
>> >> >> >> =A0 =A0 point Android would normally start opportunistic su=
spend.
>> >> >> >
>> >> >> > There is an additional benefit to this approach:
>> >> >> >
>> >> >> > =A0 =A0 In the current android world a background task (e.g.=
 download
>> >> >> > =A0 =A0 initiated before the screensaver kicked in) prevents=
 the suspend,
>> >> >> > =A0 =A0 but that also means that the crapplications can stil=
l suck power
>> >> >> > =A0 =A0 completely unconfined.
>> >> >> >
>> >> >>
>> >> >> Yes this can happen. It is usually only a big problem when you=
 combine
>> >> >> an (trusted) application that has a bug that blocks suspend fo=
rever
>> >> >> with an application that wakes up too often for us to enter lo=
w power
>> >> >> idle modes.
>> >> >
>> >> > Why is it a BUG in the trusted app, when I initiate a download =
and put
>> >> > the phone down ?
>> >> >
>> >>
>> >> It is not, but we have had bugs where a trusted app does not unbl=
ock
>> >> suspend after some failure case where it is no longer making any
>> >> progress.
>> >
>> > Well, that's simply an application bug which sucks battery with or
>> > without suspend blockers. So it's unrelated to the freezing of
>> > untrusted apps while a trusted app still works in the background
>> > before allowing the machine to suspend.
>> >
>>
>> It is not unrelated if the trusted app has stopped working but still
>> blocks suspend. The battery drains when you combine them.
>>
>> >> > That download might take a minute or two, but that's not an
>> >> > justification for the crapplication to run unconfined and preve=
nt
>> >> > lower power states.
>> >> >
>> >>
>> >> I agree, but this is not a simple problem to solve.
>> >
>> > Not with suspend blockers, but with cgroup confinement of crap, it=
's
>> > straight forward.
>> >
>>
>> I don't think is is straight forward. If the a process in the frozen
>> group holds a resource that a process in the unfrozen group needs, h=
ow
>> do deal with that?
>
> That depends a good deal on what you mean by holding a resource.
>

I'm not sure why that matters. Any resource held by a frozen process
could cause problems whether it is something like being the current
foreground app or a mutex in shared memory.

> Generally, however, if your "trusted" processes depend on the process=
es you
> don't trust, then either the former should not be trusted, or the lat=
ter should
> be trusted.
>
There are different levels of trust. Trusted processes often need to
wait for an untrusted process to release a resource for the untrusted
process to behave correctly, but the trusted process can revoke the
resource if the untrusted process does not comply in time.

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
>> >> >
>> >> > Sorry, that's really the worst argument I saw in this whole
>> >> > discussion.
>> >> >
>> >> > You're basically saying, that you have no idea what your user s=
pace
>> >> > stack is doing and you do not care at all as long as your suspe=
nd
>> >> > blocker scheme makes things work somehow.
>> >> >
>> >>
>> >> Yes I don't know everything our user-space stack is doing, but I =
do
>> >> know that it makes many calls between processes (and in both
>> >> directions). As far as I know it uses timeouts when calling into
>> >> untrusted code, so a misbehaving application will cause an error
>> >> dialog to pop up asking if the user if it should wait longer or
>> >> terminate the application.
>> >
>> > Sigh, the more I learn about the details of android and it's viola=
tion
>> > of all sane engineering principles the more I understand why you
>> > invented a huge nail to push through all layers in order to bring =
the
>> > system into idle at all. And yes, you need a sledge hammer to driv=
e
>> > that big nail through everything, so you are using the right tool.
>> >
>> > Seriously, the cross app call goes through your framework, which
>> > already knows, that the untrusted part is frozen. So it can deal
>> > nicely with it in any way you want including unfreezing.
>>
>> Cross app calls do not go through a central process.
>
> Well, yeah.
>
> Arve, we're still learning you have some more requirements we had no =
idea

What new requirement are you talking about. Did you assume all our
user-space ipc calls went though a single process?

> about before and such that _only_ the suspend blockers (or wakelocks)=
 framework
> is suitable to satisfy them. =A0I don't realistically think we can ma=
ke any
> progress this way.
>
>> >> > Up to that point, I really tried hard to step back from my init=
ial
>> >> > "OMG, promoting crap is a nono" reaction and work with you on a
>> >> > sensible technical solution to confine crap and make it aligned=
 with
>> >> > other efforts in this area.
>> >> >
>> >> > So now, after I spent a reasonable amount of time (as you did) =
to
>> >> > understand what your requirements are, you come up with another
>> >> > restriction which is so outside of any level of sanity, that I'=
m at
>> >> > the point of giving up and just going into NAK mode.
>> >> >
>> >>
>> >> I don't think this is a new restriction. Both Brian and I have
>> >> mentioned that we have a lot of dependencies between processes.
>
> Which is not the same as "the dependencies are such that they can't b=
e
> taken into account in any way other than by using wakelocks (or suspe=
nd
> blockers)".
>
>> >> > Can you please answer the following question:
>> >> >
>> >> > =A0 =A0What is the point of having the distinction of "trusted"=
 and
>> >> > =A0 =A0"untrusted" when you have no way to prevent "trusted" co=
de calling
>> >> > =A0 =A0"into "untrusted" code ?
>> >> >
>> >>
>> >> Trusted code that calls into untrusted code has to deal with the
>> >> untrusted code not responding, but we only want to pop up a messa=
ge
>> >> that the application is not responding if it is misbehaving, not =
just
>> >> because it was frozen though no fault of its own.
>
> When Android starts opportunistic suspend, all applications are froze=
n,
> "trusted" as well as "untrusted", right? =A0So, after they are all fr=
ozen, none
> of them can do anything to prevent suspend from happening, right?

Not if you mean when we write to /sys/power/state. Processes are not
frozen until the last suspend blocker is released.

>
> Now, in my proposed approach the "untrusted" apps are frozen exactly =
at the
> point Android would start opportunistic suspend and they wouldn't be =
able
> to do anything about that anyway. =A0So if one of your "trusted" apps=
 depends
> on the "untrusted" ones in a way that you describe, you alread have a=
 bug
> (the "trusted" app cannot prevent automatic suspend from happening ev=
en if it
> wants, because it depends on an "untrusted" app that has just been fr=
ozen).
>

I don't think what you said here is correct. If a wakeup event happens
all processed are unfrozen since the driver blocks suspend. The app
that reads this event blocks suspend before reading it. If it was busy
talking to a less trusted app when the event happened it still works
since all apps are running at this point.

>> >> > That's violating any sense of abstraction and layering and make=
s it
>> >> > entirely clear that the only way you can deal with your own des=
ign
>> >> > failure is a big hammer which you need to force into the kernel=
=2E
>> >> >
>> >>
>> >> How can it be fixed? The user presses the back button, the framew=
ork
>> >> determines that app A is in the foreground and send the key to ap=
p A,
>> >> app A decides that it it does not have anything internal to go ba=
ck to
>> >> and tells the framework to switch back to the previous app. If th=
e
>> >> user presses the back key again, the framework does not know whic=
h app
>> >> this key should go to until app A has finished processing the fir=
st
>> >> key press.
>> >
>> > Errm, what has this to do with frozen apps? If your system is
>> > handling input events then there are no frozen apps and even if th=
ey
>> > are frozen your framework can unfreeze them _before_ talking to th=
em.
>> >
>> > So which unfixable problem are you describing with the above examp=
le ?
>> >
>>
>> You are claiming that trusted code should not have any dependencies =
on
>> untrusted code.
>
> Not "any". =A0It shouldn't have dependencies that make a difference b=
etween
> "trusted" and "untrusted".
>
> Think of security, for example. =A0A root-owned process surely can ex=
change data
> with processes owned by non-root users, but it shouldn't blindly acce=
pt any
> data these processes give it.
>
> Your wakelock-holding application is a counterpart of the root-owned =
process
> above. =A0It can exchange data with processes that don't take wakeloc=
ks, but not
> in such a way that would prevent them from taking wakelocks if necess=
ary
> (or from dropping wakelocks if no longer needed from their point of v=
iew).
>
> If this condition is satisfied, then I claim you won't have any probl=
ems with
> freezing the "untrusted" apps upfront. =A0If this condition is not sa=
tisfied, in
> turn, your framework already doesn't work.

The problem is that properly working untrusted apps may get treated as
non-working apps and killed because they were frozen and did not
respond. Also this is not invisible to the user as the system usually
gives the app several seconds to respond.

--=20
Arve Hj=F8nnev=E5g

From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
 Suspend block api (version 8)
Date: Wed, 2 Jun 2010 21:02:24 +1000
Message-ID: <20100602210224.6ae2333f@notabene.brown>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55398 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab0FBLCj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 07:02:39 -0400
In-Reply-To: <AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

On Wed, 2 Jun 2010 02:12:10 -0700
Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:

> 2010/6/2 Neil Brown <neilb@suse.de>:
> > On Wed, 2 Jun 2010 00:05:14 -0700
> > Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:
> >
> >> On Tue, Jun 1, 2010 at 10:32 PM, Neil Brown <neilb@suse.de> wrote:
> >> > On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
> >> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >
> >> >> On Tue, 1 Jun 2010, Neil Brown wrote:
> >> >> >
> >> >> > I think you have acknowledged that there is a race with suspe=
nd - thanks.
> >> >> > Next step was "can it be closed".
> >> >> > You seem to suggest that it can, but you describe it as a "wo=
rk around"
> >> >> > rather than a "bug fix"...
> >> >> >
> >> >> > Do you agree that the race is a "bug", and therefore it is ap=
propriate to
> >> >> > "fix" it assuming an acceptable fix can be found (which I thi=
nk it can)?
> >> >>
> >> >> If we can fix it, yes we definitely should do and not work arou=
nd it.
> >> >>
> >> >> Thanks,
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 tglx
> >> >
> >> > OK.
> >> > Here is my suggestion.
> >> >
> >> > While I think this patch would actually work, and hope the ugly =
aspects are
> >> > reasonably balanced by the simplicity, I present it primarily as=
 a base for
> >> > improvement.
> >> > The important part is to present how drivers and user-space can =
co-operate
> >> > to avoid losing wake-events. =C2=A0The details of what happens i=
n the kernel are
> >> > certainly up for discussion (as is everything else really of cou=
rse).
> >> >
> >> > The user-space suspend daemon avoids losing wake-events by using
> >> > fcntl(F_OWNER) to ensure it gets a signal whenever any important=
 wake-event
> >> > is ready to be read by user-space. =C2=A0This may involve:
> >> > =C2=A0- the one daemon processing all wake events
> >>
> >> Wake up events are not all processed by one daemon.
> >
> > Not with your current user-space code, no. =C2=A0Are you saying tha=
t you are not
> > open to any significant change in the Android user-space code? =C2=A0=
That would
> > make the situation a lot harder to resolve.
> >
>=20
> Some wakeup events like the an incoming phone may be handled by a
> vendor supplied daemon that I do not have the source code for. And, n=
o
> I'm not open to a change that would require all wakeup events to go t=
o
> a single process.

Ahh..  Well I have no answer for the "I must support a closed-source ap=
p"
card that has not been heard 1000 times already.

My proposal doesn't require all wakeup events to go through one single
process - it was just one of (at least) 3 options.

>=20
> >>
> >> > =C2=A0- Both the suspend daemon and the main event handling daem=
on opening any
> >> > =C2=A0 =C2=A0given device that delivers wake events (this should=
 work with input
> >> > =C2=A0 =C2=A0events ... unless grabbing is needed)
> >>
> >> Not all wakeup events are broadcast like input events so they cann=
ot
> >> be read by both daemons. Not that this really matters, since readi=
ng
> >> the event from the suspend daemon does not mean that it has been
> >> delivered to and processed by the other daemon.
> >
> > There would still need to be some sort of communication between the=
 the
> > suspend daemon on any event daemon to ensure that the events had be=
en
> > processed. =C2=A0This could be very light weight interaction. =C2=A0=
The point though is
> > that with this patch it becomes possible to avoid races. =C2=A0Poss=
ible is better
> > than impossible.
> >
>=20
> We already have a solution. I don't think rejecting our solution but
> merging a worse solution should be the goal.
>=20
> >>
> >> > =C2=A0- The event handling daemon giving the suspend-daemon's pi=
d as F_OWNER, and
> >> > =C2=A0 =C2=A0using poll/select to get the events itself.
> >>
> >> I don't like the idea of using signals for this. Without the hack =
Alan
> >> Stern suggested, you will temporarily block suspend if the wakeup
> >> event happened before the suspend daemon thread made it to the ker=
nel,
> >> but abort suspend if it happened right after.
> >
> > I'm not sure why that difference matters. =C2=A0But I'm also not su=
re that it is
> > true.
> > When any wakeup event happen, a signal will be delivered to the sus=
pend
> > daemon.
> > This will interrupt a pending suspend request, or a sleep, or whate=
ver else
> > the daemon is doing.
> > It can then go back to waiting for a good time to suspend, and then=
 try to
> > suspend again.
> >
>=20
> This is inferior to the solution that is in the android kernel and th=
e
> suspend blocker patchset. Both suspend as soon as possible and do not
> require signal handlers that modify the argument to your kernel call.
>=20

The solution in the android kernel and the suspend blocker patchset bot=
h
share one fairly fatal flaw - they are not being accepted upstream.
I am trying to find a minimal suitable solution that does not share tha=
t
flaw.
I do not know yet if it does or not, but as it is fixing a real (design=
) bug,
I feel it has some chance.  Of course if it doesn't meet your need, the=
n
that becomes irrelevant....

And there is no requirement to modify any arguments in any signal handl=
ers.

> >
> >>
> >> >
> >> > When 'mem' is written to /sys/power/state, suspend_prepare waits=
 in an
> >> > interruptible wait until any wake-event that might have been ini=
tiated before
> >> > the suspend was request, has had a chance to be queued for user-=
space and
> >> > trigger kill_fasync.
> >>
> >> And what happens if you are not waiting when this happens?
> >
> > I'm not sure I understand the question. =C2=A0Could you explain it =
please?
> >
>=20
> If the thread is not already in the kernel how does your signal
> handler abort suspend.

setjmp / longjmp.  This is the time-honoured method for allowing a sign=
al to
break the flow of a program and re-start somewhere else.

>=20
> > Either the initial event happens late enough to abort/resume the su=
spend, or
> > the signal happens early enough to abort the suspend, or alert the =
daemon not
> > to do a suspend. =C2=A0Either way we don't get stuck in suspend.
> >
> >
> >>
> >> > Currently this wait is a configurable time after the last wake-e=
vent was
> >> > initiated. =C2=A0This is hackish, but simple and probably adequa=
te.
> >>
> >> Waiting after a wake event is the same as suspend_block_timeout. T=
his
> >> is useful when passing events through layers of code that does no
> >> block suspend, but we should strive to avoid it. Other people had =
much
> >> stronger objections to this, which is why it is not included in th=
e
> >> last suspend blocker patchset.
> >
> > Absolutely agree. =C2=A0The idea of of waiting was just a simple wa=
y to present
> > code that actually could work. =C2=A0There are doubtlessly better w=
ays and I
> > assume they have been implemented in the suspend-blocker code.
> > We just need some way to wait for the suspend-block count to reach =
zero, with
> > some confidence that this amount of time is limited.
> >
> > (though to be honest ... the incredible simplicity of waiting a lit=
tle while
> > is very compelling.... :-))
> >
>=20
> Sure, but forcing that as the only way to prevent suspend is taking t=
o too far.
>=20
> >>
> >> It also does not work for drivers that need to block suspend for m=
ore
> >> than a few seconds. For instance the gpio keypad matrix driver nee=
ds
> >> to block suspend while keys are pressed so it can scan the keypad.
> >
> > I cannot imagine why it would take multiple seconds to scan a keypa=
d.
> > Can you explain that?
> >
> > Do you mean while keys are held pressed?
>=20
> Yes.
>=20
> > =C2=A0Maybe you don't get a wake-up event
> > on key-release?
>=20
> We should.
>=20
> > =C2=A0In that case your user-space daemon could block suspend
> > while there are any pressed keys.... =C2=A0confused.
> >
>=20
> The user-space daemon should not need to know which keys are in a
> matrix. We also have other drivers that need to block suspend. For
> instance, some devices need to block suspend while connected to a USB
> host.

And this decision (to block suspend) really needs to be made in the dri=
ver,
not in userspace?

You could get those drivers to return EBUSY from PM_SUSPEND_PREPARE (wh=
ich
would need to be a configurable option), but then I guess you have no w=
ay to
wait for the device to become non-busy.

If user-space really cannot tell if the driver is busy or not, then I w=
ould
suggest that the driver is fairly poorly designed.

It would seem then that a user-space requested suspend is not sufficien=
t for
your needs even if we remove the race window, as you have drivers that =
want
to avoid suspend indefinitely, and that "need to avoid suspend" status =
is not
visible from user-space.
It is a pity that this extra requirement was not clear from your introd=
uction
to the "Opportunistic suspend support" patch.

If that be the case, I'll stop bothering you with suggestions that can =
never
work.
Thanks for your time,
NeilBrown
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

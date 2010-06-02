From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
 Suspend block api (version 8)
Date: Wed, 2 Jun 2010 18:06:14 +1000
Message-ID: <20100602180614.729246ea@notabene.brown>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54257 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403Ab0FBIG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 04:06:29 -0400
In-Reply-To: <AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

On Wed, 2 Jun 2010 00:05:14 -0700
Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:

> On Tue, Jun 1, 2010 at 10:32 PM, Neil Brown <neilb@suse.de> wrote:
> > On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> On Tue, 1 Jun 2010, Neil Brown wrote:
> >> >
> >> > I think you have acknowledged that there is a race with suspend =
- thanks.
> >> > Next step was "can it be closed".
> >> > You seem to suggest that it can, but you describe it as a "work =
around"
> >> > rather than a "bug fix"...
> >> >
> >> > Do you agree that the race is a "bug", and therefore it is appro=
priate to
> >> > "fix" it assuming an acceptable fix can be found (which I think =
it can)?
> >>
> >> If we can fix it, yes we definitely should do and not work around =
it.
> >>
> >> Thanks,
> >>
> >> =C2=A0 =C2=A0 =C2=A0 tglx
> >
> > OK.
> > Here is my suggestion.
> >
> > While I think this patch would actually work, and hope the ugly asp=
ects are
> > reasonably balanced by the simplicity, I present it primarily as a =
base for
> > improvement.
> > The important part is to present how drivers and user-space can co-=
operate
> > to avoid losing wake-events. =C2=A0The details of what happens in t=
he kernel are
> > certainly up for discussion (as is everything else really of course=
).
> >
> > The user-space suspend daemon avoids losing wake-events by using
> > fcntl(F_OWNER) to ensure it gets a signal whenever any important wa=
ke-event
> > is ready to be read by user-space. =C2=A0This may involve:
> > =C2=A0- the one daemon processing all wake events
>=20
> Wake up events are not all processed by one daemon.

Not with your current user-space code, no.  Are you saying that you are=
 not
open to any significant change in the Android user-space code?  That wo=
uld
make the situation a lot harder to resolve.

>=20
> > =C2=A0- Both the suspend daemon and the main event handling daemon =
opening any
> > =C2=A0 =C2=A0given device that delivers wake events (this should wo=
rk with input
> > =C2=A0 =C2=A0events ... unless grabbing is needed)
>=20
> Not all wakeup events are broadcast like input events so they cannot
> be read by both daemons. Not that this really matters, since reading
> the event from the suspend daemon does not mean that it has been
> delivered to and processed by the other daemon.

There would still need to be some sort of communication between the the
suspend daemon on any event daemon to ensure that the events had been
processed.  This could be very light weight interaction.  The point tho=
ugh is
that with this patch it becomes possible to avoid races.  Possible is b=
etter
than impossible.

>=20
> > =C2=A0- The event handling daemon giving the suspend-daemon's pid a=
s F_OWNER, and
> > =C2=A0 =C2=A0using poll/select to get the events itself.
>=20
> I don't like the idea of using signals for this. Without the hack Ala=
n
> Stern suggested, you will temporarily block suspend if the wakeup
> event happened before the suspend daemon thread made it to the kernel=
,
> but abort suspend if it happened right after.

I'm not sure why that difference matters.  But I'm also not sure that i=
t is
true.
When any wakeup event happen, a signal will be delivered to the suspend
daemon.
This will interrupt a pending suspend request, or a sleep, or whatever =
else
the daemon is doing.
It can then go back to waiting for a good time to suspend, and then try=
 to
suspend again.


>=20
> >
> > When 'mem' is written to /sys/power/state, suspend_prepare waits in=
 an
> > interruptible wait until any wake-event that might have been initia=
ted before
> > the suspend was request, has had a chance to be queued for user-spa=
ce and
> > trigger kill_fasync.
>=20
> And what happens if you are not waiting when this happens?

I'm not sure I understand the question.  Could you explain it please?

Either the initial event happens late enough to abort/resume the suspen=
d, or
the signal happens early enough to abort the suspend, or alert the daem=
on not
to do a suspend.  Either way we don't get stuck in suspend.


>=20
> > Currently this wait is a configurable time after the last wake-even=
t was
> > initiated. =C2=A0This is hackish, but simple and probably adequate.
>=20
> Waiting after a wake event is the same as suspend_block_timeout. This
> is useful when passing events through layers of code that does no
> block suspend, but we should strive to avoid it. Other people had muc=
h
> stronger objections to this, which is why it is not included in the
> last suspend blocker patchset.

Absolutely agree.  The idea of of waiting was just a simple way to pres=
ent
code that actually could work.  There are doubtlessly better ways and I
assume they have been implemented in the suspend-blocker code.
We just need some way to wait for the suspend-block count to reach zero=
, with
some confidence that this amount of time is limited.

(though to be honest ... the incredible simplicity of waiting a little =
while
is very compelling.... :-))

>=20
> It also does not work for drivers that need to block suspend for more
> than a few seconds. For instance the gpio keypad matrix driver needs
> to block suspend while keys are pressed so it can scan the keypad.

I cannot imagine why it would take multiple seconds to scan a keypad.
Can you explain that?

Do you mean while keys are held pressed?  Maybe you don't get a wake-up=
 event
on key-release?  In that case your user-space daemon could block suspen=
d
while there are any pressed keys....  confused.


Thanks for the review,

NeilBrown

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

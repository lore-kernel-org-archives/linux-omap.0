From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 21:44:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006102126220.2585-100000@netrider.rowland.org>
References: <AANLkTiniGxuHLeTyxBe7zZxOdYJEkFcl3akR2E_aLDi3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:56175 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760011Ab0FKBoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 21:44:09 -0400
In-Reply-To: <AANLkTiniGxuHLeTyxBe7zZxOdYJEkFcl3akR2E_aLDi3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>

On Thu, 10 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> >> For that to work the wakeup events would have to be reported to th=
e
> >> power manager in a reliable way in the first place. Passing the fi=
le
> >> descriptor that the app uses to the power manager does not work fo=
r
> >> this, since the app could read the event while the power manager w=
as
> >> not in the poll call and the power manager would never see it.
> >
> > If the app activates a suspend blocker before reading the event, th=
is
> > doesn't matter. =A0If the app doesn't activate a suspend blocker th=
en it
> > risks being suspended after it has read the event but before it has
> > handled the event. =A0This is equally true with wakelocks.
> >
>=20
> It is not the same. Using a wakelock with a timeout only has a proble=
m
> if the app did not get a change to run and block suspend before the
> timeout expires. With the timeout values we use there is only a
> problem if the system is already unresponsive. If the driver does not
> block suspend but instead a power manager calls select or poll on a
> file descriptor while the app does a blocking read, the power manager
> can easily miss the event and suspend before the app blocks suspend.

You've lost me.  If the power manager is sitting inside a select/poll,=20
how can it miss the event (given that the event will make data=20
available to be read on one of the descriptors being polled)?

Or put it another way: With wakelocks, if the app doesn't use a suspend
blocker then once it reads the event data and the timed wakelock is
deactivated, there is nothing to prevent the system from immediately
going into opportunistic suspend.  My scheme can fail in the same way. =
=20
Is that what you meant?

> >> The suspend blocker approach is more generally useful since it
> >> supports hardware where suspend is needed. Why this argument is be=
ing
> >> ignored is very puzzling.
> >
> > Probably because people doesn't envision system suspend being used =
for
> > dynamic power management on that kind of hardware.
> >
>=20
> I'm not sure what you mean by dynamic power management here (frequenc=
y
> of suspends?), but auto suspend is already in use on x86 desktops and
> laptops. Suspend blockers can fix the race with some wakeup events
> there.

You should stress this point more strongly when conversing with others.=
 =20
I doubt it will be enough to change anybody's mind, but it can't hurt. =
=20
Indeed, if you propose suspend blockers as a way to fix a lost-wakeup=20
bug in existing distributions, rather than as something needed to=20
support Android, people might view it more favorably.


There's one question that I don't remember ever seeing answered.  To
which kernel drivers do you intend to add suspend blockers?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

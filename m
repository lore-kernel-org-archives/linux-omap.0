From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 16:33:07 +1000
Message-ID: <20100603163307.721b1c23@notabene.brown>
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
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57624 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279Ab0FCGdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:33:22 -0400
In-Reply-To: <AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>

On Wed, 2 Jun 2010 11:05:18 -0700
Brian Swetland <swetland@google.com> wrote:

> On Wed, Jun 2, 2010 at 1:06 AM, Neil Brown <neilb@suse.de> wrote:
> > On Wed, 2 Jun 2010 00:05:14 -0700
> > Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:
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
>=20
> There are many wakeup events possible in a typical system --
> keypresses or other input events, network traffic, telephony events,
> media events (fill audio buffer, fill video decoder buffer, etc), and
> I think requiring that all wakeup event processing bottleneck through
> a single userspace process is non-optimal here.

Just to be clear: I'm not suggesting all wake-events need to go through=
 one
process.  That was just one example of how the interface I proposed cou=
ld be
used.  There were two other examples.
However one process would need to know about any wakeup event that happ=
ens.
I don't think that needs to be a significant bottleneck, but I don't re=
ally
know enough about all the requirement to try devising a demonstration.

>=20
> The current suspend-blocker proposal already involves userspace
> changes (it's different than our existing wakelock interface), and
> we're certainly not opposed to any/all userspace changes on principle=
,
> but on the other hand we're not interested in significant reworks of
> userspace unless they actually improve the situation somehow.  I thin=
k
> bottlenecking events through a central daemon would represent a step
> backwards.

I guess it becomes an question of economics for you then.  Does the cos=
t of
whatever user-space changes are required exceed the value of using an u=
pstream
kernel?  Both the cost and the value would be very hard to estimate in
advance.  I don't envy you the decision...

NeilBrown
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Sat, 12 Jun 2010 11:22:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006121108200.1390-100000@netrider.rowland.org>
References: <AANLkTikEJ5pWNNg6fVNHEJqN_DA3iXWfUfKQaQyQv0mL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57279 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750739Ab0FLPWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Jun 2010 11:22:20 -0400
In-Reply-To: <AANLkTikEJ5pWNNg6fVNHEJqN_DA3iXWfUfKQaQyQv0mL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>

On Fri, 11 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > Wait a second. =A0Maybe I have misunderstood how timeouts are suppo=
sed to
> > work with wakelocks. =A0I thought the idea was that the wakelock wo=
uld be
> > released when the timeout expires or the event queue is emptied,
>=20
> That is one way to use it, and I did this so code that opened an inpu=
t
> device without reading from it would not prevent suspend forever. In
> the last patchset I posted, I instead used an ioctl to enable the
> suspend blocker.
>=20
> > whichever comes first. =A0Now it sounds like you're saying that the
> > wakelock doesn't get released until the timeout expires, even if
> > userspace finishes processing all pending events before then.
> >
>=20
> For incoming network traffic we use a wakelock with a timeout to
> prevent suspend long enough for the data to make it to user-space
> since we have not added wakelocks to the network stack.

> We did this to avoid changing to the network stack, tty layer, etc.

I see.  These are examples where wakelocks are _not_ released by any
userspace action, so they don't seem to fit well into my all-userspace
scheme.  At least, not in their current form.  On the other hand, if
the network/tty wakeup events eventually cause data to become available
on a socket or device file, then they wouldn't need any special
treatment in my scheme.  The socket/file descriptors could be handled=20
the same as any others.  (Although you might need to change some apps,=20
to make them follow the usual pattern of poll, activate suspend=20
blocker, read, process, release suspend blocker.)

In other words, the fact that everything has been moved into userspace
means that you wouldn't have to worry about the missing wakelocks in
the network stack or tty layer, and consequently wouldn't have to worry
about using timed wakelocks there.

> > Sure. =A0But specifically, which drivers on Android generate wakeup
> > events? =A0And which of them don't fully handle their events in the=
ir
> > interrupt handlers?
> >
>=20
> Keypad, network, charger, rtc, but I'm sure I forgot some.
>=20
> > Maybe another way to put this is: Where in the kernel do you intend=
 to
> > add suspend blockers?
> >
>=20
> In addition to the drivers that enable the wakeup events, we have
> added suspend blockers to the input event code and power supply
> framework. The tty layer and network stack would also need suspend
> blockers to avoid using timeouts.

I see.  The keypad, charger (power supply), and rtc drivers sound=20
pretty platform-specific.  Probably nobody would complain too strongly=20
about adding suspend blockers there.

The input, network, and tty layers are more general, though.  That's
where you're most likely to encounter resistance.

People have been complaining about "suspend blockers being added all=20
throughout the kernel".  It might help if you pointed out that it's=20
just in these three layers (and maybe at only a few specific points=20
within each layer).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

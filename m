From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 01:39:03 +0200
Message-ID: <201006060139.03585.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <alpine.LFD.2.00.1006052348200.2933@localhost.localdomain> <AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
=2E..
> > So taking your example:
> >
> > Event happens and gets delivered to the framework
> >
> >      framework selects A because it is in the foreground
> >
> >      if (A is frozen)
> >         unfreeze(A)
> >
> >      deliver_event_to(A)
> >
> > It's that simple.
> >
>=20
> That is too simple. You also have to prevent A from being frozen whil=
e
> it is processing the event or the result would be the same as if it
> was frozen beforehand.

Well, the freezing of the "untrusted" part of user space needs to be tr=
iggered
somehow in the first place.  Whatever mechanism is used for that, there=
 should
be a way to tell it to not to freeze the "untrusted" part of user space=
 for a
while.  Yes, it is similar to wakelocks, but I think it can be implemen=
ted
entirely in user space.

So, in general, the "trusted" app that needs an "untrusted" one to hand=
le stuff
will take a "freeze lock" to prevent the power manager from freezing th=
e
"untrusted" part of user space (that will also cause it to thaw these t=
asks if
they are frozen at the moment) and will release the "freeze lock" when =
it's
done with its job.  You can use timeouts and whatever you like with tha=
t and
the kernel doesn't have to participate in that (except for carrying out=
 the
low-level freezing and thawing of the "untrusted" tasks at the power ma=
nager's
request).

Rafael

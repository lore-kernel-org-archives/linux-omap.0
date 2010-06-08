From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Tue, 8 Jun 2010 11:11:39 +0200
Message-ID: <201006081111.39333.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006061555.38526.rjw@sisk.pl> <AANLkTilwE8-9yi6gTI-Cx8etIX1Q6kzKobiIxtSW2Sb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTilwE8-9yi6gTI-Cx8etIX1Q6kzKobiIxtSW2Sb9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/6 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
=2E..=20
> If individual processes are frozen, we run into problems that we
> cannot run into if we freeze and thaw all processes.

Not individual processes, but the processes that don't use wakelocks in=
 the
Android world all together.  And of course the approach has to be diffe=
rent,
because it's a different design, but I don't think there are any fundam=
ental
issues you can't solve within this approach.

> >> The app that reads this event blocks suspend before reading it. If=
 it was
> >> busy talking to a less trusted app when the event happened it stil=
l works
> >> since all apps are running at this point.
> >
> > And how is this different from an approach with cgroup freezing?  A=
pps that
> > use wakelock within the current framework would use "freeze locks" =
to prevent
> > the "untrusted" part of user space from being frozen or to thaw it.=
  Where's
> > the problem, then?
> >
>=20
> They will not be able to get wakeup events directly from the kernel.
> If the kernel does not thaw processes when a wakeup event happens, th=
e
> app may never get to the point where it grabs its wakelock.

The apps that use "freeze locks" (or wakelocks) are never frozen, so I =
don't
think this would be a problem.

Rafael

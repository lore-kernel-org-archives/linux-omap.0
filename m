From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 15:55:38 +0200
Message-ID: <201006061555.38526.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006060044.16950.rjw@sisk.pl> <AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56964 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561Ab0FFNyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jun 2010 09:54:25 -0400
In-Reply-To: <AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
=2E..
> >
> > Arve, we're still learning you have some more requirements we had n=
o idea
>=20
> What new requirement are you talking about. Did you assume all our
> user-space ipc calls went though a single process?

No, but I didn't assume that your wakelock-holding processes depend on =
the
other processes in a way that might prevent them from acquiring or drop=
ping
a wakelock.

=2E..
> >> >> Trusted code that calls into untrusted code has to deal with th=
e
> >> >> untrusted code not responding, but we only want to pop up a mes=
sage
> >> >> that the application is not responding if it is misbehaving, no=
t just
> >> >> because it was frozen though no fault of its own.
> >
> > When Android starts opportunistic suspend, all applications are fro=
zen,
> > "trusted" as well as "untrusted", right?  So, after they are all fr=
ozen, none
> > of them can do anything to prevent suspend from happening, right?
>=20
> Not if you mean when we write to /sys/power/state. Processes are not
> frozen until the last suspend blocker is released.

That doesn't matter.  In the opportunistic mode you don't need to write=
 into
/sys/power/state to start suspend, this is done by the kernel automatic=
ally as
soon as the last wakelock has been released (at least this is my assump=
tion
about how this works).  Now, at this point the processes that don't use
wakelocks can't really prevent themselves from being frozen and only th=
e
wakelocks users can do that.  So, if a wakelock user depends on a proce=
ss
that doesn't use wakelocks in such a way that (because of that dependen=
ce) it
can't acquire its wakelock while processes are being frozen, things don=
't work
as they are supposed to.

> > Now, in my proposed approach the "untrusted" apps are frozen exactl=
y at the
> > point Android would start opportunistic suspend and they wouldn't b=
e able
> > to do anything about that anyway.  So if one of your "trusted" apps=
 depends
> > on the "untrusted" ones in a way that you describe, you alread have=
 a bug
> > (the "trusted" app cannot prevent automatic suspend from happening =
even if it
> > wants, because it depends on an "untrusted" app that has just been =
frozen).
> >
>=20
> I don't think what you said here is correct. If a wakeup event happen=
s
> all processed are unfrozen since the driver blocks suspend.

This only means that the theoretical failure you gave as an example doe=
sn't
happen in practice.  No problem, then. :-)

> The app that reads this event blocks suspend before reading it. If it=
 was
> busy talking to a less trusted app when the event happened it still w=
orks
> since all apps are running at this point.

And how is this different from an approach with cgroup freezing?  Apps =
that
use wakelock within the current framework would use "freeze locks" to p=
revent
the "untrusted" part of user space from being frozen or to thaw it.  Wh=
ere's
the problem, then?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

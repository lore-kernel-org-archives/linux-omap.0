From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 09:28:51 -0700
Message-ID: <20100605092851.6ee15f13@infradead.org>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45791 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645Ab0FEQ0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 12:26:25 -0400
In-Reply-To: <1275731653.27810.41078.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, 05 Jun 2010 11:54:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> > > Trusted processes are assumed to be sane and idle when there is
> > > nothing for them to do, allowing the machine to go into deep idle
> > > states.
> > >
> >=20
> > Neither the kernel nor our trusted user-space code currently meets
> > this criteria.=20
>=20
> Then both need fixing. Really, that's the only sane approach.

fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
without really bad hacks.

the kernel has a set of infrastructure already to help here (range
timers, with which you can wakeup-limit untrusted userspace crap),
timer slack for legacy background timers, etc etc.

getting to 10 seconds is not in the range of impossibilities to be
honest... and that's even without doing things like putting untrusted
junk (read: Appstore apps) into a cgroup and do wakeup limiting and cpu
time limiting on a cgroup level....


--=20
Arjan van de Ven 	Intel Open Source Technology Centre
=46or development, discussion and tips for power savings,=20
visit http://www.lesswatts.org
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

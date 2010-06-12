From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Fri, 11 Jun 2010 19:43:57 -0700 (PDT)
Message-ID: <436654.19077.qm@web180311.mail.gq1.yahoo.com>
References: <1276266502.2862.74.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276266502.2862.74.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Brian Swetland <swetland@google.com>, Pavel Machek <pavel@ucw.cz>, tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org



--- On Fri, 6/11/10, James Bottomley <James.Bottomley@suse.de> wrote:

> > Do we at least have a clean way that a driver can
> > reject a system suspend?=A0 I've lost track of
> many
> > issues, but maybe this could be phrased as a QOS
> > constraint:=A0 the current config of driver X
> needs
> > clock Y active to enter the=A0 target system
> suspend
> > state, driver's suspend() method reports as
> much.=A0 Then the entry to
> > that system state gets blocked
> > if the clock isn't enabled.
>=20
> So in QoS modifications to android patches, the answer is "yes" ...
> except that the current android patch set didn't actually
> have this type
> of wakelock in it.

Except, we're not talking "wakelock" ... :)

So ... no, these cases still have no solution.
(I think  that's at least five years now.)


> The one thing that does look difficult is that these power
> constraints
> are device (and sometimes SoC) specific.

Exactly why they make good examples  for
turning up framework limitations... like
having overlooked constraints coming from
various SoC peripherals.

> Expressing them in a generic way
> for the cpu govenors to make sense of might be hard.

Requiring "CPU governors" to be involved in such
stuff feels a bit off-course to me.  At least, if
the involvement is very deep. The constraints are
from the integrated peripherals, not (usually)
from the CPU

There are plent of places to hang SoC or
device specific data, once there's awareness
that without such data, (which PCs hide behind
ACPI bytecode) the PM framework is missing out
on support for some desirable low power modes.


>=20
> > (That QOS constraint should be removed when that
> > driver no longer needs to issue wakeups; that's
> > not quite the same as "removed by driver.resume().
>=20
> The USB one needs user input, doesn't it,

I don't quite see that.  The drivers get called
in enough places, and they'll know if the system
is going to be in a suspend state where they need
to be partially=20
aactive (with various QOS constraints, or they
can't work.

> since user hotplug might (or
> might not) be one of the wakeup sources.

If it wakes via hotplug, then the driver must
already Do The Right Thing; what input would
be needed  (Beyond changing the cable config)?

>=20
> James
>=20
>=20
> --

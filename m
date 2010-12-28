From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/2] mfd: twl6030-irq: move to threaded_irq
Date: Tue, 28 Dec 2010 09:40:03 -0800 (PST)
Message-ID: <704478.32838.qm@web180316.mail.gq1.yahoo.com>
References: <20101228154617.GC14860@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm30.bullet.mail.sp2.yahoo.com ([98.139.91.100]:38818 "HELO
	nm30.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754505Ab0L1RkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 12:40:07 -0500
In-Reply-To: <20101228154617.GC14860@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>



--- On Tue, 12/28/10, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> F

> You shouldn't need this any more; the driver used to be
> faffing around
> with this because it wasn't using genirq for
> this in the past.

Originally it couldn't, since genirq didn't
support threaded IRQ handling...

...

> 
> Simiarly here as far as I know; the original code predates
> genirq
> support for this so is doing some hairy stuff that is no
> longer
> required and may actually be harmful.
> 
> What I'd expect to see from a conversion like this would be
> that most of
> the locking/IRQ management stuff would be dropped

I'd expect that genirq solve all the issues and
that its support be used.  That's not the same
as dropping anything except the initial code to
handle what genirq didn't ... some locking/etc
would still mostly need doing, but where genirq
now handles it, that'd be preferable.
 and the
> bus_lock() and
> bus_sync_unlock() operations would be implemented.
h
ISTR maybe four or five genirq updates in the
area of threaded IRQ management, added so that
issues the twl4030 driver needed to be solved
could be solved in generic ways.

The first was just having threaded IRQ handlers,
and another was I think removing the initial
quick'n'dirty thread-per-irq restriction; there
was no point in having a few dozen IRQ threads
in e.g. a twl4030 driver, since two could never
do constructive work concurrently.

I'm glad to see this conversion finally start.
Even if all the threaded IRQ hooks don't get used
to best advantage, it'll be an improvement.


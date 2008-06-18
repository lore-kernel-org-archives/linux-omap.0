From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] suppress needless timer reprogramming {tick-sched.c}
Date: Wed, 18 Jun 2008 09:28:41 -0700
Message-ID: <200806180928.42084.david-b@pacbell.net>
References: <3B6D69C3A9EBCA4BA5DA60D91302742904554EE1@dlee13.ent.ti.com> <200806150130.32901.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE8967162035B963D16@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754744AbYFRQ25@vger.kernel.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035B963D16@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 June 2008, Woodruff, Richard wrote:
> >
> > As measured using ETM trace this drops my reprogramming penalty fro=
m
> > almost 60% CPU load down to 15% during high interrupt rate. =A0If y=
ou like
> > I can send traces to show this.

More than doubling the available-for-real-use CPU time!  Impressive.

I'd imagine that many systems using reprogrammable 32K timers for
scheduling could win from such a patch, although not necessarily
quite so visibly as on this ARM unless their CPU clocks were also
in the 500+ MHz range.

Seems like a "law of unintended consequences" here.  Use a 32K
timer since it takes less power than a multi-MHz one, and so the
faster clocks can be gated off more comprehensively (in hardware)
to give more power savings.  Then throw NO_HZ on top to get one
more increment of power savings ... whoops, it was assuming that
it was dirt cheap to reprogram timers, major badness!

- Dave

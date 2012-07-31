From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and
	clk_unprepare
Date: Tue, 31 Jul 2012 10:23:15 +0100
Message-ID: <20120731092315.GK7405@n2100.arm.linux.org.uk>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com> <1341224669-15231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com> <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com> <20120730230233.GA12574@n2100.arm.linux.org.uk> <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52294 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab2GaJXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 05:23:25 -0400
Content-Disposition: inline
In-Reply-To: <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 30, 2012 at 05:31:23PM -0700, Turquette, Mike wrote:
> On Mon, Jul 30, 2012 at 4:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jul 30, 2012 at 03:42:13PM -0700, Turquette, Mike wrote:
> >> On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > So if we make a change like this one, it seems like we would basically
> >> > expect it to break once we start doing anything meaningful with
> >> > clk_prepare(), like using clk_prepare() for voltage scaling or something
> >> > that requires I2C?  We'd also probably want to mark this with some kind of
> >> > "HACK" comment.
> >>
> >> Hi Paul,
> >>
> >> Did you have anything in mind to start using clk_prepare?  I still
> >> hope to get rid of it some day and replace that call with a
> >> combination of clk_enable and a check like clk_enable_can_sleep.
> >
> > Don't you dare.
> >
> > We arrived at the clk_prepare()/clk_enable() split after lots of
> > discussion between different platform maintainers and their
> > requirements.
> >
> > Shoving crap like "clk_enable_can_sleep()" down into drivers is
> > totally and utterly idiotic.  We've had the situation *already*
> > where some drivers can be used on some platforms but not on others
> > because of differences in clk_enable() expectations.
> >
> 
> How does having a dynamic run-time check cause a generic driver to run
> on "some platforms but not on others"?

What you're asking is for drivers which use clk_prepare() and clk_enable()
correctly to be littered with:

-	clk_prepare(clk);
+	if (clk_enable_can_sleep(clk))
+		clk_enable(clk);

and, in atomic contexts:

-	clk_enable(clk);
+	if (!clk_enable_can_sleep(clk))
+		clk_enable(clk);

which is total bollocks - drivers should not need to know about this
clk_enable_can_sleep() crap.

> Two calls exist because of context differences.  But in practice they
> do the same thing: cause a line to toggle at a rate.  If a run-time
> check exists and the framework could handle this gracefully, why would
> you still choose the split api?

How can it handle it gracefully?

Take a look at something like amba-pl011.c for a clue.  Remove the
clk_prepare() and clk_unprepare() calls.  Then consider a clk
implementation which does not support clk_enable()/clk_disable() from
atomic contexts.  Now think about how the pl011 driver enable the clock
for console output from atomic contexts?  Answer, it can't.

We've been here before with this stuff, and this is exactly why we split
clk_enable() into the two separate calls we have today.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 02:42:52 +0100
Message-ID: <20110401014252.GC17857@sirena.org.uk>
References: <20110317183048.GW7258@atomide.com> <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com> <20110318101512.GA15375@n2100.arm.linux.org.uk> <201103301906.42429.arnd@arndb.de> <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com> <alpine.LFD.2.00.1103302155270.22418@localhost6.localdomain6> <20110330215434.GI18334@atomide.com> <alpine.LFD.2.00.1103310018540.22418@localhost6.localdomain6> <20110330224526.GM18334@atomide.com> <alpine.LFD.2.00.1103310049530.22418@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1103310049530.22418@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 31, 2011 at 12:56:33AM +0200, Thomas Gleixner wrote:
> On Wed, 30 Mar 2011, Tony Lindgren wrote:
> > * Thomas Gleixner <tglx@linutronix.de> [110330 15:22]:
> > > On Wed, 30 Mar 2011, Tony Lindgren wrote:

> > > > One thing that will help here and distribute the load is to move
> > > > more things under drivers/ as then we have more maintainers looking
> > > > at the code.

> > > Guess what's that going to solve? Nothing, nada.

> > > Really, you move the problem to people who are not prepared to deal
> > > with the wave either. So what's the gain?

> > I guess my point is that with creating more common frameworks people
> > will be using common code. Some examples that come to mind are clock
> > framework, gpiolib, dma engine, runtime PM and so on.

> For all that to happen you need a really experienced team with a
> strong team lead to fight that through and go through the existing
> horror while dealing  with the incoming flood at the same time.

My experience is that it's not that bad doing this providing you can
convince people to actually show their code to the relevant subsystem
maintainers and they have time to look at the code.  The first step is
reasonably tractable since it's a fairly basic level of review and as a
subsystem maintainer you're well enough motivated to at least ensure
that people aren't breaking the abstractions enough to cause problems
for anyone but the people directly working with the drivers.

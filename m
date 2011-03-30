From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 15:45:26 -0700
Message-ID: <20110330224526.GM18334@atomide.com>
References: <20110317183048.GW7258@atomide.com>
 <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
 <20110318101512.GA15375@n2100.arm.linux.org.uk>
 <201103301906.42429.arnd@arndb.de>
 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <alpine.LFD.2.00.1103302155270.22418@localhost6.localdomain6>
 <20110330215434.GI18334@atomide.com>
 <alpine.LFD.2.00.1103310018540.22418@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1103310018540.22418@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [110330 15:22]:
> On Wed, 30 Mar 2011, Tony Lindgren wrote:
> 
> > * Thomas Gleixner <tglx@linutronix.de> [110330 14:07]:
> > > 
> > > So one person will be not enough, that needs to be a whole team of
> > > experienced people in the very near future to deal with the massive
> > > tsunami of crap which is targeted at mainline. If we fail to set that
> > > up, then we run into a very ugly maintainability issue in no time.
> > 
> > One thing that will help here and distribute the load is to move
> > more things under drivers/ as then we have more maintainers looking
> > at the code.
> 
> Guess what's that going to solve? Nothing, nada.
> 
> Really, you move the problem to people who are not prepared to deal
> with the wave either. So what's the gain?

I guess my point is that with creating more common frameworks people
will be using common code. Some examples that come to mind are clock
framework, gpiolib, dma engine, runtime PM and so on.

Then even arch specific driver code becomes generic and separated
from the arch specific code. And then the driver subsystem maintainer
can review it easier.

Regards,

Tony

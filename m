From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 08/26] arm: Replace various irq_desc accesses
Date: Wed, 26 Feb 2014 09:05:31 -0800
Message-ID: <20140226170530.GC11654@atomide.com>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.099151500@linutronix.de>
 <20140224025539.GE25011@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140224025539.GE25011@S2101-09.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, arm <linux-arm-kernel@lists.infradead.org>, omap <linux-omap@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Shawn Guo <shawn.guo@linaro.org> [140223 18:58]:
> On Sun, Feb 23, 2014 at 09:40:12PM -0000, Thomas Gleixner wrote:
> > Use the proper functions. There is no need to fiddle with irq_desc.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> ...
> >  arch/arm/mach-imx/pm-imx6q.c        |    7 +++----
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com> 

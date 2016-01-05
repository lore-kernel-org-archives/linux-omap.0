From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 04 Jan 2016 17:23:00 -0800
Message-ID: <20160105012300.15239.77012@quark.deferred.io>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io> <568A20E5.6040005@ti.com>
 <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
 <568A735D.2060309@ti.com> <20160104144221.GA5783@n2100.arm.linux.org.uk>
 <20160104162853.GA12777@atomide.com> <568AC4D8.2060509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <568AC4D8.2060509@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2016-01-04 11:15:36)
> On 01/04/2016 06:37 PM, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [160104 06:43]:
> >> On Mon, Jan 04, 2016 at 03:27:57PM +0200, Tero Kristo wrote:
> >>> On 01/04/2016 12:21 PM, Geert Uytterhoeven wrote:
> >>>> FWIW, there are small loops with just a cpu_relax() in various clock drivers
> >>>> under drivers/clk/shmobile/.
> >>>
> >>> Just did a quick profiling round, and the clk_enable/disable delay loops
> >>> take anything from 0...1500ns, most typically consuming some 400-600ns. So,
> >>> based on this, dropping the udelay and adding cpu_relax instead looks like a
> >>> good change. I just verified that changing the udelay to cpu_relax works
> >>> fine also, I just need to change the bail-out period to be something sane.
> >>
> >> Was that profiling done with lockdep/lock debugging enabled or disabled?
> 
> omap2plus_defconfig, so lockdep was enabled. The profiling was done 
> around the while {} block though, which should not have any locks within 
> it (except for the SCM clocks, which may explain some of the higher 
> latency numbers seen.)
> 
> > And also the thing to check from the hw folks is what all do these clkctrl
> > bits really control. If they group together the OCP clock and an extra
> > functional clock for some devices the delays could be larger.
> 
> Does it matter really? The latencies are only imposed to the device in 
> question, and lets face it, the same latencies are there already with 
> the hwmod implementation. This series moves the implementation under 
> clock driver with as less modifications as possible to avoid any problems.

So long as we can all convince ourselves that the flaw is not a flaw
then I'm OK with it. No bugs were ever introduced that way ;-)

But in fairness, we've had these delays in the .enable callbacks for a
while, so this patch does not introduce the regression. Furthermore it
does clean up some code that needs more work, and I don't want to delay
that.

I won't NACK the patch due to the delays, but it would be nice to
revisit it some day.

Regards,
Mike

> 
> > In general, I think we need to get rid of pm_runtime_irq_safe usage to
> > allow clocks to sleep properly. The other option is to allow toggling
> > pm_runtime_irq_safe but that probably gets super messy.
> 
> That is something not to be done with this set though.
> 
> -Tero

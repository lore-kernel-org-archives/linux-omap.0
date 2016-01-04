From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 6/9] clk: ti: add support for omap4 module clocks
Date: Mon, 4 Jan 2016 08:37:41 -0800
Message-ID: <20160104162853.GA12777@atomide.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io>
 <568A20E5.6040005@ti.com>
 <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
 <568A735D.2060309@ti.com>
 <20160104144221.GA5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160104144221.GA5783@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [160104 06:43]:
> On Mon, Jan 04, 2016 at 03:27:57PM +0200, Tero Kristo wrote:
> > On 01/04/2016 12:21 PM, Geert Uytterhoeven wrote:
> > >FWIW, there are small loops with just a cpu_relax() in various clock drivers
> > >under drivers/clk/shmobile/.
> > 
> > Just did a quick profiling round, and the clk_enable/disable delay loops
> > take anything from 0...1500ns, most typically consuming some 400-600ns. So,
> > based on this, dropping the udelay and adding cpu_relax instead looks like a
> > good change. I just verified that changing the udelay to cpu_relax works
> > fine also, I just need to change the bail-out period to be something sane.
> 
> Was that profiling done with lockdep/lock debugging enabled or disabled?

And also the thing to check from the hw folks is what all do these clkctrl
bits really control. If they group together the OCP clock and an extra
functional clock for some devices the delays could be larger.

In general, I think we need to get rid of pm_runtime_irq_safe usage to
allow clocks to sleep properly. The other option is to allow toggling
pm_runtime_irq_safe but that probably gets super messy.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Mon, 3 Apr 2017 20:03:00 -0700
Message-ID: <20170404030300.GK10760@atomide.com>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
 <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
 <20170328154740.GW10760@atomide.com>
 <20170328164911.xwwl3kdy6j2y7hfq@sirena.org.uk>
 <20170328171022.GZ10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328171022.GZ10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [170328 10:13]:
> * Mark Brown <broonie@kernel.org> [170328 09:51]:
> > On Tue, Mar 28, 2017 at 08:47:41AM -0700, Tony Lindgren wrote:
> > > * Mark Brown <broonie@kernel.org> [170328 08:21]:
> > 
> > > > Right, my thinking here is that by pushing into genirq we minimise the
> > > > need even further since it'll also be available to drivers not using
> > > > regmap-irq.
> > 
> > > > > like, handle until we get IRQ_NONE? :)
> > 
> > > > Well, that's what the per driver emulation does so...  yeah.  Probably
> > > > with an upper limit on the number of times we do that.
> > 
> > > OK let's first see how that would work. I'll send a patch
> > > for that.
> > 
> > Thanks.  Can you keep me on the CC please?  It's something I keep
> > thinking about looking at myself.
> 
> Sure will do, you'll get some shared flames on it :)

So I found the real problem after thinking what you guys commented
on the "level device connected to an edge only GPIO". I added some
printks to verify that's not the case just to find out that the dts
GPIO interrupt edge configuration got only passed to the SPI driver :)

So the level IRQ changes I did earlier to the dts file did nothing.

The fix is simply to call devm_regmap_add_irq_chip() with
irq_get_trigger_type(cpcap->spi->irq) to get the configured
triggering passed properly from the dts.

So I'll drop the genirq/regmap_irq related hacks and resend just
the minimal MFD fixes. Similar misconfiguration may be the root
cause for other drivers too..

Regards,

Tony

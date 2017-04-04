From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 4 Apr 2017 06:56:30 -0700
Message-ID: <20170404135629.GN10760@atomide.com>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
 <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
 <20170328154740.GW10760@atomide.com>
 <20170328164911.xwwl3kdy6j2y7hfq@sirena.org.uk>
 <20170328171022.GZ10760@atomide.com>
 <20170404030300.GK10760@atomide.com>
 <20170404121957.v64jcx2k4w3mwtje@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404121957.v64jcx2k4w3mwtje@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [170404 05:22]:
> On Mon, Apr 03, 2017 at 08:03:00PM -0700, Tony Lindgren wrote:
> 
> > So I'll drop the genirq/regmap_irq related hacks and resend just
> > the minimal MFD fixes. Similar misconfiguration may be the root
> > cause for other drivers too..
> 
> It is sadly far too common for people to implement interrupt controllers
> that only do edge triggers, I've no idea why even on what are supposed
> to be relatively high end SoCs.  It seems to be a hardware designer
> thing, AFAICT they think for something to be useful it needs to be a bit
> more complicated.

For edge only GPIO controllers handling level interrupts might be
somewhat fixable in software. The GPIO controller could have a loop
reading of the GPIO line status in the interrupt handler and comparing
it to the configured triggering.

Regards,

Tony

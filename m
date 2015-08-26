From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] gpio: omap: fixes and improvements
Date: Wed, 26 Aug 2015 09:06:22 -0700
Message-ID: <20150826160622.GO4215@atomide.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
 <20150819063851.GI4215@atomide.com>
 <20150821081342.GL4215@atomide.com>
 <55DC544D.9000304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55DC544D.9000304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150825 04:44]:
> On 08/21/2015 11:13 AM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150818 23:42]:
> >> Hi,
> >>
> >> * Grygorii Strashko <grygorii.strashko@ti.com> [150818 04:14]:
> >>> Hi,
> >>>
> >>> This patch series contains set of trivial fixes and improvements, and also
> >>> patches which fixes wrong APIs usage in atomic context as for -RT as for
> >>> non-RT kernel. The final goal of this series is to make TI OMAP GPIO
> >>> driver compatible with -RT kernel as much as possible.
> >>>
> >>> Patch 1-4: trivial fixes and improvements
> >>> Patch 5: fixes wrong CLK clk_prepare/unprepare APIs usage in atomic contexet
> >>> Patch 6(rfc): required to be compatible with -RT kernel, because PM runtime
> >>>   can't be used in atimic context on -RT.
> >>> Patch 7(rfc): This patch converts TI OMAP GPIO driver to use generic irq
> >>>   handler instead of chained IRQ handler. This way OMAP GPIO driver will be
> >>>   compatible with RT kernel where it will be forced thread IRQ handler
> >>>   while in non-RT kernel it still will be executed in HW IRQ context.
> >>
> >> Based on quick testing this series breaks at least core off idle for omap3.
> >> You probably should add a beagle xm to your test devices so you can
> >> properly test PM features.
> > 
> > Sorry I take that back, after trying to figure out which patch breaks PM
> > I noticed I had some other patches applied also. Looks like PM works just
> > fine with this series for me, so please feel free to add:
> > 
> 
> Uh... :) Thanks Tony a lot and sorry for delayed reply (was ooo).
> You've restored my heartbeat :)
> 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > Note that I have not been able to test this with gpio button as my
> > boards are in a rack. You may want to do some gpio button tests to
> > make sure things wake up properly from off idle if you can get hold
> > of a beagle xm. I posted some instructions how to test earlier today
> > for Kishon in the "[PATCH v2 00/16] omap_hsmmc: regulator usage
> > cleanup and fixes" thread.
> 
> 
> I've tested it actually using GPIO buttons and UART console wake-up
> (Results - https://lkml.org/lkml/2015/8/14/194 :)

OK great good to hear :)
 
> And I'd try to retest it on beagle xm also, but not sure if i'd be able
> to test button's wake-up - have shared access only now to beagle xm
> which is rack also.

OK. FYI, we're still missing a clean solution to omap3 errata 1.158
that requires remuxing GPIO pins to safe mode with pull for off idle
to avoid glitches:

http://www.spinics.net/lists/linux-omap/msg11669.html

Regards,

Tony

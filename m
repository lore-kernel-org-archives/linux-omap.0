From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 4/5] clocksource: omap-timer: Introduce clocksource driver
 for OMAP SoCs
Date: Fri, 14 Mar 2014 08:52:03 -0700
Message-ID: <20140314155202.GA27560@atomide.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
 <1394742919-32163-5-git-send-email-joelf@ti.com>
 <20140313204851.GB23432@atomide.com>
 <532243F5.4040609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <532243F5.4040609@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [140313 16:52]:
> On 03/13/2014 03:48 PM, Tony Lindgren wrote:
> > * Joel Fernandes <joelf@TI.com> [140313 13:43]:
> >> We introduce functions to initialize clocksource and clockevent, use
> >> CLOCKSOURCE_OF_DECLARE to declare the clocksource, and handle the clocksource
> >> selection on a per-SoC basis (Currently only AM335x is supported). Powering up
> >> of the timer will be done with the help of the mach-omap layer function that's
> >> introduced earlier in the series.
> >>
> >> We make a local copy of dmtimer API for use by clocksource, the original
> >> dmtimer API in plat-omap is kept as-is till the migration of all SoCs is
> >> completed after which it can't be deleted.
> >>
> >> Signed-off-by: Joel Fernandes <joelf@ti.com>
> >> ---
> >>  drivers/clocksource/Makefile     |    1 +
> >>  drivers/clocksource/omap-timer.c | 1157 ++++++++++++++++++++++++++++++++++++++
> >>  drivers/clocksource/omap-timer.h |  422 ++++++++++++++
> >>  3 files changed, 1580 insertions(+)
> >>  create mode 100644 drivers/clocksource/omap-timer.c
> >>  create mode 100644 drivers/clocksource/omap-timer.h
> > 
> > Hmm this leaves duplicate arch/arm/plat-omap/dmtimer.c code, please
> 
> Sure, ofcourse- but how else can we make sure everything works while we do
> the migration in steps. We can get rid of the duplicate once everything is
> migrated.

That's not doing incremental changes then. You're not even modifying
the existing omap_dm_timer functions, so please do the changes in incremental
steps where things keep working throughout the series.
 
> > sort out that issue too by allowing omap1 and omap3 still to use
> > the legacy timer init functions but with timer code under
> > drivers/clocksource/omap-timer.c.
> 
> Sorry, I didn't follow. I didn't see OMAP3 using legacy timer stuff. To me
> it looks like OMAP3 migration should be straight forward along the same
> lines as this RFC patchset. Could you elaborate a bit more what the legacy
> functions you mentioned for OMAP1 are? I will just like to keep everything
> in drivers/clocksource/ private for now till we're done migrating most
> platforms. IMO once we get system timers working for omap2+, then we can
> look into omap1 :)

Well omap3 is still also booting in legacy mode too.
 
> > And not the that drivers/clocksource/omap-timer.h won't be needed at
> > all, those defines can stay private to the drivers/clocksource/omap-timer.c.
> 
> Actually- I wanted it separate because omap-timer.c is already huge at 1157
> lines. Infact the largest among the clocksource drivers. Is that fair?

No need for it. We want to keep these functions private to the driver.
 
> > So this patch really should just be moving of the code to the new
> > location.
> 
> To be honest, its not just a simple moving of code, there are new things
> such as selecting correct timer, new functions for clockevent and
> clocksource init, different handling of clocks etc.

Those changes should then be separate patches to prepare things so
people can see what changes in arch/arm/plat-omap/dmtimer.c code.

Regards,

Tony

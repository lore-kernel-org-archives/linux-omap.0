From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
Date: Fri, 24 Feb 2012 16:35:44 +0200
Message-ID: <1330094144.4102.554.camel@sokoban>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
	 <1330003320-17400-4-git-send-email-t-kristo@ti.com>
	 <CAMQu2gxQQTfiNoiwZszNWFiDWaei8+f6eKj+K2ZE1wNuvFLH9A@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab2BXOfu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:35:50 -0500
In-Reply-To: <CAMQu2gxQQTfiNoiwZszNWFiDWaei8+f6eKj+K2ZE1wNuvFLH9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Thu, 2012-02-23 at 19:23 +0530, Shilimkar, Santosh wrote:
> On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > From: Vishwanath BS <vishwanath.bs@ti.com>
> >
> > IO Daisychain feature has to be triggered whenever there is a change in
> > device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
> >
> > Now devices can idle independent of the powerdomain, there can be a
> > window where device is idled and corresponding powerdomain can be
> > ON/INACTIVE state. In such situations, since both module wake up is
> > enabled at padlevel as well as io daisychain sequence is triggered,
> > there will be 2 PRCM interrupts (Module async wake up via swakeup and
> > IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> > Padlevel WKST bit in the first interrupt, module specific interrupt
> > handler will not triggered for the second time
> >
> > Also look at detailed explanation given by Rajendra at
> > http://www.spinics.net/lists/linux-serial/msg04480.html
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
> >  arch/arm/mach-omap2/pm.c         |    7 +++++++
> >  arch/arm/mach-omap2/pm.h         |    1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> 
> [...]
> 
> >
> > diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> > index 1881fe9..e8b54eb 100644
> > --- a/arch/arm/mach-omap2/pm.c
> > +++ b/arch/arm/mach-omap2/pm.c
> > @@ -25,6 +25,7 @@
> >  #include "clockdomain.h"
> >  #include "pm.h"
> >  #include "twl-common.h"
> > +#include "prm44xx.h"
> >
> >  static struct omap_device_pm_latency *pm_lats;
> >
> > @@ -64,6 +65,12 @@ static void omap2_init_processor_devices(void)
> >        }
> >  }
> >
> > +void omap_trigger_wuclk_ctrl(void)
> > +{
> > +       if (cpu_is_omap44xx())
> 
> can we avoid above check to make it generic so that even OMAP5 can use this
> code without any change. Some flag might do the trick.

Can't remove this check, as we don't want to execute this code for
omap2 / omap3, it would just crash.

-Tero

> 
> Rest of the patch looks fine to me.
> 
> Regards
> Santosh



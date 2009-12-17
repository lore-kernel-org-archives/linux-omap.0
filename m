From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] AM3517: Add support for TSC2004 driver
Date: Thu, 17 Dec 2009 10:21:33 -0800
Message-ID: <20091217182133.GB12790@core.coreip.homeip.net>
References: <hvaibhav@ti.com> <1259212261-32528-1-git-send-email-hvaibhav@ti.com> <19F8576C6E063C45BE387C64729E739404370D7AEB@dbde02.ent.ti.com> <20091130173331.GS4348@atomide.com> <19F8576C6E063C45BE387C64729E73940449F43A4C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F43A4C@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 17, 2009 at 11:38:18PM +0530, Hiremath, Vaibhav wrote:
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Thursday, December 10, 2009 11:13 AM
> > To: 'Tony Lindgren'; 'Dmitry Torokhov'; 'dtor@mail.ru'
> > Cc: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> > Subject: RE: [PATCH V2] AM3517: Add support for TSC2004 driver
> > 
> > 
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Monday, November 30, 2009 11:04 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH V2] AM3517: Add support for TSC2004 driver
> > >
> > > * Hiremath, Vaibhav <hvaibhav@ti.com> [091125 21:13]:
> > > >
> > > > > -----Original Message-----
> > > > > From: Hiremath, Vaibhav
> > > > > Sent: Thursday, November 26, 2009 10:41 AM
> > > > > To: linux-omap@vger.kernel.org
> > > > > Cc: tony@atomide.com; Hiremath, Vaibhav
> > > > > Subject: [PATCH V2] AM3517: Add support for TSC2004 driver
> > > > >
> > > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > >
> > > > > Changes:
> > > > > 	- Removed omap_cfg_reg()
> > > > >
> > > > > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > > ---
> > > > >  arch/arm/mach-omap2/board-am3517evm.c |   61
> > > > > +++++++++++++++++++++++++++++++++
> > > > >  1 files changed, 61 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-omap2/board-am3517evm.c
> > > b/arch/arm/mach-
> > > > > omap2/board-am3517evm.c
> > > > > index 415a13d..b183d93 100644
> > > > > --- a/arch/arm/mach-omap2/board-am3517evm.c
> > > > > +++ b/arch/arm/mach-omap2/board-am3517evm.c
> > > > > @@ -20,6 +20,8 @@
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/gpio.h>
> > > > > +#include <linux/irq.h>
> > > > > +#include <linux/i2c/tsc2004.h>
> > > > >
> > > > >  #include <mach/hardware.h>
> > > > >  #include <asm/mach-types.h>
> > > > > @@ -27,10 +29,64 @@
> > > > >  #include <asm/mach/map.h>
> > > > >
> > > > >  #include <plat/board.h>
> > > > > +#include <plat/mux.h>
> > > > >  #include <plat/common.h>
> > > > >  #include <plat/usb.h>
> > > > >
> > > > >  /*
> > > > > + * TSC 2004 Support
> > > > > + */
> <snip>...
> 
> > > merged. But I am not sure what the procedure is for input
> > subsystem
> > > drivers? Is it happens through linux-omap or linux-input?
> > >
> > > I'd rather see it merged via linux-input as that's where most
> > > of the code is. The platform init code looks OK to me to merge
> > > via linux-input too.
> > >
> > [Hiremath, Vaibhav] Dmitry,
> > 
> > Can you please merge the TSC2004 driver patch?
> > 
> [Hiremath, Vaibhav] Just a gentle reminder. 
> 

Sorry for the delays, I am swamped at the moment. Fortunately the
Christmas break is coming up so I'll try to catch up.

-- 
Dmitry

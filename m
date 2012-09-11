From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Enable pinctrl dummy states
Date: Tue, 11 Sep 2012 11:35:22 -0700
Message-ID: <20120911183522.GL23092@atomide.com>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
 <1347385599-27558-3-git-send-email-mporter@ti.com>
 <20120911180306.GI23092@atomide.com>
 <20120911181540.GO27758@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120911181540.GO27758@beef>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, AnilKumar <anilkumar@ti.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Added Linus Walleij to Cc as well.

* Matt Porter <mporter@ti.com> [120911 11:24]:
> On Tue, Sep 11, 2012 at 11:03:06AM -0700, Tony Lindgren wrote:
> > * Matt Porter <mporter@ti.com> [120911 10:46]:
> > > Enable pinctrl dummy states for all OMAP platforms. This allows
> > > drivers to be converted to pinctrl while still running on
> > > platforms that do not provide pinctrl data.
> > > 
> > > Signed-off-by: Matt Porter <mporter@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/devices.c |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > > index c00c689..577cd04 100644
> > > --- a/arch/arm/mach-omap2/devices.c
> > > +++ b/arch/arm/mach-omap2/devices.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/of.h>
> > > +#include <linux/pinctrl/machine.h>
> > >  #include <linux/platform_data/omap4-keypad.h>
> > >  
> > >  #include <mach/hardware.h>
> > > @@ -631,6 +632,9 @@ static inline void omap_init_vout(void) {}
> > >  
> > >  static int __init omap2_init_devices(void)
> > >  {
> > > +	/* Enable dummy states for those platforms without pinctrl support */
> > > +	pinctrl_provide_dummies();
> > > +
> > >  	/*
> > >  	 * please keep these calls, and their implementations above,
> > >  	 * in alphabetical order so they're easier to sort through.
> > 
> > Hmm I think this may need to be board specific. And may need to
> > be board specific and depend on unpopulated device tree?
> 
> If I run this on AM33xx with dummy states enabled, I'm able to override
> that dummy state just fine with an appropriate pinctl/pinmux entry in my
> DT data for spi.

But do you get an error then if the desired pins are not found?
If you do get an error, then sounds like it's OK to do.
 
> Meanwhile on xM booting from board-omap3evm.c/!DT and debug enabled I
> get the following:
> 
> [    1.837829] omap2_mcspi omap2_mcspi.1: no of_node; not parsing
> pinctrl DT
> [    1.845214] omap2_mcspi omap2_mcspi.1: using pinctrl dummy state
> (default)
> [    1.854278] omap2_mcspi omap2_mcspi.2: no of_node; not parsing
> pinctrl DT
> [    1.861572] omap2_mcspi omap2_mcspi.2: using pinctrl dummy state
> (default)
> [    1.870025] omap2_mcspi omap2_mcspi.3: no of_node; not parsing
> pinctrl DT
> [    1.877288] omap2_mcspi omap2_mcspi.3: using pinctrl dummy state
> (default)
> [    1.885681] omap2_mcspi omap2_mcspi.4: no of_node; not parsing
> pinctrl DT
> [    1.892913] omap2_mcspi omap2_mcspi.4: using pinctrl dummy state
> (default)
> 
> which seems to cover things being informative enough about what is
> going on. Are you wanting to see an explicit warning that the pinctrl
> dummy state is in use when pinctrl data is not available?

Well I think we should consider at least the following:

1. Always see warnings when device tree is populated with board-generic.
   If somebody wants to use bootloader only muxing with DT, they can patch
   in pinctrl_provide_dummies() somewhere. But let's assume we always
   want to see the warnings with board-generic.c and DT.

2. For legacy booting without DT, we should not see any warnings
   from pinctrl-single.c as it's DT based.

3. There may be other non-pinctrl drivers too that are not DT
   based, and in those cases we should see the warnings as well
   for in the non-DT case.
 
> > For board-generic.c we always want to see the warnings. And some boards
> > insist on doing all the muxing only in the bootloader.
> 
> Which warnings are you saying we should see in the board-generic.c
> case?  Sure, there's plenty of cases where this will be unused due to
> somebody setting all the muxes in the bootloader and then not using
> pinctrl data. I'll have to doublecheck but I believe that case is also
> fine as the -single driver can't override the dummy state if the DT has
> no pinctrl data for the spi driver.

Yeah I guess it's the case #1 above for board-generic.c.

Regards,

Tony

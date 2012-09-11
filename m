From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Enable pinctrl dummy states
Date: Tue, 11 Sep 2012 15:06:02 -0400
Message-ID: <20120911190602.GP27758@beef>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
	<1347385599-27558-3-git-send-email-mporter@ti.com>
	<20120911180306.GI23092@atomide.com> <20120911181540.GO27758@beef>
	<20120911183522.GL23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120911183522.GL23092-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, AnilKumar <anilkumar-l0cyMroinI0@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 11, 2012 at 11:35:22AM -0700, Tony Lindgren wrote:
> Added Linus Walleij to Cc as well.
> 
> * Matt Porter <mporter-l0cyMroinI0@public.gmane.org> [120911 11:24]:
> > On Tue, Sep 11, 2012 at 11:03:06AM -0700, Tony Lindgren wrote:
> > > * Matt Porter <mporter-l0cyMroinI0@public.gmane.org> [120911 10:46]:
> > > > Enable pinctrl dummy states for all OMAP platforms. This allows
> > > > drivers to be converted to pinctrl while still running on
> > > > platforms that do not provide pinctrl data.
> > > > 
> > > > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > > > ---
> > > >  arch/arm/mach-omap2/devices.c |    4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > > > index c00c689..577cd04 100644
> > > > --- a/arch/arm/mach-omap2/devices.c
> > > > +++ b/arch/arm/mach-omap2/devices.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/err.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/pinctrl/machine.h>
> > > >  #include <linux/platform_data/omap4-keypad.h>
> > > >  
> > > >  #include <mach/hardware.h>
> > > > @@ -631,6 +632,9 @@ static inline void omap_init_vout(void) {}
> > > >  
> > > >  static int __init omap2_init_devices(void)
> > > >  {
> > > > +	/* Enable dummy states for those platforms without pinctrl support */
> > > > +	pinctrl_provide_dummies();
> > > > +
> > > >  	/*
> > > >  	 * please keep these calls, and their implementations above,
> > > >  	 * in alphabetical order so they're easier to sort through.
> > > 
> > > Hmm I think this may need to be board specific. And may need to
> > > be board specific and depend on unpopulated device tree?
> > 
> > If I run this on AM33xx with dummy states enabled, I'm able to override
> > that dummy state just fine with an appropriate pinctl/pinmux entry in my
> > DT data for spi.
> 
> But do you get an error then if the desired pins are not found?
> If you do get an error, then sounds like it's OK to do.

Hrm, no. In that case, it will be completely silent (assuming we took
care of the pinmuxing in the bootloader) as it uses the dummy state.
Only with debug on will you see the information that mcspi has used
the dummy state as is the case with !DT.

> > Meanwhile on xM booting from board-omap3evm.c/!DT and debug enabled I
> > get the following:
> > 
> > [    1.837829] omap2_mcspi omap2_mcspi.1: no of_node; not parsing
> > pinctrl DT
> > [    1.845214] omap2_mcspi omap2_mcspi.1: using pinctrl dummy state
> > (default)
> > [    1.854278] omap2_mcspi omap2_mcspi.2: no of_node; not parsing
> > pinctrl DT
> > [    1.861572] omap2_mcspi omap2_mcspi.2: using pinctrl dummy state
> > (default)
> > [    1.870025] omap2_mcspi omap2_mcspi.3: no of_node; not parsing
> > pinctrl DT
> > [    1.877288] omap2_mcspi omap2_mcspi.3: using pinctrl dummy state
> > (default)
> > [    1.885681] omap2_mcspi omap2_mcspi.4: no of_node; not parsing
> > pinctrl DT
> > [    1.892913] omap2_mcspi omap2_mcspi.4: using pinctrl dummy state
> > (default)
> > 
> > which seems to cover things being informative enough about what is
> > going on. Are you wanting to see an explicit warning that the pinctrl
> > dummy state is in use when pinctrl data is not available?
> 
> Well I think we should consider at least the following:
> 
> 1. Always see warnings when device tree is populated with board-generic.
>    If somebody wants to use bootloader only muxing with DT, they can patch
>    in pinctrl_provide_dummies() somewhere. But let's assume we always
>    want to see the warnings with board-generic.c and DT.

Ok, this is clear.

> 2. For legacy booting without DT, we should not see any warnings
>    from pinctrl-single.c as it's DT based.

Right, except anything legacy booting without DT will require that
dummy states be present otherwise it will fail probe.

> 
> 3. There may be other non-pinctrl drivers too that are not DT
>    based, and in those cases we should see the warnings as well
>    for in the non-DT case.

I'm not sure what you mean here. "non-pinctrl drivers" means any driver
that is not yet pinctrl or DT enabled? It's unclear to me how this
case has a bearing on mcspi and pinctrl enablement across legacy
board-foo.c !DT booting platforms.

However, I think if the approach was modified by only calling
pinctrl_provide_dummies() when we are booting with DT populated
and using board-generic.c then it will satisfy all of your
concerns. Thoughts?

i.e. the legacy !DT booting will have dummy states and continue
along through mcspi the way it does today, relying on board-foo level
pinmux calls (or bootloader pinmuxing). Meanwhile DT booting will now
require that a mcspi instance also require pinctrl entry in this dts.

The only worrisome thing is the pinctrl requirement on DT booting is
now an implicit requirement.

> > > For board-generic.c we always want to see the warnings. And some boards
> > > insist on doing all the muxing only in the bootloader.
> > 
> > Which warnings are you saying we should see in the board-generic.c
> > case?  Sure, there's plenty of cases where this will be unused due to
> > somebody setting all the muxes in the bootloader and then not using
> > pinctrl data. I'll have to doublecheck but I believe that case is also
> > fine as the -single driver can't override the dummy state if the DT has
> > no pinctrl data for the spi driver.
> 
> Yeah I guess it's the case #1 above for board-generic.c.

Right, I just checked that, in any case.

-Matt

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

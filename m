From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Patch for Touch Screen noise on OMAP3EVM.
Date: Fri, 5 Sep 2008 09:50:20 -0700
Message-ID: <20080905165019.GG24202@atomide.com>
References: <764af1890808290007t4ec0afabs4980f23237629f2c@mail.gmail.com> <31e679430808290050g797e4b90g1b5fcb316dd97cd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54406 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYIEQua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:50:30 -0400
Content-Disposition: inline
In-Reply-To: <31e679430808290050g797e4b90g1b5fcb316dd97cd7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Naveen Atmakuri <naveen.maillist@gmail.com>, linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

* Felipe Balbi <felipebalbi@users.sourceforge.net> [080829 00:51]:
> The new list is linux-omap@vger.kernel.org
> 
> Thanks
> 
> On Fri, Aug 29, 2008 at 10:07 AM, Naveen Atmakuri
> <naveen.maillist@gmail.com> wrote:
> > When git kernel tree is used on a OMAP3EVM board file for touch screen
> > testing, it shows lot of jitter. With this patch the jitter can be reduced.
> >

This patch does not seem to apply, can you please refresh?

Thanks,

Tony


> > Signed-off-by: Naveen Atmakuri <anaveen@mistralsolutions.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> > b/arch/arm/mach-omap2/board-omap3evm.c
> > index 4963f0f..9a4784e 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -27,6 +27,8 @@
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/map.h>
> > +#include <linux/io.h>
> > +#include <linux/delay.h>
> >
> >  #include <mach/gpio.h>
> >  #include <mach/keypad.h>
> > @@ -132,8 +134,16 @@ static int ads7846_get_pendown_state(void)
> >  }
> >
> >  struct ads7846_platform_data ads7846_config = {
> > +    .x_max                  = 0x0fff,
> > +    .y_max                  = 0x0fff,
> > +    .x_plate_ohms           = 180,
> > +    .pressure_max           = 255,
> > +    .debounce_max           = 10,
> > +    .debounce_tol           = 3,
> > +    .debounce_rep           = 1,
> >     .get_pendown_state    = ads7846_get_pendown_state,
> >     .keep_vref_on        = 1,
> > +    .settle_delay_usecs     = 150,
> >  };
> >
> >  static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> > --
> > 1.5.6
> >
> > Warm Regards,
> > Naveen Atmakuri.
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> 
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> felipebalbi@users.sourceforge.net
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fix for dispc's error "omapfb omapfb: irq error status 4020"
Date: Wed, 26 Nov 2008 09:32:04 -0800
Message-ID: <20081126173203.GP11997@atomide.com>
References: <E1KyYMw-0003Ob-5e@amazonia.comcast.net> <1226585192.32348.3.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64426 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYKZRcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:32:06 -0500
Content-Disposition: inline
In-Reply-To: <1226585192.32348.3.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: rick@efn.org, imre.deak@nokia.com, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [081113 06:06]:
> Hi,
> 
> On Fri, 2008-11-07 at 12:55 -0800, ext Rick Bronson wrote:
> > Folks,
> > 
> >   Please take a look at this change to drivers/video/omap/dispc.c.  It
> > addresses a problem seen on some boots of OMAP's.  On about 1 in 30
> > boots one gets an endless stream of interrupts from the
> > DISPC_IRQ_SYNC_LOST bit in the DISPC_IRQSTATUS register.  The
> > following messages are printed.
> > 
> >  omapfb omapfb: irq error status 4020
> 
> Can you try the patch below if it fixes this problem for you? On my new
> display subsystem adding a sleep between enabling clocks and doing the
> soft reset removed the problem.
> 
> I tried a bit with different sleep times. With 1ms sleep I still got
> sync losts. With 10ms I didn't, but I went safe and put 40ms.

Here's my canned fbdev reply for this tread too:

Guys, please take this discussion to fbdev mailing list and cc
linux-omap list. I'm not going to push any more omap fbdev patches,
so please send the patches against mainline kernel to fbdev list.

Regards,

Tony

> 
>  Tomi
> 
> 
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index c140c21..bdfda0c 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -24,6 +24,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/sram.h>
>  #include <mach/omapfb.h>
> @@ -1402,6 +1403,10 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>                 /* Reset monitoring works only w/ the 54M clk */
>                 enable_digit_clocks(1);
>  
> +               /* We need to wait here a bit, otherwise we sometimes start to get
> +                * synclost errors. */
> +               msleep(40);
> +
>                 /* Soft reset */
>                 MOD_REG_FLD(DISPC_SYSCONFIG, 1 << 1, 1 << 1);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

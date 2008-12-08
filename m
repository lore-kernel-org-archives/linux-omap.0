From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Mon, 08 Dec 2008 09:59:38 +0200
Message-ID: <1228723178.8668.6.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <877i6ejxb4.fsf@deeprootsystems.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30295 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYLHH7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 02:59:55 -0500
In-Reply-To: <877i6ejxb4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2008-12-05 at 10:23 -0800, ext Kevin Hilman wrote:
> <Tomi.Valkeinen@nokia.com> writes:
> 
> > Hi,
> >
> > I have had strange clk_enable() crashes with DSS2, and now I managed to
> > isolate it. With the included patch, on OMAP3 SDP board, with default
> > kernel config, I always get the crash below. In this example case it
> > happens at specific time on boot, but with DSS2 it happens randomly at
> > runtime, when I enable the DSS clocks.
> >
> > diff --git a/drivers/video/omap/omapfb_main.c
> > b/drivers/video/omap/omapfb_main.c
> > index 3bb4247..2d5ef0d 100644
> > --- a/drivers/video/omap/omapfb_main.c
> > +++ b/drivers/video/omap/omapfb_main.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/mm.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/clk.h>
> >  
> >  #include <mach/dma.h>
> >  #include <mach/omapfb.h>
> > @@ -1806,6 +1807,18 @@ static int omapfb_probe(struct platform_device
> > *pdev)
> >  {
> >         BUG_ON(fbdev_pdev != NULL);
> >  
> > +       {
> > +               struct clk *c1, *c2;
> > +               c1 = clk_get(&pdev->dev, "dss_ick");
> > +               c2 = clk_get(&pdev->dev, "dss1_fck");
> > +               while(1) {
> > +                       clk_enable(c1);
> > +                       clk_enable(c2);
> > +                       clk_disable(c1);
> > +                       clk_disable(c2);
> > +               }
> > +       }
> > +
> >         /* Delay actual initialization until the LCD is registered */
> >         fbdev_pdev = pdev;
> >         if (fbdev_panel != NULL)
> > @@ -1958,7 +1971,7 @@ module_param_named(rotate, def_rotate, uint,
> > 0664);
> >  module_param_named(mirror, def_mirror, uint, 0664);
> >  module_param_named(manual_update, manual_update, bool, 0664);
> >  
> > -module_init(omapfb_init);
> > +late_initcall(omapfb_init);
> >  module_exit(omapfb_cleanup);
> >  
> >  MODULE_DESCRIPTION("TI OMAP framebuffer driver");
> >
> >
> > And the crash:
> >
> >
> >
> > <1>Unhandled fault: external abort on non-linefetch (0x1028) at
> > 0xd8200098
> > Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8200098
> > Internal error: : 1028 [#1]
> > Internal error: : 1028 [#1]
> > Modules linked in:Modules linked in:
> >
> > CPU: 0    Not tainted  (2.6.28-rc6-omap1-05264-g1705711-dirty #6)
> > CPU: 0    Not tainted  (2.6.28-rc6-omap1-05264-g1705711-dirty #6)
> > PC is at __irq_svc+0x34/0x80
> > PC is at __irq_svc+0x34/0x80
> > LR is at _omap2_clk_enable+0xa0/0xe0
> > LR is at _omap2_clk_enable+0xa0/0xe0
> 
> What looks to be happening is an interrupt is firing in the middle of
> your clk_enable() call, and accesses to the Interrupt controller
> registers are triggering a fault.
> 
> As a temporary workaround, could you try wrapping your clk_enable() 
> with an IRQ save/restore?  Something like:
> 
>   local_irq_save(flags);
>   clk_enable(c);
>   local_irq_restore(flags);
> 
> If this works, then we need to investigate in more detail which
> interrupt is firing, and why the INTC registers are not accessible.

No, I get the same error with irq_saves also. However, if I wrap the
whole while loop inside local_irq_save, then it doesn't crash.

So this does crash:

		while(1) {
			local_irq_save(flags);
			clk_enable(c1);
			local_irq_restore(flags);

			local_irq_save(flags);
			clk_disable(c1);
			local_irq_restore(flags);
		}

And this doesn't:

		local_irq_save(flags);
		while(1) {
			clk_enable(c1);
			clk_disable(c1);
		}

 Tomi



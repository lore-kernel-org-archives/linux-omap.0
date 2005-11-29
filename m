From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] FB support for OMAP2
Date: Mon, 28 Nov 2005 18:17:25 -0800
Message-ID: <20051129021725.GG8319@atomide.com>
References: <1129668250.5871.56.camel@mammoth.research.nokia.com>
	<4356BD5A.2040100@mvista.com>
	<1129799050.5762.6.camel@mammoth.research.nokia.com>
	<8028e5750511271548o1c5a213i@mail.gmail.com>
	<1133158321.8150.9.camel@localhost.localdomain>
	<8028e5750511272311r7fb387b2t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <8028e5750511272311r7fb387b2t@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Romain Goyet <r.goyet@gmail.com>
Cc: tony.lindgren@atomide.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Romain Goyet <r.goyet@gmail.com> [051127 23:11]:
> .
> After checking, it appeared your patch was just working great : my
> Palm's in fact crashing because of a bug in the function
> paging_init(); in arch/arm/mm/init.c.
> 
> 2005/11/28, Imre Deak <imre.deak@nokia.com>:
> > Hi,
> >
> > For me it didn't even build for PALMTE, so this is at least needed:
> >
> > diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
> > index fd5e137..5700d25 100644
> > --- a/drivers/video/omap/lcdc.c
> > +++ b/drivers/video/omap/lcdc.c
> > @@ -439,7 +439,7 @@ static void inline setup_regs(void)
> >  #ifdef CONFIG_MACH_OMAP_PALMTE
> >  /* FIXME:if (machine_is_omap_palmte()) { */
> >                 /* PalmTE uses alternate TFT setting in 8BPP mode */
> > -               l |= (tft && fbdev->panel->video_mode->bpp == 8) ? 0x810000 : 0;
> > +               l |= (is_tft && panel->bpp == 8) ? 0x810000 : 0;
> >  /*     } */
> >  #endif
> >         omap_writel(l, OMAP_LCDC_CONTROL);

Pushing this today.

Tony

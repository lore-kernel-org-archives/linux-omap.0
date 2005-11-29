From: Romain Goyet <r.goyet@gmail.com>
Subject: Re: [PATCH] FB support for OMAP2
Date: Tue, 29 Nov 2005 09:11:39 +0100
Message-ID: <8028e5750511290011l5a716c82o@mail.gmail.com>
References: <1129668250.5871.56.camel@mammoth.research.nokia.com>
	<4356BD5A.2040100@mvista.com>
	<1129799050.5762.6.camel@mammoth.research.nokia.com>
	<8028e5750511271548o1c5a213i@mail.gmail.com>
	<1133158321.8150.9.camel@localhost.localdomain>
	<8028e5750511272311r7fb387b2t@mail.gmail.com>
	<20051129021725.GG8319@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051129021725.GG8319@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,
You might push this if you want, but I'm preparing a slightly bigger
patch that will include this one. (Since even with this Palm TE
support is still broken...)

Kind regards,
Romain Goyet

2005/11/29, Tony Lindgren <tony@atomide.com>:
> * Romain Goyet <r.goyet@gmail.com> [051127 23:11]:
> > .
> > After checking, it appeared your patch was just working great : my
> > Palm's in fact crashing because of a bug in the function
> > paging_init(); in arch/arm/mm/init.c.
> >
> > 2005/11/28, Imre Deak <imre.deak@nokia.com>:
> > > Hi,
> > >
> > > For me it didn't even build for PALMTE, so this is at least needed:
> > >
> > > diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
> > > index fd5e137..5700d25 100644
> > > --- a/drivers/video/omap/lcdc.c
> > > +++ b/drivers/video/omap/lcdc.c
> > > @@ -439,7 +439,7 @@ static void inline setup_regs(void)
> > >  #ifdef CONFIG_MACH_OMAP_PALMTE
> > >  /* FIXME:if (machine_is_omap_palmte()) { */
> > >                 /* PalmTE uses alternate TFT setting in 8BPP mode */
> > > -               l |=3D (tft && fbdev->panel->video_mode->bpp =3D=3D 8=
) ? 0x810000 : 0;
> > > +               l |=3D (is_tft && panel->bpp =3D=3D 8) ? 0x810000 : 0=
;
> > >  /*     } */
> > >  #endif
> > >         omap_writel(l, OMAP_LCDC_CONTROL);
>
> Pushing this today.
>
> Tony
>

From: Romain Goyet <r.goyet@gmail.com>
Subject: Re: [PATCH] FB support for OMAP2
Date: Mon, 28 Nov 2005 08:11:24 +0100
Message-ID: <8028e5750511272311r7fb387b2t@mail.gmail.com>
References: <1129668250.5871.56.camel@mammoth.research.nokia.com>
	<4356BD5A.2040100@mvista.com>
	<1129799050.5762.6.camel@mammoth.research.nokia.com>
	<8028e5750511271548o1c5a213i@mail.gmail.com>
	<1133158321.8150.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1133158321.8150.9.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: tony.lindgren@atomide.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Imre,
Actually it didn't for me either,
I'm preparing a big patch to have my PalmTE back to life again :-) I
had already patched this line (but thanks anyway ;-)), as well as a
few others.
After checking, it appeared your patch was just working great : my
Palm's in fact crashing because of a bug in the function
paging_init(); in arch/arm/mm/init.c. I haven't had time to
investigate any further, but debugging this looks a bit hard to me
(since I'm working without any output - I just have a way to figure
out where the kernel crashes using a dumb "while(1){}"). If you ever
have any suggestion.... BTW, I'm having a 2.6.13-rc6 snapshot that's
working just well. So it has to be a recent patch that messed things
up...

Thanks again,
Romain Goyet

2005/11/28, Imre Deak <imre.deak@nokia.com>:
> Hi,
>
> For me it didn't even build for PALMTE, so this is at least needed:
>
> diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
> index fd5e137..5700d25 100644
> --- a/drivers/video/omap/lcdc.c
> +++ b/drivers/video/omap/lcdc.c
> @@ -439,7 +439,7 @@ static void inline setup_regs(void)
>  #ifdef CONFIG_MACH_OMAP_PALMTE
>  /* FIXME:if (machine_is_omap_palmte()) { */
>                 /* PalmTE uses alternate TFT setting in 8BPP mode */
> -               l |=3D (tft && fbdev->panel->video_mode->bpp =3D=3D 8) ? =
0x810000 : 0;
> +               l |=3D (is_tft && panel->bpp =3D=3D 8) ? 0x810000 : 0;
>  /*     } */
>  #endif
>         omap_writel(l, OMAP_LCDC_CONTROL);
>
>
> Let me know if you still have problems.
>
> --Imre
>
> On Mon, 2005-11-28 at 00:48 +0100, ext Romain Goyet wrote:
> > Hi guys,
> > I know I'm probably a bit late, but I hadn't much time to work on my
> > Palm lately, but it looks like this patch actually broke support of
> > the LCD on my Palm. The big issue is that we _need_ the LCD to debug
> > anything, since it's virtually our only output :-S
> >
> > It looks like it has to do with this :
> >
> > - pixel clock divider calculation based on the panel->pixel_clock
> >  instead of the wired panel->pcd
> >
> > So if you have any suggestion about how I could get my LCD back, I'd
> > be very glad :-)
> >
> > Thanks again,
> > Romain Goyet
> >
> > 2005/10/20, Imre Deak <imre.deak@nokia.com>:
> > > On Wed, 2005-10-19 at 14:40 -0700, ext Kevin Hilman wrote:
> > > > Imre,
> > > >
> > > > Tested using dirctFB on 730/P2 and it works fine.
> > >
> > > Great. Hope it won't break the other platforms either.
> > >
> > > > Here's a minor fix so it builds when I2C isn't enabled (default for
> > > > 730/P2 defconfig).  I'll push if it's OK with you.
> > >
> > > It's ok.
> > >
> > > --Imre
> > >
> > > >
> > > > Kevin
> > > >
> > > >
> > > >
> > > > diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devi=
ces.c
> > > > --- a/arch/arm/plat-omap/devices.c
> > > > +++ b/arch/arm/plat-omap/devices.c
> > > > @@ -93,6 +93,8 @@ static void omap_init_i2c(void)
> > > >       (void) platform_device_register(&omap_i2c_device1);
> > > >  }
> > > >
> > > > +#else
> > > > +static inline void omap_init_i2c(void) {}
> > > >  #endif
> > > >
> > > >  /*----------------------------------------------------------------=
---------*/
> > >
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >
>
>

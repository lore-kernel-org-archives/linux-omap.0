From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 2420 sDMA address mapping typo
Date: Tue, 15 Mar 2011 16:24:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103151529140.4431@utopia.booyaka.com>
References: <E8606C3FD412994585953171ED63A9340217F287D9@dnce01.ent.ti.com> <4D7FCCD7.7050604@ti.com> <alpine.DEB.2.00.1103151520150.4431@utopia.booyaka.com> <4D7FD97C.2020604@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2088388036-1300227861=:4431"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36080 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1COWYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 18:24:22 -0400
In-Reply-To: <4D7FD97C.2020604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Fillinger, Michael" <m-fillinger@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2088388036-1300227861=:4431
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 15 Mar 2011, Cousson, Benoit wrote:

> Salut Paul,
>=20
> You are faster than me :-)
>=20
> It appears that OMAP4 is wrong as well :-(=20
> Yeah I know that's a shame...
>=20
> Here is my version. Fell free to update yours, with my s-o-b.

Thanks, I'll just use yours instead.

>=20
> Thanks
> Benoit
>=20
>=20
> ---
> >From efab4432d5f8a98fe2a21704b7dd3469116385ac Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Tue, 15 Mar 2011 21:45:27 +0100
> Subject: [PATCH] OMAP2+: hwmod data: Fix wrong dma_system end address
>=20
> OMAP2420, 2430 and 3xxx were using the OMAP4 end address
> that unfortunately is not located at the same base address.
> Moreover the OMAP4 size was set to 256 instead of 4096.
>=20
> Change all .pa_end to set them to .pa_start + 0xfff
>=20
> Reported-by: Michael Fillinger <m-fillinger@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2420_data.c
> index 6282346..0a76f2f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1783,7 +1783,7 @@ static struct omap_hwmod_irq_info omap2420_dma_syst=
em_irqs[] =3D {
>  static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
>  =09{
>  =09=09.pa_start=09=3D 0x48056000,
> -=09=09.pa_end=09=09=3D 0x4a0560ff,
> +=09=09.pa_end=09=09=3D 0x48056fff,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT
>  =09},
>  };
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2430_data.c
> index 0fdf2ca..2a9b875 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1915,7 +1915,7 @@ static struct omap_hwmod_irq_info omap2430_dma_syst=
em_irqs[] =3D {
>  static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] =3D {
>  =09{
>  =09=09.pa_start=09=3D 0x48056000,
> -=09=09.pa_end=09=09=3D 0x4a0560ff,
> +=09=09.pa_end=09=09=3D 0x48056fff,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT
>  =09},
>  };
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index c819c30..a82d7ef 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2383,7 +2383,7 @@ static struct omap_hwmod_irq_info omap3xxx_dma_syst=
em_irqs[] =3D {
>  static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] =3D {
>  =09{
>  =09=09.pa_start=09=3D 0x48056000,
> -=09=09.pa_end=09=09=3D 0x4a0560ff,
> +=09=09.pa_end=09=09=3D 0x48056fff,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT
>  =09},
>  };
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index 3e88dd3..abc548a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -885,7 +885,7 @@ static struct omap_hwmod_ocp_if *omap44xx_dma_system_=
masters[] =3D {
>  static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] =3D {
>  =09{
>  =09=09.pa_start=09=3D 0x4a056000,
> -=09=09.pa_end=09=09=3D 0x4a0560ff,
> +=09=09.pa_end=09=09=3D 0x4a056fff,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT
>  =09},
>  };
> --=20
> 1.7.0.4
>=20
>=20
>=20
> On 3/15/2011 10:21 PM, Paul Walmsley wrote:
> > Hi Beno=EEt, Michael,
> >=20
> > On Tue, 15 Mar 2011, Cousson, Benoit wrote:
> >=20
> >> On 3/15/2011 5:44 PM, Fillinger, Michael wrote:
> >>> Hi,
> >>>
> >>> There is a small issue introduced in 2.6.38 on the address space of s=
DMA for
> >>> OMAP2420, which seems to be a mix of OMAP2&   newer OMAP addresses :
> >>>
> >>> arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >>>
> >>> static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
> >>>           {
> >>>                    .pa_start   =3D 0x48056000,
> >>>                    .pa_end     =3D 0x4a0560ff,
> >>>                    .flags      =3D ADDR_TYPE_RT
> >>>           },
> >>> };
> >>>
> >>> pa_end should be 0x480560ff unless I'm mistaken.
> >>
> >> Good catch, but the size is almost 4k to store all the channels.
> >>
> >> The quick and dirty patch is:
> >> -                   .pa_end     =3D 0x4a0560ff,
> >> +                   .pa_end     =3D 0x48056fff,
> >=20
> > Here's a patch to fix this for the -rc series.  Beno=EEt, care to reply=
 with
> > a Signed-off-by: or Acked-by: ?
> >=20
> >=20
> > - Paul
> >=20
> > From: Paul Walmsley<paul@pwsan.com>
> > Date: Tue, 15 Mar 2011 14:13:11 -0600
> > Subject: [PATCH] OMAP2/3: hwmod data: sDMA IP block has incorrect end a=
ddress
> >=20
> > Commits 745685df95961ebbf0bcafcf28f31217a75070ae ("OMAP2420: hwmod
> > data: add system DMA"), 82cbd1aebafd126f40a8ed0725a6feb6ed710576
> > ("OMAP2430: hwmod data: add system DMA"), and
> > 01438ab6a49b63ef02b2eb44b63345a09792f982 ("OMAP3: hwmod data: add
> > system DMA") all have an incorrect end address for the SDMA IP block.
> >=20
> > Thanks to Michael Fillinger<m-fillinger@ti.com>  for reporting this.
> > Thanks to Beno=EEt Cousson<b-cousson@ti.com>  for suggesting an appropr=
iate
> > correction.
> >=20
> > Cc: "G, Manjunath Kondaiah"<manjugk@ti.com>
> > Reported-by: Michael Fillinger<m-fillinger@ti.com>
> > Cc: Beno=EEt Cousson<b-cousson@ti.com>
> > Signed-off-by: Paul Walmsley<paul@pwsan.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
> >   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
> >   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
> > index f1776d4..1760d11 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > @@ -1789,7 +1789,7 @@ static struct omap_hwmod_irq_info omap2420_dma_sy=
stem_irqs[] =3D {
> >   static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
> >   =09{
> >   =09=09.pa_start=09=3D 0x48056000,
> > -=09=09.pa_end=09=09=3D 0x4a0560ff,
> > +=09=09.pa_end=09=09=3D 0x48056fff,
> >   =09=09.flags=09=09=3D ADDR_TYPE_RT
> >   =09},
> >   };
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
> > index 62ff097..4a7ea12 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > @@ -1921,7 +1921,7 @@ static struct omap_hwmod_irq_info omap2430_dma_sy=
stem_irqs[] =3D {
> >   static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] =3D {
> >   =09{
> >   =09=09.pa_start=09=3D 0x48056000,
> > -=09=09.pa_end=09=09=3D 0x4a0560ff,
> > +=09=09.pa_end=09=09=3D 0x48056fff,
> >   =09=09.flags=09=09=3D ADDR_TYPE_RT
> >   =09},
> >   };
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
> > index 41e53c2..0da858c 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > @@ -2396,7 +2396,7 @@ static struct omap_hwmod_irq_info omap3xxx_dma_sy=
stem_irqs[] =3D {
> >   static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] =3D {
> >   =09{
> >   =09=09.pa_start=09=3D 0x48056000,
> > -=09=09.pa_end=09=09=3D 0x4a0560ff,
> > +=09=09.pa_end=09=09=3D 0x48056fff,
> >   =09=09.flags=09=09=3D ADDR_TYPE_RT
> >   =09},
> >   };
>=20


- Paul
--155748971-2088388036-1300227861=:4431--

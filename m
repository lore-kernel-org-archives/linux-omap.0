From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/30] ARM: omap: add missing __devexit_p() annotations
Date: Mon, 3 Oct 2011 10:48:48 -0700
Message-ID: <20111003174844.GQ6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-5-git-send-email-arnd@arndb.de>
 <CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFULf_wevZxWW1RW+r-18R_8=ry2kD6_i5L9NfPd9t8afm5Cog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bjarne Steinsbo <bsteinsbo@gmail.com> [111002 08:22]:
> Arnd,
>=20
> Ref http://www.spinics.net/lists/linux-omap/msg57274.html
>=20
> Don't get me wrong.  This is not about you "stealing" my patch, or
> anything like that.  But look also at thread starting at
> http://www.spinics.net/lists/linux-omap/msg57667.html Also a patch
> that I have posted previously.  Something is not right with the
> workflow when bugs are identified, patches are submitted, then
> ignored, only for someone else to fix the same bug.  Enough said.

Arnd, I suggest using Bjarne's earlier patch here:

Acked-by: Tony Lindgren <tony@atomide.com>
=20

> On Sun, Oct 2, 2011 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Drivers that refer to a __devexit function in an operations
> > structure need to annotate that pointer with __devexit_p so
> > replace it with a NULL pointer when the section gets discarded.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > =C2=A0arch/arm/mach-omap2/smartreflex.c | =C2=A0 =C2=A02 +-
> > =C2=A0arch/arm/plat-omap/dma.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A02 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap=
2/smartreflex.c
> > index 34c01a7..67bc6ce 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -1002,7 +1002,7 @@ static int __devexit omap_sr_remove(struct pl=
atform_device *pdev)
> > =C2=A0}
> >
> > =C2=A0static struct platform_driver smartreflex_driver =3D {
> > - =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap=
_sr_remove,
> > + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __de=
vexit_p(omap_sr_remove),
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0=
 =3D "smartreflex",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c22217c..f7150ba 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -2105,7 +2105,7 @@ static int __devexit omap_system_dma_remove(s=
truct platform_device *pdev)
> >
> > =C2=A0static struct platform_driver omap_system_dma_driver =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D omap_system_dma_probe,
> > - =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap=
_system_dma_remove,
> > + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __de=
vexit_p(omap_system_dma_remove),
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0=
 =3D "omap_dma_system"
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > --
> > 1.7.5.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

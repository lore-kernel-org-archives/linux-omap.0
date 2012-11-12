From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH linux-next] ARM: OMAP2: Fix compillation error in
 cm_common
Date: Mon, 12 Nov 2012 09:38:47 -0800
Message-ID: <20121112173847.GJ6801@atomide.com>
References: <1352733428-27889-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.00.1211121625150.6043@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211121625150.6043@utopia.booyaka.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121112 08:27]:
> Hi
>=20
> On Mon, 12 Nov 2012, Peter Ujfalusi wrote:
>=20
> > Fixes the following error:
> >   CC      arch/arm/mach-omap2/cm_common.o
> > arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_register=E2=
=80=99:
> > arch/arm/mach-omap2/cm_common.c:42:11: error: =E2=80=98EINVAL=E2=80=
=99 undeclared (first use in this function)
> > arch/arm/mach-omap2/cm_common.c:42:11: note: each undeclared identi=
fier is reported only once for each function it appears in
> > arch/arm/mach-omap2/cm_common.c:45:11: error: =E2=80=98EEXIST=E2=80=
=99 undeclared (first use in this function)
> > arch/arm/mach-omap2/cm_common.c: In function =E2=80=98cm_unregister=
=E2=80=99:
> > arch/arm/mach-omap2/cm_common.c:66:11: error: =E2=80=98EINVAL=E2=80=
=99 undeclared (first use in this function)
> > make[1]: *** [arch/arm/mach-omap2/cm_common.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >=20
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >=20
> > Hi,
> >=20
> > with today's linux-next the kernel build failed with the abive erro=
r for OMAP.
> >=20
> > Regards,
> > Peter
> >=20
> >  arch/arm/mach-omap2/cm_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/=
cm_common.c
> > index 3246cef..3fafc27 100644
> > --- a/arch/arm/mach-omap2/cm_common.c
> > +++ b/arch/arm/mach-omap2/cm_common.c
> > @@ -13,6 +13,7 @@
> > =20
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > +#include <linux/errno.h>
> > =20
> >  #include "cm2xxx.h"
> >  #include "cm3xxx.h"
> > --=20
> > 1.8.0
>=20
> Acked-by: Paul Walmsley <paul@pwsan.com>
>=20
> Thanks Peter.
>=20
> Tony, how would you like to handle this one?

I can queue it.

Regards,

Tony

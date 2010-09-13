From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/7] omap4: l2x0: Fix init parameter for ES2.0
Date: Mon, 13 Sep 2010 22:07:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17F688@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTik3wD+A-EC0Bs79CT53=AP8nC0Bxg3FDxm7GO16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab0IMQhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 12:37:21 -0400
In-Reply-To: <AANLkTik3wD+A-EC0Bs79CT53=AP8nC0Bxg3FDxm7GO16@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Gadiyar, Anand
> Sent: Monday, September 13, 2010 9:58 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 3/7] omap4: l2x0: Fix init parameter for ES2.0
>=20
> On Thu, Sep 9, 2010 at 4:53 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > On ES2.0 the L2 cache init parameter ineeds to be changed to take
> > care of cache size. The cache size is 1MB on ES2.0 vs 512KB on ES1.=
0
> >
> > This patch fixes the init parameter to update the same using
> > dynamic cpu version check
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/omap4-common.c | =A0 =A05 ++++-
> > =A01 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-
> omap2/omap4-common.c
> > index 13dc979..2b32229 100644
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -64,7 +64,10 @@ static int __init omap_l2_cache_init(void)
> > =A0 =A0 =A0 =A0 * 32KB way size, 16-way associativity,
> > =A0 =A0 =A0 =A0 * parity disabled
> > =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
> > + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP4430_REV_ES2_0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e070000, 0=
xc0000fff);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2x0_init(l2cache_base, 0x0e050000, 0=
xc0000fff);
>=20
>=20
> It's probably better to invert this check - you need 512 kB on ES1
> alone, but ES2 and newer will need more. You need the exception only
> for the ES1 case.
>=20
> (else you will end up patching this section again with newer revision=
s as
> well).
>=20
Good point
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

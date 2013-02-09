From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
Date: Sat, 9 Feb 2013 15:14:33 -0300
Message-ID: <20130209181432.GD32349@localhost>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165335.GA13338@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36987 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459Ab3BISO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 13:14:27 -0500
Content-Disposition: inline
In-Reply-To: <20130209165335.GA13338@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

Hi Felipe,

On Sat, Feb 09, 2013 at 06:53:35PM +0200, Felipe Balbi wrote:
> On Sat, Feb 09, 2013 at 01:38:12PM -0300, Ezequiel Garcia wrote:
> > Fix gpmc_cs_reserved() so it returns 0 if the chip select
> > is available (not reserved) or an error otherwise.
> > This allows to use the return value directly and return a proper er=
ror code.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.=
c
> > index bd3bc93..604c1eb 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -452,12 +452,16 @@ static int gpmc_cs_set_reserved(int cs, int r=
eserved)
> >  	return 0;
> >  }
> > =20
> > +/* Returns 0 if CS is available (not reseverd) or an error otherwi=
se */
>=20
> s/reseverd/reserved/
>=20

Indeed.

> >  static int gpmc_cs_reserved(int cs)
> >  {
> >  	if (cs > GPMC_CS_NUM)
> >  		return -ENODEV;
> > =20
> > -	return gpmc_cs_map & (1 << cs);
> > +	if (gpmc_cs_map & (1 << cs))
> > +		return -EBUSY;
> > +
> > +	return 0;
>=20
> you could use a ternary operator here:
>=20
> bit =3D gpmc_cs_map & (1 << cs);
>=20
> return bit ? -EBUSY : 0;
>=20
> But to be frank, I'm not sure this makes that much sense, I'd expect
> gpmc_cs_reserved() to return 0 or 1 depending on the state (just as i=
t
> was before). The name of the method asks for a boolean return value.
>=20

Well, we can change the return value to a boolean.

However, note that the function 'as it was before' was somewhat inconsi=
stent:
gpmc_cs_reserved returned -ENODEV if the given 'cs' was out of range an=
d
a non-negative integer otherwise, 0 if the cs is available and positive
integer otherwise.

So, what I'm doing here is fixing this by returning an appropriate erro=
r
condition or 0 if the CS is available.

If we change it to return a boolean, we won't be able to distinguish
between EBUSY and ENODEV.

Let me know what you prefer and I'll fix it on v2.

Thanks for the review,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

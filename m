From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Thu, 23 Jul 2015 10:08:44 -0500
Message-ID: <20150723150844.GD21984@saruman.tx.rr.com>
References: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
 <20150723145532.GC21984@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150723145532.GC21984@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nikhil Badola <nikhil.badola@freescale.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Thu, Jul 23, 2015 at 09:55:32AM -0500, Felipe Balbi wrote:
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 0447788..b7a5119 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -124,6 +124,7 @@
> >  #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
> > =20
> >  #define DWC3_GHWPARAMS8		0xc600
> > +#define DWC3_GFLADJ		0xc630
> > =20
> >  /* Device Registers */
> >  #define DWC3_DCFG		0xc700
> > @@ -234,6 +235,10 @@
> >  /* Global HWPARAMS6 Register */
> >  #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
> > =20
> > +/* Global Frame Length Adjustment Register */
> > +#define GFLADJ_30MHZ_REG_SEL		(1 << 7)
>=20
> always prepend with DWC3_ like *all* other macros in this file.
>=20
> Also, match docs to ease grepping. This should be called
> DWC3_GFLADJ_30MHZ_SDBND_SEL

yet another problem is that this register doesn't exist in *all*
versions of DWC3. It was introduced in version 2.50a so the branch I
typed above needs one extra check, and since it's getting so large, it
deserves be factored out into its own function.

static int dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
{
	u32 reg;
	u32 dft;

	if (dwc->revision <=3D DWC3_REVISION_250A)
		return 0;

	if (fladj =3D=3D 0)
		return 0;

	reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
	dft =3D reg & 0x3f; /* needs a mask macro */

	if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D fladj,
		"requested value same as default, ignoring\n")) {
		reg &=3D ~0x3f; /* needs a mask macro */
		reg |=3D DWC3_GFLADJ_30MHZ_SDBND_SEL |
			DWC3_GFLADJ_30MHZ(fladj_value);

		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
	}
}

you really *MUST* check this sort of this out when writing patches. It's
not only about *your* SoC. You gotta remember we have a ton of different
users and those a prone to major grumpyness should a completely
unrelated patch break their use case.

You have access to the IP's documentation, and that contains the entire
history of the IP itself, so it's easy to figure all of this out with a
simple search in the documentation.

One extra detail is that you were very careless when writing to the
GFLADJ register too. You simply wrote your 30MHz sideband value,
potentially clearing other bits which shouldn't be touched. That alone
can add regressions.

When resending, make sure all 3 patches reach linux-usb. I still can't
find patch 3/3.

--=20
balbi

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsQN8AAoJEIaOsuA1yqREiI4QALRJmIxuDmlVzcBSliZONk5u
Gp6JQXX9JvaV8eo8JL93PZMRBcWG9ZZQq1V1xGCQpJa5zFNbHM1LjER1G3ouczfI
mjLAZNKjuKPKyisdtrw0W2rxMOFdnB9IxYFnfFEdihIwTmPp9BDLcNpM+0jweJOV
Gi84XTeQgGFXKtO0xkZ0/sALKDJi4Q80Eo+aTGx+rc719gAg9zRPwq98R3JS3dlP
slECLIb81O/JcGy57SZUErjzvJ2f7VpEhZbGK3G5OS1x1ceSiRIP/qYVdtqz0XAL
6jjts4lQwbbcs0rdbVTA95xSfSExGce7n1QHwOx1uMQ2QrbLSM8cRWK6fEXsaw0w
8EmBTN48FlBtY9QAo9RDwGiELY9aLXJARGq3R9sqOUluoD91qmphgWRuaaM210bZ
wHoUjy/LBd/KdaY24UAcb34EGq6rX/Zje27KFliTSbpsQyJHGOFWkQxdO6Hn/tzF
XuNamBvnRnyA/y8MYzVIoNOK8jE1cGJ/+LDfWAT63DO/noy6/JYJesCj6BDw5q9f
PV/ySqsiqIduEnULZzpiZ1xnE2T2iVGwVaDXd50dLdWo8Bkyj+HqHnVq/nyigIln
cRbMisxIXn+ul6E9Q87KR0sPTTikdeB1KAHZshL/T4PmkfY05Wtwo7A8dmmaRgOC
Swb1gomxBYYUQ88EB/XK
=U4Pq
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--

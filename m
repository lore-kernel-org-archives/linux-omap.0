From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: dts: add support for AM437x StarterKit
Date: Tue, 17 Jun 2014 20:30:05 -0500
Message-ID: <20140618013004.GA16868@saruman.home>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-3-git-send-email-balbi@ti.com>
 <20140613162334.GI8319@saruman.home>
 <20140613163118.GJ8319@saruman.home>
 <20140616072720.GX17845@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140616072720.GX17845-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Josh Elliot <jelliott-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 16, 2014 at 12:27:21AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140613 09:33]:
> > On Fri, Jun 13, 2014 at 11:23:34AM -0500, Felipe Balbi wrote:
> > > On Fri, Jun 13, 2014 at 11:15:47AM -0500, Felipe Balbi wrote:
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > > > @@ -0,0 +1,539 @@
> > > > +/*
> > > > + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.=
ti.com/
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or m=
odify
> > > > + * it under the terms of the GNU General Public License version 2 =
as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +/* AM437x SK EVM */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "am4372.dtsi"
> > > > +#include <dt-bindings/pinctrl/am43xx.h>
> > > > +#include <dt-bindings/pwm/pwm.h>
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/input.h>
> > > > +
> > > > +/ {
> > > > +	model =3D "TI AM437x SK EVM";
> > > > +	compatible =3D "ti,am437x-sk-evm","ti,am4372","ti,am43";
> > > > +
> > > > +	aliases {
> > > > +		display0 =3D &lcd0;
> > > > +	};
> > > > +
> > > > +	vmmcsd_fixed: fixedregulator-sd {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "vmmcsd_fixed";
> > > > +		regulator-min-microvolt =3D <3300000>;
> > > > +		regulator-max-microvolt =3D <3300000>;
> > > > +		enable-active-high;
> > > > +	};
> > > > +
> > > > +	v33_fixed: fixedregulator-v33 {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "v33_fixed";
> > > > +		regulator-min-microvolt =3D <3300000>;
> > > > +		regulator-max-microvolt =3D <3300000>;
> > > > +		enable-active-high;
> > > > +	};
> > > > +
> > > > +	v18_fixed: fixedregulator-v18 {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "v18_fixed";
> > > > +		regulator-min-microvolt =3D <1800000>;
> > > > +		regulator-max-microvolt =3D <1800000>;
> > > > +		enable-active-high;
> > > > +	};
>=20
> Chances are these are not fixed regulators.. Typically the these
> come from external regulators controlled by GPIO pins. Sounds
> like you have the schematics so it would be best to verify it.
> If they come from something not yet supported, let's at least
> document it with comments.

sure, let me just make sure of it.

> Also looks like all the am43xx boards are using vmmcsd_fixed,
> might be worth checking those as well while at it.

I'll need help testing, but sure thing.

--=20
balbi

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToOucAAoJEIaOsuA1yqRE28wP/A0XxCLETw2Krn8BZNr6u1du
Vn3Pk37/u0FTs28UQd0pvO8aKF8EEO0DtIdd4iJE4i0TF3gZcyu6lh1iDM3MjOXL
a+3GXdODd1JC9rQm6E1LyWS+Tq/czDvbGYEoWlaTJiZF0ucW52PjfRusHbHG5aq4
+2riU/bxo8Xvdnfp1RKoA3lz62kdkzLq7vztf8j9UbVcyu4LKysKP6B7Uq//Sv/R
pwOZwiAIC9ikli/zkJNwuSvDHxQbISIFNJ+wNsUbEtZLRwDqXWt+RbmsBiIpKulN
oXzHAzgeNUF/zxiue/JyoduJj/Gey0vRUeBwipmCSdaIe3gCYMVvuDM3RgxGTzsP
/S3rDP3gp1oMbsaJdV+oCsPFoipclzsgYUNML2mTDBR/ffu6S1AsE8j/33Kzngvo
bwclCGHgcPLIbGICLwHei+XpPAuZvL5pJmd1ja8sL0JGrkQ1f4xzwkg+vuTD2ym6
BZEhGmB7XEkOPHJQgw+wVxveEi5qK05Df9kAwto1uPJHLV8UxocZGgUvkdFf7Qp4
XJI3wiiUQfWY3EXkw4soIROy1LU9s6IAHe6jwtCiBwfGQMe72JObK1Ljz3ftVLFY
fcCAPWnXwlZQHiORFImurVgtBQyUKGV4KmvuN04u2xsIF0t8UT9nklBH4sumlEqW
GVzWmBpcR1Z15EFbbCSg
=SETu
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

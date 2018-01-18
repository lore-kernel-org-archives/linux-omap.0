From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] Nokia N9: add support for up/down keys in the dts
Date: Thu, 18 Jan 2018 23:03:48 +0100
Message-ID: <20180118220348.GD17196@amd>
References: <20180102125948.GA20051@amd>
 <20180102194236.ahrhkvnefre2l6gf@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180102194236.ahrhkvnefre2l6gf-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-02 20:42:36, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jan 02, 2018 at 01:59:48PM +0100, Pavel Machek wrote:
> >=20
> > This adds support for volume up/down keys in the dts.
> >=20
> > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Tony, ping? Can I get you to apply this one?

[PATCHv2] nokia N9: Add support for magnetometer

should be good to go, too...
									Pavel
								=09

> > diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n=
9.dts
> > index 39e35f8..57a6679 100644
> > --- a/arch/arm/boot/dts/omap3-n9.dts
> > +++ b/arch/arm/boot/dts/omap3-n9.dts
> > @@ -11,9 +11,10 @@
> >  /dts-v1/;
> > =20
> >  #include "omap3-n950-n9.dtsi"
> > +#include <dt-bindings/input/input.h>
> > =20
> >  / {
> >  	model =3D "Nokia N9";
> >  	compatible =3D "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
> >  };
> > =20
> > @@ -72,3 +133,9 @@
> >  	st,max-limit-y =3D <46>;
> >  	st,max-limit-z =3D <46>;
> >  };
> > +
> > +&twl_keypad {
> > +	linux,keymap =3D < MATRIX_KEY(6, 8, KEY_VOLUMEUP)
> > +			 MATRIX_KEY(7, 8, KEY_VOLUMEDOWN)
> > +			 >;
> > +};
> >=20
> >=20
> > --=20
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
>=20
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlphGcQACgkQMOfwapXb+vLmFwCfQPDusoIGZ7kx83h9RXdprszs
hQMAoKFR8TnZwJOgF2T1dGuaDLKjsAtp
=QyHD
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

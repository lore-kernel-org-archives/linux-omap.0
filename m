From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Lithium battery protection was Re: [PATCH v4.14] Add support for
 bq27521 battery monitor
Date: Wed, 13 Dec 2017 09:39:46 +0100
Message-ID: <20171213083946.GA26605@amd>
References: <20171109210615.GA27638@amd>
 <20171110103937.GA29900@amd>
 <20171201230649.GA27533@amd>
 <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
 <20171208170610.gbmlsgm7xzh2zpyn@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171208170610.gbmlsgm7xzh2zpyn@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> This adds basic support for BQ27521 battery monitor, used in Nokia N9
> > >> and N950. In particular, battery voltage is important to be able to
> > >> tell when the battery is almost empty. Emptying battery on N950 is
> > >> pretty painful, as flasher needs to be used to recover phone in such
> > >> case.
> > >=20
> > > Sebastian, ping? This one should not be too controversial.
> >
> > Acked-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
>=20
> Thanks, queued, I dropped the spurious change in twl.h and added the
> dt-binding from the previous patch version, that was lost somehow.

Thanks!

> > > If you could also apply the "shut down when battery is low", that
> > > would be nice.
>=20
> I only have one with values specific to N900 hardcoded in the
> driver. That one can't be applied for obvious reasons.

Well... the values are not really N900-specific. They should work well
on anything with lithium battery, because they basically depend only
on battery chemistry.

I guess I can simplify patch to work with battery voltage only --
that's what hardware battery protection does -- and make shutdown
voltage configurable ...?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlow51IACgkQMOfwapXb+vI65gCfVHpJZZDo/CT/RcbN9geCaYOp
ISgAnRm8ZFgsCjIjrJT4sd4hTE78eMCA
=LGBd
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

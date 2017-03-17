From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Fri, 17 Mar 2017 12:48:40 +0100
Message-ID: <20170317114839.GA4771@amd>
References: <20170302010900.28532-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170302010900.28532-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The mounting-matrix for the sensors and the touchscreen's=20
> rotation assume, that the phone's default rotation is vertical.
> I think that's sensible, because
>=20
>  * Android on the phone uses this as default rotation
>    (like almost? all other phones)
>  * volume buttons make sense (in horizontal position one
>    would expect, that left button means lower volume. I
>    know at least Maemo swaps them)
>=20
> That should cover all mainline drivers.

Actually, I'd use orientation with keyboard open (horizontal) -- as
that's how the console will be orientated (right?) and how the linux
will be most useful...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljLzRcACgkQMOfwapXb+vLx8wCdGxc+WakhwOfMsTjzF4+2FTrY
K5YAn2tOSN8Eq13DuTy0hZBph/qup4AJ
=YLk/
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

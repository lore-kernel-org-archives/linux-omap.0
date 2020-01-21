From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: motorola-cpcap-mapphone: Configure calibration
 interrupt
Date: Tue, 21 Jan 2020 10:16:49 +0100
Message-ID: <20200121091649.GA6934@amd>
References: <20200119194501.17125-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200119194501.17125-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-01-19 11:45:01, Tony Lindgren wrote:
> We added coulomb counter calibration support With commit 0cb90f071f73
> ("power: supply: cpcap-battery: Add basic coulomb counter calibrate
> support"), but we also need to configure the related interrupt.
>=20
> Without the interrupt calibration happens based on a timeout after two
> seconds, with the interrupt the calibration just gets done a bit faster.
>=20
> Cc: Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>

Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

Not for stable.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4mwYEACgkQMOfwapXb+vKqOgCgvto+aTKjcR8Gywm33f1WWaJ7
p0QAoJuwuy2F8RuJIOhzUXq9BFuWSZqZ
=Qn6E
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

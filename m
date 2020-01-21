From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Enable hdq for droid4 ds250x
 1-wire battery nvmem
Date: Tue, 21 Jan 2020 10:17:17 +0100
Message-ID: <20200121091717.GB6934@amd>
References: <20200119195659.18273-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200119195659.18273-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-01-19 11:56:59, Tony Lindgren wrote:
> With "[PATCHv3] w1: omap-hdq: Simplify driver with PM runtime autosuspend"
> we can read the droid4 battery information over 1-wire with this patch
> with something like:
>=20
> # modprobe omap_hdq
> # hd /sys/bus/w1/devices/89-*/89-*/nvmem
> ...
>=20
> Unfortunately the format of the battery data seems to be Motorola specific
> and is currently unusable for battery charger unless somebody figures out
> what it means.
>=20
> Note that currently keeping omap_hdq module loaded will cause extra power
> consumption as it seems to scan devices periodically.
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

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4mwZ0ACgkQMOfwapXb+vJ8egCfc2gRU+lYJZzSLf95Se8s4H5n
clkAoKfl7tnelxQQqiCtAsEFfmIAgowj
=d6KS
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

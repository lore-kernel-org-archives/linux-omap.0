From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Sat, 31 Mar 2018 02:40:30 +0200
Message-ID: <20180331004030.2kvdhlgynwmeiuib@earth.universe>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180327212156.GA10834@amd>
 <20180330121959.uxx6kcl7v5w777vq@earth.universe>
 <20180330211729.GA3389@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3kes3mtjjbjul6e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330211729.GA3389@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--p3kes3mtjjbjul6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 30, 2018 at 11:17:29PM +0200, Pavel Machek wrote:
> On Fri 2018-03-30 14:19:59, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Mar 27, 2018 at 11:21:56PM +0200, Pavel Machek wrote:
> > > Also, if you know how to get information from light sensor, that would
> > > be nice.
> >=20
> > You need CONFIG_SENSORS_ISL29028. Once the driver is probed:
> >=20
> > $ cat /sys/bus/iio/devices/iio\:device1/name
> > isl29030
> > $ cat /sys/bus/iio/devices/iio\:device1/in_illuminance_input
> > 19
>=20
> Thanks, that works.
>=20
> I was also able to get accelerometers to work, but they are extremely
> slow to read (6 seconds for all 3 axis). Interesting, but probably not
> too important for now.

IIRC this is related to runtime PM. It should not be a problem if
you use libiio.

-- Sebastian

--p3kes3mtjjbjul6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq+2PkACgkQ2O7X88g7
+pqpAQ/9GkUg3mt5twNhoz2iuG1gEvzhfi4Aq3U3nnanGDpvtgyTwApjGThRfqD8
zJi+bV8q5CGJXyxPDa7IJ4lSM83ugdRnBztuexrN3RzyJzM3SpE37Fd1K+xyby8o
alVURP+uQyJCHSzBZUWzTxtDaI5xGfySgrM2aB2y1dcE5uaM2aviuJxElWP4Rxto
UysRb49RXSKq/nTTLROiKtWE8Z/7avR5HEjyJe+Wa0EqiLmbFiBwRne0fy4qy+SZ
g2VhSxPUIY8iDLZZ5Qh0ZvFVTG4JTMm9YrTREzzHfTQY2/3f8CEZYSqA4ghpeBkB
mZN4HXD+zBF5XOr2HKkSoZgA0pmupWwlQj9suK0T6fEBECmRj29fLO2Ks1AVFZoT
iivQaqaiE8ft7sbrJXlcPIcF38YS8pksN2lHsipZun0aQiHTXi4se6To0wHhCKy8
zREDzd6t4W2fy67xHm14vJM9wEnHbD0ZNfKG+bMkFVikNgD0fIX3M8ZPC9bf10CQ
7jTg1BgiCj/wc0bBEl0vOB1aFo7aP1coP8YV0YrCN+r4Sh5wApwmpoZahNEoUOEa
TMgI3R38p54L0EzbbE4zfRqTdIUyzMZv5wTKeltYm9ot3FUPGUvzq2lP/c3INAh1
osj1/CNndrYifCLCNM7e5SviM7a9z2StRf9vq3vzjJRv0xwgPtE=
=wreR
-----END PGP SIGNATURE-----

--p3kes3mtjjbjul6e--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Fri, 29 Apr 2016 22:06:00 +0200
Message-ID: <20160429200559.GA16598@earth>
References: <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160421130450.GQ29406@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 21, 2016 at 03:04:50PM +0200, Pali Roh=E1r wrote:
> > CONFIG_HSI breaks power management completely, so power management
> > with modem will be another topic. =20
>=20
> Sebastian, any idea why power management does not work for HSI?

I wasn't aware, that pm_runtime_irq_safe() basically breaks runtime
PM until Tony's fix for musb (even though it's logical when thinking
about it). Currently omap-ssi and omap-ssi-port make use of
pm_runtime_irq_safe().

Since pm_runtime_get_sync/pm_runtime_put_sync is called from
tasklets in omap-ssi (and omap-ssi-port) it cannot be simply
removed. So fixing PM for the ssi controller requires reworking
the driver in a non trivial way.

-- Sebastian

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXI76lAAoJENju1/PIO/qa+k4QAJMQkRwZti+elYFLGSXiIYdJ
4N5m0aI30BMU3SH4QQGdY4x1N7iAO759Pm6VEY7kWrqqL7YiQSqdohrZQt75vP26
KPAyuoJZoZV5aHb5DsJkuLW2M8PL3CMHHZpnUyvyDRMgtonKjLWBQrKW5sSjOuyh
4F6+KYXzE3uU2/6uHf0bSkliOg92khPqAe26JeiKH4MPuuS5wUpOOGcGWOeKrbqy
kKdx5t271+KBnfYCZazAKi+R/UdSQeIpuvTxlLTwW/FvKC9mk76mbmuH26+hRvOT
vb/IJkBhEuD4N+fh1D3geKdQuwGdYYE7UanJWbD6fGLgJO5aAvn/nOXgFySgndvU
RKK4k5CYALXS3OcGGaWT5/Y2BvEII/wBAEGJvh+8T5CI0Jl8FkUXO/v+MU7oG7ez
+BupAfBAZPTLCebAF7h00YGfMYF88DDtem8C1/S7fQWTs1XLo6XSJGodiLwAdy2H
D87tf+RJBZ5R1ZPjIl7H4Eo5OLXNZmNdP4o6PlYl5X5QRZ1XBhpenlN/61cV0IEq
5M0tZZJocS1BgUH9CQLcAuTyXkN9NcTPQLh56/ic0VR9GNSFbc8YMSB1sR7YJAVy
iOXJnY1UPdQdUgBtDk1WGRZzHafRrVNADQhAkSYiUJ06tc2JFprV4MBm25vivbzW
LCZB/zpY2yHuJCKLFlc/
=bTOK
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

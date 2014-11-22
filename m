From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/4] i2c: omap: patch series related to multimaster
 mode
Date: Sat, 22 Nov 2014 22:08:13 +0100
Message-ID: <20141122210812.GA1275@katana>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416685634-5864-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 11:47:10PM +0400, Alexander Kochetkov wrote:
> Here is the patch series intended to improve stability of
> i2c-omap driver in the i2c multimaster environments.
>=20
> Tested on Beagleboard XM C.
> For now all fine. No controller timeouts, no data corruptions.
>=20
> Also impelemented i2c bus fault detection during startup and
> after reset.
>=20
> So, instead of the message "controller timeout" blaming IP,
> you get "timeout waiting for bus ready".
>=20
> Rebased against i2c/for-next (eb61694b43dea0d43ea2574e7d48f476a6bdffb0)
>=20
> Tested on the kernel from angstrom-v2013.06-yocto1.4
> Kernel recepie linux-mainline_3.2.bb
> git://github.com/Angstrom-distribution/meta-ti.git; branch angstrom-stagi=
ng-yocto1.4
> With all i2-omap.c patches backported from upstream linux/master
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Alexander Kochetkov (4):
>   i2c: omap: cleanup register definitions
>   i2c: omap: implement workaround for handling invalid BB-bit values
>   i2c: omap: don't reset controller if Arbitration Lost detected
>   i2c: omap: add notes related to i2c multimaster mode

All applied to for-next, thanks!


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcPs8AAoJEBQN5MwUoCm2of4P/RYg5MELYAaeKfX8bMbiQYe/
dOoccjTAaGR/KI3fd0qb0K+0SSjYz8OHqe2YpoD4Xqd8p5OhHzIZgDQjAikS5fQc
WcLYs9pnUxgO30LONK2o78lUy5VIl+9/5Cg2EHuQPeJMvedupOup3aVG/O5JDwD7
LNsCZp6RKRwE4DCTVHhaRpMC/pa9bTwW3M1Zt2a5wUjAYLlih+dvcNBv/cQ/lmft
LX2u3Yy2pRvo/NEo3aoxr9np88XwIvvVRcELCIlJ2bE0rEVoYmqKFFW+MTR/bGMi
A+0ptbH0B7E4HUUch4XMYbvyBupvvaBz8Izr6jIudQFx1q0PiEevuQv6UIM9QIe+
y1tRql8o4cTv2Vk2YXhuPh2l4J3HHoczhv29bxI6dOUh4g3ixExlP4tBhc+WaWAh
D0NxhpsQsOaJyqFtRLsANEl8WPHD2AbNcLa8U2RshZMhp5Pf6PoeTpv6vxJF8Jpv
BU5HnsFlgWRqfee+HZEcmZ/d/oR7TUuPjjhmDg+FWgAmT6VMkbyl+aQ79FMBQqlT
u6swIdti14Og7hXxU6tqR5VQD6KBhiO3jRbgWKofxLG/TkJvRIXDF4OY7QhyyMCP
T5YIvdakBfJrpayDO5DDfxQT5vrbyEcxlLpSBXXasunQ9R9y5RYcddJrFOtlrfN0
OENSIho3PzzLbT346jNN
=YMcV
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

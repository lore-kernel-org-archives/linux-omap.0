From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 01/15] power_supply core: support use of devres to
 register/unregister a power supply.
Date: Thu, 26 Feb 2015 03:25:32 +0100
Message-ID: <20150226022532.GA19242@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043350.4243.92949.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043350.4243.92949.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heil,

On Tue, Feb 24, 2015 at 03:33:50PM +1100, NeilBrown wrote:
> Using devm_power_supply_register allows the unregister to happen
> automatically on error or final put.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks, applied to battery-2.6.git.

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7oQZAAoJENju1/PIO/qafSMP/2Gp2+/8IGIJHP3N8vuZmueZ
ekR2DfD+ganv+vh0G5y8RzUDkGmxW8CNUxqMl1mV/1c95A18GU/1yyzTsmvHop6l
SmRYEfEXgDjRaUb8OhHs8Mcls+p5s9hF3AMPbucUHcj5PYk0b8MsP8nvz6bkyJJa
qhiNlNTq+oSTmT/k4vd+MzZEl/OrVenHd9b2ftGWQWBqXtjXLbU+MWOSwfBktFOw
jGu58sQUNJ/Tyl7RPP5BTI0Btp45sKdBDjqzKRbcLV+9vfkUCczhbKh7lA1B7B5U
bnNXFC37QkeB4nopYeQHybTptlcHCN4b7JOLqUz1w5bXbji1BONyezpKRYl0f4/v
AgcJir0Vrr0yS2JR1HGrX4gSpAzMOfXi3r4wfx6poSuXhPKh2t6vg5bgjzUqZEIB
hcfMDlhLZLcngbp1a3SkSn2NSLdyj4K6GuVCJcT2fvZQVNgwSKLIL3zjy0yZADYP
02tVTAQJJ9PJ4RTizzuaYyMNriGjxrt33emFNEv40irvazMKx1b7GzJfJ1hBqIwz
dA6pAy5iQLbc+WIE685utJevOJDNGp3vtdbwIXe+n97syALA/cKfjnr+g68g7qaJ
hh7SrSgFfN7DhRnK3bq7Z+c9Mgv/oKMc2sMu+fVdAsIlfSspPuUN17Z68tBgRQV8
F0LNjWamxueIL/h5kxYN
=cdNj
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

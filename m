From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/13] Enhance twl4030_charger functionality. - V3
Date: Wed, 5 Aug 2015 05:35:18 +0200
Message-ID: <20150805033518.GA16139@earth>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2015 at 10:11:24AM +1000, NeilBrown wrote:
> Following is most of my twl4030_charger patches, rebased against
>  git://git.infradead.org/battery-2.6
>=20
> Since the previous set I have added the conversion to
> module_platform_driver so EPROBE_DEFER can be used, and fixed
> a few minor typos.
>=20
> This does not include the changes to add extcon support, in part
> because extcon has seen some changes lately which leave me even more
> confused about how best to use it than before.
> I need to sort that out before I can resolve the rest of my usb phy
> patches and then add a few more charger patches.

Thanks, queued.

-- Sebastian

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwYRzAAoJENju1/PIO/qamp0P/3MjpidjsVjMZqUzPrdl5R73
QnbZ/xJ23WuKJzvNsDs66gu1og6yEIPPy4IzprWlPl/Gq0eFw082hy0M/xE8/HlR
tzb6F4pqeGHqHCxQWy5SrYaGprLrg/9rk/GnVxOjzDOnKhW6dfiDlUJyiDVmLgY1
UlD+5E5WYvKQyPL1TtfdnoPutd9yPqzY7vxyNtO8Bxr+bYMVu9RoVAdPLQkWEf9v
JAY8UEIqfE3alGIrmifJ9ixt4dogQZCgqGRm3TdhjDLYTIK30Rn2hM3NXAlflSLc
Qip9y9MP/zCGr1Z8QzBEzQb/rIIESncCHPEu0v1DYNumbo+Oawxf58UhXD2s1aE3
n9e8m0o3ihnxrStkEaPh6c5XA2/g7Ga6yDvEDtUQR0Mlg0e5rWaAy3V0+Y6Fp4Ys
qvnAScGC41qTv5jcMQOKoNTZOGBH3mrXQ6Ts3l8be90PNNSG30mLRI87NJ01EY4D
cwezk+A+9M13LVKXrfZydLLSov+TTnN8GWLVXm3iJBZ6P7ZcMUC+ruNdUoMPndD5
MZ8/sVi3eaFo9vM7TatRLtTHisT9HQEsGTXO8muh5V7z44W1AqfFYC4bfhonjTYI
GtzSdL3qJqNUWg2qkAS7MLBhjRgM8UzINz5ZBhKFim+MoXEkPKCydsIpYXvQ9Nyi
3aeUpX7MhAocMK1yHm7b
=ZGn0
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

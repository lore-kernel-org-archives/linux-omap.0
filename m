From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 07/13] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Fri, 7 Aug 2015 15:29:09 +1000
Message-ID: <20150807152909.77603f47@home.neil.brown.name>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.48552.stgit@noble>
	<20150807031116.GH4215@atomide.com>
	<20150807134525.251528ab@home.neil.brown.name>
	<20150807051309.GA24702@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QjdZNJ7FBx5MmMlsKFN5zKT"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807051309.GA24702@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/QjdZNJ7FBx5MmMlsKFN5zKT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Aug 2015 07:13:09 +0200 Sebastian Reichel <sre@kernel.org>
wrote:

> Hi,
>=20
> This actually slipped through my review. IMHO madc should be
> accessed through IIO, as already done for twl4030-madc-battery
> and rx51-battery. That way the custom API can be removed at
> some point.
>=20
> Anyway, I queued the below patch with Tony's ACK to fix the build
> issue in next.
>=20

OK, thanks.

I'll try to figure out are more proper approach ... might be a week or
so though.

Thanks,
NeilBrown

--Sig_/QjdZNJ7FBx5MmMlsKFN5zKT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVxEIlAAoJEDnsnt1WYoG5fcsP/0s0RvbvSrJOxlVaQ5HSs24L
6ZUYi1Enlb/Mz2wTP1F86TwFX0/1dT85A5hC3LIXEj3EmBTWL4ZXjqoy5oBTD2bH
WqnpFUU2tEd0a2bZhEk6KyjvZXQZphRWqf03DA5iVJXh06uvBVgsCi3tSWSZKqEU
t1Bp2XqK0WXSCZDXuCFqTENDqdCY/mNuvp/Tjc1vMBLmR2Ia4wXfsOhRDNbNDsAx
Ek+afZvpjqvMc6LnkTOkzluOqwlrH65rPpNzhwwPgYJQ1q58AyXuZFfKCK9iJAHy
cZTw75jCYLvGZjlAwt08hX3duKKq1lkrDqhPhkwJZG/dR4SwS+T7x1kWfLuz8Pzj
QIhpPyhXofquYPlckUOCjXxv5uei5VJqjBN9wH6scrEJQfvv51myOR9D0CUAJlnT
BMO+LXVoBTT6hITVw01uk2bXWVnCMSV2M6bwWtoWrwvjF/1T0ghy80pEOPjciYZ/
B7G0b8A8IydOsRKTxjWhX1H9oM0fRLj0kSC+5eYd3esQJD1IAHOqqhKh/r5c5TPl
lN/joCIMhYKCU5etORAWNmwpDN0HP37twJIO7uJZ0zgO8gQJfzFYhYQ/ZEXYapPj
6I2PfdudiUFT3XRPR6TqH34DeN5g0MEXaaByzwnHGyPnAmYydW2lKjXY3M65dG2b
kP4t2H1O4k85tuhw8PZF
=90c5
-----END PGP SIGNATURE-----

--Sig_/QjdZNJ7FBx5MmMlsKFN5zKT--

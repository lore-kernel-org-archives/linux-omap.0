From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] HSI: omap-ssi: add clk change support
Date: Wed, 24 Feb 2016 18:05:30 +0100
Message-ID: <20160224170530.GA343@earth>
References: <1454201558-31285-1-git-send-email-sre@kernel.org>
 <1454201558-31285-3-git-send-email-sre@kernel.org>
 <20160223023443.GB19629@earth>
 <4852048.rpY1LniVlK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4852048.rpY1LniVlK@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 24, 2016 at 04:19:09PM +0100, Arnd Bergmann wrote:
> On Tuesday 23 February 2016 03:34:43 Sebastian Reichel wrote:
> >=20
> > On Sun, Jan 31, 2016 at 01:52:38AM +0100, Sebastian Reichel wrote:
> > > This adds support for frequency changes of the SSI
> > > functional clock, which may occur due to DVFS.
> >=20
> > I queued this one for 4.6.
> >=20
>=20
> This causes a regression when SSI is a loadable module:
>=20
> ERROR: "omap_ssi_port_update_fclk" [drivers/hsi/controllers/omap_ssi.ko] =
undefined!

Thanks for the notice.

> I suspect that there is now some form of circular dependency between the
> various modules, but I couldn't figure it out. Can you have a look,
> and maybe revert the commit in linux-next for the time being?

I dropped the patch from my -next branch until I figured out what's
going on.

-- Sebastian

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWzeLXAAoJENju1/PIO/qappwQAIEpDEF2djVwctsJ7Mmcc/GV
p8D8gG5ifzpeGtREly4CRP/uRMODexrIpwT6lsiEy7Z3JKjK7dvENRihzilGabbL
ZDWfYNXyqihQXedpQiPOG3dgb8MKcbIz9wgCLZVmCg42+qGw50VL5PuRsGP4prW6
A6v2ZpM8ds5CFzxvLF+hBDs4NzJT+K2eJCyt7u6z9clvaUuBCKGCCFvbB4wN1JV8
VH0YvM5o6KlOWj1aEY2848Xu9EKkhvrO6R9QuoyUV3Ll4UM70QvsnBEMHUjLQxHU
BGH617f0k9fO4IuPK6GASvEf8l7AG4vNuHA1JCBlvv6vm/68F4QVXAKMauR37M0n
1w1fO/qHSWspDHODv0a2y5AW/th6SLziia1VonhrST13u6wc0cSy2oFfsIDCI62M
z/dm7gmU3PPNlJKGzqgJwPNYmycaarDRTXdSEbnHBYkNLdMD7sGjm2ULlhbfAuxG
JTGBBIbhNKLlHlhw8BcHg/MFI4NqwiS8ItWYzIoQfbPHXgH2rkIZDok8Nh9+iWCU
yiUqmels/Srir/PfvC1n0XlvGMAmxxg4mJqOFJNjenldyzxBAaMk2R8ZtSFUtz4T
gPL5bzS0rOtGYa+z/4qHoW9sam46o/jPg7YUrZIRm8pOkeb0Y2VHKQWSQwqSY6Me
j3LpC1i3SoU3uvS0ZqLQ
=LtHx
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/13] video: omap: allow building on !MMU
Date: Wed, 7 May 2014 12:14:27 +0300
Message-ID: <5369F973.10803@ti.com>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-14-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dEWaKqBDIhpEP6uWPfrVghDeIlpxe7XL0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398342509-10243-14-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--dEWaKqBDIhpEP6uWPfrVghDeIlpxe7XL0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/04/14 15:28, Peter Griffin wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The omap lcdc driver has an elaborate mmap_kern function
> to map the frame buffer into kernel address space as
> write-combined. This uses functions that are only available
> on MMU-enabled builds.
>=20
> It does seem equivalent to ioremap_wc though, so we should
> be able to just use that instead.
>=20
> This patch is build-tested only, it needs to be run on real
> hardware before applying.

I don't have omap1 boards, and I don't know anyone that has. I don't
even know if the omap1 fb is working or not...

Tony, any idea of omap1's fb? Are you able to test this?

 Tomi



--dEWaKqBDIhpEP6uWPfrVghDeIlpxe7XL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaflzAAoJEPo9qoy8lh71mwEP/ixwXorGiw6rNjAy3+rQ/Ht3
d1rWch/w3Xtu+eSjKLKRDBcIKdo0FjU839RrPvFXd48ooo256tJn1hR/DKiysX2T
52uCv/FBJRHHdVvc7ujtwcKSzxL8y/xa9YYL7N3jFlGxbLUqWOJqKiji5fAR408H
PV55iIV8sANH2RoWY5u8JL+UebSkj8GMsapRnf4+Pl30/H+oGRExD+xHEcT5e07/
6F3P6b/FTkG/esI2XQIFx3df7vqpLf/myW3RtjOPd4yQZW3lW5LNZz4XZOuqunzG
MeIX6e+6zFH/JiG/WR/xmeES/gEhTSx9gcOYykbWUDVZZGOp8R6TpsMZFSeLHama
6qNHtS7sYJfupZlyNUHQFvJiQiSe2rIOLIa3MQITuWCvh5vxoNQvGlElpumVIN7+
817hmLIf5bQsQfOWTM6RwEuqnSA++2DKwOhkA0E+9sWT+ChZJ8AyVQhW0Jq5NrnW
34w17sJZFgXHdYkaDmwQb0TWlITJ3D0CKOpiCWEjo24Z5gAyP/pn/QTNAQQ8iVGD
O35y4qDzQnPX6KSaalQMa/HystgqjuKITPmVmfzerxgCFpmjGgwQeIjKKqkrfv4h
7ZeZ8r8TsBLz8+aOPeJro6/cDrf3Z04f/a9s4czesat6F0kfQqi+PDGaH1r+4+XI
5kgARnLt/C5OSbEE+1sw
=N6bJ
-----END PGP SIGNATURE-----

--dEWaKqBDIhpEP6uWPfrVghDeIlpxe7XL0--

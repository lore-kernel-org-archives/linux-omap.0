From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/4] usb: otg: twl4030: use devres API for regulator
 get and request irq
Date: Thu, 14 Mar 2013 17:48:11 +0200
Message-ID: <20130314154811.GA3001@arwen.pp.htv.fi>
References: <1363242239-1061-1-git-send-email-kishon@ti.com>
 <1363242239-1061-3-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363242239-1061-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 11:53:57AM +0530, Kishon Vijay Abraham I wrote:
> Used devres APIs devm_request_threaded_irq and devm_regulator_get for
> requesting irq and for getting regulator respectively.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

please refresh this on top of my testing branch, you should be patching
drivers/usb/phy/phy-twl4030-usb.c

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQfE7AAoJEIaOsuA1yqREpVwQAKkMT+Nk8sNv3/27fgtMdmif
Xg2lRVQGc0dwCe04Wq5TXV0Sa198QWyD4/yddv/cipfncHwhPHTzz31B8IgGUSwg
5eH1+LqAFLSbzZZvCuYzXzgZef1ntSOwXhHfYhr7//jkCpnR8mPuTN/nAohxg9NL
OZbTQ7uTjs7apsjPGimztNoHiw8xeUc5nkxQezTKtQYZCj6Edzjy8mQ5wE3izuJJ
YNYSbsWtuwrRtY+b0A7O7e8Ki+mXKIlCF2CdEydEs04EOI7n0fHHpwF5IOaKmBsL
eRwvEVlhEyqNV6hrFThrYxW2n0bxo1hU+nls08TiGy5J/G9SyDgZ+EnEq8BTU3X2
UdG3UqX086sTunCjhmqTNdfW1oTZo727VZSv7hZz5kqqF6udkZ5MwxNARRMdgFf1
VejSF0D3bQkqYPbItRZqKhINtXGtc43dwTRQRBZw9jo2mO3891W4jyVl+cU/Gd6S
lDAU7PckLdY3BK5WvijW17dUol9g2IU/3VL0e4gVp2yMm7hUuzXObAoRa2UlJVg0
l5N7cuAN/UM5cC8tswZBqOQ8/8q//pTt9vuWrjY4CR/f9yyOK9L+E7EVC/2SlIFQ
7NhUYDs8Lcy9n0WSFRwMTbuyNp5/M3N9SH4lHJQ19uQ936jt19w2Hw1in9zlIwMK
QcxNk5EMMgijgj0BSW6r
=oCVP
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

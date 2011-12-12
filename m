From: Felipe Balbi <balbi@ti.com>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Mon, 12 Dec 2011 23:34:00 +0200
Message-ID: <20111212213359.GB4349@legolas.emea.dhcp.ti.com>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
 <20111212191241.GC3408@legolas.emea.dhcp.ti.com>
 <CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49024 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753415Ab1LLVeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 16:34:06 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 12, 2011 at 10:55:11PM +0200, Felipe Contreras wrote:
> > Samuel assumed it was ok and, like I said above, it worked for my simpl=
e GPIO
> > usecase with beagleboard.
>=20
> Well, for 3.2 I think the situation is fine, but that's not what I'm
> talking about. About your GPIO tests, are you sure you got the
> interrupts through twl4030 irq handling?

Card detect GPIO on beagleboard is a TWL GPIO. Checking that
removing/adding the card actually triggers an IRQ, should be enough. No?

--=20
balbi

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5nNHAAoJEIaOsuA1yqRE/5QP+wRDIwszgdbt0i4qbXfUV4gP
wEOHSThAtqjGo+cMlhrqTNtcwq5sfl1xR5nmF9dTpCb/Pg2tKQ9aALkdJhAd4i9f
pQ9q6wI/oaftoAlGrbLxWb19JI2XDAoma1VavHfZt+ZisNp5oS6UrVpJk/s59fU+
VGMFXWsXkUFgeuCTABRjZVG83xPFszCqBHIfEb/oHj2zI9Ou5bS8eFyygmiR09Wh
mjEUJCXGuP9HlJvoX0v6yKrEmpOaI/b6MJlYJuFBRkuBBDAYNrFutqjkNq0QmQEV
uzVvtFadyF3tpBHIY8B2OQOY+kLvFe7gxSodQTglpfay9uKOsSoCsOEQ3JyHVcZp
RI3zd4hPe4KhIDQn026bzi31ftzTvEZ5hf0YVzwUI1hJ9xDLDqMKcmOuSCIlUDcD
Fj970jw1yvguIw8SUif+jEpEmcv/wUUZPNjkMGx/kKVUzzxuJbMHmqIusggxlK40
XlvheLiG7E+vrtPLVFyMmvR3QZqNWjKurHQpO7nLkpizJKuseml+mxnrgkyTgLor
WOp2gOobVV6DW4saQuy27GYXJGoBCoj5Qi8y3SsQsyazHh08RiwqhFh7YANaj/w6
OVA9dZ/Q0lU6T95n2w7yqva5OBYB4+yaPypqUP0viob/wrFJwchox+CejM5X9fVk
9wSi9pGuUZwyZtZGox2T
=+Kds
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: query on [PATCH 2/3] usb: otg: add device tree support to otg
 library
Date: Tue, 25 Sep 2012 10:54:16 +0200
Message-ID: <50617138.2040507@pengutronix.de>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9E8319@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E1050132AE6CB04A9236201"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59095 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2IYIy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 04:54:28 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E8319@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E1050132AE6CB04A9236201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Afzal,

On 09/25/2012 10:47 AM, Mohammed, Afzal wrote:
> This is a query regarding patch,
> "usb: otg: add device tree support to otg library" [1]
>=20
> It seems there is so far no consensus on this change.

After I have posted this patch, Kishon had posted a better solution [2].
We discussed the patch, but he has not posted any updates since then.

> Do you have ideas to proceed on this ? is there something
> that I can help you to proceed on this ?

I'm interested in to get these patches into the kernel soon. Kishon any
news on this patch?

> Something like this would be required for USB support
> on beagle bone (AM335X), which has 2 phy's of same type.
>=20
> Or is the plan to use generic phy framework instead ?

Yes, Kishon's patches look more generic than mine.

Marc

[2] https://patchwork.kernel.org/patch/1457801/
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6E1050132AE6CB04A9236201
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBhcTsACgkQjTAFq1RaXHOZZwCeO/x5Yfzoj3x2NeoCGHzuqUNX
u70An3Kt2/19nSlZfYWuybYbcNMM13Oy
=JKJb
-----END PGP SIGNATURE-----

--------------enig6E1050132AE6CB04A9236201--

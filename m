From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 1/2] mtd/nand/omap2: fix omap_nand_remove segfault
Date: Fri, 31 Aug 2012 14:57:35 +0300
Message-ID: <1346414255.9709.46.camel@sauron.fi.intel.com>
References: <1346412942-4015-1-git-send-email-andreas@biessmann.de>
	 <1346412942-4015-2-git-send-email-andreas@biessmann.de>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-KtaGsJYjTBS7yDjIXg8R"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346412942-4015-2-git-send-email-andreas@biessmann.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?ISO-8859-1?Q?Bie=DFmann?= <andreas@biessmann.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--=-KtaGsJYjTBS7yDjIXg8R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 13:35 +0200, Andreas Bie=C3=9Fmann wrote:
> Do not kfree() the mtd_info, it is handled in the mtd subsystem and alrea=
dy
> freed by nand_release(). Instead kfree() the struct omap_nand_info alloca=
ted in
> omap_nand_probe which was not kfree()ed before.
>=20
> This patch fixes following error when unloading the omap2 module:

Added "Cc: stable@vger.kernel.org" to both patches and pushed to
l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-KtaGsJYjTBS7yDjIXg8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQQKavAAoJECmIfjd9wqK0c+4P/0FMKVZMEcG01eJoNVofSLT5
LcjkPBboCXCOErDfH528VRS4F4hnhW49pYm3DfUGooXGDgMGTUv4OiYWKiNUABJ0
bPz6hL94Q43ax8xS6QmUqBFiyDeWIoPDa8hxpnjz3I9pvE8ksyT7hR5lGxeN8clh
pjaQ/AvoIYVI470/HRPuiXkokKWiOFOunANeL3UpbzFGth/DBMtFpQsJue+8YHkW
56YGPEjnWdn3ECOVsNqfo0zmUDhQdXZRSHb8kPcBC/4utBHyhG3RjAImNZl6PsI3
myU/Hopqu4kXMRxfh0tDGzh/nfzo7WB7BJ9hC5Z2YlZejdhzEV4ooRKOhBa/bzDl
sY9OQW40ikEo6q6HUH6SL/3G3Q0yt0LhHnJSePy9PTxOyJyxYtOxOZPwZ5Jj1+U1
ohhrDDnOIe7yqQOn7H6+Q5dsGFa9BbjdouEvfwjKZtNR11y7LajmoxNjYqyNf3fD
gLXR+dX44+3yOn8LedZal7uJPUjTliWocITRkCvCSLQtZA0XwT2qpCTzm3bH/TdL
zMoHvB520xIa/oUBsfSXJlDM0tkeItV6rfTGI8GtPzx7Nn/COlNAHapykZWJMEzU
HetPUwlGK/PDuU1zYcDyw2Enm8BNxXrh/MAzQV0EqnZ564IvkFQBYXLAeGmEQiag
OVnkCcbZui4ufffXGUkW
=TSh3
-----END PGP SIGNATURE-----

--=-KtaGsJYjTBS7yDjIXg8R--

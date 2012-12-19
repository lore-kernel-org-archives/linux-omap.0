From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 13:19:24 +0200
Message-ID: <50D1A2BC.4040605@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01C90E14B865F1D7B0A57A4A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47717 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2LSLT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 06:19:29 -0500
In-Reply-To: <alpine.DEB.2.01.1212191132250.16226@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

--------------enig01C90E14B865F1D7B0A57A4A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 12:51, Peter Meerwald wrote:
> Hello,
>=20
>> In the case we set it to 4, the DISPC_FCLK is fast enough to do the re=
quired
>> downscaling, but in the case when it's set to 0, it might need to pre =
decimate
>> rather than try to scale.
>=20
> this is my understanding as well
>=20
>>> I think there is a bug downscaling YUV data when resorting to
>>> pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workaro=
und
>>> -- any ideas how this can be fixed?
>=20
>> Pre-decimation should work for YUV formats also. Could you share DISPC=
 reg
>> dumps when this happens:
>>
>> mount -t debugfs debugfs /sys/kernel/debug
>> cat /sys/kernel/debug/omapdss/dispc
>=20
> please find the files http://pmeerw.net/ok.dispc (with FCK_PER_PCK=3D4)=
 and=20
> http://pmeerw.net/fail.dispc (FCK_PER_PCK=3D0)

Something funny is going on here. I can reproduce on omap3 with a few
hacks that reduce the clocks. The PICTURE_SIZE's width field is
different for working and non-working cases, but I think it should be
the same for both.

Even more interesting, with my tests I first setup the ovl with a test
picture, and see the issue (with RGB mode also). If I then use fbset to
first set the mode to YUV and then back to RGB, predecimation is not
used and the issue is not visible...

 Tomi



--------------enig01C90E14B865F1D7B0A57A4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0aK8AAoJEPo9qoy8lh71uNoP/3cqtls142toAFRyqz94+KlP
5JKEhIDjRIKfTd1BRWiSxfEwuXLnrb046u2kWT2kMQLwiEuiKXnPTyQMWejByDQr
ex2TBJSXPeRvmiIWiCCKL7YApqd2MsJNL9tS/ZMcKzIPPny4+KIOY1CKjrKAVBAF
b1tPdoUOXKdkakzRhDWA4iw12T2jskiLTQ9o3pFMd7yyK4CK1TGdscMo3g2JFWL7
KGdgJe/m9jl38vTgcfW/U6VQx1NkfCjz+kVvt7BNTOIXPXE5YFQrB3It9LPLzKlV
qwSqOFc2wH29qqq8yPVainrW28ApGhG9dY8sHixnw+n5eLbb6umE0cHsYOxg0U8p
OhAbdg50KB4DFVrpOEEZ1PUbU6y1tyr1Ekw9BAgOTPv8DNPI8v7OD1AHbk7uiHNy
omBO5Z2hEU4nYCKClk/8EzV0gBSrh+JYFar2QRcU/6GdgQzPrJDyy/9u1yl1pZ0H
Gl/dEOROy/y8RGxnHBZzFILWZPBL6UdFioWyRaoB/8GBLJ1Y1SGCeWVp95HuzfO5
40dJcXFiin4xYrNDbwmHg4VYpPQMWMC1OtIMkGbJqUB1553fUr7yXBzUvRUcqqi6
zFCp+wREwPZLEvoe6RctHXsBYWEmUz3zlM4jA8Rdx3MtH3o/uU88E36tliyV/KLw
BxXZVj58lNBu1CwjP+zy
=8cjD
-----END PGP SIGNATURE-----

--------------enig01C90E14B865F1D7B0A57A4A--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and
 make omap3 LDP to use it
Date: Mon, 18 Nov 2013 15:06:20 +0200
Message-ID: <528A10CC.7070908@ti.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com> <1384562167-14725-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aCe8uQl9U93B73DjDgRVxFQfRX10Sbo7s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52702 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab3KRNGp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 08:06:45 -0500
In-Reply-To: <1384562167-14725-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--aCe8uQl9U93B73DjDgRVxFQfRX10Sbo7s
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-16 02:36, Tony Lindgren wrote:
> In order to make the remaining omap3 boards usable with device
> tree, we need to initialize the DPI based displays using pdata
> until we have the DSS bindings in place.
>=20
> At least board-am3517evm.c, board-cm-t35.c, board-devkit8000.c,
> board-ldp.c and board-overo.c all use fairly similar DPI setup,
> so let's add generic code for it. And let's make omap3 LDP to
> use it and also initialize the ads7846 until we have a binding
> for it.
>=20
> Note that at least LDP needs the TWL bug fix posted as
> "gpio: twl4030: Fix regression for twl gpio output" for the
> LCD backlight to power.

Looks fine to me.

Is it possible to keep this, and other similar DSS patches, in a
separate branch, that could be dropped if needed? I'm kind of hoping I
would get the DSS DT finished for the next merge window (but I've said
that before, so...).

 Tomi



--aCe8uQl9U93B73DjDgRVxFQfRX10Sbo7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSihDMAAoJEPo9qoy8lh71ElwP/A01R0XY1RhyMUtC8cqvlnv8
qpQL4bTANOmN8fyPkiSJc/dNNUitArgkplSqJXuuCXtMOs0NmchJXbydCmdmhVH8
N6JECKAS2v2SkQs/ZEt2fwE0XoUoAzo/pWxSodcrAIJZbFQVhM38VcBV65r10rto
uAJwVGUsj1tSkqK/UWkIQ5LRvcSDUC0jYu/5CAaZ3lMvFg9GGNamZ0JMR57fFUih
JfgXvuSTjcW9IVHnNcV2tAg53S05/sS5Kkpuz3I2Y42DWno1n3MOdsaFxylxJ4U+
ebo94OREOp+k+ZumEzQ+FGwtQvZwj+ljRlNp7ph4cRX8mixACH6zDWfhO+Td8jBU
77/7wpGbgt2C6sfVgS/QqlZhIzZ45SgOXkg/MYN4IfxCcSYb2o0qwBzYvMlTkoaY
zCdJnh4dEyKfGgtdxw2Xg4gHlTiNqtXGyNYmcR/eEECYdxfyjVTroSaV1IggNV+h
MVlUL1FPDBXuIvNo3ESrHOnuJ+GUK6hWmsWnjuj/odmnrHWQuUeqQZ4pUMmQEbex
2tSC/jmRIGujkXjgSFn4XsPo5II3UQIs1IvwcwASVMryN86a/YIOHOh4SGERG5vR
qnS2IxeMIti6oVNGObJ2FlAsFg9mWIWP4/U+/V2KTsZWaZJRmsfOJMtODwG1v77O
Vi6c8XSljowe5MKpH0OS
=fQWR
-----END PGP SIGNATURE-----

--aCe8uQl9U93B73DjDgRVxFQfRX10Sbo7s--

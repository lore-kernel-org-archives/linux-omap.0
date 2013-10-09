From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 9 Oct 2013 09:02:03 +0300
Message-ID: <5254F15B.5050207@ti.com>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk> <20131008211108.GQ8313@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rVn8QJn2rq5m017rdtVKbuqUWknpVA3dt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab3JIGCO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 02:02:14 -0400
In-Reply-To: <20131008211108.GQ8313@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

--rVn8QJn2rq5m017rdtVKbuqUWknpVA3dt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 09/10/13 00:11, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131004 20=
:00]:
>> IGEPv2 board has both an DVI and TFP410 video interfaces but
>> DSS support for DeviceTree has not yet landed in mainline so
>> is necessary to init the displays using legacy platform code.
>=20
> Thanks, applying into omap-for-v3.13/quirk.

Can you remove the patch from your branch? It had bug, and I had some
questions related to it.

 Tomi



--rVn8QJn2rq5m017rdtVKbuqUWknpVA3dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVPFbAAoJEPo9qoy8lh715GMP/2zyXhK3UtB0FstjRAluYGfP
7t6obmmxGtw6VQNdtlfNrY/5mqmfCdmh85cwbbXXzZVi3cd6kVCaPfQOrz2PoT7p
YZJ1RtkS+ftdfSz5tSDLcrPX2WXLeZGTxyfPY7Mldjp08G5kXCLTtzJgOchEAptB
FAQFLmNehF8isEO/XXQOA8sxwev3vcXX+2kq5yxUne9NGYePAyv+/8ipXsvM9GOj
u1XTjt0b6CTQzsAFbJyq2M5Z6METmXsN/3HAaceWoeLCNLxvWuhgGFy6cH8OL4cy
jX24SNhD9aXF+JPTWq2JvuW4sqK2jJLCi8mxp76aHJHw2v1PvYrp2CJnjlrGvnQu
5mpUL6NGC9UfmGElVW5e/5iYtggWPhWykWxEtddQEfo5MRyEBD6xcD5/Ie8ncsNy
ZU40iMA/WPeeZ6Jhin8h3CLNk18YhQQ6qc8IA15E/Uzq4aVOLopBlmrzg/MLYWRG
xF1eG4mxvEwGX7NUBegyn9imeoF0gxrIRThWQcfloojQeKdHdk++n4fiG+oXcr5j
SiXAzQa2rrpHEdjB/GzBTgoFrTXCDPs6vGFROKYL9TuU3/HvdvWG1sAsi/l1YYwB
vDb4/v7hYDR3KXukXdybft99gCqGyJe35ZUDD8Ji89zDn49CYVTrFoAm03rriOtC
BoDvHLkcHRCGTrPOyUUG
=oJcC
-----END PGP SIGNATURE-----

--rVn8QJn2rq5m017rdtVKbuqUWknpVA3dt--

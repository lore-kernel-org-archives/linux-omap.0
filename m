From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/5] ARM: OMAP2+: hwmod: add enable_preprogram hook
Date: Wed, 9 Jan 2013 17:07:57 +0200
Message-ID: <20130109150757.GL27133@arwen.pp.htv.fi>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
 <1357743792-13917-2-git-send-email-s-guiriec@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39408 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab3AIPIU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 10:08:20 -0500
Content-Disposition: inline
In-Reply-To: <1357743792-13917-2-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>

--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 04:03:07PM +0100, Sebastien Guiriec wrote:
> From: Paul Walmsley <paul@pwsan.com>
>=20
> After setup/enable, some IP blocks need some additional setting to
> indicate the PRCM that they are inactive until they are configured.
> Some examples on OMAP4 include the AESS and FSUSB IP blocks.
>=20
> To fix this cleanly, this patch adds another optional function
> pointer, setup_preprogram, to the IP block's hwmod data.  The function

the function pointer is called enable_preprogram.

--=20
balbi

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7YfNAAoJEIaOsuA1yqREtdQQAI5JV/SDTjBLuHqZgRyOl3Rl
kwgnERRIkr0S3yUu7AU7KGv452neWgIIQ0/ldQ1E/F1w160mPRKLf01Q+t8CP/B0
h6FKzqLbYCAvlu/QjFHji9B4pSr0slxxYWErxB+beRuYFj1M2/pLEMdK3HUlvy4g
CPCYyhY968oq+L4+WAUb4BlT9/4TFWPJ+SqtDhS5ZwRyKW9BiOlhbSXrAt6S9yy/
Jn1sxKXTTA5vBZoLCvmGDOVu1B41e9ZltVzMTu/sfYqYlv51NI9FaIoNFfjn06uu
5+cLmTV29Uqhf1HhtVRN6KxEORJecnr1IDl1mgUi6UziqSf9eue1LEbQD9MALtb2
F7Nvwu5r6FiljcKqHbNuxzRH6to1EwjbrqMmujUHr+YfAGk0HCVNxlUbGFSsdErO
SoCvLBczSdSDAiahZf7JVsRikNwwpXJxq1A090yb4N5BSMjCXxkrFAj0syoGF+y+
LxiIpp/JLtUFSHKP92d9ocLxMvw9or4wx7+FFcGBiR6JiYSUWmpTrADPEC8i3rMe
PCQPMI+X29ql6dmdSrRCA6fueMU8zpgC2OnE7Vqz3ss5H3dZ0ReABjecpUDKOsQ6
e70rspwWw0HJN2iiVLPeP1fwdDWg6hjR3QEzeLuxhyqJGZp3B76Jix0LXnvbGwIZ
bFN6PgCX5AChS2+amlpo
=J4jX
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--

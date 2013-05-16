From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.10-rc1: backlight brightness after boot on N900
Date: Thu, 16 May 2013 07:52:12 +0300
Message-ID: <519465FC.9090002@ti.com>
References: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2WKOCBKSPBCJOKLNCWNIA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3EPEw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 00:52:26 -0400
In-Reply-To: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

------enig2WKOCBKSPBCJOKLNCWNIA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/05/13 20:18, Aaro Koskinen wrote:
> Hi,
>=20
> Is it expected that after boot you get 0 brightness i.e. a seemingly
> blank display on N900 with 3.10-rc1?
>=20
> First thought after seeing a blank display was that the probe
> issues are still there, but everything was fine and after setting
> /sys/class/backlight/acx565akm/brightness you get a picture.
>=20
> Just wondering how the initial brightness is determined anyway?

There were some small changes merged in v3.10 related to acx's
backlight, but they were removing dead code so I don't see how those
could affect...

Looking at the driver, the bl is initialized:

	if (md->has_bc)
		brightness =3D acx565akm_get_actual_brightness(md);
	else
		brightness =3D 0;

And has_bc is set only if the model is detected as MIPID_VER_ACX565AKM
(that's the panel in final N900, isn't it?). So what comes to my mind is
that either the model is detected wrong, or the
acx565akm_get_actual_brightness() which reads the current BL from the
panel happens to return 0, either because of an error, or because the
bootloader has set the BL to 0.

But why either of those would've changed with v3.10... No idea...

Can you add debug prints to see which code paths are taken there
(drivers/video/omap2/displays/panel-acx565akm.c, around line 580). The
panel model should also be printed with "omapfb: %s rev %02x LCD detected=
".

 Tomi



------enig2WKOCBKSPBCJOKLNCWNIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRlGX/AAoJEPo9qoy8lh71fuMP/0IPvFMul2AuoqI4O+yh6Xwv
vcHTT06xbjJ2vXLxpNhRCvA3ZANeq2v5EyoGwfY4WkxrAKQOKPoPiy3SEi+HyMTH
aSoaKooe+PCy7PpiYDiB4aMZPjpAoOptD2As4T9qBjC4jy10G6HjWh8kr5b2+r0U
tPEoDH02X94BdgTmm4sN9X8Fno/fYcdQLQrKtykO3qhSAc2nCPvwDofhkFbhRJhA
Oh7CRCIM9f996qNDjwODCCrXCyKBIkbTDO32QD1uQFQ5xKnXt4VT5c9031qXN67K
ZSE9EkO+SJzWyDO6vQIhNjD4KiTgnMQOOQLyzL2UFEaRkJ00NAfyW9qMxzaGGCTr
mwLSdakAiw9wL0jlNabsBtZT0f8cuq/8I9VNtrJVZLVVvtRjk1oJ2QcTlj+kzFGe
OfV888s8CsMOrv7mw3/LbwEIBWKtKGVhpGSSx2ZLMyse9AUzHdReNhm6zThcRjzh
8CJxWpJ66O6Se8QYW11tviA8PCMtNGNSNjqh0g/nLyN7lt9VRBXr0+DHwr21vFJ1
p9vQDYJTC1aViUeGaJv91iZbumo6z1vYznMC1CemldWDGo2Raz4gpKgmoIgZ0/Iy
nMN/lMcFMntsM60YOCjsZU9xsxcwP5Mhq6yogorTOeAAtUXAE4DezVrdjYHafYRS
j1vVIuWMRBH8EKhIRrV+
=We85
-----END PGP SIGNATURE-----

------enig2WKOCBKSPBCJOKLNCWNIA--

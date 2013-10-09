From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 9 Oct 2013 10:47:52 +0300
Message-ID: <52550A28.4060508@ti.com>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk> <5254F0ED.5030800@ti.com> <5255094B.2060207@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EFL8OgfxACXQGQXh02C6pt8ocB1LW7rSI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49023 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3JIHsE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 03:48:04 -0400
In-Reply-To: <5255094B.2060207@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

--EFL8OgfxACXQGQXh02C6pt8ocB1LW7rSI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/13 10:44, Javier Martinez Canillas wrote:

> I can't do it yet because the two are still needed for different boot p=
aths.
> Once the board DTS has all the hardware support that is currently avail=
able on
> the board file I'll delete the board file but until then I can't remove=
 anything
> from the legacy code since that is what users are using right now.

Yes, right, I meant that move the code from the board file to
dss_common.c, and call the same display init code from both the board
file and from the quirks system.

 Tomi



--EFL8OgfxACXQGQXh02C6pt8ocB1LW7rSI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVQooAAoJEPo9qoy8lh71qiQP/3o5Iyr6loKydhjeHjq6y+I8
rdcaEY6VE6Z9kfDFj1OXKk3Ywt3Vip5yX81t2bdrJO+p+CHSd6MROpljWSYJArSF
kD4fexVngKwPRcpkQQwD1AkBRHB+yg2OuXBRQMGVq1tGfHGKFlgmNHIfSxDs2EMv
DnEXas1X4em3AaIWNKfFE9V3yH7plY/s+v8Erz5qxEbAVx5rzGDyWX2qNogKF8b9
D/MIaA12iLiXhLPs73Qc1TM6J7qesNGM7Wq2dZZYtyH54RyiPH4IIl32DMw9EdWn
67NLKQp353+0O+wEWkKe5guGqKIc/Wo3Kd8CJtLMKHgewEynR1y/hRZ8tzu3ZaBm
aZAyR/sq+YcpOwO4HPT88MEpmsfsM+d5fO6deQ7zYUABNZMOFmFNBUJvE31DHwzv
x1NiOBmoqI6NYTTIruJgUEDUUeviR1jcrFN6vLCiHisuip7MdQCVdaHDYdGQeB+i
aRl0lmKCuNmbTFgJvXwWPRiI+fUwTHsrxTyTrIsYJ1TxVbe1KVhDmIvHo9mB8jU7
LU8XL23hfhchPWlKzvXAOAo1rBBW1maS0+A8S//xpEoouQjYWZPuFDENLhNHeaYM
10PSHkI0XRr5+Hb2Hp2TKBbi65FJg1V3HCDOzhKVgCeLNiFe+FcfsriFZZ3QN/p1
P+SDR6/YJHx3wZYghsqv
=aI3w
-----END PGP SIGNATURE-----

--EFL8OgfxACXQGQXh02C6pt8ocB1LW7rSI--

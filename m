From: Sebastian Reichel <sre@debian.org>
Subject: Re: problem with "undefined instruction"
Date: Mon, 6 Jun 2011 14:56:00 +0200
Message-ID: <20110606125600.GB20909@earth.universe>
References: <20110430162357.GA14287@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:42482 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab1FFM4D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 08:56:03 -0400
Received: from sre.ring0.de (unknown [134.106.131.106])
	by smtp.ring0.de (Postfix) with ESMTP id CD1ED81814
	for <linux-omap@vger.kernel.org>; Mon,  6 Jun 2011 12:56:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110430162357.GA14287@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 30, 2011 at 06:23:57PM +0200, Sebastian Reichel wrote:
> I'm currently trying to get a mainline based kernel running on my pandabo=
ard.
> The problem is, that it's crashing very early during the init phase becau=
se of
> "undefined instruction" exceptions:
>=20
> [    1.867980] udevd (56): undefined instruction: pc=3D401e6ed4
> [    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.977752] modprobe (69): undefined instruction: pc=3D400c6ed4
> [    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.978240] init (1): undefined instruction: pc=3D40149ed4
> [    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    2.005706] Kernel panic - not syncing: Attempted to kill init!
>
> Exactly the same userland boots fine with the original 2.6.35 kernel, so =
it's
> probably not the userland's fault.

I found the source of this problem. VFPv3 support is not working
correctly when OMAP2 (and thus CPU_V6) is enabled in the kernel
config.

I guess this should be mentioned in the kernel config (or fixed if
possible).

-- Sebastian

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN7M5gAAoJENju1/PIO/qa5vYQAIP7QESB2IjFznB17j3I98r7
E/N/PNoEGpnA3/cRJxx/rtuh4vtc2He4UtuKXLPaDvGWuV6eHlqkU7Kd2dJpQR3c
FZbvSQ37jbyHYfXhlAcwWS0kh57GXU2IZ1zp8z1ZnbFPXMJ9xOxNadhG1BHi/zTe
y3eaPUmXqgC28QmexoYo+68Bqjf/FZYibitXizLYWAnuagDkVP5/S8Yaaz9DIHPg
7y4Ud69t30S39GqnPPcCABxXbhcS5Y34QYg+DoFKt6juYBu36mJrD3oKuzV8vgF9
e1qKwGyIUBIA3l7+t3QwAOWehwe9J8eKtfL8hceicOIz3qteXeaU0N1p/EDYUIWR
u0Jg0fbN5rS9NGnw8PHKIIzS5zwzwana0PeHmImkrmYZmGJUPmpGM0Ml4oUbdiih
0pw8Y9oAfENqJ6uSvP6VvKW0hl68llr7B+HknnnRZr7ZUsXcSGRwnsu5G8JGg2HU
IxG7qo4FTblVj20AMc6BSKzD9druXsI9VlA2aGFTblhabIDy5l9JDC7WfyULsusJ
wzsB3YwSSIQCqyaDhAuOeALpzj37hhhb74KDHQu2BvOC2CvyckAUQpwCs44wAXXD
TthQnZQWY357TadSQYEcEKZH4sweZVJ4zOAu4NhyfsUxWd6k5WkPFvS/qo/S2v0y
tNMzmbEvKZDFYoYPwh6l
=qgIx
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

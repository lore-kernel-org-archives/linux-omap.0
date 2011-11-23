From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 35/65] OMAPDSS: APPLY: move spinlock outside the struct
Date: Wed, 23 Nov 2011 12:47:33 +0200
Message-ID: <1322045253.28917.62.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
	 <4ECCCB07.10702@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-z3TsCBz0/9tcTWE5Rsmk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50068 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919Ab1KWKrh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:47:37 -0500
In-Reply-To: <4ECCCB07.10702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Kibrik <sergiikibrik@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-z3TsCBz0/9tcTWE5Rsmk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 12:29 +0200, Sergey Kibrik wrote:
> On 11/22/2011 11:21 AM, Tomi Valkeinen wrote:
> > dss_cache struct contains a spinlock used to protect the struct. A more
> > logical place for the spinlock is outside the struct that it is
> > protecting. So move it there.
>=20
> a small question: isn't it clearer to keep lock inside struct, so it woul=
d be easier to read code? Say, if we meet
>=20
> > spin_lock_irqsave(&dss_cache.lock, flags);
>=20
> in code we already aware of what struct being actually protected, and in =
case of external lock it's not that obvious

But if you meet code like:

op =3D get_ovl_priv(ovl);

You don't see that the data is inside the struct protected with the
spinlock. So you still need to understand what it protects, and what the
above function returns.

But I see your point. I'm not sure which way is better. I thought it
like this: the lock protects a struct, but if the lock is inside the
struct, the lock would protect also itself. Which it doesn't.

That said, I'm fine with both ways. It doesn't matter much. I didn't
really look for any established patterns for this in the kernel code,
but if everybody else have their locks inside the structs they protect,
then obviously we should also.

 Tomi


--=-z3TsCBz0/9tcTWE5Rsmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzM9FAAoJEPo9qoy8lh71vCcP/25gGWJv9U7woKwOQNQpnkIL
1lhSMKRGlzYlMoZtc9fipnINDQy9Uikx/MzQpGs97LArlnsIKiM98E9adcTwxBQt
mxY6AGbEcgbJwsqRFlvAmy5GMEhqFairzSHNYrOZzrYxc4GRErtqcyzo8kUYUIgL
S1hCjz4yfkvxrTcdRYtt2WwBFrSEmZH8XXFqdjm+iaS7Jypk61H0QiI66iNE/J5r
leu/+dtGb41EPckPk6/HF0Ofa8dhUnMJNwBmQo8cgzONZyNIyOjh9nOOT+wro5W6
u3Kb07FzelMwgWDANuSrjfro6ZxuonyAqMVSee0XBiV/vqJcaFUoZy4kQTRmPmit
wAUXfsPURmqpCjnFJ68NRN/s6PgWugUIflU4qETcn/jh4x4wLzK9/Lg5MUzRgHsS
i22lFmCkta5Z/KNqB8cq0XYV8oBhm/ez+9EcUoXisC88yyh5tchYU27bgZFyCcLD
b0PP2BLS2Ve5qKmDQwmhTmtddrEAeRM3VzI8so7u1Nq1wL3WrBcUE7loSYXK0PXb
XPu4wGffBmAfhvKa+Edr1vKze+o1SAE7HBoMEEHowIK4eIk7eT3loPO4I8t40UBe
YTXpx/UdOCBMvjzO+A0Seyz+tqxijPAz+xCy5GI1j78Krl5IKdg8XVAO3R/YPFCw
CLOF9nhFPwqPwxwEwL5f
=jCpz
-----END PGP SIGNATURE-----

--=-z3TsCBz0/9tcTWE5Rsmk--


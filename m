From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: clock DT conversion issues with omap36xx
Date: Thu, 13 Feb 2014 11:03:52 +0200
Message-ID: <52FC8A78.1050500@ti.com>
References: <52E697C0.6000202@gmail.com> <1390848104.4936.62.camel@mars>	 <52E772A3.4090401@ti.com> <1390901735.2963.8.camel@lovely>	 <52E77D03.8090001@ti.com>  <52E7B361.2030601@ti.com>	 <1390928565.4904.88.camel@mars> <1390994505.5023.32.camel@mars>	 <52F10C3D.7000507@ti.com> <1391767923.4937.110.camel@mars> <52FB748E.6050007@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="i14cdrHiJG2Pfjt8r58ua8vBpwe0DJWxo"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FB748E.6050007@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Tero Kristo <t-kristo@ti.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--i14cdrHiJG2Pfjt8r58ua8vBpwe0DJWxo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/14 15:18, Tomi Valkeinen wrote:

> However, I hacked together the patch below, which "fixes" the issue for=

> 96m and dss fclk. It sets the clock parents so that the x2 clocks are
> skipped, and makes the x2 clock nodes compatible with "unused", making
> them effectively disappear. I only verified dss fclk, so Christoph, can=

> you verify the 96m clock?

Aaand the hack patch I sent is crap... We can't skip the x2 clock path,
as the dpll4_mNx2_ck clock nodes handle enable/disable bit, which is
present on 3630 also.

I think the best and simplest way to fix this is by setting the
multiplier in the dpll4_mNx2_mul_ck nodes to 1. I don't know why I
didn't think of it yesterday.

I have a bunch of other patches needed to get the clocks right, so I'll
send a series separately a bit later today.

 Tomi



--i14cdrHiJG2Pfjt8r58ua8vBpwe0DJWxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/Ip4AAoJEPo9qoy8lh71Z5MP/iSntFIJXnIY4mlMoM1mWH3j
MvahhzY4M/faeNyLEt9mTs7f5aa/D5wE0gRMHxN8GIpzLC8C1JByMMkV0D1kZxTD
5uQOrL/JrmHU0DYiW5Rdr0hpu4ZcynHYsqEEfxRIswJHiSTO2fvMwP6vva8UQkaF
7GRucXAa4GIwspmRa+JRdcorMTjUkq5lYXCarvvgUkq87DaUBewQPGf+lEgg39sS
amJv1qPTLFPECXCYa+2ccxRrgDbAzhlYJuKjLj3BbQptC5CTWxDY5nYJlZs3XOUC
CrntRxiG51WsSU0lb6tyCZjm+igpmwa9NsvwBae9FpjMNSUfskXztSkbwXHXb3Ve
89/Tmoy40KYVv4OldK4kPYddz0FkxC0Xeeav9c2ht4M2DcbA4UuHwzkJi4KVsR6t
6L5GI+OZirznICO9Eld/mJrojpDVulWz2mg7I9Bo5xddsytAca5mhwrCh8NLaBXp
1Umr3/t7igOt9+FJc2dXt9Rdip4Ngk8FASKixEQOvigmieQQ8+ZGMOYpkybRNl3E
xeBa9fx56A7Oi0HRUbKsAexod6m2gRI6HUH9zDNkeYAoF+lGvbbcrP1ph3TF88A+
hIQ8gKFG3I4drFip+lOAUVOScBrCscsK2Qq5DDH+lLPx1s8hDPJwci3WW5spq7UM
pRvcLxGAGtZP6hp+9WgO
=BrcT
-----END PGP SIGNATURE-----

--i14cdrHiJG2Pfjt8r58ua8vBpwe0DJWxo--

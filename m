From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Sat, 14 Jan 2012 12:17:26 +1100
Message-ID: <20120114121726.5da0949c@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<87hazzquhb.fsf@ti.com>
	<87lipbp6uq.fsf@ti.com>
	<alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
	<alpine.DEB.2.00.1201131606310.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3V.XCgDs5VYL923Frsnb0tx"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37734 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab2ANBRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 20:17:38 -0500
In-Reply-To: <alpine.DEB.2.00.1201131606310.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: govindraj.raja@ti.com, Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, linux-omap@vger.kernel.org

--Sig_/3V.XCgDs5VYL923Frsnb0tx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2012 16:34:06 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:


>=20
> So ideally this formula should change the "8" depending on the number of=
=20
> data bits, whether there is a parity bit, and on the number of stop bits.=
 =20
> The real formula to determine the number of bits per byte should be=20
> something like:
>=20
>     bits_per_byte =3D number of data bits + 1 bit if parity is used + num=
ber=20
>                     of stop bits
                     + 1 for the start bit.

NeilBrown

--Sig_/3V.XCgDs5VYL923Frsnb0tx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxDXpjnsnt1WYoG5AQJ19w//ZFj5fXDkHpIfA2+UguNyGrK3OKJN5p1e
Nkpg6rpLHl4nfoOgEidbfOmPHWh7XxXw5uFlWb8RU8j0E/k7lQwMF5IiU1eMw9Vf
ZqI1BjBR+RUn+8Vj0ojDZ9CbDRRMIJqadXdkCiYcFQjaiokfRaWCIUCiTR1Iyh5P
gAZv9jRxNtUAFbS9/2EHJFz433xYkrH/O9Pup2qR49ckjrJdT3p8Rwd4rNsxesmN
7qbr6C7IQmDhG9odlt0COAbXAQhOnpmIQEzQHc7zeX2mewhTae1oPp9jyXoa8wYl
jSyqASzrTdSDxnLb14oO8aAEIgwmvRZGBP+QV/y0h2mquk61YNmZXJ230Cmbpr1e
VMMvJXHS/u5SKXHtwIQwqxif8xdc8K9EXRPpbW+RwcffaTQuuKDYKT/bscKIhdDs
lY2tJhLMkuZx3wLQjGN0/aTvSJcPGFqKm0QOm7jnbBI8Lb6efMuzvGFpnWEv+I3d
LAssFJay7NkbvrBFiMO5Ur2yh+HykeRzaCJ3lkOHnJmFdGvUZ+byEZ1T8SC85yn2
NyMk53bsOWepSYbx8mpvDVRz4Wfmky82ftKiSrdMrXMT+Ih1J3ktthbwy95sfGMJ
94wUxriQNWHYw7CUI/rPCJqwdImrG6OvBDdniWX+2jl4w7/ELC+yvOg+GcagQiy9
PPMOvKL9f80=
=KFwc
-----END PGP SIGNATURE-----

--Sig_/3V.XCgDs5VYL923Frsnb0tx--

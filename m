From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/8] ARM: dts: use ti,fixed-factor-clock for dpll4_m4x2_mul_ck
Date: Fri, 14 Feb 2014 16:05:02 +0200
Message-ID: <52FE228E.6050102@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-7-git-send-email-tomi.valkeinen@ti.com> <52FE2001.1020906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4L0nPSoCGFD3DaNRMMLx5gwej2p28o86i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaBNOF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 09:05:27 -0500
In-Reply-To: <52FE2001.1020906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--4L0nPSoCGFD3DaNRMMLx5gwej2p28o86i
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/02/14 15:54, Tero Kristo wrote:
> On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
>> We need to use set-rate-parent for dpll4_m4 clock path, so use the
>> ti,fixed-factor-clock version which supports set-rate-parent property.=

>=20
>=20
> .... you are talking about the flag but not introducing it in this
> patch, maybe squash this + patch 7...?

Hmm, yes, I should mention that the flag itself is set in a following pat=
ch.

 Tomi



--4L0nPSoCGFD3DaNRMMLx5gwej2p28o86i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/iKOAAoJEPo9qoy8lh71hcAP+wTsoTW1AL1NDR4aUlJzByaT
zrAz0I6bw9WBJpaooknWJcbdR/m7HTTqUNrpsEw5iXp0HUuw8jpj+kDyKQR/MTxj
FOhd5db7LrR8vGHsxH3QWwiRIwA/yH4f2Lduj2zBMGskp6E5YC8afh+TCc0MMzqF
s8AY7LMwFZG+j+G5O29wNHh2nA7HBCw67MsP7U3k1lhsb35FNCcIdTkdZGexiI7b
k7F3t8GXjNBsgeKcpmG7vyWWv75zrYb9485TQbTWhxwaqJPnvmUXKinXcsgaGQg3
aI73SxbFrPJQ67Slu1Jae+zYGkG9DH5BzM9uRQK70hRZwIeP4BmTj36c+x3XTLBV
56brg7R29EQQ4P0Y0eiu8DrvbuYi/L6d7BNncCdAUad7EB12WDkcJtyExJow6Pa+
GOdMw2UCVG4JLxoVWYdjDpZFkFpdJTY07HMQdcUJInRoaF/O1hmqe1yBHun0hm3g
Tl28jdT13JxbSL7n7dGWblVooHdAohomYpEpqIaLaIyxcrq5100xNPFj4Jcx8OHf
8WFD7zvcgDEuEWeW8nMGRby5k0MOPV/d1Iomjtlg2V6oddxymwGi13aJk2DhuzBQ
dIadvX8YrVpYdWHSiVgZOUOa9EjB7UUGNYxqezTU9QTEKAGM242nBuAsCHh/CvXS
AJYDa39f/wEvkAhgAHO2
=h/8C
-----END PGP SIGNATURE-----

--4L0nPSoCGFD3DaNRMMLx5gwej2p28o86i--

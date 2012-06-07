From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [CFT 09/11] mtd: omap2: add DMA engine support
Date: Thu, 07 Jun 2012 15:49:35 +0300
Message-ID: <1339073375.6875.102.camel@sauron.fi.intel.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	 <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YCdqRaR1c6JqlZiHog8o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3274 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab2FGMpq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 08:45:46 -0400
In-Reply-To: <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>


--=-YCdqRaR1c6JqlZiHog8o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-07 at 12:09 +0100, Russell King wrote:
> Add DMA engine support to the OMAP2 NAND driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be independently switched at build time between using DMA
> engine and the private DMA API.
>=20
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I guess it is makes sense to make this stuff to go in via the OMAP tree.

--=20
Best Regards,
Artem Bityutskiy

--=-YCdqRaR1c6JqlZiHog8o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJP0KNfAAoJECmIfjd9wqK02kMQAMFlAXK7rPogAzGkS2z1jy+X
XGtdvdrSYqU4nPtKEJ6pLo+DZQmhJEly0YCvhtclCGpeFAAvQvqupaha1BkIdpqq
uOZVB0ve7x4VEKMIueLCPN64750qAM0+WEtsdxJyGhZOkeyAJl5l3RW0LnjCsvU8
Hazu+P1vMszq6JLKSW0rIPdCNsjaiRsJUUzlCny3M01u/CH1Nw3c/vZcv0FO0nfi
z5h/t2NVp/xM+rRV0MeM6lvdhZ8d5fFZ2WO2fQXb7zHoz8SlRWui2w1Ef35hHcv8
JG0dEsBi6kZiVDK1zT0LokYiby9rZuqv4kye8y4+xvERCO01aJJTV0Fsqv1trBJQ
oXuVMUq5E/5i/347PxoYKRHCO3ue7/gRMtvrjtqZ71Yjd+g8py3ePsN+hnQ0lf04
5KdJTSLOFRmM6uhGJPlVnfKjKaHk73GzXybiurqJ/in/EHlFsYdDu7+NZPFvm0oe
dkpgbgbHZI+NjgjZV1aDjeq/FW30IqTHikLM256xYe7c3xdOlWy1VfY6ZMUr9fKl
sHmyiX7aVPwABdHS4QPodkyjERqppCfpmfJQ4TxTqSnllSkfUDszHluCK4pd/jcp
tD6L0jJopCIUVxgrHXvsidX4JqJICYxVj/ldSHrYb25fHQ/Q1POsPjUbt3eHgmA2
Lng/DpLP1FLBLcvySlBK
=+nUe
-----END PGP SIGNATURE-----

--=-YCdqRaR1c6JqlZiHog8o--


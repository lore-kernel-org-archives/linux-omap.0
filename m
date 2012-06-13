From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 08/10] ARM: OMAP2+: gpmc: Modify interrupt handling
Date: Wed, 13 Jun 2012 14:55:58 +0300
Message-ID: <1339588558.2401.117.camel@sauron.fi.intel.com>
References: <cover.1339586624.git.afzal@ti.com>
	 <35f198577330e7260ff7e5f1f3ac603372d83589.1339586624.git.afzal@ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-GPMCEHY3tKACoSCaIgzP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31708 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab2FMLwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 07:52:07 -0400
In-Reply-To: <35f198577330e7260ff7e5f1f3ac603372d83589.1339586624.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com


--=-GPMCEHY3tKACoSCaIgzP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-13 at 17:03 +0530, Afzal Mohammed wrote:
> +/* XXX: Only NAND irq has been considered,currently these are the only o=
nes used
> + */
> +#define	GPMC_NR_IRQ		2

I guess "XXX" means "Warning"? Why not to use plain English? :-)

--=20
Best Regards,
Artem Bityutskiy

--=-GPMCEHY3tKACoSCaIgzP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJP2H/OAAoJECmIfjd9wqK0KvYP/2F2ZwTryAzTg4EwzdLR06/6
SyscOETXuRc37l4vsL9ACPpbVV0fUZU35k7rnmjiyyLixwPIkMDiGrsonPsjs3Ia
30yGMvG6puTuG8yJSFgAmZ1LRnshxPV2dokwUIHWomhXq2oXTQA/xyzOAJi5DkJ1
HRqdWh5AGzGvT03of7f4eLolbTDTWwo29Mlis+mSVbpgfmgEPNt0kkJ+uJyquIwK
XVg1oqask7Lg3KeqIe75G1yAZb0aEfUQ5Ay0qBiGn7n9XXxW+3b8xm55cQ1bSAz0
B4VlA3nEt6mNocuezqrBulEnyjiV7aoJAc54bg6qz6OUmZ+esm5vNO5b/j5JIAPx
hMcZn4wkSnmWVEH4hfoziXMUoa2x7iq3JUOCE6gVHclVu2pEFO9DkPBpEGDAQnCi
f1oiKP3ydDVt4w0IVSUhoo/k7J/WW7/xfaXCHvFFoHCt/2n/hM8OY4GEcYTBPala
We46HOXdLbfkWOSHWT14d/HYO5WmKFbo+vGpXko6kz/q9i+OLQDQnJH4VN6CD/yH
9tZWqLth3zRRMp2ZCKeriEzdG6yZheBH9AfeaFyZPTIzhS6LoEtW3RtdyJ3hAtPq
uSArgxZjKgq7ub9e2/og1SXHISCOWKcLAkqj53ifSNfh+WfYJ3/0ETNW3dDKREWk
ovCMG5eI/A8whoE/KZ/Q
=zolg
-----END PGP SIGNATURE-----

--=-GPMCEHY3tKACoSCaIgzP--


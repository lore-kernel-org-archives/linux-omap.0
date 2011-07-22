From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
 to_omap_device()
Date: Fri, 22 Jul 2011 11:53:57 +0300
Message-ID: <20110722085356.GH32058@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-2-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41136 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753242Ab1GVIyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 04:54:00 -0400
Received: by mail-fx0-f54.google.com with SMTP id 4so5683594fxe.27
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 01:53:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311292338-11830-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 04:52:11PM -0700, Kevin Hilman wrote:
> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
>=20
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
>=20

FWIW:

you can use either Reported-by: Felipe Balbi <balbi@ti.com> or
Reviewed-by: Felipe Balbi <balbi@ti.com>

thanks for posting the patch Kevin.

--=20
balbi

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKTqkAAoJEAv8Txj19kN1y2EH/2xO9QaL6ZruEIifAHOQJrQv
VI3vUbaUfDgoyXK960gins6XGcMul43UXL08n5fskUx9vr4aJBLcyaNHVprTh2iV
xJcJ+mRGxfLY1vuNwQ12GNVE+ChQUze2xWwPQ7Rxy2w0GYhZsq0ZmVH6YPOdWC9O
ymlMd+GQbVyIpgA35lhkMGfvS359R/gZ/BmOnx3JYjwH5rw+zZ9oDIfWn8MvL0HY
8ZLTLVluO8jNOLZQlXFe8PsYUokngDHElrQqQR5PUPIRXUlzIzumZfQrb+pqY8/Z
MGQkZZ57BFIWunhpPx/kK5qxC8IkhJ2Qwx1lN3yTkBi3/jf0a98k3nyRTvMdwHM=
=XB2d
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

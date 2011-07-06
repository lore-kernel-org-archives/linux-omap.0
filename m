From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
 to_omap_device()
Date: Thu, 7 Jul 2011 01:18:57 +0300
Message-ID: <20110706221856.GB823@legolas.emea.dhcp.ti.com>
References: <1309980377-5964-1-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47156 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494Ab1GFWTC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 18:19:02 -0400
Received: by mail-bw0-f43.google.com with SMTP id 7so798224bwd.16
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 15:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309980377-5964-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2011 at 12:26:17PM -0700, Kevin Hilman wrote:
> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
>=20
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
>=20
> Cc: Felipe Balbi <balbi@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

thanks for sending this one Kevin ;-)

--=20
balbi

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFN9QAAoJEAv8Txj19kN1/WYH/jKnAATv6fGoGwQ2UzuoepND
NEDWMegQLxKGkt4jaPsNc0qzWSUWsjdz02SaMIt091h6EW0mq85FrNaeJc5jSYHT
WEJT81qfImUNnLXe0pif8ueh9ZAlZqXQggpPOk1TWa4In0bfgoFQp5BsU5vRSomj
wvnl99JRKK59eTX8SW4xRX1jGdmrIyxEfD471PpWBDjJMqPYFxD5cyLWbILzlaZA
6CwvuvpadmyexZmmb3p0iCcTukWd1MQPgacRd9ZY+NEkVu3pMi1XRzfDxGf84wXQ
w2+6gdee0pkQBSy/n3bfZPLTxEm78BJH5J9WbKJm8NCXValXH7v1H5YcQK/YKhk=
=mmR+
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

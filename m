From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulators: TPS65218: Add the missing of_node
 assignment in probe
Date: Tue, 24 Jun 2014 16:29:38 +0100
Message-ID: <20140624152938.GS23300@sirena.org.uk>
References: <1403104668-32316-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55797 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbaFXPaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 11:30:02 -0400
Content-Disposition: inline
In-Reply-To: <1403104668-32316-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: lgirdwood@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, stable@vger.kernel.org


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2014 at 10:17:47AM -0500, Felipe Balbi wrote:
> From: Keerthy <j-keerthy@ti.com>
>=20
> Add the missing of_node assignment in probe.

Applied both, thanks.  Please use subject lines reflecting the style for
the subsystem.

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqZleAAoJELSic+t+oim9StoP/2oyQGe8RQbxk0oz0sdNaeFM
eLtXol5PbxGLKLNXLOj9BJ+KY3YSzC2CCxsHnugU9EPnZGg+KnwhRBUHUn8TZTq6
9tzkrwoDPXPupgVEef04lrLUk+70pWzA6KO/2w+TBaUnULyrXhN/brxKg6pT4vXx
8Sht51Dcrkc9N36rO5BVHFRIrBhJQ1IcuM3YfyuTusyYxMhkQwell01GKkI3x58I
yKGwlAX+dm2baIVMgV+ixghLu36Hsdq+yOBB6eOzvacYfHYFWGoDY3T9gTxoHrlj
oR2odBDrE4HPXFer7c3Zp2aTN1SnGP+DMnEwLkOqBWy3F2U5yF7epQeG8yhPs45f
pcPFErQe2wS8uxz+23zhIqCO2Rs66JYXASvn105e0Y43xZ/tjXR6Hw57GDdoeW/t
BSOEtmVmu4MUv7CO7ISP7/6E+4k4eyXT7zQ0hyJw74ygWB9OuegC/HyucoYURY6T
qS3BwumQB/yAHISf55uurertiPAY35r7YWBoTvpgTZCSVeX9I5Iu95pYElcGOKZX
zlLXb2wm/N1xc1+8dBrQdZak6QgWU4BdHMNLnuwURD3N0VvaYL9qTXGhd3/9uAZp
XyJddhEFXNr3xN9hKLt6fADqUfhugBK+mzjkQhEDYUjhBs+ahVU961OPfSuVANeE
XajMF6+a9nzShCtSW7iQ
=HMd5
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--

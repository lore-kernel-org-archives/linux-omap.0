From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Thu, 21 May 2015 11:18:57 +0100
Message-ID: <20150521101857.GR21577@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A1VS04HCCjrR2aaM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49705 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbbEUKTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 06:19:14 -0400
Content-Disposition: inline
In-Reply-To: <20150521020709.GA14258@deathray>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org


--A1VS04HCCjrR2aaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2015 at 09:07:09PM -0500, Michael Welling wrote:

> My guess is that the set_cs needs to be called even when toggling as GPIO.

> How should I handle this?

It shouldn't be part of a set_cs() operation but rather part of the main
transfer operation.

--A1VS04HCCjrR2aaM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbERAAoJECTWi3JdVIfQRUwH/jrjusZl1DDv4j3E3NnCJhCN
h4e0/WsgprJaCIJSKwV4rvBrd0LJKbpCu8tFSLiGKJsliaQTDEkHe5RKp51OdMwZ
+hmihUsH36BFROpdyEsh+skbCgZ2jqcCI9cD55mQjlzw9EFXr9Xg2J1MqlMo4n87
GODGkVYYMOAY4b6WQyb7kyZ+2QZiAXR2HD1KR80oWixkvVxHmtqvs6rsw2aeVRiJ
Bh/PIh+Ckd3NHAmnCU3l36VabcKTTF4cfsjm2DgZM+kwo8Sa54LHhrJlzYhZlO1j
2pG53Ox9txGZzR0+V204zQdJxm56zPRuP0SIb74VA8EC7MixgMee9DabyLv12Pw=
=O88L
-----END PGP SIGNATURE-----

--A1VS04HCCjrR2aaM--

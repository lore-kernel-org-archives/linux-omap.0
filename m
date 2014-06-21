From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Make u32 DT parameter handling
 64-bit proof
Date: Sat, 21 Jun 2014 11:07:03 +0100
Message-ID: <20140621100703.GB5099@sirena.org.uk>
References: <cover.1402653217.git.jsarha@ti.com>
 <ff985604371ff8afa35352db9d460b08760003e2.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SaJ70UJ7F+qlPd18"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51703 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbaFUKHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jun 2014 06:07:18 -0400
Content-Disposition: inline
In-Reply-To: <ff985604371ff8afa35352db9d460b08760003e2.1402653217.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, detheridge@ti.com


--SaJ70UJ7F+qlPd18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 01:04:36PM +0300, Jyri Sarha wrote:
> Passing unsigned int pointers as u32 ponters may be dangerous on 64-bit
> system.

Applied, thanks.

--SaJ70UJ7F+qlPd18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVlEAAoJELSic+t+oim9P8cP/2Ek+a3MNrJOrvDWv4ECP783
zmCQ+0ZN0GBu9UasEtrdfniIdEnckuK5W+A9QYeTuZ5b3eo9CJRc2DWj+f+iJh1I
xIZrVHhByuxRSCmRmLNJS1IaTsR3DLBMK4fyJrkHP6BopIwBSizEgJ/VML6Rdr1l
6XSq3eRzfu22lpTmewTSJ7Sd+35vM4qhnpxbE3UVHJJgz7WL6KuzVkXm9PHb8EF/
5qDeDGt1P3J2eLgE4VxIuhxx4SzLK1ucLDcHZuv3tCJd1ri+RMN6LBlQoZ+ggvm2
LBAhpw468QD7D3MgyfSgNt61x4+kFVbJf5JwUujAiZw37ypr6s/nH19iiff6xlJh
CeJKyJ08VkUe0PUHljvFXgj0LpD0DMN+kp0igrvva3BdFgQ7hAQwSyRie/a8hHh3
I9WbexGtsIBSatJ4yTvX+Ie1UKIDX4at97LYS2R9TAPh78TFgh1rCVYCx6KrpU1F
BhaRkfutlEv1yLGY26l9i+u206r7dRXd0jObAG4JX1PGtx2VnkfSWFyBIcytr5s4
4pY7UwIcVUFT8ycY0hEJk7EfJOC0taWr45bd0I9g0XzJjjfqlgG/ZX1MRm6HKpAz
ymVbElaBd4sHrP0Xo11fa5Zdw5flhrXReClNnQ4DKIqIqc6ckyvG0zMh1BGIsK11
gtCgBHiuERiJd+Xe0J8t
=5ALn
-----END PGP SIGNATURE-----

--SaJ70UJ7F+qlPd18--

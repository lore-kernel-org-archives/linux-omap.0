From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Configure hardware when slave driver
 changes mode
Date: Thu, 3 Jul 2014 19:49:48 +0100
Message-ID: <20140703184948.GS410@sirena.org.uk>
References: <1404271712-669-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HB/4rhAYKmGVivlS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45321 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaGCSuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2014 14:50:05 -0400
Content-Disposition: inline
In-Reply-To: <1404271712-669-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stefan =?iso-8859-1?Q?S=F8rensen?= <stefan.sorensen@spectralink.com>


--HB/4rhAYKmGVivlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 08:28:32PM -0700, Mark A. Greer wrote:
> Commit id 2bd16e3e23d9df41592c6b257c59b6860a9cc3ea
> (spi: omap2-mcspi: Do not configure the controller
> on each transfer unless needed) does its job too

Applied, thanks.

--HB/4rhAYKmGVivlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtaXJAAoJELSic+t+oim9rpAP+wdqUE/zE7wR0jBKCasffTvH
cbsVjzwnKotBka+lpkS4XiiMP/eHw5Em8x1rIfMozKy97FJIfqLpFR1ZVAGYbNIc
oA/39gmWU39sN2GPAndg60q1C5t5uRrREsZSfWnX4UHeKG1JqlN7yEoxkhuED3wB
K7wontyRH/NzQ4dFzPrNRGKyz7e94Zc9gRb3aoyFE4VFgoMq4AG3kBIb56GMbokT
0htNHYy7Ut1UuToxiTdNxbwoVuOpxXUXU8dNl9qygFMvJnGqxkdcOmvEm2EcawME
nBQO5ZQg9fE5hHTbsqpmHXKa+Onp63SVj2aE+Lv9vOCj25BiY4vB9sNJBJdfHslO
FsenSEdWYOCPhZFTSpEAOBImISTrFGYUuYmvc2eZqpWGjSIVcm15gIRXsS24OXc5
HVOrKM1vtQHImAzwcqhGYhk3SUsDz/pm5rxfJ5QakZ8b9FxzwIi8nkcHQS/05W2n
lPAbMahjjzuBev9smjT4UFjz0b6dHYCDaKWnERkmltrZgKNCq6LnIHtxH7EELss7
gZTJZScXBikhccy3cyli5ZY+SWxiQqSofAVYJma9ph2UaofXzFZPjF4UqjxqfObD
cCt4HHgGjMzhx65IaVpjN1TPXiNZa01pPuLfsmYImLgcexYENGBJaUpFgiM94LOC
wJfoLp0tvwjaJ7OlpWAu
=0Xwv
-----END PGP SIGNATURE-----

--HB/4rhAYKmGVivlS--

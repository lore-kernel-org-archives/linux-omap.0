From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Tue, 3 Feb 2015 12:16:20 +0000
Message-ID: <20150203121620.GI21293@sirena.org.uk>
References: <54CF2CDA.3060607@ti.com>
 <1422888485-13626-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/g+HdBW4tzDpdEIu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48775 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbbBCMQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 07:16:30 -0500
Content-Disposition: inline
In-Reply-To: <1422888485-13626-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, benoit.thebaudeau.dev@gmail.com, wlear@appliedlogix.com


--/g+HdBW4tzDpdEIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 04:48:05PM +0200, Jyri Sarha wrote:

> Changes since the first version of the patch
>  - Added "ti,tlv320aic3104" to tlv320aic3x_of_match table
>  What surprises me is how come the code worked even before this change?

Applied, thanks.  I2C has the interesting feature that it falls back to
using regular I2C IDs if it can't match based on the DT ID table which
masks lots of errors like this.

--/g+HdBW4tzDpdEIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0LwTAAoJECTWi3JdVIfQZ+0H/1wHWa6aJwQSSBYLfK22u9da
npBM4e38gg0X86kn8BRYdcoadHOwbqseXrwfhu5Qt3bNegRK/arNfTPFcFCPQm9j
BeRIzoe60ncthDSCN6hQivxlhrljYv4ZiYeZyJ1XlfbTmLdIRiWeJ4s+Xk4TAPKg
g4e3L5Ltr2WNY91zv14pag82tMG1EpeLGTtenH8mOUQ6Y+uOiLnJn+iQdDHKPXdV
eeqbTdVsUH+in+T6jTVvkqY0KpZLq3FlBiGVNWgWVUGul+L5M8n/Oi926qU++Pi3
6D68b9ybpebJgrc7X9TG6Xa5ufz7HjFzJnRZ7OoaAljKlIs9s+3PhlSVX4Lnu9E=
=MU6b
-----END PGP SIGNATURE-----

--/g+HdBW4tzDpdEIu--

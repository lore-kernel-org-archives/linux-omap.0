From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Choose PCM driver based on
 configured DMA controller
Date: Tue, 2 Jun 2015 11:46:27 +0100
Message-ID: <20150602104627.GI14071@sirena.org.uk>
References: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com>
 <556D8600.1060204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38933 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbbFBKqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 06:46:33 -0400
Content-Disposition: inline
In-Reply-To: <556D8600.1060204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 01:31:28PM +0300, Peter Ujfalusi wrote:
> On 06/02/2015 11:58 AM, Jyri Sarha wrote:

> > +enum {
> > +	MCASP_EDMA = 1,

> Why start from 1?

It's a fairly common style to ensure that zero initialised structures
don't have a default value.  Don't know if that's the intent here or
not.

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYmCAAoJECTWi3JdVIfQPZ4H/1DcQz/QRbxzr7Aklm1dyXTs
FuVpfZCYIKOBGL5bfn/herOR+WeA0kYIVqfYNcb/B8zXxz7FQAPuAVPASt+2xAGi
kVnJETKyvTqyt2YhaAJ+evspo2RT23ZTb4vG/NlkCpMAIvL+SPQzzj0qhqYIQAws
gsQ8jf3OdyW1I2Kl1slmKNfnJgs0BZkD+18zx1YimNvwWTgJp5CQTRArybh6lZ1Z
wcDbXkWxhU7dFGpPd0TXWgfVgOlCattp+lDWbfkLwocDEqBMgsU/R/UkPMnxsPZ0
m+TFPZnEd8UgXb6nZnTXGdX3+4RoPQRy2/PVa1vBvXyRtMisRrJgV2ezYEMTao4=
=6LAo
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/12] ASoC: omap: Remove obsolete HDMI audio code and
 Kconfig options
Date: Fri, 27 Jun 2014 13:17:04 +0100
Message-ID: <20140627121704.GN23300@sirena.org.uk>
References: <cover.1403807781.git.jsarha@ti.com>
 <93e1aaeba564e0e38ffbd7254adfbb54e3206211.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="991t1H9DIskWxVIu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:32908 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbaF0MRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 08:17:22 -0400
Content-Disposition: inline
In-Reply-To: <93e1aaeba564e0e38ffbd7254adfbb54e3206211.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi


--991t1H9DIskWxVIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 10:21:00PM +0300, Jyri Sarha wrote:
> Removes omap-hdmi DAI driver, omap-hdmi-card driver, the related
> Kconfig options, and Makefile entries. The HDMI DAI drivers has been
> integrated directly to OMAP4+ HDMI drivers and simple-card driver is
> used instead of omap-hdmi-card driver.

Acked-by: Mark Brown <broonie@linaro.org>

--991t1H9DIskWxVIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrWC9AAoJELSic+t+oim9PW4QAIooqH7DcPxYeYR95FBcNi3T
9lULM1XT06QMFuiM9M/VK4grYmKaqJqaCCy+4eANz/PV5tJuzYFuLSNz47Jao2aK
jusOw3cJBVvNf8y6y917DYzYAzIWFjXu9v1M7jg0czcZHh+JoffqxFusWNB54Vfn
i6XpMnqOKZW6CgNa/cldDSlNOws07gyEozEGh0DpT9e/+TRT/p9R01C4O1xZKNLB
bDZxvZ4WIVH+/BvQYcpV4BUV7YrdFsmjNHAARQvkB/GkXr6RRGvrDDeg5arMmvU3
es0ZZ3dfiOHDXbYJo7BY9ygXBPEVYu4id/oe+GD7+M1Q6iRe5/v6G4uH83bB8EAY
z6vyRb9yp5EQ3t9ZbvescR2ZWs/M/HtYYfnQJI9Hy2rjjvBbxJixmF/jTyRAyOp+
Fo+UQ8MMDuGdaOQtUy1ege44lmBMf5W03CtPQ1kMhAlWpy604occIu67bOIJ6iW4
630AG12tfK6Bnu2c6/MJTQzqtQXe9PSSJ7NdnqRucC8w6GXEWWK906W6qVpEcRXw
ZKmCIgGP+ohmFugICe0QwJAR1WGtQz/E/mqiLN3uNGejEcMb7VvYC7GhV2HwgWxd
NVXWNXU5PclYnkmqHqznOPW2A9OEfASR8Shr5DWITBK+LFYHHkC8G8EOvzJBr53t
kwAiijNHiKLYeKzHU4e5
=M+cs
-----END PGP SIGNATURE-----

--991t1H9DIskWxVIu--

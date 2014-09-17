From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/5] ASoC: davinci: HDMI audio build for AM33XX and
 TDA998x
Date: Wed, 17 Sep 2014 12:41:26 -0700
Message-ID: <20140917194126.GV7960@sirena.org.uk>
References: <cover.1410898073.git.jsarha@ti.com>
 <270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pi1ad4bzbEMsC2x1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48717 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbaIQTll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 15:41:41 -0400
Content-Disposition: inline
In-Reply-To: <270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, tony@atomide.com, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com, Jean-Francois Moine <moinejf@free.fr>


--Pi1ad4bzbEMsC2x1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 11:40:17PM +0300, Jyri Sarha wrote:
> Adds configuration option for HDMI audio support for AM33XX based
> boards with NXP TDA998x HDMI transmitter. The audio is connected to
> NXP TDA998x trough McASP running in i2s mode.

So, Jean-Francois is also trying to do things with the TDA998x - what's
the story with that, is this joined up at all?

--Pi1ad4bzbEMsC2x1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGePmAAoJECTWi3JdVIfQHGoH/2jKqvJC4Kj9x3EzOyIoRvEM
u4yZ1gT3++3BkCYZh2+cYn+nIjECDL/OvLg5UvYv9B1G1aopvUtAgzhUu8R5PT2W
f+KU87DUbnru81Xow74eiXhtPLpjswQr8kHWrhyey5IkKqKO2jp+suwXzDTRahzj
rKCNbkCo3uvnzztnYxWtbwYz9ShMo4n/bNu2/KUZcalXvxKv9ZgtRlhCg3Oiq+nK
aFN5zXigyQp4ixSw7kJ8BP2+C7RKwSKJHNTYGtoq8XjvTSMDETicXMzvQCenfMjF
uwZXaq88ZTL9MfhwRrdShRBfQx0wIam52j/pH6BIqQe1DG8KS9yG1XVUHlt2lOk=
=cLAs
-----END PGP SIGNATURE-----

--Pi1ad4bzbEMsC2x1--

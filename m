From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/8] ASoC: davinci-evm: HDMI audio support for TDA998x
 trough McASP I2S bus
Date: Thu, 21 Aug 2014 13:24:11 -0500
Message-ID: <20140821182411.GN24407@sirena.org.uk>
References: <cover.1408397864.git.jsarha@ti.com>
 <a92cd9257efb58711b2d5d3de2abff9c8a1052d2.1408397864.git.jsarha@ti.com>
 <20140819131621.GL3302@leverpostej>
 <53F3A843.4010409@ti.com>
 <20140820123434.GC21734@leverpostej>
 <53F49CB2.5020801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I2DZnI03i1DS0lOz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53468 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaHUSYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2014 14:24:43 -0400
Content-Disposition: inline
In-Reply-To: <53F49CB2.5020801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "detheridge@ti.com" <detheridge@ti.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "t-kristo@ti.com" <t-kristo@ti.com>


--I2DZnI03i1DS0lOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2014 at 04:03:46PM +0300, Jyri Sarha wrote:

> Could we drop the SoC id completely and make it just
> "beaglebone-black-audio"?

> The board design is the unique factor here, not the SoC. McASP block can be
> found from several TI SoCs.

That's a lot more sensible, yes.

--I2DZnI03i1DS0lOz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9jlIAAoJELSic+t+oim9ktkP/2vCpG97GqH4UKrT1FxmfSPx
iPLsTr6tWD9vsN0Jq50uNfNXMPKu6NsOmWhgaBLPuDEGefbUHjGi0F0jl6q3248n
5qymail4p9B/chB1aDaMS4R61DHs+41xyQ1kF4p3k9SQv7XmROYjs3n1bLbIy0VM
gb6YDF5rUVoCrx9xUi27BN1UXRM303WjVcbySZ9cS+vfrXXOL/FxTntqdMdPxaE2
5TqAOMS3ea086BpkIuWKSXkqpIDPQztIndVXU89VLQ+YMCZsIq8NmCEd8+lG1Goi
yXV7o0X5XLXkzplCTt/AhKRU1V8ugNQ4pLGK4Q2AhR5ABzhN5L2m1vFIRTHDx9AG
UTBGV7KaIbtUUlBYrH6Dbe/S/8P4u7JzpegAJmoX1FNCo04PIxYDJDEQg6TjHzGA
Xwq+LwKZQsnKf20RKIsCd64B6zwMw98aABZhkzIWIfmIMX4mfJcwfNLnmDWzxma+
c16pG1ONwMjUQ+y0lrvH8KDNeTpHjc83xbT49x4yOVbwgk/BJudb4HsFot6uj1J8
mYhGeAHOU/OQRQKZ9aQKXTetRlfevkt6+Ky5L1xTlvwOv3gIsfyqvkJjxZFJwnQA
gnlQM+pla83ALYKUshgYzCNo6FIqtq629eAflZV1wa3T/F7hR378L1JCa7jzvQPv
WZ+9JoTIKrWt8XTzrkHh
=PPWp
-----END PGP SIGNATURE-----

--I2DZnI03i1DS0lOz--

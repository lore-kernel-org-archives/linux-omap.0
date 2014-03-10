From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 10 Mar 2014 12:11:49 +0000
Message-ID: <20140310121149.GF28112@sirena.org.uk>
References: <cover.1394440470.git.jsarha@ti.com>
 <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
 <20140310120938.GJ14999@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7+J38Rf7xqVaSgUf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40600 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaCJML6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 08:11:58 -0400
Content-Disposition: inline
In-Reply-To: <20140310120938.GJ14999@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "detheridge@ti.com" <detheridge@ti.com>


--7+J38Rf7xqVaSgUf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 12:09:38PM +0000, Mark Rutland wrote:
> On Mon, Mar 10, 2014 at 08:52:21AM +0000, Jyri Sarha wrote:

> > +        1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
> > +        2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
> > +        3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
> > +       If this node is not mentioned or if the value is unknown, then
> > +       micbias is set to 2.0V.

> Why does the dts write need to select these -- what prevents this
> getting selected dynamically?

It's a property of the system integration - the board will be designed
to bias the microphone at some voltage.

--7+J38Rf7xqVaSgUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHawCAAoJELSic+t+oim9uoEP/iOpX1L8a/ZT0Il6IzHtmk43
sRRUcTsv5Z/w8mjtNgHbXJz9g27oeYHtk5qqkQQ+gSiVG85E6yj+Qw8RwtCC1CrE
0obNDXvLsa8moS/h7TCbX/8q4aZBddQ3RvBxv+CX/cF5u0eNqgQCAIzYra5fMh8I
RgBIFduJViPDsuJbUJ8dktO3V7xGRrb0Dz8aTWKk3IXOUZWMW0/9RdfLz2jU/zpx
KqMLvWxRVhXMPXTbAOREqWNSxncM1cbef5jHJ9jbgF6Z3ZISjtHymrdshNupmVue
l5ui9HMQUuqbljz4yvR8cTbLD8i1YNp6sSgzDsebo3x3wgEI+AbwaDb/HxAp/9Py
ImT2CuMbSPBBnXZL6w9ST4O5aSAYeV/DItSxIK9YFaLnEO57WTODtQXboMR8OeVj
eAGGKZJsGyeobC7yclkd6EYmbgyScxfpb6t2x/ZIo551kVRiI7uNEISLPF4phVvp
GC6WFd/+Yr8+9SBasuWZ1PmNgY2SPy6XSnmDGCKzjQsHUW26MfDztWj70MPYKW7Z
VyaYR7VprhAmJU1NgaAkVwFh7F3HKlzC2Ux3xT4MJMdyMGO69Zls5cGmG7dmJUXJ
3zRmE1rqe0zrjt/KdxH5wTSsCrevqyNkIedONj4or8lLzxsqObur2wjTHzXgZgBA
8R16mnO9SxUfqdMuKfdO
=tl+G
-----END PGP SIGNATURE-----

--7+J38Rf7xqVaSgUf--

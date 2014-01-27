From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 4/8] ASoC: davinci-evm: HDMI audio support for
 TDA998x trough McASP I2S bus
Date: Mon, 27 Jan 2014 20:49:10 +0000
Message-ID: <20140127204910.GB11841@sirena.org.uk>
References: <cover.1390836773.git.jsarha@ti.com>
 <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gzJEy4voKlV4eANz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60375 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbaA0UtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2014 15:49:15 -0500
Content-Disposition: inline
In-Reply-To: <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, detheridge@ti.com, bcousson@baylibre.com


--gzJEy4voKlV4eANz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 05:37:53PM +0200, Jyri Sarha wrote:
> Add machine driver support for BeagleBone-Black and other boards with
> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
> port in I2S mode. McASP produces the bit clock for the i2s bus from
> the masted clock by a simple divider and the available sample rates

I have to say I agree with Lars' comments about where the code to set
the constraints is here - I don't doubt that these limitations are valid
but it would be better to factor them into the relevant chip drivers so
that other systems with similar limitations can be handled correctly
too.

--gzJEy4voKlV4eANz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5sZDAAoJELSic+t+oim92CEP/i6Lk3eoSGMZhmghkLueNZ5F
jxY69hZj9Nj5piSWBp7RG0P3XYv0GfMft6/8XM912fZmvbNBGVbBITCDOqTgKEaR
ZRo2fNHshv33frh7BsxJefYSfs59mhzpB9DKW40+KxNAWOZi6PKg+Bu6KyvVpZca
tEiovnDetDYtuFx0iPkEiPvYYb1VCUlqTISQlaYNi3G+VQ3xwXclvGkCgZJD37pN
5w+Yoa0l1Vp3AplfO5q9QZT7HIdqCUzcSnFdeiQBFxr4xxGWOPvIS1hBBgSXFe90
X5rOKZ6F86lN6UxpEu2Hz6NiozuRQs2/EssUrjG7FM2on/PMtludXUldI15a1GsJ
l5PruX3HA1ZCivLOBhcSHHZdX7FCnY8EAFXsaCZQVs0TiB34HkvdUHnSdbO6b++q
NJ/pqwpeLdtGlAzeSb8kEDUZTcY71/ZZccr7J74rruyo4GPZPM8fH3vvbiaOT+Vc
eZyvGF/k8oORwn/B8F1lYbbc8Me35+zq7VlnD8UtfRS/J4PY77u0dDy9+auERQSN
0gfP6Tejp+AO9r8GNOUbOAJrK6ehn37beNg9coeUPaBRYrPCT/iG7G0j0CPa+/oN
Q13Uqp5l+htydZvBKIs3YUkRAVgopXzkg9b/lCpata95ve4UCrlPktXuCspy91VF
skZ08KotoBP/Y2JA/bdR
=P3GD
-----END PGP SIGNATURE-----

--gzJEy4voKlV4eANz--

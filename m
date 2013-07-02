From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] drivers: spi: Add qspi flash controller
Date: Tue, 2 Jul 2013 11:17:18 +0100
Message-ID: <20130702101718.GE27646@sirena.org.uk>
References: <1372755399-21769-1-git-send-email-sourav.poddar@ti.com>
 <20130702093247.GY27646@sirena.org.uk>
 <20130702094404.GL3352@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l6uVvLg33S+39+i8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130702094404.GL3352@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--l6uVvLg33S+39+i8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 12:44:04PM +0300, Felipe Balbi wrote:
> On Tue, Jul 02, 2013 at 10:32:47AM +0100, Mark Brown wrote:

> > Does this hardware really support anything other than 8 bits per word?
> > There is no code in the driver which pays any attention to the word
> > size...

> the HW has a 128-bit shift register ;-) but driver doesn't look
> complete.

That's not the issue - remember that SPI specifies big endian byte
ordering for words on the bus so things will need to be reordered by the
hardware for anything except 8 bits.

--l6uVvLg33S+39+i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0qiqAAoJELSic+t+oim9YAsP/1np9MigYru6uKF4qNf7pVl9
UKaCIhPzQAAmC1V5eqfHyPkKCsX2a4SWA0W0KGFRUbGplW997utTsJGe0P3GzQ36
m/8RQtJTZV4LmsTJi/dPxJ3DvT9X5KZOUFF6KULUHHyG8UNGwHycKc/+oTOeZmFq
AUlBbSOBPGm8g7zsZ9D4+0jvQtlyVc3c8SmIjQWYj9CnJru2l2RYlBrYrYQ24yT7
vpgIzoFtxhrAmEOxGzh/XYyfkaTCq/yIwNvbh47OlYKCYafYExPwCe3DH3NDNfyN
1wLx6xykQCU0lVG4/FF1/JhWwUdWt9R2zyVMj9eNZC8ZV7jM9iiUyhNrtEAGJ1wI
NqexzOCvTlnFbtSRwRLC8pB0mcYldkNpq0v8HkI2gLDhXYWMEtgkUwNbJoXaJ7yL
dHUSPk5YINWy6sqgli4m4I1w6iMRSjZLRf+3VZsuccpIIrITX768PzF9WhyF8rVd
oqOeSD1R9F/pczYchvNtGlHlvSAdGjq/xsTydVA4f8aOlDFn7+/W7WrpKVPjJQZi
eaYjB/Tp1CJiU1VeF5XMxLZkYUZmSJWoUNNNFs3TzOa+Qg4C1fqf/ygYTC5E9XaM
JIhmSVfDoHogTPyKYjiwacsUrytsMoQGeFlGIyHDsHBlxYL/gu/ggxh/Qc6sN1V5
tNa4OodyOnAA9tUgabd9
=39MU
-----END PGP SIGNATURE-----

--l6uVvLg33S+39+i8--
